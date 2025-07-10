import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/sample_item.dart';
import '../providers/samples_provider.dart';
import 'samples_state.dart';

part 'samples_viewmodel.g.dart';

@riverpod
class SamplesNotifier extends _$SamplesNotifier {
  @override
  SamplesState build() => const SamplesState();

  Future<void> loadSamples(int userId, DateTime date) async {
    state = state.copyWith(isLoading: true, status: SamplesStatus.loading, errorMessage: null);

    try {
      final samplesRepository = await ref.read(samplesRepositoryProvider);

      // Cargar datos remotos
      final remoteSamples = await samplesRepository.getSamplesSummaryByUser(userId, date);

      // Cargar datos locales desde assets
      final localSamples = await samplesRepository.getSampleItemsFromAssets();

      // Combinar ambas listas
      final allSamples = [...remoteSamples, ...localSamples];

      state = state.copyWith(samples: allSamples, status: SamplesStatus.loaded, isLoading: false);
    } catch (e) {
      // Si falla todo, intentar cargar solo datos locales como fallback
      try {
        final samplesRepository = await ref.read(samplesRepositoryProvider);
        final localSamples = await samplesRepository.getSampleItemsFromAssets();

        state = state.copyWith(
          samples: localSamples,
          status: SamplesStatus.loaded,
          isLoading: false,
          errorMessage: 'Mostrando datos locales. Error de red: ${e.toString()}',
        );
      } catch (localError) {
        state = state.copyWith(status: SamplesStatus.error, errorMessage: 'Error cargando datos: ${localError.toString()}', isLoading: false);

        if (kDebugMode) {
          print('Error cargando muestras: ${localError.toString()}');
        }
      }
    }
  }

  /// Método para cargar solo datos locales
  Future<void> loadLocalSamples() async {
    state = state.copyWith(isLoading: true, status: SamplesStatus.loading, errorMessage: null);

    try {
      final samplesRepository = await ref.read(samplesRepositoryProvider);
      final localSamples = await samplesRepository.getSampleItemsFromAssets();

      state = state.copyWith(samples: localSamples, status: SamplesStatus.loaded, isLoading: false);
    } catch (e) {
      state = state.copyWith(status: SamplesStatus.error, errorMessage: 'Error cargando datos locales: ${e.toString()}', isLoading: false);
    }
  }

  Future<void> refreshSamples(int userId, DateTime date) async {
    await loadSamples(userId, date);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null, status: state.samples.isNotEmpty ? SamplesStatus.loaded : SamplesStatus.initial);
  }

  void clearSamples() {
    state = const SamplesState();
  }
}
