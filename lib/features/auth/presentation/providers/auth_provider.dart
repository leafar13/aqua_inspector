import 'package:flutter/foundation.dart';
import 'package:aqua_inspector/features/auth/domain/entities/user.dart';
import 'package:aqua_inspector/features/auth/domain/usecases/login_usecase.dart';
import 'package:aqua_inspector/features/auth/domain/repositories/auth_repository.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  final AuthRepository authRepository;

  AuthProvider({required this.loginUseCase, required this.authRepository}) {
    _checkAuthStatus();
  }

  // Estado privado
  AuthStatus _status = AuthStatus.initial;
  User? _currentUser;
  String? _errorMessage;
  bool _isLoading = false;

  // Getters públicos para acceder al estado
  AuthStatus get status => _status;
  User? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  // Método para hacer login
  Future<void> login({required String username, required String password}) async {
    _setLoading(true);
    _clearError();

    try {
      // Ejecutar el caso de uso de login
      final result = await loginUseCase.execute(username: username, password: password);

      if (result.isSuccess) {
        _currentUser = result.user;
        _status = AuthStatus.authenticated;
        _setLoading(false);

        if (kDebugMode) {
          print('Login exitoso: ${_currentUser?.username}');
        }
      } else {
        _status = AuthStatus.error;
        _errorMessage = result.error;
        _setLoading(false);

        if (kDebugMode) {
          print('Error en login: ${result.error}');
        }
      }
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = 'Error inesperado: ${e.toString()}';
      _setLoading(false);

      if (kDebugMode) {
        print('Excepción en login: ${e.toString()}');
      }
    }

    notifyListeners();
  }

  // Método para hacer logout
  Future<void> logout() async {
    try {
      await authRepository.logout();
      _currentUser = null;
      _status = AuthStatus.unauthenticated;
      _clearError();

      if (kDebugMode) {
        print('Logout exitoso');
      }
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = 'Error al cerrar sesión: ${e.toString()}';

      if (kDebugMode) {
        print('Error en logout: ${e.toString()}');
      }
    }

    notifyListeners();
  }

  // Verificar estado de autenticación al inicializar
  Future<void> _checkAuthStatus() async {
    try {
      final isLoggedIn = await authRepository.isLoggedIn();

      if (isLoggedIn) {
        _currentUser = await authRepository.getCurrentUser();
        _status = AuthStatus.authenticated;

        if (kDebugMode) {
          print('Usuario ya autenticado: ${_currentUser?.username}');
        }
      } else {
        _status = AuthStatus.unauthenticated;

        if (kDebugMode) {
          print('Usuario no autenticado');
        }
      }
    } catch (e) {
      _status = AuthStatus.unauthenticated;

      if (kDebugMode) {
        print('Error verificando estado de auth: ${e.toString()}');
      }
    }

    notifyListeners();
  }

  // Método para limpiar errores
  void clearError() {
    _clearError();
    notifyListeners();
  }

  // Método para refrescar el estado de autenticación
  Future<void> refreshAuthStatus() async {
    await _checkAuthStatus();
  }

  // Métodos privados helpers
  void _setLoading(bool loading) {
    _isLoading = loading;
    if (loading) {
      _status = AuthStatus.loading;
    }
  }

  void _clearError() {
    _errorMessage = null;
    if (_status == AuthStatus.error) {
      _status = _currentUser != null ? AuthStatus.authenticated : AuthStatus.unauthenticated;
    }
  }
}
