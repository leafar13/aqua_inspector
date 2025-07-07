import 'package:aqua_inspector/core/providers/app_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config_providers.g.dart';

@riverpod
Future<AppConfig> appConfig(Ref ref) async {
  await AppConfig.init();
  AppConfig.validateConfig();
  AppConfig.printConfig();
  return AppConfig();
}

@riverpod
Future<bool> appInitialization(Ref ref) async {
  try {
    // Forzar inicialización de dependencias críticas
    await ref.watch(appConfigProvider.future);

    print('App inicializada correctamente');
    return true;
  } catch (e) {
    print('Error inicializando app: $e');
    rethrow;
  }
}

@riverpod
class DarkMode extends _$DarkMode {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}
