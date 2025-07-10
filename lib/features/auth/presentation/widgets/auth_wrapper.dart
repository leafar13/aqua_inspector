import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dashboard/presentation/pages/home_screen.dart';
import '../pages/login_screen.dart';
import '../providers/auth_provider.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStatusNotifierProvider);

    switch (authState.status) {
      case AuthStatus.initial:
        return const LoginScreen();
      case AuthStatus.authenticated:
        return const HomeScreen();
      case AuthStatus.loading:
      case AuthStatus.unauthenticated:
      case AuthStatus.error:
        // En estos casos, mostrar la pantalla de login
        return const LoginScreen();
    }
  }
}
