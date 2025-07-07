import 'package:aqua_inspector/features/samples/domain/entities/sample_item.dart';
import 'package:aqua_inspector/features/samples/presentation/providers/samples_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'samples_viewmodel.g.dart';

enum SamplesStatus { initial, loading, loaded, error }

class SamplesState {
  final SamplesStatus status;
  final List<SampleItem> samples;
  final String? errorMessage;
  final bool isLoading;

  const SamplesState({
    this.status = SamplesStatus.initial,
    this.samples = const [],
    this.errorMessage,
    this.isLoading = false,
  });

  SamplesState copyWith({
    SamplesStatus? status,
    List<SampleItem>? samples,
    String? errorMessage,
    bool? isLoading,
  }) {
    return SamplesState(
      status: status ?? this.status,
      samples: samples ?? this.samples,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  bool get hasData => samples.isNotEmpty;
  bool get hasError => status == SamplesStatus.error;
}

@riverpod
class SamplesNotifier extends _$SamplesNotifier {
  @override
  SamplesState build() {
    return const SamplesState();
  }

  Future<void> loadSamples(int userId, DateTime date) async {
    state = state.copyWith(
      isLoading: true,
      status: SamplesStatus.loading,
      errorMessage: null,
    );

    try {
      final samplesRepository = await ref.read(samplesRepositoryProvider.future);
      final samples = await samplesRepository.getSamplesSummaryByUser(userId, date);
    samples.addAll(getDummySamples()); // Agregar muestras de prueba
      state = state.copyWith(
        samples: samples,
        status: SamplesStatus.loaded,
        isLoading: false,
      );

      if (kDebugMode) {
        print('Muestras cargadas exitosamente: ${samples.length} items');
      }
    } catch (e) {
      state = state.copyWith(
        status: SamplesStatus.error,
        errorMessage: e.toString(),
        isLoading: false,
      );

      if (kDebugMode) {
        print('Error cargando muestras: ${e.toString()}');
      }
    }
  }

  Future<void> refreshSamples(int userId, DateTime date) async {
    await loadSamples(userId, date);
  }

  void clearError() {
    state = state.copyWith(
      errorMessage: null,
      status: state.samples.isNotEmpty ? SamplesStatus.loaded : SamplesStatus.initial,
    );
  }

  void clearSamples() {
    state = const SamplesState();
  }
 List<SampleItem> getDummySamples() {
  List<SampleItem> samples = [
   SampleItem(id: 1, samplingDatetime: DateTime.now(), sampleNumber: '102-20250707-04', waterAssociationName: 'Asada San Carlos', systemName: 'Tanque sureste', isSynced: false),
   SampleItem(id: 2, samplingDatetime: DateTime.now(), sampleNumber: '102-20250707-05', waterAssociationName: 'Asada San Ramon', systemName: 'Tanque sureste', isSynced: false),
   SampleItem(id: 3, samplingDatetime: DateTime.now(), sampleNumber: '102-20250707-06', waterAssociationName: 'Asada CHEPE', systemName: 'Tanque sureste', isSynced: false),
  ];

  return samples;
 
 }

}