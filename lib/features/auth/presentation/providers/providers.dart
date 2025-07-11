import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';

part 'providers.g.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

@riverpod
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return await SharedPreferences.getInstance();
}

@riverpod
Future<AuthRepository> authRepository(Ref ref) async {
  return AuthRepositoryImpl(remoteDataSource: ref.watch(authRemoteDataSourceProvider), sharedPreferences: await ref.watch(sharedPreferencesProvider.future));
}
