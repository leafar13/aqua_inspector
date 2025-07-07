import 'package:aqua_inspector/features/samples/domain/entities/sample_item.dart';
import 'package:aqua_inspector/features/samples/domain/repositories/samples_repository.dart';
import 'package:aqua_inspector/features/samples/data/datasources/samples_remote_datasource.dart';

class SamplesRepositoryImpl implements SamplesRepository {
  final SamplesRemoteDataSource remoteDataSource;

  SamplesRepositoryImpl({required this.remoteDataSource});

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
}

class SamplesRepositoryException implements Exception {
  final String message;
  final int? statusCode;

  SamplesRepositoryException(this.message, {this.statusCode});

  @override
  String toString() => 'SamplesRepositoryException: $message';
}