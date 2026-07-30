import 'package:cinemax/features/Auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signUp({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<UserEntity> login({
    required String email,
    required String password,
  });

  Future<void> signInWithGoogle();

  Future<bool> verifyOtp({
    required String email,
    required String otp,
  });

  Future<void> resendOtp({
    required String email,
  });

  Future<void> logout();

  Future<UserEntity?> getCurrentUser();
}
