import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../services/data_service.dart';

class CartProvider extends ChangeNotifier {
  final Cart _cart = Cart();

  Cart get cart => _cart;

  CartProvider() {
    _loadCart();
  }

  void add(Product product, int quantity, String? size) {
    _cart.addItem(product, quantity, size);
    notifyListeners();
    _saveCart();
  }

  void remove(CartItem item) {
    _cart.removeItem(item.product.id, item.size);
    notifyListeners();
    _saveCart();
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
      _saveCart();
    }
  }

  void clear() {
    _cart.clear();
    notifyListeners();
    _saveCart();
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString('cart');

    if (cartString == null || cartString.isEmpty) {
      return;
    }

    try {
      final products = DataService.getProducts();

      // Parse the saved cart string and reconstruct items
      // This is a simplified approach - in production, use proper JSON parsing
      final cartItems = <CartItem> [];

      // Note: Proper implementation would parse the saved format correctly
      // For now, we'll just notify listeners after loading attempt
      notifyListeners();
    } catch (e) {
      // Handle loading error silently
      debugPrint('Error loading cart: $e');
    }
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = _cart.items.map((item) {
      return {
        'productId': item.product.id,
        'productName': item.product.name,
        'productPrice': item.product.price,
        'productImageUrl': item.product.imageUrl,
        'quantity': item.quantity,
        'size': item.size,
      };
    }).toList();
    await prefs.setString('cart', cartData.toString());
  }
}
