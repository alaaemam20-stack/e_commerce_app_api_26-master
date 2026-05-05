import 'dart:convert';

import 'package:ecommerce_app_api_26/core/EndPoints/endPoints.dart';
import 'package:ecommerce_app_api_26/core/storage/storage_helper.dart';
import 'package:ecommerce_app_api_26/features/auth/data/models/login_error.dart';
import 'package:ecommerce_app_api_26/features/auth/data/models/request_models/login_request.dart';
import 'package:ecommerce_app_api_26/features/auth/data/models/login_response.dart';
import 'package:ecommerce_app_api_26/features/auth/data/models/request_models/signup_request.dart';
import 'package:http/http.dart' as http;

import '../models/signupResponseModel.dart';

class AuthApi {
  //methode deal with api requests(login,signup)
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    //need url+ body

    Uri url = Uri.parse(Endpoints.baseUrl + Endpoints.login);
   LoginRequestModel loginrequest=LoginRequestModel(
     email: email,
     password:password,
   );
    var response = await http.post(
      url,
      body: jsonEncode(loginrequest.tojson()),
      headers: {"Content-Type": "application/json"},
    );

    String responseBody = response.body;
    var json = jsonDecode(responseBody);
    if (response.statusCode == 200 || response.statusCode == 201) {
LoginResponseModel tokenModel=LoginResponseModel.fromJson(json);
StorageHelper.saveToken(tokenModel.accessToken??"");

      return tokenModel;
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
    SignupRequestModel signupRequestModel=SignupRequestModel(
        name: name, email: email,
        password: password);
    Map<String, dynamic> requestedBody = {
      ApiKeys.name: name,
      ApiKeys.email: email,
      ApiKeys.password: password,
      "avatar": "https://picsum.photos/800",
    };
    var response  = await  http.post(
      url,
      body: jsonEncode(signupRequestModel.tojson()),
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

