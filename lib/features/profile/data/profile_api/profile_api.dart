import 'dart:convert';

import 'package:ecommerce_app_api_26/core/EndPoints/endPoints.dart';
import 'package:ecommerce_app_api_26/core/storage/storage_helper.dart';
import 'package:ecommerce_app_api_26/features/profile/data/models/profile_model.dart';
import 'package:http/http.dart' as http;

import '../models/profile_error_model.dart';
class ProfileApi {
 Future<ProfileModel> getProfile()async{
   Uri url=Uri.parse(Endpoints.baseUrl+Endpoints.profile);
   // var get data from storage
   String? token =await StorageHelper.getToken();
   var response=await http.get(url,
   headers: {

     "Authorization":"Bearer $token"
   }

   );
   var json=jsonDecode(response.body);
   if(response.statusCode==200||response.statusCode==201){
     ProfileModel profileModel=ProfileModel.fromJson(json);
     return profileModel;

   }else{
     ProfileErrorModel errorModel=ProfileErrorModel.fromJson(json);
     throw Exception(errorModel.message);
   }


  }

}