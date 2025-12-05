import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/hero_slide.dart';

void main() {
  group('HeroSection Logic', () {
    test('HeroSlide has all required fields', () {
      const slide = HeroSlide(
        imageUrl: 'https://example.com/image.jpg',
        title: 'Test Title',
        subtitle: 'Test Subtitle',
        buttonText: 'SHOP NOW',
        buttonRoute: '/collection',
      );

      expect(slide.imageUrl, isNotEmpty);
      expect(slide.title, isNotEmpty);
      expect(slide.subtitle, isNotEmpty);
      expect(slide.buttonText, isNotEmpty);
      expect(slide.buttonRoute, isNotEmpty);
    });

    test('HeroSlide supports local images', () {
      const slide = HeroSlide(
        imageUrl: 'assets/hero.png',
        title: 'Local Hero',
        subtitle: 'Local Subtitle',
        buttonText: 'VIEW',
        buttonRoute: '/collection',
      );

      expect(slide.imageUrl, startsWith('assets/'));
    });

    test('HeroSlide supports remote images', () {
      const slide = HeroSlide(
        imageUrl: 'https://example.com/hero.jpg',
        title: 'Remote Hero',
        subtitle: 'Remote Subtitle',
        buttonText: 'EXPLORE',
        buttonRoute: '/printshack',
      );

      expect(slide.imageUrl, startsWith('http'));
    });

    test('Multiple slides can have different routes', () {
      const slides = [
        HeroSlide(
          imageUrl: 'assets/1.png',
          title: 'Slide 1',
          subtitle: 'Sub 1',
          buttonText: 'SHOP',
          buttonRoute: '/collection-detail',
        ),
        HeroSlide(
          imageUrl: 'assets/2.png',
          title: 'Slide 2',
          subtitle: 'Sub 2',
          buttonText: 'EXPLORE',
          buttonRoute: '/printshack-about',
        ),
      ];

      expect(slides[0].buttonRoute, '/collection-detail');
      expect(slides[1].buttonRoute, '/printshack-about');
      expect(slides[0].buttonRoute, isNot(slides[1].buttonRoute));
    });
  });
}
