import 'product.dart';

class CartItem {
  final Product product;
  int quantity;
  final String? size;

  CartItem({
    required this.product,
    required this.quantity,
    this.size,
  });

  double get totalPrice => product.price * quantity;

  Map<String, dynamic> toJson() => {
    'productId': product.id,
    'quantity': quantity,
    'size': size,
  };

  factory CartItem.fromJson(Map<String, dynamic> json, Product product) {
    return CartItem(
      product: product,
      quantity: json['quantity'] as int,
      size: json['size'] as String?,
    );
  }

  CartItem copyWith({
    Product? product,
    int? quantity,
    String? size,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
    );
  }

  @override
  String toString() =>
      'CartItem(product: ${product.name}, quantity: $quantity, size: $size, totalPrice: ${totalPrice.toStringAsFixed(2)})';
}
