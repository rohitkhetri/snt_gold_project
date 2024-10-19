
class CartProduct {
  final int productId;
  final int quantity;
  final int productIndex;
  final int size;

  CartProduct({
    required this.productId,
    required this.quantity,
    required this.productIndex,
    required this.size,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      productId: json['productId'],
      quantity: json['quantity'],
      productIndex: json['product_index'],
      size: json['size'],
    );
  }
}

