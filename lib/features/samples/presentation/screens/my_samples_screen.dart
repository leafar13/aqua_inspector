import 'package:aqua_inspector/features/auth/data/models/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/config_providers.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../viewmodels/samples_state.dart';
import '../viewmodels/samples_viewmodel.dart';
import '../widgets/sample_item_card.dart';

class MySamplesScreen extends ConsumerStatefulWidget {
  const MySamplesScreen({super.key});

  @override
  ConsumerState<MySamplesScreen> createState() => _MySamplesScreenState();
}

class _MySamplesScreenState extends ConsumerState<MySamplesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadSamples();
    });
  }

  void loadSamples() {
    final authState = ref.read(authStatusNotifierProvider);
    if (authState.currentUser != null) {
      final today = DateTime.now();
      print('Loading samples for userId: ${authState.currentUser!.id}');
      ref.read(samplesNotifierProvider.notifier).loadSamples(authState.currentUser!.id, today);
    }
  }

  @override
  Widget build(BuildContext context) {
    final samplesState = ref.watch(samplesNotifierProvider);
    final authState = ref.watch(authStatusNotifierProvider);
    final theme = Theme.of(context);
    final isDarkMode = ref.watch(darkModeProvider);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Muestras de Agua',
          style: TextStyle(color: theme.appBarTheme.foregroundColor, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [IconButton(onPressed: loadSamples, icon: const Icon(Icons.refresh), tooltip: 'Actualizar')],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.getBackgroundGradient(isDarkMode)),
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: SampleScreenBody(samplesState: samplesState, authState: authState, loadSamples: loadSamples),
      ),
    );
  }
}

class SampleScreenBody extends StatelessWidget {
  final SamplesState samplesState;
  final AuthState authState;
  final VoidCallback _loadSamples;

  const SampleScreenBody({super.key, required this.samplesState, required this.authState, required VoidCallback loadSamples}) : _loadSamples = loadSamples;

  @override
  Widget build(BuildContext context) {
    if (authState.currentUser == null) {
      return const Center(
        child: Text('Usuario no autenticado', style: TextStyle(fontSize: 16, color: Colors.grey)),
      );
    }

    if (samplesState.isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Cargando muestras...', style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      );
    }

    if (samplesState.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error al cargar las muestras',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800]),
            ),
            const SizedBox(height: 8),
            Text(
              samplesState.errorMessage ?? 'Error desconocido',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadSamples,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
            ),
          ],
        ),
      );
    }

    if (!samplesState.hasData) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.science_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No hay muestras para mostrar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800]),
            ),
            const SizedBox(height: 8),
            Text(
              'No se encontraron muestras para la fecha de hoy',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadSamples,
              icon: const Icon(Icons.refresh),
              label: const Text('Actualizar'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: samplesState.samples.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final sample = samplesState.samples[index];
        return SampleItemCard(sample: sample);
      },
    );
  }
}
