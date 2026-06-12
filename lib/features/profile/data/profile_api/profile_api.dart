import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_app_api_26/core/EndPoints/endPoints.dart';
import 'package:ecommerce_app_api_26/core/storage/storage_helper.dart';
import 'package:ecommerce_app_api_26/features/profile/data/models/profile_model.dart';
import 'package:http/http.dart' as http;

import '../models/profile_error_model.dart';
import '../models/upload_model.dart';
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
 /// upload image
 Future<String?> uploadImage(String avatar) async {
   Uri url = Uri.parse(Endpoints.baseUrl + Endpoints.uploadImage);

   var request = http.MultipartRequest('POST', url);
   request.files.add(await http.MultipartFile.fromPath('file', avatar));
   var streamResponse = await request.send();
   var response = await http.Response.fromStream(streamResponse);
   var json = jsonDecode(response.body);
   if (response.statusCode == 200 || response.statusCode == 201) {
     final imageUrl = UploadImageModel.fromJson(json);
     return imageUrl.location;
   } else {
     ProfileErrorModel error = ProfileErrorModel.fromJson(json);
     throw Exception(error.message);
   }
 }/// update profile
 Future<ProfileModel> updateProfile(
     int userId,
     String name,
     String role,
     String? avatar,
     ) async {
   Uri url = Uri.parse(
     "${Endpoints.baseUrl + Endpoints.updateProfile}/$userId",
   );
   String? token = await StorageHelper.getToken();
   Map<String, dynamic> requestedBody = {
     ApiKeys.name: name,
     ApiKeys.role: role,
     ApiKeys.avatar: avatar,
   };
   var response = await http.put(
     url,
     body: jsonEncode(requestedBody),
     headers: {
       "Authorization": "Bearer $token",
       "Content-Type": "application/json",
     },
   );
   var json = jsonDecode(response.body);
   if (response.statusCode == 200 || response.statusCode == 201) {
     ProfileModel profileModel = ProfileModel.fromJson(json);
     return profileModel;
   } else {
     ProfileErrorModel error = ProfileErrorModel.fromJson(json);
     throw Exception(error.message);
   }
 }

}

