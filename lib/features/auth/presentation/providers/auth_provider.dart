import 'package:aqua_inspector/core/config/providers/config_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:aqua_inspector/features/auth/domain/entities/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// IMPORTANTE: Esta línea es obligatoria
part 'auth_provider.g.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

// Estado inmutable
class AuthState {
  final AuthStatus status;
  final User? currentUser;
  final String? errorMessage;
  final bool isLoading;

  const AuthState({this.status = AuthStatus.initial, this.currentUser, this.errorMessage, this.isLoading = false});

  AuthState copyWith({AuthStatus? status, User? currentUser, String? errorMessage, bool? isLoading}) {
    return AuthState(
      status: status ?? this.status,
      currentUser: currentUser ?? this.currentUser,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  bool get isAuthenticated => status == AuthStatus.authenticated;
}

// Provider principal con anotación @riverpod
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    // Estado inicial
    _checkAuthStatus();
    return const AuthState();
  }

  // Método para hacer login
  Future<void> login({required String username, required String password}) async {
    state = state.copyWith(isLoading: true, status: AuthStatus.loading, errorMessage: null);

    try {
      // Usar los providers en lugar de DependencyInjection
      final loginUseCase = await ref.read(loginUseCaseProvider.future);
      final result = await loginUseCase.execute(username: username, password: password);

      if (result.isSuccess) {
        state = state.copyWith(currentUser: result.user, status: AuthStatus.authenticated, isLoading: false);

        if (kDebugMode) {
          print('Login exitoso: ${result.user?.username}');
        }
      } else {
        state = state.copyWith(status: AuthStatus.error, errorMessage: result.error, isLoading: false);

        if (kDebugMode) {
          print('Error en login: ${result.error}');
        }
      }
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, errorMessage: 'Error inesperado: ${e.toString()}', isLoading: false);

      if (kDebugMode) {
        print('Excepción en login: ${e.toString()}');
      }
    }
  }

  // Método para hacer logout
  Future<void> logout() async {
    try {
      final authRepository = await ref.read(authRepositoryProvider.future);
      await authRepository.logout();

      state = state.copyWith(currentUser: null, status: AuthStatus.unauthenticated, errorMessage: null);

      if (kDebugMode) {
        print('Logout exitoso');
      }
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, errorMessage: 'Error al cerrar sesión: ${e.toString()}');

      if (kDebugMode) {
        print('Error en logout: ${e.toString()}');
      }
    }
  }

  // Verificar estado de autenticación al inicializar
  Future<void> _checkAuthStatus() async {
    try {
      final authRepository = await ref.read(authRepositoryProvider.future);
      final isLoggedIn = await authRepository.isLoggedIn();

      if (isLoggedIn) {
        final user = await authRepository.getCurrentUser();
        state = state.copyWith(currentUser: user, status: AuthStatus.authenticated);

        if (kDebugMode) {
          print('Usuario ya autenticado: ${user?.username}');
        }
      } else {
        state = state.copyWith(status: AuthStatus.unauthenticated);

        if (kDebugMode) {
          print('Usuario no autenticado');
        }
      }
    } catch (e) {
      state = state.copyWith(status: AuthStatus.unauthenticated);

      if (kDebugMode) {
        print('Error verificando estado de auth: ${e.toString()}');
      }
    }
  }

  // Método para limpiar errores
  void clearError() {
    state = state.copyWith(errorMessage: null, status: state.currentUser != null ? AuthStatus.authenticated : AuthStatus.unauthenticated);
  }

  // Método para refrescar el estado de autenticación
  Future<void> refreshAuthStatus() async {
    await _checkAuthStatus();
  }
}
