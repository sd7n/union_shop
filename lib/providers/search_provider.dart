import 'package:flutter/material.dart';
import '../models/product.dart';

class SearchProvider extends ChangeNotifier {
  String searchTerm = '';
  List<Product> results = [];

  void setSearchTerm(String term) {
    searchTerm = term;
    notifyListeners();
  }

  void runSearch(List<Product> allProducts) {
    if (searchTerm.isEmpty) {
      results = [];
    } else {
      results = allProducts
          .where((product) =>
              product.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
              product.description.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
