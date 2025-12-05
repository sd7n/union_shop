import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/search_provider.dart';
import '../services/data_service.dart';

class SearchOverlay extends StatefulWidget {
  final bool isVisible;
  final VoidCallback onToggle;

  const SearchOverlay({
    super.key,
    required this.isVisible,
    required this.onToggle,
  });

  @override
  State<SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void didUpdateWidget(covariant SearchOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    // When overlay becomes visible → request focus so ENTER works
    if (widget.isVisible && !oldWidget.isVisible) {
      Future.delayed(const Duration(milliseconds: 50), () {
        _focusNode.requestFocus();
      });
    }
  }

  void _submitSearch(BuildContext context) {
    final searchProvider = context.read<SearchProvider>();
    final allProducts = DataService.instance.products;

    // Make sure we have the latest text from the controller
    searchProvider.setSearchTerm(_controller.text);
    searchProvider.runSearch(allProducts);
    widget.onToggle();
    Navigator.pushNamed(context, '/search');
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: widget.isVisible ? 0 : -100,
      left: 0,
      right: 0,
      height: 80,
      duration: const Duration(milliseconds: 300),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: RawKeyboardListener(
                focusNode: FocusNode(),
                autofocus: true,
                onKey: (event) {
                  if (event is KeyDownEvent &&
                      event.logicalKey == LogicalKeyboardKey.enter) {
                    _submitSearch(context);
                  }

                  if (event is RawKeyDownEvent &&
                      event.logicalKey == LogicalKeyboardKey.enter) {
                    _submitSearch(context);
                  }
                },
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (_) => _submitSearch(context),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                  ),
                  onChanged: (value) {
                    context.read<SearchProvider>().setSearchTerm(value);
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => _submitSearch(context),
            ),
          ],
        ),
      ),
    );
  }
}
