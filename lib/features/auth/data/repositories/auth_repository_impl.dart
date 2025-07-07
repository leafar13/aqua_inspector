import 'package:aqua_inspector/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:aqua_inspector/features/auth/domain/entities/user.dart';
import 'package:aqua_inspector/features/auth/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aqua_inspector/core/network/errors/network_errors.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SharedPreferences sharedPreferences;

  // Keys para SharedPreferences
  static const String _tokenKey = 'auth_token';
  static const String _tokenTypeKey = 'auth_token_type';
  static const String _userIdKey = 'user_id';
  static const String _usernameKey = 'username';
  static const String _fullNameKey = 'full_name';
  static const String _emailKey = 'email';
  static const String _organizationIdKey = 'organization_id';
  static const String _organizationNameKey = 'organization_name';
  static const String _roleIdKey = 'role_id';
  static const String _roleNameKey = 'role_name';

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
    await sharedPreferences.remove(_userIdKey);
    await sharedPreferences.remove(_usernameKey);
    await sharedPreferences.remove(_fullNameKey);
    await sharedPreferences.remove(_emailKey);
    await sharedPreferences.remove(_organizationIdKey);
    await sharedPreferences.remove(_organizationNameKey);
    await sharedPreferences.remove(_roleIdKey);
    await sharedPreferences.remove(_roleNameKey);
  }

  @override
  Future<User?> getCurrentUser() async {
    final userId = sharedPreferences.getInt(_userIdKey);
    if (userId == null) return null;

    return User(
      id: userId,
      username: sharedPreferences.getString(_usernameKey) ?? '',
      fullName: sharedPreferences.getString(_fullNameKey) ?? '',
      email: sharedPreferences.getString(_emailKey) ?? '',
      organizationId: sharedPreferences.getInt(_organizationIdKey) ?? 0,
      organizationName: sharedPreferences.getString(_organizationNameKey) ?? '',
      roleId: sharedPreferences.getInt(_roleIdKey) ?? 0,
      roleName: sharedPreferences.getString(_roleNameKey) ?? '',
    );
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
    await sharedPreferences.setInt(_userIdKey, user.id);
    await sharedPreferences.setString(_usernameKey, user.username);
    await sharedPreferences.setString(_fullNameKey, user.fullName);
    await sharedPreferences.setString(_emailKey, user.email);
    await sharedPreferences.setInt(_organizationIdKey, user.organizationId);
    await sharedPreferences.setString(_organizationNameKey, user.organizationName);
    await sharedPreferences.setInt(_roleIdKey, user.roleId);
    await sharedPreferences.setString(_roleNameKey, user.roleName);
  }
}
