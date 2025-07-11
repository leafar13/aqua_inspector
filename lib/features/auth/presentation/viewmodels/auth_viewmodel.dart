import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/auth_state.dart';
import '../providers/providers.dart';
import 'login_view_model.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
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
      } else {
        state = state.copyWith(status: AuthStatus.error, errorMessage: result.error, isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, errorMessage: 'Error inesperado: ${e.toString()}', isLoading: false);
    }
  }

  // Método para hacer logout
  Future<void> logout() async {
    try {
      final authRepository = await ref.read(authRepositoryProvider.future);
      await authRepository.logout();

      state = state.customCopyWith(status: AuthStatus.unauthenticated, errorMessage: null, clearUser: true);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, errorMessage: 'Error al cerrar sesión: ${e.toString()}');
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
      } else {
        state = state.copyWith(status: AuthStatus.unauthenticated);

        if (kDebugMode) {}
      }
    } catch (e) {
      state = state.copyWith(status: AuthStatus.unauthenticated);
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

@riverpod
Future<LoginUseCase> loginUseCase(Ref ref) async {
  return LoginUseCase(authRepository: await ref.watch(authRepositoryProvider.future));
}
