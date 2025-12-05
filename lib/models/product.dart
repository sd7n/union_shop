class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? strikePrice;
  final String imageUrl;
  final bool isLocalImage;
  final String collectionId;
  final List<String> sizes;
  final List<String>? images;
  final List<String>? colors;
  final String? externalUrl;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.strikePrice,
    required this.imageUrl,
    required this.isLocalImage,
    required this.collectionId,
    required this.sizes,
    this.images,
    this.colors,
    this.externalUrl,
  });

  @override
  String toString() =>
      'Product(id: $id, name: $name, price: $price, collectionId: $collectionId)';
}
