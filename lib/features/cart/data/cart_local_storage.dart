import 'dart:convert';
import 'package:ecommerce_app_api_26/features/home/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/cart_item_model.dart';


class CartLocalStorage {
  static const String key = "cart";

  //add
  static Future<void> addToCart(ProductModel product) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(key) ?? [];
    List<ProductModel> items = cart
        .map((e) => ProductModel.fromJson(jsonDecode(e)))
        .toList();
    items.add(product);
    await prefs.setStringList(
      key,
      items.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }
  // get
  static Future<List<ProductModel>> getCardProducts() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> cartList = prefs.getStringList(key) ?? [];

    return cartList.map((item) {
      final json = jsonDecode(item) as Map<String, dynamic>;
      return ProductModel.fromJson(json);
    }).toList();
  }


  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }


  static Future<void> saveList(List<CartItemModel> items) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
      key,
      items.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

static Future<void> removeProduct(int productId) async {
final prefs = await SharedPreferences.getInstance();

List<String> cart = prefs.getStringList(key) ?? [];

cart.removeWhere((item) {
final product = ProductModel.fromJson(
jsonDecode(item),
);

return product.id == productId;
});

await prefs.setStringList(key, cart);
}}

