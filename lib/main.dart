import 'package:aqua_inspector/features/splash/presentation/screen/splash_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Core

// Features

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

void main() async {
  // Asegura que los widgets estén inicializados antes de usar servicios async

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((fn) {
    runApp(ProviderScope(child: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // MultiProvider(
    //   providers: [
    //     // Auth Provider
    //     ChangeNotifierProvider<AuthProvider>(create: (_) => DependencyInjection.authProvider),
    //     // Aquí puedes agregar más providers en el futuro
    //   ],
    // child:
    MaterialApp(
      title: 'AquaInspector',
      home: SplashWrapper(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        scaffoldBackgroundColor: Color.fromARGB(255, 119, 178, 226), // AGREGAR ESTA LÍNEA
        appBarTheme: const AppBarTheme().copyWith(backgroundColor: kColorScheme.onPrimaryContainer, foregroundColor: kColorScheme.primaryContainer),
      ),
    );
    // );
  }
}
