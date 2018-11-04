import 'dart:async';
import 'dart:convert';

import 'package:cv/src/models/auth_model.dart';
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
    }).catchError((error) {
      AuthLoginResponseModel response =
          AuthLoginResponseModel(token: null, user: null);
      response.error = true;
      response.message = error.toString();
      return response;
    });
  }
}
