import 'package:aqua_inspector/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aqua_inspector/features/auth/presentation/providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Hero(
            tag: 'logoText',
            child: Image.asset('assets/images/texto.png', width: 220, fit: BoxFit.contain),
          ),
        ),
        //backgroundColor: const Color.fromARGB(255, 119, 178, 226),
      ),
      body: Stack(
        children: [
          // Contenido principal
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(gradient: AppTheme.getBackgroundGradient(isDarkMode)),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Logo
                    Hero(
                      tag: 'logo',
                      child: Image.asset('assets/images/logo.png', width: 300, height: 300, alignment: Alignment.center),
                    ),

                    const SizedBox(height: 20),

                    // Campo de usuario
                    Card(
                      elevation: 30, // sombra
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // bordes redondeados
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16), // espacio interno adicional
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.name,
                                controller: _usernameController,
                                enabled: !ref.watch(authNotifierProvider).isLoading, // Deshabilitar durante loading
                                decoration: const InputDecoration(fillColor: Colors.white, filled: true, prefixIcon: Icon(Icons.person), labelText: 'Usuario'),
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
                                enabled: !ref.watch(authNotifierProvider).isLoading, // Deshabilitar durante loading
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: const Icon(Icons.lock),
                                  labelText: 'Contraseña',
                                  suffixIcon: IconButton(
                                    icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
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
                              Consumer(
                                builder: (context, ref, child) {
                                  final authState = ref.watch(authNotifierProvider);
                                  final authNotifier = ref.read(authNotifierProvider.notifier);
                                  return Column(
                                    children: [
                                      // Mostrar error si existe
                                      if (authState.errorMessage != null)
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          margin: const EdgeInsets.only(bottom: 20),
                                          decoration: BoxDecoration(
                                            color: theme.colorScheme.error.withValues(alpha: 0.1),
                                            border: Border.all(color: theme.colorScheme.error),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.error, color: theme.colorScheme.error),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(authState.errorMessage!, style: TextStyle(color: theme.colorScheme.error)),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.close, color: theme.colorScheme.error),
                                                onPressed: () => authNotifier.clearError(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      // Botón de login
                                      SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: OutlinedButton.icon(
                                          onPressed: authState.isLoading ? null : () => _handleLogin(context),
                                          icon: authState.isLoading
                                              ? const SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 255, 255, 255)),
                                                  ),
                                                )
                                              : const Icon(Icons.login, color: Colors.white),
                                          label: Text(authState.isLoading ? 'Iniciando sesión...' : 'Iniciar sesión', style: const TextStyle(fontSize: 16)),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Maneja el proceso de login
  void _handleLogin(BuildContext context) async {
    final authNotifier = ref.read(authNotifierProvider.notifier);

    // Limpiar errores anteriores
    authNotifier.clearError();

    // Validar formulario
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Ocultar el teclado
    FocusScope.of(context).unfocus();

    // Ejecutar login a través del provider
    await authNotifier.login(username: _usernameController.text.trim(), password: _passwordController.text.trim());

    // El AuthWrapper en main.dart se encargará de navegar automáticamente
    // cuando el estado cambie a authenticated
  }
}
