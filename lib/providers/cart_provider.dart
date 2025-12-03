import 'package:flutter/foundation.dart';
import '../models/cart.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Cart _cart = Cart();

  Cart get cart => _cart;

  void add(Product product, int quantity, String? size) {
    _cart.addItem(product, quantity, size);
    notifyListeners();
  }

  void remove(CartItem item) {
    _cart.removeItem(item.product.id, item.size);
    notifyListeners();
  }

  void updateQuantity(CartItem item, int qty) {
    if (qty <= 0) {
      remove(item);
    } else {
      final index = _cart.items.indexOf(item);
      if (index != -1) {
        _cart.items[index].quantity = qty;
        notifyListeners();
      }
    }
  }

  void clear() {
    _cart.clear();
    notifyListeners();
  }
}
