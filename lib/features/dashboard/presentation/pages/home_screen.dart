import 'package:aqua_inspector/core/config/providers/config_providers.dart';
import 'package:aqua_inspector/core/config/theme/app_theme.dart';
import 'package:aqua_inspector/features/dashboard/presentation/widgets/custom_button_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aqua_inspector/features/auth/presentation/providers/auth_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = ref.watch(darkModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (context, ref, child) {
            final authState = ref.watch(authNotifierProvider);
            return Text(
              'Bienvenido ${authState.currentUser?.fullName ?? ''}',
              style: TextStyle(color: theme.appBarTheme.foregroundColor, fontWeight: FontWeight.bold),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: theme.appBarTheme.foregroundColor),
            onPressed: () {
              ref.read(darkModeProvider.notifier).toggle();
            },
          ),
          SizedBox.shrink(),
          Consumer(
            builder: (context, authProvider, child) {
              return IconButton(
                icon: Icon(Icons.logout, color: theme.appBarTheme.foregroundColor),
                onPressed: () => ref.read(authNotifierProvider.notifier).logout(),
              );
            },
          ),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.getBackgroundGradient(isDarkMode)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonMenu(tittle: 'Tomar muestra', onPressed: () {}, icon: Icons.science_outlined),
                  SizedBox(width: 20),
                  CustomButtonMenu(tittle: 'Mis muestras', onPressed: () {}, icon: Icons.science),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonMenu(tittle: 'Reportes', onPressed: () {}, icon: Icons.file_copy_rounded),
                  SizedBox(width: 20),
                  CustomButtonMenu(tittle: 'Sincronizar', onPressed: () {}, icon: Icons.sync),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
