import 'package:aqua_inspector/core/config/app_config.dart';
import 'package:aqua_inspector/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:aqua_inspector/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:aqua_inspector/features/auth/domain/repositories/auth_repository.dart';
import 'package:aqua_inspector/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'providers.g.dart';

@riverpod
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  print('SharedPreferences inicializado');
  return await SharedPreferences.getInstance();
}

@riverpod
http.Client httpClient(Ref ref) {
  print('🌐 Creando nuevo HTTP Client...');
  final client = http.Client();

  // Mantener el cliente vivo durante toda la vida de la app
  ref.keepAlive();

  // Cleanup automático cuando el provider se dispose
  ref.onDispose(() {
    print('🗑️ Cerrando HTTP Client...');
    client.close();
  });

  print('🌐 HTTP Client creado: ${client.hashCode}');
  return client;
}

@riverpod
Future<AppConfig> appConfig(Ref ref) async {
  await AppConfig.init();
  AppConfig.validateConfig();
  AppConfig.printConfig();
  return AppConfig();
}

@riverpod
Future<AuthRemoteDataSource> authRemoteDataSource(Ref ref) async {
  print('🔧 Inicializando AuthRemoteDataSource...');
  final client = ref.watch(httpClientProvider);
  await ref.watch(appConfigProvider.future); // Asegurar que AppConfig esté inicializado
  print('🔧 AuthRemoteDataSource creado con baseUrl: ${AppConfig.apiBaseUrl}');
  print('🔧 Cliente HTTP: ${client.hashCode}');

  return AuthRemoteDataSourceImpl(client: client, baseUrl: AppConfig.apiBaseUrl);
}

@riverpod
Future<AuthRepository> authRepository(Ref ref) async {
  final remoteDataSource = await ref.watch(authRemoteDataSourceProvider.future);
  final sharedPrefs = await ref.watch(sharedPreferencesProvider.future);

  return AuthRepositoryImpl(remoteDataSource: remoteDataSource, sharedPreferences: sharedPrefs);
}

@riverpod
Future<LoginUseCase> loginUseCase(Ref ref) async {
  print('📋 Inicializando LoginUseCase...');
  final authRepo = await ref.watch(authRepositoryProvider.future);
  print('📋 LoginUseCase creado');

  return LoginUseCase(authRepository: authRepo);
}

@riverpod
Future<bool> appInitialization(Ref ref) async {
  try {
    // Forzar inicialización de dependencias críticas
    await ref.watch(appConfigProvider.future);
    await ref.watch(sharedPreferencesProvider.future);

    print('App inicializada correctamente');
    return true;
  } catch (e) {
    print('Error inicializando app: $e');
    rethrow;
  }
}
