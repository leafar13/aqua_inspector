import '../entities/user.dart';

abstract class AuthRepository {
  Future<AuthResult> login({required String username, required String password});

  Future<void> logout();

  Future<User?> getCurrentUser();

  Future<bool> isLoggedIn();
}

class AuthResult {
  final User? user;
  final String? token;
  final String? tokenType;
  final int? expiresIn;
  final String? error;
  final bool isSuccess;

  AuthResult({this.user, this.token, this.tokenType, this.expiresIn, this.error, required this.isSuccess});

  factory AuthResult.success({required User user, required String token, required String tokenType, required int expiresIn}) {
    return AuthResult(user: user, token: token, tokenType: tokenType, expiresIn: expiresIn, isSuccess: true);
  }

  factory AuthResult.failure(String error) {
    return AuthResult(error: error, isSuccess: false);
  }
}
