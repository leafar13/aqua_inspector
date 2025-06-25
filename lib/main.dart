import 'package:aqua_inspector/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'AquaInspector', home: LoginScreen(), debugShowCheckedModeBanner: false);
  }
}
