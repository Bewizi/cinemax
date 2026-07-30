import 'package:cinemax/core/data/error/api_exception.dart';
import 'package:cinemax/features/Auth/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('getErrorMessage', () {
    test('returns the backend message from ServerException', () {
      expect(
        getErrorMessage(ServerException('The email has already been taken.')),
        'The email has already been taken.',
      );
    });

    test('returns the network message from NetworkException', () {
      expect(
        getErrorMessage(NetworkException('No internet connection')),
        'No internet connection',
      );
    });

    test('strips the Exception prefix from generic exceptions', () {
      expect(
        getErrorMessage(Exception('Unexpected error occurred')),
        'Unexpected error occurred',
      );
    });
  });
}
