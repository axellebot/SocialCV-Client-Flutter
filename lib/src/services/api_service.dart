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
    final response = await client.post(
      "$_baseUrl/auth/login",
      headers: headers,
      body: jsonEncode(loginModel),
    );
    Map<String, dynamic> json = jsonDecode(response.body);

    // If that call was not successful, throw an error.
    return AuthLoginResponseModel.fromJson(json);
  }
}
