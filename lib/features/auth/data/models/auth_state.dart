import 'package:aqua_inspector/features/auth/domain/entities/user.dart';
import 'package:aqua_inspector/features/auth/presentation/providers/auth_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const AuthState._();
  const factory AuthState({@Default(AuthStatus.initial) AuthStatus status, User? currentUser, String? errorMessage, @Default(false) bool isLoading}) =
      _AuthState;

  // Custom copyWith method with clearUser logic
  AuthState customCopyWith({AuthStatus? status, User? currentUser, String? errorMessage, bool? isLoading, bool clearUser = false}) {
    return copyWith(
      status: status ?? this.status,
      currentUser: clearUser ? null : (currentUser ?? this.currentUser),
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  // Add a getter for authentication status
  bool get isAuthenticated => status == AuthStatus.authenticated;
}
