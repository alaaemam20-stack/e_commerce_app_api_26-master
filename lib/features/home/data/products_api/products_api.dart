import 'dart:convert';

import 'package:ecommerce_app_api_26/core/EndPoints/endPoints.dart';
import 'package:ecommerce_app_api_26/features/home/data/models/product_model.dart';
import 'package:ecommerce_app_api_26/features/profile/data/models/profile_model.dart';
import 'package:http/http.dart' as http;
class ProductsApi{
  Future<List<ProductModel>>getAllProducts()async{


    Uri url =Uri.parse(Endpoints.baseUrl+Endpoints.allProduct);
   var response= await http.get(url);
   var json=jsonDecode(response.body)as List;
// .map ...apply operation(convert to productmodel) in every element in list
   List<ProductModel>products=json.map((element){
     return ProductModel.fromJson(element);

   }).toList();
   return products;


  }
  Future<List<ProductModel>>getProductById(int categoryId)async{
    Uri url =Uri.parse(Endpoints.baseUrl+Endpoints.allProduct+"?categoryId=$categoryId");
    var response= await http.get(url);
    var json=jsonDecode(response.body)as List;
// .map ...apply operation(convert to productmodel) in every element in list
    List<ProductModel>products=json.map((element){
      return ProductModel.fromJson(element);

    }).toList();
    return products;

  }


}