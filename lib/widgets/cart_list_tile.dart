import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';

class CartListTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const CartListTile({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
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
                onPressed: onDecrease,
              ),
              Text(item.quantity.toString()),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: onIncrease,
              ),
              const SizedBox(width: 16),
              Text(
                '£${item.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: onRemove,
                child: const Text('Remove'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
