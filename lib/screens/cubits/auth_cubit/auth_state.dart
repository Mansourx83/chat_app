part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class SignupInitial extends AuthState {}

final class SignupSuccess extends AuthState {}

final class SignupLoading extends AuthState {}

final class SignupFailure extends AuthState {
  final String errorMessage;

  SignupFailure({required this.errorMessage});
}

final class LoginInitial extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginFailure extends AuthState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}
