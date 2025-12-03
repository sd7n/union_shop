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
      final List<dynamic> jsonList = cartStringDecode(cartString);
      final products = DataService.instance.products;

      _cart.items.clear();

      for (final json in jsonList) {
        final productId = json['productId'];
        final size = json['size'];
        final quantity = json['quantity'];

        final product = products.firstWhere(
          (p) => p.id == productId,
          orElse: () => throw Exception("Invalid product ID: $productId"),
        );

        _cart.items.add(
          CartItem(
            product: product,
            quantity: quantity,
            size: size,
          ),
        );
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading cart: $e');
    }
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = _cart.items.map((item) {
      return {
        'productId': item.product.id,
        'quantity': item.quantity,
        'size': item.size,
      };
    }).toList();
    await prefs.setString('cart', cartStringEncode(cartData));
  }

  String cartStringEncode(List<Map<String, dynamic>> data) {
    return data.toString();
  }

  List<dynamic> cartStringDecode(String data) {
    try {
      final cleaned = data
          .replaceAll('[', '')
          .replaceAll(']', '')
          .split('},')
          .map((chunk) => chunk.endsWith('}') ? chunk : "$chunk}")
          .toList();

      return cleaned.map((c) {
        return {
          'productId': _extract(c, 'productId'),
          'quantity': int.parse(_extract(c, 'quantity')),
          'size': _extract(c, 'size'),
        };
      }).toList();
    } catch (e) {
      debugPrint('Error decoding saved cart: $e');
      return [];
    }
  }

  String _extract(String source, String key) {
    final pattern = RegExp("$key: ([^,}]+)");
    final match = pattern.firstMatch(source);
    return match != null ? match.group(1)!.trim() : "";
  }
}
