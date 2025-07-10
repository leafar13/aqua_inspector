import 'package:aqua_inspector/features/samples/domain/entities/samples_remote_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/datasources/samples_remote_datasource.dart';
import '../../data/datasources/samples_local_datasource.dart';
import '../../data/repositories/samples_repository_impl.dart';
import '../../domain/repositories/samples_repository.dart';

part 'samples_provider.g.dart';

@riverpod
SamplesRemoteDataSource samplesRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioClientProvider);
  return SamplesRemoteDataSourceImpl(dio: dio);
}

@riverpod
SamplesLocalDataSource samplesLocalDataSource(Ref ref) {
  return SamplesLocalDataSourceImpl();
}

@riverpod
SamplesRepository samplesRepository(Ref ref) {
  final remoteDataSource = ref.watch(samplesRemoteDataSourceProvider);
  final localDataSource = ref.watch(samplesLocalDataSourceProvider);
  return SamplesRepositoryImpl(remoteDataSource: remoteDataSource, localDataSource: localDataSource);
}
