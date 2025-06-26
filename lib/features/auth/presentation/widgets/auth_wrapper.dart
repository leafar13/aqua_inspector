import 'package:aqua_inspector/features/auth/presentation/pages/login_screen.dart';
import 'package:aqua_inspector/features/auth/presentation/providers/auth_provider.dart';
import 'package:aqua_inspector/features/dashboard/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        switch (authProvider.status) {
          case AuthStatus.initial:
            // Solo mostrar loading en initial, no en loading de login
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          case AuthStatus.authenticated:
            return HomeScreen();

          case AuthStatus.loading:
          case AuthStatus.unauthenticated:
          case AuthStatus.error:
            // En estos casos, mostrar la pantalla de login
            // El loading se maneja dentro del LoginScreen
            return const LoginScreen();
        }
      },
    );
  }
}
