import 'package:aqua_inspector/features/auth/presentation/providers/auth_provider.dart';
import 'package:aqua_inspector/features/dashboard/presentation/widgets/custom_button_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return Text('Bienvenido ${authProvider.currentUser?.fullName ?? ''}');
          },
        ),
        backgroundColor: Colors.blue,
        actions: [
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return IconButton(icon: const Icon(Icons.logout), onPressed: () => authProvider.logout());
            },
          ),
        ],
      ),

      body: Container(
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
