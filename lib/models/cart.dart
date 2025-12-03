import 'product.dart';
import 'cart_item.dart';

class Cart {
  final List<CartItem> items = [];

  double get total {
    return items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  int get itemCount {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  void addItem(Product product, int quantity, String? size) {
    final existingItemIndex = items.indexWhere(
      (item) => item.product.id == product.id && item.size == size,
    );

    if (existingItemIndex != -1) {
      items[existingItemIndex].quantity += quantity;
    } else {
      items.add(CartItem(
        product: product,
        quantity: quantity,
        size: size,
      ));
    }
  }

  void removeItem(String productId, String? size) {
    items.removeWhere(
      (item) => item.product.id == productId && item.size == size,
    );
  }

  void clear() {
    items.clear();
  }
}
