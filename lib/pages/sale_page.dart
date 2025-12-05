import 'package:flutter/material.dart';
import '../widgets/page_shell.dart';
import '../widgets/product_tile.dart';
import '../services/data_service.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  String _selectedSort = 'featured';

  @override
  Widget build(BuildContext context) {
    final data = DataService.instance;
    // Get all products with strikePrice
    var saleProducts = data.products.where((p) => p.strikePrice != null).toList();
    
    // Sort products
    switch (_selectedSort) {
      case 'price_low':
        saleProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high':
        saleProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'featured':
      default:
        break;
    }

    return PageShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'FILTER BY',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: 'all',
                items: const [
                  DropdownMenuItem(
                    value: 'all',
                    child: Text('All products'),
                  ),
                ],
                onChanged: (value) {},
              ),
              const Spacer(),
              Text(
                'SORT BY',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: _selectedSort,
                items: const [
                  DropdownMenuItem(
                    value: 'featured',
                    child: Text('Best selling'),
                  ),
                  DropdownMenuItem(
                    value: 'price_low',
                    child: Text('Price: Low to High'),
                  ),
                  DropdownMenuItem(
                    value: 'price_high',
                    child: Text('Price: High to Low'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedSort = value;
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${saleProducts.length} products',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 900;
              final columns = isWide ? 3 : 2;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: saleProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: isWide ? 3 / 4.2 : 3 / 4.5,
                ),
                itemBuilder: (context, index) {
                  final product = saleProducts[index];
                  return ProductTile(
                    product: product,
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/product',
                      arguments: product.id,
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
