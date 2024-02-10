import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

final authServiceProvider = Provider<AuthService>((_) => AuthService());

class AuthService {
  final _client = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:3000',
    ),
  );

  final _secureStorage = const FlutterSecureStorage();
  final Logger _logger = Logger();

  Future<void> saveCredentials(Map response) async {
    Map<String, String> credentials = {};
    try {
      credentials = {
        'token': response['token'],
        '_id': response['_id'],
        'name': response['name'],
        'email': response['email'],
        'role': response['role'],
      };
      await _secureStorage.write(key: 'token', value: credentials['token']);
      await _secureStorage.write(key: '_id', value: credentials['_id']);
      await _secureStorage.write(key: 'name', value: credentials['name']);
      await _secureStorage.write(key: 'email', value: credentials['email']);
      await _secureStorage.write(key: 'role', value: credentials['role']);
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<Map<String, String>> checkCredentials() async {
    Map<String, String> credentials = {};
    try {
      credentials = {
        'token': await _secureStorage.read(key: 'token') ?? '',
        '_id': await _secureStorage.read(key: '_id') ?? '',
        'name': await _secureStorage.read(key: 'name') ?? '',
        'email': await _secureStorage.read(key: 'email') ?? '',
        'role': await _secureStorage.read(key: 'role') ?? '',
      };
      await Future.delayed(const Duration(seconds: 2));
      return credentials;
    } catch (e) {
      _logger.e(e);
      return credentials;
    }
  }

  Future<bool> clearCredentials() async {
    try {
      await _secureStorage.delete(key: 'token');
      await _secureStorage.delete(key: '_id');
      await _secureStorage.delete(key: 'name');
      await _secureStorage.delete(key: 'email');
      await _secureStorage.delete(key: 'role');
      return true;
    } catch (e) {
      _logger.e(e);
      return false;
    }
  }

  Future<Map<String, dynamic>> loginAdmin(String email, String password) async {
    try {
      final response = await _client.post(
        '/admin-auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      _logger.i(response.data);
      return response.data;
    } catch (e) {
      _logger.e(e);
      return {};
    }
  }

  void loginStudent() async {
    try {
      final response = await _client.post('/login/student');
      _logger.i(response.data);
    } catch (e) {
      _logger.e(e);
    }
  }
}
