import 'package:bloc/bloc.dart';
import 'package:cinemax/core/data/error/api_exception.dart';
import 'package:cinemax/features/Auth/domain/auth_repository.dart';
import 'package:cinemax/features/Auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

String getErrorMessage(Object error) {
  if (error is ServerException) {
    return error.message;
  }

  if (error is NetworkException) {
    return error.message;
  }

  final message = error.toString();
  if (message.startsWith('Exception:')) {
    return message.replaceFirst('Exception:', '').trim();
  }

  return message;
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onCheckRequested);
    on<AuthSignUpRequested>(_onSignUpRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthGoogleSignInRequested>(_onGoogleSignInRequested);
    on<AuthVerifyOtpRequested>(_onVerifyOtpRequested);
    on<AuthResendOtpRequested>(_onResendOtpRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  final AuthRepository _authRepository;

  // Keeps the last known user around between states (e.g. between
  // AuthOtpVerificationSuccess and re-emitting AuthAuthenticated).
  UserEntity? _currentUser;

  Future<void> _onCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final user = await _authRepository.getCurrentUser();
    if (user != null) {
      _currentUser = user;
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.signUp(
        firstname: event.params.firstname,
        lastname: event.params.lastname,
        email: event.params.email,
        password: event.params.password,
        confirmPassword: event.params.confirmPassword,
      );
      _currentUser = user;
      emit(
        AuthSignUpSuccess(
          'Account created successfully!',
          email: event.params.email,
        ),
      );
    } on Exception catch (e) {
      emit(AuthFailure(getErrorMessage(e)));
    }
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.login(
        email: event.email,
        password: event.password,
      );
      _currentUser = user;
      emit(const AuthLoginSuccess('Login successful!'));
      emit(AuthAuthenticated(user));
    } on Exception catch (e) {
      emit(AuthFailure(getErrorMessage(e)));
    }
  }

  Future<void> _onGoogleSignInRequested(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.signInWithGoogle();
      emit(const AuthGoogleSignInSuccess('Google sign-in successful!'));
    } on Exception catch (e) {
      emit(AuthFailure(getErrorMessage(e)));
    }
  }

  Future<void> _onVerifyOtpRequested(
    AuthVerifyOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final isVerified = await _authRepository.verifyOtp(
        email: event.email,
        otp: event.otp,
      );
      if (isVerified) {
        emit(const AuthOtpVerificationSuccess('OTP verified successfully!'));
        if (_currentUser != null) {
          emit(AuthAuthenticated(_currentUser!));
        }
      } else {
        emit(const AuthFailure('Invalid OTP'));
      }
    } on Exception catch (e) {
      emit(AuthFailure(getErrorMessage(e)));
    }
  }

  Future<void> _onResendOtpRequested(
    AuthResendOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.resendOtp(email: event.email);
      emit(const AuthOtpResentSuccess('OTP resent successfully!'));
    } on Exception catch (e) {
      emit(AuthFailure(getErrorMessage(e)));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.logout();
      emit(AuthLogoutSuccess());
    } on Exception catch (e) {
      emit(AuthFailure(getErrorMessage(e)));
    } finally {
      _currentUser = null;
      emit(AuthUnauthenticated());
    }
  }
}
