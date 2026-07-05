part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  final UserTypeEnum userType;

  AuthSuccessState({required this.userType});
}

final class AuthFailureState extends AuthState {
  AuthFailureState(this.message);
  final String message;
}
