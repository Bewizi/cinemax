import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ApiInterceptor extends Interceptor {
  final secureStorage = const FlutterSecureStorage();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // final prefs = await SharedPreferences.getInstance();
    // final token = prefs.getString('auth_token');
    final token = await secureStorage.read(key: 'auth_token');
    final user = await secureStorage.read(key: 'auth_user');

    if (token != null && user != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await secureStorage.delete(key: 'auth_token');
      await secureStorage.delete(key: 'auth_user');
    }

    super.onError(err, handler);
  }
}
