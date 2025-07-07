import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aqua_inspector/core/network/dio_client.dart';
import 'package:aqua_inspector/features/samples/data/datasources/samples_remote_datasource.dart';
import 'package:aqua_inspector/features/samples/data/repositories/samples_repository_impl.dart';
import 'package:aqua_inspector/features/samples/domain/repositories/samples_repository.dart';

// Provider para el DataSource remoto
final samplesRemoteDataSourceProvider = Provider<SamplesRemoteDataSource>((ref) {
  final dio = ref.watch(dioClientProvider);
  return SamplesRemoteDataSourceImpl(dio: dio);
});

// Provider para el repositorio de samples
final samplesRepositoryProvider = FutureProvider<SamplesRepository>((ref) async {
  final remoteDataSource = ref.watch(samplesRemoteDataSourceProvider);
  return SamplesRepositoryImpl(remoteDataSource: remoteDataSource);
});