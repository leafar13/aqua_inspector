import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_client.dart';
import '../../../../core/providers/app_config.dart';
import '../../domain/repositories/auth_remote_repository.dart';
import '../models/login_model.dart';

part 'auth_remote_datasource.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSourceImpl(ref.watch(dioClientProvider));
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<LoginModel> login({required String username, required String password}) async {
    try {
      final response = await _dio.post(AppConfig.authLoginEndpoint, data: {'username': username, 'password': password});

      if (response.statusCode == 200) {
        return LoginModel.fromJson(response.data);
      } else {
        throw AuthDataSourceException('Error en login', statusCode: response.statusCode);
      }
    } on DioException catch (e) {
      throw AuthDataSourceException('Error de conexión', statusCode: e.response?.statusCode);
    } catch (e) {
      throw AuthDataSourceException('Error inesperado: ${e.toString()}');
    }
  }
}

class AuthDataSourceException implements Exception {
  final String message;
  final int? statusCode;

  AuthDataSourceException(this.message, {this.statusCode});

  @override
  String toString() => message;
}
