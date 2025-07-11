import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/providers/config_providers.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/presentation/screen/splash_wrapper.dart';

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

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(appInitializationProvider);
    final isDarkMode = ref.watch(darkModeProvider);
    return MaterialApp(
      title: 'AquaInspector',
      home: SplashWrapper(),
      debugShowCheckedModeBanner: false,
      // theme: ThemeData().copyWith(
      //   colorScheme: kColorScheme,
      //   scaffoldBackgroundColor: Color.fromARGB(255, 119, 178, 226), // AGREGAR ESTA LÍNEA
      //   appBarTheme: const AppBarTheme().copyWith(backgroundColor: kColorScheme.onPrimaryContainer, foregroundColor: kColorScheme.primaryContainer),
      // ),
      theme: AppTheme(isDarkmode: isDarkMode).getTheme(),
    );
    // );
  }
}
