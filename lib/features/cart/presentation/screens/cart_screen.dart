import 'package:ecommerce_app_api_26/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_api_26/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app_api_26/features/cart/data/cart_local_storage.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<ProductModel> cartItems = [];
  bool isLoading = true;
  double totalPrice() {
    double total = 0;
    for (var item in cartItems) {
      total += (item.price ?? 0);
    }
    return total;
  }


  Future<void> getCart() async {
    cartItems = await CartLocalStorage.getCardProducts();
    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    getCart();
  }

  Widget build(BuildContext context) {
    if(isLoading){
      return Scaffold(body: Center(child: CircularProgressIndicator(),),);

    }if(cartItems.isEmpty){
      return Scaffold(body: Center(child:Text("cart is empty"),),);
    }
    return  Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('My Cart', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems[index];
                return ListTile(
                    leading: Image.network(product.images?.first ?? ''),
                    title: Text(product.title ?? ''),
                    subtitle: Text("${product.price ?? 0} EGP"),
                    trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        _buildQtyBtn(Icons.remove, () async {

                      await getCart();
                    }),
                    SizedBox(width: 8),
                    Text("1"),
                    SizedBox(width: 8),
                          _buildQtyBtn(Icons.add, () async {

                            await getCart();
                          }),
                        ]));}
                     ),
                     ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Amount', style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
                    Text('\$${totalPrice().toStringAsFixed(2)}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue)),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 0,
                    ),
                    child: const Text('Checkout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: Colors.black),
      ),
    );
  }
}
