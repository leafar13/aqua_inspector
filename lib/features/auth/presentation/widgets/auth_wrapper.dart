import 'package:aqua_inspector/features/auth/presentation/pages/login_screen.dart';
import 'package:aqua_inspector/features/auth/presentation/providers/auth_provider.dart';
import 'package:aqua_inspector/features/dashboard/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    switch (authState.status) {
      case AuthStatus.initial:
        // Solo mostrar loading en initial, no en loading de login
        return const LoginScreen();
      case AuthStatus.authenticated:
        return const HomeScreen();
      case AuthStatus.loading:
      case AuthStatus.unauthenticated:
      case AuthStatus.error:
        // En estos casos, mostrar la pantalla de login
        // El loading se maneja dentro del LoginScreen
        return const LoginScreen();
    }
  }
}
