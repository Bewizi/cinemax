import 'dart:io';

import 'package:flutter/foundation.dart';

class Api {
  static String get rootUrl {
    if (kIsWeb) {
      return 'http://localhost:8000/';
    }
    return Platform.isAndroid
        ? 'http://10.0.2.2:8000/'
        : 'http://localhost:8000/';
  }

  static String get baseUrl => '${rootUrl}api/';

  // static const baseUrl = 'http://localhost:8000/api/';
  //auth
  static const signup = 'register';
  static const login = 'login';
  static const sendOtp = 'v1/otp/';
  static const verifyOtp = 'v1/otp/verify';
  static const resendOtp = 'v1/otp/resend';
  static const logout = 'logout';

  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, String> authHeaders(String token) => {
    ...headers,
    'Authorization': 'Bearer $token',
  };
}
