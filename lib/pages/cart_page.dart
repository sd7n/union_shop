import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/widgets/page_shell.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    final provider = context.read<CartProvider>();

    if (cart.items.isEmpty) {
      return PageShell(
        child: Center(
          child: Text(
            'Your cart is empty',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      );
    }

    return PageShell(
      child: ListView(
        shrinkWrap: true,
        children: cart.items
            .map((item) => ListTile(
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
                ))
            .toList(),
      ),
    );
  }
}
