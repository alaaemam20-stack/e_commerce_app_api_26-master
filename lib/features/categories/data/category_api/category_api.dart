import 'dart:convert';

import 'package:ecommerce_app_api_26/core/EndPoints/endPoints.dart';
import 'package:ecommerce_app_api_26/features/categories/data/models/category_model.dart';
import 'package:http/http.dart' as http;
class CategoryApi {
    Future<List<CategoryModel>>getAllCategories()async{


      Uri url =Uri.parse(Endpoints.baseUrl+Endpoints.allCategories);
      var response= await http.get(url);
      var json=jsonDecode(response.body)as List;
// .map ...apply operation(convert to cattegorymodel) in every element in list
      List<CategoryModel>categories=json.map((element){
        return CategoryModel.fromJson(element);

      }).toList();
      return categories;


    }









}