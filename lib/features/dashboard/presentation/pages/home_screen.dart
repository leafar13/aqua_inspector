import 'package:aqua_inspector/features/dashboard/presentation/widgets/custom_button_menu.dart';
import 'package:aqua_inspector/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AquaInspector - Inicio'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              // Navegar de vuelta al login
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
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
