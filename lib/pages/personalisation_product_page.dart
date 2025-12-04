import 'package:flutter/material.dart';
import 'package:union_shop/widgets/page_shell.dart';

class PersonalisationProductPage extends StatefulWidget {
  const PersonalisationProductPage({super.key});

  @override
  State<PersonalisationProductPage> createState() =>
      _PersonalisationProductPageState();
}

class _PersonalisationProductPageState
    extends State<PersonalisationProductPage> {
  final double _basePrice = 25.00;
  final double _pricePerLine = 3.00;
  int _numberOfLines = 1;
  final List<TextEditingController> _controllers = [TextEditingController()];

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  double get _totalPrice => _basePrice + (_pricePerLine * _numberOfLines);

  void _updateNumberOfLines(int lines) {
    setState(() {
      _numberOfLines = lines;
      while (_controllers.length < lines) {
        _controllers.add(TextEditingController());
      }
      while (_controllers.length > lines) {
        _controllers.removeLast().dispose();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personalised Product',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),
          Text(
            'Customise your product with up to 4 lines of text. Each line costs £${_pricePerLine.toStringAsFixed(2)}.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          Text(
            'Number of Lines',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(4, (index) {
              final lineCount = index + 1;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text('$lineCount'),
                  selected: _numberOfLines == lineCount,
                  onSelected: (selected) {
                    if (selected) _updateNumberOfLines(lineCount);
                  },
                  selectedColor: const Color(0xFF4D2963),
                  labelStyle: TextStyle(
                    color: _numberOfLines == lineCount
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 32),
          Text(
            'Text Lines',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          ...List.generate(_numberOfLines, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: _controllers[index],
                decoration: InputDecoration(
                  labelText: 'Line ${index + 1}',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                maxLength: 30,
              ),
            );
          }),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Price',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                '£${_totalPrice.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF4D2963),
                    ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4D2963),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Add to Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
