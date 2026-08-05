import 'dart:convert';

import 'package:cinemax/core/data/api.dart';
import 'package:cinemax/core/data/api_client.dart';
import 'package:cinemax/features/Auth/data/models/user_model.dart';
import 'package:cinemax/features/Auth/domain/auth_repository.dart';
import 'package:cinemax/features/Auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthData implements AuthRepository {
  AuthData(this._apiClient);

  final ApiClient _apiClient;
  final _secureStorage = const FlutterSecureStorage();

  static const _tokenKey = 'auth_token';
  static const _userKey = 'auth_user';

  Future<void> _persistSession(UserModel user, {String? token}) async {
    if (token != null) {
      await _secureStorage.write(key: _tokenKey, value: token);
      _apiClient.setToken(token);
    }
    await _secureStorage.write(key: _userKey, value: jsonEncode(user.toJson()));
  }

  @override
  Future<UserEntity> signUp({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await _apiClient.post(
      Api.signup,
      data: {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      },
    );

    final data = response.data;
    if (data is Map<String, dynamic>) {
      final userJson = data['user'] as Map<String, dynamic>;
      final userModel = UserModel.fromJson(userJson);

      final token = data['token'] as String?;
      await _persistSession(userModel, token: token);

      return userModel.toEntity();
    }
    throw Exception('Invalid response format');
  }

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post(
      Api.login,
      data: {
        'email': email,
        'password': password,
      },
    );

    final data = response.data;
    if (data is Map<String, dynamic>) {
      final userJson = data['user'] as Map<String, dynamic>;
      final userModel = UserModel.fromJson(userJson);

      final token = data['token'] as String?;
      await _persistSession(userModel, token: token);

      return userModel.toEntity();
    }
    throw Exception('Login failed: Invalid response');
  }

  @override
  Future<void> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      throw Exception('Google sign-in was cancelled');
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<bool> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final response = await _apiClient.post(
      Api.verifyOtp,
      data: {
        'email': email,
        'otp': otp,
      },
    );

    final data = response.data;
    if (data is Map<String, dynamic>) {
      return data['verified'] as bool? ?? false;
    }
    return false;
  }

  @override
  Future<void> resendOtp({
    required String email,
  }) async {
    await _apiClient.post(Api.resendOtp, data: {'email': email});
  }

  @override
  Future<void> logout() async {
    await _apiClient.post(Api.logout);
    _apiClient.clearToken();
    await _secureStorage.delete(key: _tokenKey);
    await _secureStorage.delete(key: _userKey);
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final token = await _secureStorage.read(key: _tokenKey);
    final stored = await _secureStorage.read(key: _userKey);
    if (token == null || stored == null) {
      return null;
    }

    _apiClient.setToken(token);
    final json = jsonDecode(stored) as Map<String, dynamic>;
    return UserModel.fromJson(json).toEntity();
  }
}
