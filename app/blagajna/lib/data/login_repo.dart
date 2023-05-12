import 'dart:io';

import 'package:blagajna/data/url_constants.dart';
import 'package:dio/dio.dart';

class LoginRepo {

  static String? username;

  Future<bool> loginUser(String username, String password) async {
    Map<String, String> body = {
      'username': username,
      'password': password,
    };

    try {
      var response = await Dio().post(UrlConstants.baseUrl + UrlConstants.loginUrl,
          data: body,
          options: Options(
            contentType: "application/json",
          ));
      var responseBody = response.data;
      username = responseBody['username'];
      return true;
    } catch (e) {
      return false;
    }
  }
}
