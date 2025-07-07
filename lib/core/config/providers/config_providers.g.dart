// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'aa2938c3f485b8fec6e6d1e4441b44677a5bb44d';

/// See also [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider =
    AutoDisposeFutureProvider<SharedPreferences>.internal(
      sharedPreferences,
      name: r'sharedPreferencesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sharedPreferencesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedPreferencesRef = AutoDisposeFutureProviderRef<SharedPreferences>;
String _$httpClientHash() => r'32678d1078fca5ad7ccbcbb212322b27e7d192b3';

/// See also [httpClient].
@ProviderFor(httpClient)
final httpClientProvider = AutoDisposeProvider<http.Client>.internal(
  httpClient,
  name: r'httpClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$httpClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HttpClientRef = AutoDisposeProviderRef<http.Client>;
String _$appConfigHash() => r'38d74e484e5f88647d3090de0155cef8a8597295';

/// See also [appConfig].
@ProviderFor(appConfig)
final appConfigProvider = AutoDisposeFutureProvider<AppConfig>.internal(
  appConfig,
  name: r'appConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppConfigRef = AutoDisposeFutureProviderRef<AppConfig>;
String _$authRemoteDataSourceHash() =>
    r'c81db24387e80dfe447c73609533b17dc41c4b0a';

/// See also [authRemoteDataSource].
@ProviderFor(authRemoteDataSource)
final authRemoteDataSourceProvider =
    AutoDisposeFutureProvider<AuthRemoteDataSource>.internal(
      authRemoteDataSource,
      name: r'authRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$authRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRemoteDataSourceRef =
    AutoDisposeFutureProviderRef<AuthRemoteDataSource>;
String _$authRepositoryHash() => r'3eab85e9d88fd8b2e7ac8c300ee692d52d747c19';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider =
    AutoDisposeFutureProvider<AuthRepository>.internal(
      authRepository,
      name: r'authRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$authRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = AutoDisposeFutureProviderRef<AuthRepository>;
String _$loginUseCaseHash() => r'b8396c8dc0eef71d47c6298ca1aac97ebb35f7e1';

/// See also [loginUseCase].
@ProviderFor(loginUseCase)
final loginUseCaseProvider = AutoDisposeFutureProvider<LoginUseCase>.internal(
  loginUseCase,
  name: r'loginUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loginUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LoginUseCaseRef = AutoDisposeFutureProviderRef<LoginUseCase>;
String _$appInitializationHash() => r'c4b5138c7fcf7845678077f6181df990ace860d3';

/// See also [appInitialization].
@ProviderFor(appInitialization)
final appInitializationProvider = AutoDisposeFutureProvider<bool>.internal(
  appInitialization,
  name: r'appInitializationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appInitializationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppInitializationRef = AutoDisposeFutureProviderRef<bool>;
String _$darkModeHash() => r'de8df955555af3cbc4fd1bbfb9665f163bfc542f';

/// See also [DarkMode].
@ProviderFor(DarkMode)
final darkModeProvider = AutoDisposeNotifierProvider<DarkMode, bool>.internal(
  DarkMode.new,
  name: r'darkModeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$darkModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DarkMode = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
