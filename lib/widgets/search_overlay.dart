import 'package:flutter/material.dart';

class SearchOverlay extends StatelessWidget {
  final bool isVisible;

  const SearchOverlay({
    super.key,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: isVisible ? 0 : -100,
      left: 0,
      right: 0,
      height: 80,
      duration: const Duration(milliseconds: 300),
      child: Container(
        color: Colors.white,
        child: const SizedBox.shrink(),
      ),
    );
  }
}
