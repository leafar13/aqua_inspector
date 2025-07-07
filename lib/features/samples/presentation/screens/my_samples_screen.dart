import 'package:aqua_inspector/core/config/providers/config_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aqua_inspector/features/samples/presentation/viewmodels/samples_viewmodel.dart';
import 'package:aqua_inspector/features/samples/presentation/widgets/sample_item_card.dart';
import 'package:aqua_inspector/features/auth/presentation/providers/auth_provider.dart';
import 'package:aqua_inspector/core/config/theme/app_theme.dart';

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
      _loadSamples();
    });
  }

  void _loadSamples() {
    final authState = ref.read(authNotifierProvider);
    if (authState.currentUser != null) {
      final today = DateTime.now();
      print('Loading samples for userId: ${authState.currentUser!.id}');
      ref.read(samplesNotifierProvider.notifier).loadSamples(
        authState.currentUser!.id,
        today,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final samplesState = ref.watch(samplesNotifierProvider);
    final authState = ref.watch(authNotifierProvider);
    final theme = Theme.of(context);
    final isDarkMode = ref.watch(darkModeProvider);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title:  Text(
          'Muestras de Agua',
          style: TextStyle(color: theme.appBarTheme.foregroundColor, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: _loadSamples,
            icon: const Icon(Icons.refresh),
            tooltip: 'Actualizar',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.getBackgroundGradient(isDarkMode)),
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: _buildBody(samplesState, authState),
      ),
    );
  }

  Widget _buildBody(SamplesState samplesState, AuthState authState) {
    if (authState.currentUser == null) {
      return const Center(
        child: Text(
          'Usuario no autenticado',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    if (samplesState.isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Cargando muestras...',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    if (samplesState.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Error al cargar las muestras',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
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
            Icon(
              Icons.science_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No hay muestras para mostrar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
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