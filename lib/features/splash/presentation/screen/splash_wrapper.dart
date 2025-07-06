import 'package:aqua_inspector/features/auth/presentation/widgets/auth_wrapper.dart';
import 'package:aqua_inspector/features/splash/presentation/screen/splash_screen.dart';
import 'package:flutter/material.dart';

class SplashWrapper extends StatefulWidget {
  @override
  _SplashWrapperState createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      onAnimationComplete: () {
        Navigator.of(
          context,
        ).pushReplacement(PageRouteBuilder(pageBuilder: (_, __, ___) => const AuthWrapper(), transitionDuration: const Duration(milliseconds: 1000)));
      },
    );
  }
}
