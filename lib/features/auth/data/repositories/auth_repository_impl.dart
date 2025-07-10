import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/errors/network_errors.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SharedPreferences sharedPreferences;

  // Keys para SharedPreferences
  static const String _tokenKey = 'auth_token';
  static const String _tokenTypeKey = 'auth_token_type';
  static const String _user = 'user';

  AuthRepositoryImpl({required this.remoteDataSource, required this.sharedPreferences});

  @override
  Future<AuthResult> login({required String username, required String password}) async {
    try {
      // Llamar al DataSource para obtener los datos del servidor
      final loginModel = await remoteDataSource.login(username: username, password: password);

      // Convertir UserInfo (modelo) a User (entidad de dominio)
      final user = User(
        id: loginModel.userInfo.id,
        username: loginModel.userInfo.username,
        fullName: loginModel.userInfo.fullName,
        email: loginModel.userInfo.email,
        organizationId: loginModel.userInfo.organizationId,
        organizationName: loginModel.userInfo.organizationName,
        roleId: loginModel.userInfo.roleId,
        roleName: loginModel.userInfo.roleName,
      );

      // Guardar datos en SharedPreferences para persistencia
      await _saveUserData(loginModel, user);

      return AuthResult.success(user: user, token: loginModel.token, tokenType: loginModel.tokenType, expiresIn: loginModel.expiresIn);
    } on AuthDataSourceException catch (e) {
      // Convertir statusCode a mensaje amigable
      int errorCode = e.statusCode ?? 500;
      String userMessage = NetworkErrors.fromHttpCode(errorCode).message;
      return AuthResult.failure(userMessage);
    } catch (e) {
      return AuthResult.failure('Error inesperado: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    // Limpiar todos los datos guardados
    await sharedPreferences.remove(_tokenKey);
    await sharedPreferences.remove(_tokenTypeKey);
    await sharedPreferences.remove(_user);
  }

  @override
  Future<User?> getCurrentUser() async {
    final user = sharedPreferences.getString(_user);
    if (user == null) {
      return null;
    } else {
      return User.fromJson(json.decode(user));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = sharedPreferences.getString(_tokenKey);
    return token != null && token.isNotEmpty;
  }

  // Método privado para guardar datos del usuario
  Future<void> _saveUserData(dynamic loginModel, User user) async {
    await sharedPreferences.setString(_tokenKey, loginModel.token);
    await sharedPreferences.setString(_tokenTypeKey, loginModel.tokenType);
    await sharedPreferences.setString(_user, json.encode(user.toJson()));
  }
}
