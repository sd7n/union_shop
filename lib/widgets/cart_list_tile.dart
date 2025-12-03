import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';

class CartListTile extends StatelessWidget {
  final CartItem item;
  final CartProvider provider;

  const CartListTile({
    super.key,
    required this.item,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        item.product.imageUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(item.product.name),
      subtitle: Text('Size: ${item.size ?? 'N/A'}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () => provider.updateQuantity(
              item,
              item.quantity - 1,
            ),
          ),
          Text(item.quantity.toString()),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => provider.updateQuantity(
              item,
              item.quantity + 1,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '£${item.totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
