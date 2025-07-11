import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/samples_remote_data_source.dart';
import '../models/sample_item_model.dart';

class SamplesRemoteDataSourceImpl implements SamplesRemoteDataSource {
  final Dio dio;

  SamplesRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<SampleItemModel>> getSamplesSummaryByUser(int userId, DateTime date) async {
    try {
      // Formatear fecha en formato dd/MM/yyyy
      final formatter = DateFormat('dd/MM/yyyy');
      final dateString = formatter.format(date);

      final response = await dio.get('/samples/summary/user/$userId', queryParameters: {'startDate': dateString, 'endDate': dateString});

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) {
          // Agregar isSynced = false por defecto ya que no viene del API
          final jsonWithSync = Map<String, dynamic>.from(json);
          jsonWithSync['isSynced'] = true;
          return SampleItemModel.fromJson(jsonWithSync);
        }).toList();
      } else {
        throw SamplesDataSourceException('Error al obtener muestras: ${response.statusMessage}', statusCode: response.statusCode);
      }
    } on DioException catch (e) {
      throw SamplesDataSourceException(_getErrorMessage(e), statusCode: e.response?.statusCode);
    } catch (e) {
      throw SamplesDataSourceException('Error inesperado: ${e.toString()}');
    }
  }

  String _getErrorMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Tiempo de conexión agotado';
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 400:
            return 'Formato de fecha inválido';
          case 404:
            return 'Usuario no encontrado';
          case 500:
            return 'Error interno del servidor';
          default:
            return 'Error del servidor: ${error.response?.statusCode}';
        }
      case DioExceptionType.cancel:
        return 'Solicitud cancelada';
      case DioExceptionType.connectionError:
        return 'Error de conexión. Verifica tu internet';
      default:
        return 'Error de red desconocido';
    }
  }
}

class SamplesDataSourceException implements Exception {
  final String message;
  final int? statusCode;

  SamplesDataSourceException(this.message, {this.statusCode});

  @override
  String toString() => 'SamplesDataSourceException: $message';
}
