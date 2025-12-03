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

  void updateQuantity(CartItem item, int newQuantity) {
    if (newQuantity < 1) {
      remove(item);
      return;
    }

    final index = _cart.items.indexWhere(
      (i) => i.product.id == item.product.id && i.size == item.size,
    );

    if (index != -1) {
      _cart.items[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  void clear() {
    _cart.clear();
    notifyListeners();
  }
}
