part of 'singup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupSuccess extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupFailure extends SignupState {
  final String errorMessage;

  SignupFailure({required this.errorMessage});
}
