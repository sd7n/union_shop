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
    if (item == null) {
      return const SizedBox.shrink();
    }

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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    iconSize: 20,
                    onPressed: onIncrease,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text(item.quantity.toString()),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    iconSize: 20,
                    onPressed: onDecrease,
                  ),
                ],
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
