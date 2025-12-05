import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/collection_card.dart';

void main() {
  group('CollectionCard', () {
    test('CollectionCard should have required properties', () {
      bool tapped = false;
      final card = CollectionCard(
        title: 'Test',
        subtitle: 'Desc',
        collectionId: 'id1',
        imageUrl: 'url',
        isLocalImage: false,
        onTap: () => tapped = true,
        index: 2,
      );

      expect(card.title, 'Test');
      expect(card.subtitle, 'Desc');
      expect(card.collectionId, 'id1');
      expect(card.index, 2);
      card.onTap();
      expect(tapped, isTrue);
    });

    test('CollectionCard with local image', () {
      final card = CollectionCard(
        title: 'Local',
        subtitle: 'Image',
        collectionId: 'id2',
        imageUrl: 'assets/test.png',
        isLocalImage: true,
        onTap: () {},
      );

      expect(card.isLocalImage, isTrue);
      expect(card.imageUrl, 'assets/test.png');
    });
  });
}
