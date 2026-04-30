import 'dart:convert';

import 'package:ecommerce_app_api_26/core/EndPoints/endPoints.dart';
import 'package:ecommerce_app_api_26/features/auth/data/models/error_model.dart';
import 'package:ecommerce_app_api_26/features/auth/data/models/token_model.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class AuthApi {
  //methode deal with api requests(login,signup)
  Future<TokenModel> login({
    required String email,
    required String password,
  }) async {
    //need url+ body

    Uri url = Uri.parse(Endpoints.baseUrl + Endpoints.login);
    Map<String, dynamic> RequestBody = {
      ApiKeys.email: email,
      ApiKeys.password: password,
    };
    var response = await http.post(
      url,
      body: jsonEncode(RequestBody),
      headers: {"Content-Type": "application/json"},
    );

    String responseBody = response.body;
    var json = jsonDecode(responseBody);
    if (response.statusCode == 200 || response.statusCode == 201) {
      TokenModel tokens = TokenModel.fromJson(json);
      return tokens;
    } else {
      ErrorModel error = ErrorModel.fromJson(json);
      throw Exception(error.message);
    }
  }

   Future<UserModel>signup({
    required String name,
    required String email,
    required String password,
  })async {
    Uri url = Uri.parse(Endpoints.baseUrl + Endpoints.signup);
    Map<String, dynamic> requestedBody = {
      ApiKeys.name: name,
      ApiKeys.email: email,
      ApiKeys.password: password,
      "avatar": "https://picsum.photos/800",
    };
    var response  = await  http.post(
      url,
      body: jsonEncode(requestedBody),
      headers: {"Content-Type": "application/json"},
    );
    String responseBody = response.body;
    var json = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.fromJson(json);
    } else {
      ErrorModel error = ErrorModel.fromJson(json);
      throw Exception(error.message);
    }
  }

  }

