import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Core
import 'package:aqua_inspector/core/config/app_config.dart';

// Data sources
import 'package:aqua_inspector/features/auth/data/datasources/auth_remote_datasource.dart';

// Repositories
import 'package:aqua_inspector/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:aqua_inspector/features/auth/domain/repositories/auth_repository.dart';

// Use cases
import 'package:aqua_inspector/features/auth/domain/usecases/login_usecase.dart';

// Providers
import 'package:aqua_inspector/features/auth/presentation/providers/auth_provider.dart';

class DependencyInjection {
  // Instancias singleton para reutilizar
  static http.Client? _httpClient;
  static SharedPreferences? _sharedPreferences;
  static AuthRemoteDataSource? _authRemoteDataSource;
  static AuthRepository? _authRepository;
  static LoginUseCase? _loginUseCase;
  static AuthProvider? _authProvider;

  /// Inicializa todas las dependencias necesarias para Auth
  static Future<void> init() async {
    // 1. Cargar configuración desde .env
    await AppConfig.init();
    AppConfig.validateConfig();
    AppConfig.printConfig();

    // 2. Inicializar servicios externos (solo una vez)
    await _initExternalServices();

    // 3. Configurar dependencias de Auth
    await _setupAuthDependencies();
  }

  /// Inicializa servicios externos como SharedPreferences
  static Future<void> _initExternalServices() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
      print('SharedPreferences inicializado');
    }

    if (_httpClient == null) {
      _httpClient = http.Client();
      print('HTTP Client inicializado');
    }
  }

  /// Configura todas las dependencias del módulo Auth
  static Future<void> _setupAuthDependencies() async {
    // 1. Data Source
    if (_authRemoteDataSource == null) {
      _authRemoteDataSource = AuthRemoteDataSourceImpl(client: _httpClient!, baseUrl: AppConfig.apiBaseUrl);
      print('AuthRemoteDataSource creado');
    }

    // 2. Repository
    if (_authRepository == null) {
      _authRepository = AuthRepositoryImpl(remoteDataSource: _authRemoteDataSource!, sharedPreferences: _sharedPreferences!);
      print('AuthRepository creado');
    }

    // 3. Use Cases
    if (_loginUseCase == null) {
      _loginUseCase = LoginUseCase(authRepository: _authRepository!);
      print('LoginUseCase creado');
    }

    // 4. Provider
    if (_authProvider == null) {
      _authProvider = AuthProvider(loginUseCase: _loginUseCase!, authRepository: _authRepository!);
      print('AuthProvider creado');
    }
  }

  // Getters para acceder a las instancias
  static AuthProvider get authProvider {
    if (_authProvider == null) {
      throw Exception('DependencyInjection no ha sido inicializado. Llama a DependencyInjection.init() primero.');
    }
    return _authProvider!;
  }

  static AuthRepository get authRepository {
    if (_authRepository == null) {
      throw Exception('DependencyInjection no ha sido inicializado. Llama a DependencyInjection.init() primero.');
    }
    return _authRepository!;
  }

  static LoginUseCase get loginUseCase {
    if (_loginUseCase == null) {
      throw Exception('DependencyInjection no ha sido inicializado. Llama a DependencyInjection.init() primero.');
    }
    return _loginUseCase!;
  }

  static SharedPreferences get sharedPreferences {
    if (_sharedPreferences == null) {
      throw Exception('DependencyInjection no ha sido inicializado. Llama a DependencyInjection.init() primero.');
    }
    return _sharedPreferences!;
  }

  /// Método para limpiar dependencias
  static void reset() {
    _httpClient?.close();
    _httpClient = null;
    _sharedPreferences = null;
    _authRemoteDataSource = null;
    _authRepository = null;
    _loginUseCase = null;
    _authProvider = null;
    print('🧹 DependencyInjection reseteado');
  }

  /// Método para configurar dependencias específicas para testing
  static void setupForTesting({
    http.Client? httpClient,
    SharedPreferences? sharedPreferences,
    AuthRemoteDataSource? authRemoteDataSource,
    AuthRepository? authRepository,
  }) {
    _httpClient = httpClient;
    _sharedPreferences = sharedPreferences;
    _authRemoteDataSource = authRemoteDataSource;
    _authRepository = authRepository;
    print('DependencyInjection configurado para testing');
  }
}
