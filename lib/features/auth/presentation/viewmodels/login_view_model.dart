import '../../domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<AuthResult> execute({required String username, required String password}) async {
    // Validaciones de negocio
    if (username.trim().isEmpty) {
      return AuthResult.failure('El nombre de usuario es requerido');
    } else if (password.trim().isEmpty || password.trim().length < 4) {
      return AuthResult.failure('La contraseña es requerida');
    }

    try {
      // Delegar al repositorio la operación de login
      final result = await authRepository.login(username: username.trim(), password: password.trim());

      return result;
    } catch (e) {
      return AuthResult.failure('Error inesperado: ${e.toString()}');
    }
  }
}
