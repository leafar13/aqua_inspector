import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aqua_inspector/features/auth/data/models/login_model.dart';
import 'package:aqua_inspector/core/config/app_config.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> login({required String username, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  AuthRemoteDataSourceImpl({required this.client, this.baseUrl = ''});

  @override
  Future<LoginModel> login({required String username, required String password}) async {
    final url = Uri.parse('$baseUrl${AppConfig.authLoginEndpoint}');

    final body = {'username': username, 'password': password};

    try {
      final response = await client.post(url, headers: AppConfig.defaultHeaders, body: json.encode(body));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return LoginModel.fromJson(jsonData);
      } else {
        // Manejar diferentes códigos de error
        String errorMessage;
        switch (response.statusCode) {
          case 401 || 403:
            errorMessage = 'Credenciales incorrectas';
            break;
          case 404:
            errorMessage = 'Servicio no encontrado';
            break;
          case 500:
            errorMessage = 'Error interno del servidor';
            break;
          default:
            errorMessage = 'Error de conexión: ${response.statusCode}';
        }
        throw AuthDataSourceException(errorMessage);
      }
    } catch (e) {
      if (e is AuthDataSourceException) {
        rethrow;
      }
      throw AuthDataSourceException('Error de conexión: ${e.toString()}');
    }
  }
}

class AuthDataSourceException implements Exception {
  final String message;

  AuthDataSourceException(this.message);

  @override
  String toString() => message;
}
