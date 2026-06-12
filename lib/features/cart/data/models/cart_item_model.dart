class CartItemModel {
  final int id;
  final String title;
  final double price;
  int quantity;

  CartItemModel({
    required this.id,
    required this.title,
    required this.price,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "quantity": quantity,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json["id"],
      title: json["title"],
      price: json["price"].toDouble(),
      quantity: json["quantity"],
    );
  }
}