import 'dart:async';
import 'dart:convert';

import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:http/http.dart';

class ApiService {
  Client client = Client();
  final String _baseUrl = "https://api.cv.lebot.me";

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<AuthLoginResponseModel> login(AuthLoginModel loginModel) async {
    return client
        .post(
          "$_baseUrl/auth/login",
          headers: headers,
          body: jsonEncode(loginModel),
        )
        .timeout(Duration(seconds: 5))
        .then((onValue) {
      Map<String, dynamic> json = jsonDecode(onValue.body);
      return AuthLoginResponseModel.fromJson(json);
    });
  }

  Future<ResponseModel<UserModel>> fetchAccountDetails(String token) async {
    return client
        .get(
          "$_baseUrl/me?token=$token",
          headers: headers,
        )
        .timeout(Duration(seconds: 5))
        .then((onValue) {
      Map<String, dynamic> json = jsonDecode(onValue.body);
      return ResponseModel<UserModel>.fromJson(json);
    });
  }
}
