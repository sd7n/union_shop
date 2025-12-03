import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/widgets/page_shell.dart';
import 'package:union_shop/widgets/cart_list_tile.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView(
            shrinkWrap: true,
            children: cart.items
                .map((item) => Dismissible(
                      key: ValueKey('${item.product.id}_${item.size ?? 'none'}'),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) => provider.remove(item),
                      child: CartListTile(item: item, provider: provider),
                    ))
                .toList(),
          ),
          const SizedBox(height: 24),
          Text(
            'Subtotal: £${cart.total.toStringAsFixed(2)}',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }
}
