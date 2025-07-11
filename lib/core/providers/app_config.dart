import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  /// Inicializa las variables de entorno
  static Future<void> init() async {
    await dotenv.load(fileName: ".env");
  }

  // API Configuration
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? 'http://localhost:8081/api';
  static String get authLoginEndpoint => dotenv.env['AUTH_LOGIN_ENDPOINT'] ?? '/auth/login';

  // App Configuration
  static String get appName => dotenv.env['APP_NAME'] ?? 'AquaInspector';
  static String get appVersion => dotenv.env['APP_VERSION'] ?? '1.0.0';

  // Debug Configuration
  static bool get debugMode => dotenv.env['DEBUG_MODE']?.toLowerCase() == 'true';

  /// URL completa para el login
  static String get loginUrl => '$apiBaseUrl$authLoginEndpoint';

  /// Método para verificar que todas las variables críticas estén configuradas
  static bool validateConfig() {
    final criticalVars = ['API_BASE_URL', 'AUTH_LOGIN_ENDPOINT'];

    for (String varName in criticalVars) {
      if (dotenv.env[varName] == null || dotenv.env[varName]!.isEmpty) {
        throw Exception('Variable de entorno requerida no encontrada: $varName');
      }
    }

    return true;
  }

  /// Método para debug la configuración (solo en modo debug)
  static void printConfig() {
    if (!debugMode) return;

    print('App Configuration:');
    print('API Base URL: $apiBaseUrl');
    print('Login URL: $loginUrl');
    print('App Name: $appName');
    print('App Version: $appVersion');
    print('Debug Mode: $debugMode');
  }

  /// Método para obtener headers HTTP comunes
  static Map<String, String> get defaultHeaders => {'Content-Type': 'application/json', 'Accept': 'application/json', 'User-Agent': '$appName/$appVersion'};
}
