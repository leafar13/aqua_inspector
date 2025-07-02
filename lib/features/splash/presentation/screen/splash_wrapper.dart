import 'package:aqua_inspector/features/auth/presentation/widgets/auth_wrapper.dart';
import 'package:aqua_inspector/features/splash/presentation/screen/splash_screen.dart';
import 'package:flutter/material.dart';

class SplashWrapper extends StatefulWidget {
  @override
  _SplashWrapperState createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  bool _showLogin = false;

  @override
  Widget build(BuildContext context) {
    if (_showLogin) {
      return AuthWrapper(); // Tu pantalla de login actual
    }

    return SplashScreen(
      onAnimationComplete: () {
        setState(() {
          _showLogin = true;
        });
      },
    );
  }
}
