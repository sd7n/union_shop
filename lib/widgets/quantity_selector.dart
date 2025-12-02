import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  final ValueChanged<int> onChanged;
  const QuantitySelector({super.key, required this.onChanged});

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int qty = 1;

  void _inc() {
    setState(() => qty++);
    widget.onChanged(qty);
  }

  void _dec() {
    if (qty > 1) {
      setState(() => qty--);
      widget.onChanged(qty);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: _dec, icon: const Icon(Icons.remove)),
        Text(qty.toString(), style: Theme.of(context).textTheme.titleMedium),
        IconButton(onPressed: _inc, icon: const Icon(Icons.add)),
      ],
    );
  }
}
