import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../server/routes.dart';
import '../util/either.dart';
import '../util/failures/backend_failure.dart';
import 'http_service.dart';

class AuthService {
  static AuthService? _instance;
  static AuthService get instance => _instance!;

  const AuthService._({required HttpService httpService}) : _http = httpService;

  factory AuthService({required HttpService httpService}) {
    if (_instance != null) {
      throw StateError('AuthService already created!');
    }

    _instance = AuthService._(httpService: httpService);
    return _instance!;
  }

  final HttpService _http;

  Future<Either<BackendFailure, EventPayUser>> login(
      String username, String password) async {
    final http.Response? response = await _http.post(
      [
        EPServerRoute.apiAuthLogin,
      ],
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: ContentType.json.value,
      },
      body: jsonEncode(
        <String, String>{
          'username': username,
          'password': password,
        },
      ),
    );

    if (response == null) return error(const UnknownBackendFailure());

    switch (response.statusCode) {
      case HttpStatus.ok:
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(
            'sessionId: ${jsonResponse['sessionId']}, oseba: ${jsonResponse['username']}.');
        return value(EventPayUser.fromJson(jsonResponse));
      case HttpStatus.badRequest:
        print('No email/password, fail code: ${response.statusCode}.');
        return error(const BadRequestBackendFailure());
      // return {'error': "badRequest"};
      case HttpStatus.notFound:
        print('Wrong email/password, fail code: ${response.statusCode}.');
        return error(const NotFoundBackendFailure());
      // return {'error': "notFound"};
      default:
        return error(const UnknownBackendFailure());
    }
  }

  Future<Either<BackendFailure, EventPayUser>> register(String firstname,
      String lastname, String email, String username, String password) async {
    print("$firstname, $lastname, $email, $username, $password");
    final http.Response? response = await _http.post(
      [
        EPServerRoute.apiAuthRegister,
      ],
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: ContentType.json.value,
      },
      body: jsonEncode(
        <String, String>{
          'firstname': firstname,
          'lastname': lastname,
          'email': email,
          'username': username,
          'password': password,
        },
      ),
    );

    if (response == null) return error(const UnknownBackendFailure());
    print("response.statusCode: ${response.statusCode}");

    switch (response.statusCode) {
      case HttpStatus.created:
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(
            'sessionId: ${jsonResponse['sessionId']}, oseba: ${jsonResponse['username']}.');
        return value(EventPayUser.fromJson(jsonDecode(response.body)));
      case HttpStatus.badRequest:
        print('Missing required field, fail code: ${response.statusCode}.');
        return error(const BadRequestBackendFailure());
      // return {'error': "badRequest"};
      case HttpStatus.forbidden:
        print('Email already taken, fail code: ${response.statusCode}.');
        return error(const ForbiddenBackendFailure());
      // return {'error': "forbidden"};
      default:
        return error(const UnknownBackendFailure());
    }
  }
}
