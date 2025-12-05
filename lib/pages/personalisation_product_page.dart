import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/widgets/page_shell.dart';
import 'package:union_shop/providers/cart_provider.dart';
import 'package:union_shop/models/product.dart';

class PersonalisationProductPage extends StatefulWidget {
  const PersonalisationProductPage({super.key});

  @override
  State<PersonalisationProductPage> createState() =>
      _PersonalisationProductPageState();
}

class _PersonalisationProductPageState
    extends State<PersonalisationProductPage> {
  String _selectedOption = 'One Line of Text';
  int _quantity = 1;
  final List<TextEditingController> _controllers = [TextEditingController()];
  int _selectedImageIndex = 0;

  final Map<String, double> _priceMap = {
    'One Line of Text': 3.50,
    'Two Lines of Text': 5.00,
    'Three Lines of Text': 6.50,
    'Four Lines of Text': 8.00,
  };

  final Map<String, int> _lineCountMap = {
    'One Line of Text': 1,
    'Two Lines of Text': 2,
    'Three Lines of Text': 3,
    'Four Lines of Text': 4,
  };

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  double get _totalPrice => (_priceMap[_selectedOption] ?? 3.50) * _quantity;

  void _updateSelection(String? newValue) {
    if (newValue == null) return;
    
    setState(() {
      _selectedOption = newValue;
      final lines = _lineCountMap[newValue] ?? 1;
      
      while (_controllers.length < lines) {
        _controllers.add(TextEditingController());
      }
      while (_controllers.length > lines) {
        _controllers.removeLast().dispose();
      }
    });
  }

  void _updateQuantity(int delta) {
    setState(() {
      _quantity = (_quantity + delta).clamp(1, 99);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final numberOfLines = _lineCountMap[_selectedOption] ?? 1;

    return PageShell(
      child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImageSection(),
        const SizedBox(height: 24),
        _buildProductDetails(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: _buildImageSection(),
        ),
        const SizedBox(width: 48),
        Expanded(
          flex: 1,
          child: _buildProductDetails(),
        ),
      ],
    );
  }

  Widget _buildImageSection() {
    final imageUrls = [
      'https://union.host.cs.st-andrews.ac.uk/~sd7n/images/personalisation_1.jpg',
      'https://union.host.cs.st-andrews.ac.uk/~sd7n/images/personalisation_2.jpg',
    ];

    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(maxHeight: 500),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrls[_selectedImageIndex],
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildThumbnail(0, imageUrls[0]),
            const SizedBox(width: 8),
            _buildThumbnail(1, imageUrls[1]),
          ],
        ),
      ],
    );
  }

  Widget _buildThumbnail(int index, String imageUrl) {
    final isSelected = _selectedImageIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedImageIndex = index;
        });
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFF4D2963) : Colors.grey.shade300,
            width: isSelected ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetails() {
    final numberOfLines = _lineCountMap[_selectedOption] ?? 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personalisation',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Text(
          '£${_priceMap[_selectedOption]?.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Tax included.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
        ),
        const SizedBox(height: 32),
        Text(
          'Per Line: One Line of Text',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedOption,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              items: _priceMap.keys.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: _updateSelection,
            ),
          ),
        ),
        const SizedBox(height: 24),
        ...List.generate(numberOfLines, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Personalisation Line ${index + 1}:',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _controllers[index],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  maxLength: 30,
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 8),
        Text(
          'Quantity',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 120,
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.remove, size: 18),
                onPressed: _quantity > 1 ? () => _updateQuantity(-1) : null,
                padding: EdgeInsets.zero,
              ),
              Text(
                '$_quantity',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 18),
                onPressed: () => _updateQuantity(1),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              final numberOfLines = _lineCountMap[_selectedOption] ?? 1;
              final personalisationText = List.generate(numberOfLines, (i) => _controllers[i].text).join(' | ');
              
              // Create a Product object for the personalisation
              final personalisationProduct = Product(
                id: 'personalisation',
                name: 'Personalisation',
                description: 'Customized product with personalized text',
                price: _priceMap[_selectedOption] ?? 3.50,
                imageUrl: 'https://union.host.cs.st-andrews.ac.uk/~sd7n/images/personalisation_1.jpg',
                isLocalImage: false,
                collectionId: 'print-shack',
                sizes: [],
                images: [
                  'https://union.host.cs.st-andrews.ac.uk/~sd7n/images/personalisation_1.jpg',
                  'https://union.host.cs.st-andrews.ac.uk/~sd7n/images/personalisation_2.jpg',
                ],
              );
              
              // Add to cart with personalisation details in the size field
              final cartProvider = context.read<CartProvider>();
              final sizeWithPersonalisation = '$_selectedOption: $personalisationText';
              
              cartProvider.add(personalisationProduct, _quantity, sizeWithPersonalisation);
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added $_quantity x Personalisation ($_selectedOption) to cart',
                  ),
                  backgroundColor: const Color(0xFF4D2963),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4D2963),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text(
              'ADD TO CART',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
