import 'package:aqua_inspector/features/auth/presentation/widgets/auth_wrapper.dart';
import 'package:aqua_inspector/features/splash/presentation/screen/splash_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// Core
import 'package:aqua_inspector/core/di/dependency_injection.dart';

// Features
import 'package:aqua_inspector/features/auth/presentation/providers/auth_provider.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

void main() async {
  // Asegura que los widgets estén inicializados antes de usar servicios async
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar todas las dependencias
  await DependencyInjection.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((fn) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Auth Provider
        ChangeNotifierProvider<AuthProvider>(create: (_) => DependencyInjection.authProvider),
        // Aquí puedes agregar más providers en el futuro
      ],
      child: MaterialApp(
        title: 'AquaInspector',
        home: SplashWrapper(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(backgroundColor: kColorScheme.onPrimaryContainer, foregroundColor: kColorScheme.primaryContainer),
        ),
      ),
    );
  }
}
