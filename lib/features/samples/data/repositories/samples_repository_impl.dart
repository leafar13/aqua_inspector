import 'package:aqua_inspector/features/samples/domain/entities/samples_remote_data_source.dart';

import '../../domain/entities/sample_item.dart';
import '../../domain/repositories/samples_repository.dart';
import '../datasources/samples_remote_datasource.dart';
import '../datasources/samples_local_datasource.dart';

class SamplesRepositoryImpl implements SamplesRepository {
  final SamplesRemoteDataSource remoteDataSource;
  final SamplesLocalDataSource localDataSource;

  SamplesRepositoryImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<List<SampleItem>> getSamplesSummaryByUser(int userId, DateTime date) async {
    try {
      final models = await remoteDataSource.getSamplesSummaryByUser(userId, date);
      return models.map((model) => model.toEntity()).toList();
    } on SamplesDataSourceException catch (e) {
      throw SamplesRepositoryException(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw SamplesRepositoryException('Error inesperado: ${e.toString()}');
    }
  }

  @override
  Future<List<SampleItem>> getSampleItemsFromAssets() async {
    try {
      final models = await localDataSource.getSampleItemsFromAssets();
      return models.map((model) => model.toEntity()).toList();
    } on SamplesLocalDataSourceException catch (e) {
      throw SamplesRepositoryException('Error cargando datos locales: ${e.message}');
    } catch (e) {
      throw SamplesRepositoryException('Error inesperado cargando assets: ${e.toString()}');
    }
  }
}

class SamplesRepositoryException implements Exception {
  final String message;
  final int? statusCode;

  SamplesRepositoryException(this.message, {this.statusCode});

  @override
  String toString() => 'SamplesRepositoryException: $message';
}
