import 'package:aqua_inspector/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aqua Inspector'), backgroundColor: Color.fromARGB(255, 74, 167, 243)),
      body: Container(
        padding: const EdgeInsets.all(40),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 74, 167, 243), Color.fromARGB(255, 4, 95, 186)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 300, height: 300, alignment: Alignment.center),
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.person, color: Colors.grey),
                  labelText: 'Usuario',
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.person, color: Colors.grey),
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                },
                label: const Text('Iniciar sesión'),
                style: OutlinedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.blue),
                icon: const Icon(Icons.arrow_right_alt, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
