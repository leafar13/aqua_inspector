import 'package:aqua_inspector/core/widgets/loading_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aqua_inspector/features/auth/presentation/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controladores para los campos de texto
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Variable para controlar la visibilidad de la contraseña
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'assets/images/texto.png', 
            width: 220,
            fit: BoxFit.contain,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 119, 178, 226),
      ),
      body: Stack(
        children: [
          // Contenido principal
          Container(
            padding: const EdgeInsets.all(40),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 119, 178, 226), Color.fromARGB(255, 4, 95, 186)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Logo
                      Image.asset('assets/images/logo.png', width: 300, height: 300, alignment: Alignment.center),

                      const SizedBox(height: 20),

                      // Campo de usuario
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: _usernameController,
                        enabled: !context.watch<AuthProvider>().isLoading, // Deshabilitar durante loading
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.person, color: Colors.grey),
                          labelText: 'Usuario',
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'El usuario es requerido';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Campo de contraseña
                      TextFormField(
                        controller: _passwordController,
                        enabled: !context.watch<AuthProvider>().isLoading, // Deshabilitar durante loading
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                          labelText: 'Contraseña',
                          border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'La contraseña es requerida';
                          }
                          if (value.trim().length < 4) {
                            return 'La contraseña debe tener al menos 4 caracteres';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 30),

                      // Botón de login con estado del provider
                      Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                          return Column(
                            children: [
                              // Mostrar error si existe
                              if (authProvider.errorMessage != null)
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  margin: const EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade100,
                                    border: Border.all(color: Colors.red),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.error, color: Colors.red),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(authProvider.errorMessage!, style: const TextStyle(color: Colors.red)),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.close, color: Colors.red),
                                        onPressed: () => authProvider.clearError(),
                                      ),
                                    ],
                                  ),
                                ),

                              // Botón de login
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: OutlinedButton.icon(
                                  onPressed: authProvider.isLoading ? null : () => _handleLogin(context, authProvider),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  icon: authProvider.isLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 255, 255, 255)),
                                          ),
                                        )
                                      : const Icon(Icons.login, color: Colors.white),
                                  label: Text(authProvider.isLoading ? 'Iniciando sesión...' : 'Iniciar sesión', style: const TextStyle(fontSize: 16)),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          //
          // Consumer<AuthProvider>(
          //   builder: (context, authProvider, child) {
          //     if (!authProvider.isLoading) {
          //       return const SizedBox.shrink();
          //     } else {
          //       return LoadingCard('Verificando Credenciales...');
          //     }
          //   },
          // ),
        ],
      ),
    );
  }

  /// Maneja el proceso de login
  void _handleLogin(BuildContext context, AuthProvider authProvider) async {
    // Limpiar errores anteriores
    authProvider.clearError();

    // Validar formulario
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Ocultar el teclado
    FocusScope.of(context).unfocus();

    // Ejecutar login a través del provider
    await authProvider.login(username: _usernameController.text.trim(), password: _passwordController.text.trim());

    // El AuthWrapper en main.dart se encargará de navegar automáticamente
    // cuando el estado cambie a authenticated
  }
}
