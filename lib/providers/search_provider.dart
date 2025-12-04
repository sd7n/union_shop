import 'package:flutter/material.dart';
import '../models/product.dart';

class SearchProvider extends ChangeNotifier {
  String searchTerm = '';
  List<Product> results = [];

  void setSearchTerm(String term) {
    searchTerm = term;
    notifyListeners();
  }
}
