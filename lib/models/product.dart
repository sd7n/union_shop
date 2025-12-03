import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final bool isLocalImage;
  final String collectionId;
  final List<String> sizes;
  final String? externalUrl;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isLocalImage,
    required this.collectionId,
    required this.sizes,
    this.externalUrl,
  });

  get strikePrice => null;

  get images => null;

  @override
  String toString() =>
      'Product(id: $id, name: $name, price: $price, collectionId: $collectionId)';
}
