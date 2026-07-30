part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoaded extends AuthState {
  const AuthLoaded(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class AuthSignUpSuccess extends AuthState {
  const AuthSignUpSuccess(this.message, {this.email = ''});

  final String message;
  final String email;

  @override
  List<Object> get props => [message, email];
}

final class AuthLoginSuccess extends AuthState {
  const AuthLoginSuccess(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class AuthGoogleSignInSuccess extends AuthState {
  const AuthGoogleSignInSuccess(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class AuthOtpVerificationSuccess extends AuthState {
  const AuthOtpVerificationSuccess(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class AuthOtpResentSuccess extends AuthState {
  const AuthOtpResentSuccess(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class AuthFailure extends AuthState {
  const AuthFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class AuthLogoutSuccess extends AuthState {}

class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}
