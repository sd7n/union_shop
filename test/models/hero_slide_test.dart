import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/hero_slide.dart';

void main() {
  group('HeroSlide', () {
    test('should create HeroSlide with all required fields', () {
      final slide = HeroSlide(
        imageUrl: 'https://example.com/hero.jpg',
        title: 'Welcome to Union Shop',
        subtitle: 'Discover amazing products',
        buttonText: 'Shop Now',
        buttonRoute: '/collection',
      );

      expect(slide.imageUrl, 'https://example.com/hero.jpg');
      expect(slide.title, 'Welcome to Union Shop');
      expect(slide.subtitle, 'Discover amazing products');
      expect(slide.buttonText, 'Shop Now');
      expect(slide.buttonRoute, '/collection');
    });

    test('should handle local image URLs', () {
      final slide = HeroSlide(
        imageUrl: 'assets/images/hero.png',
        title: 'Local Hero',
        subtitle: 'With local image',
        buttonText: 'Explore',
        buttonRoute: '/about',
      );

      expect(slide.imageUrl, startsWith('assets/'));
    });

    test('should handle remote image URLs', () {
      final slide = HeroSlide(
        imageUrl: 'https://cdn.example.com/images/hero.jpg',
        title: 'Remote Hero',
        subtitle: 'With remote image',
        buttonText: 'View',
        buttonRoute: '/products',
      );

      expect(slide.imageUrl, startsWith('https://'));
    });

    test('should handle different button routes', () {
      final routes = ['/', '/shop', '/sale', '/about', '/contact'];
      
      for (final route in routes) {
        final slide = HeroSlide(
          imageUrl: 'https://example.com/hero.jpg',
          title: 'Test',
          subtitle: 'Test',
          buttonText: 'Click',
          buttonRoute: route,
        );

        expect(slide.buttonRoute, route);
      }
    });

    test('should handle long title text', () {
      final longTitle = 'This is a very long title that might wrap to multiple lines in the UI';
      final slide = HeroSlide(
        imageUrl: 'https://example.com/hero.jpg',
        title: longTitle,
        subtitle: 'Subtitle',
        buttonText: 'Click',
        buttonRoute: '/shop',
      );

      expect(slide.title, longTitle);
      expect(slide.title.length, greaterThan(50));
    });

    test('should handle long subtitle text', () {
      final longSubtitle = 'This is a very long subtitle that provides detailed information about the hero section and what users can expect';
      final slide = HeroSlide(
        imageUrl: 'https://example.com/hero.jpg',
        title: 'Title',
        subtitle: longSubtitle,
        buttonText: 'Click',
        buttonRoute: '/shop',
      );

      expect(slide.subtitle, longSubtitle);
      expect(slide.subtitle.length, greaterThan(80));
    });

    test('should handle special characters in text', () {
      final slide = HeroSlide(
        imageUrl: 'https://example.com/hero.jpg',
        title: 'Sale: Up to 50% Off!',
        subtitle: 'Don\'t miss out - Limited time only & while stocks last',
        buttonText: 'Shop Now →',
        buttonRoute: '/sale',
      );

      expect(slide.title, contains('%'));
      expect(slide.subtitle, contains('&'));
      expect(slide.buttonText, contains('→'));
    });

    test('should handle unicode characters', () {
      final slide = HeroSlide(
        imageUrl: 'https://example.com/hero.jpg',
        title: 'New Collection 2024 🎉',
        subtitle: 'Exclusive designs you\'ll ❤️',
        buttonText: 'Explore →',
        buttonRoute: '/collection',
      );

      expect(slide.title, contains('🎉'));
      expect(slide.subtitle, contains('❤️'));
      expect(slide.buttonText, contains('→'));
    });

    test('should handle empty strings', () {
      final slide = HeroSlide(
        imageUrl: '',
        title: '',
        subtitle: '',
        buttonText: '',
        buttonRoute: '',
      );

      expect(slide.imageUrl, isEmpty);
      expect(slide.title, isEmpty);
      expect(slide.subtitle, isEmpty);
      expect(slide.buttonText, isEmpty);
      expect(slide.buttonRoute, isEmpty);
    });

    test('should be const constructible', () {
      const slide = HeroSlide(
        imageUrl: 'https://example.com/hero.jpg',
        title: 'Const Hero',
        subtitle: 'Const subtitle',
        buttonText: 'Click',
        buttonRoute: '/shop',
      );

      expect(slide.title, 'Const Hero');
    });

    test('should handle query parameters in image URL', () {
      final slide = HeroSlide(
        imageUrl: 'https://example.com/hero.jpg?w=1200&h=600&fit=cover',
        title: 'Hero',
        subtitle: 'With query params',
        buttonText: 'View',
        buttonRoute: '/shop',
      );

      expect(slide.imageUrl, contains('?'));
      expect(slide.imageUrl, contains('&'));
    });

    test('should handle different button text styles', () {
      final buttonTexts = [
        'Shop Now',
        'LEARN MORE',
        'Get Started',
        'View Collection',
        'Discover',
        'Buy Now',
      ];

      for (final text in buttonTexts) {
        final slide = HeroSlide(
          imageUrl: 'https://example.com/hero.jpg',
          title: 'Title',
          subtitle: 'Subtitle',
          buttonText: text,
          buttonRoute: '/shop',
        );

        expect(slide.buttonText, text);
      }
    });

    test('should handle route with parameters', () {
      final slide = HeroSlide(
        imageUrl: 'https://example.com/hero.jpg',
        title: 'Special Offer',
        subtitle: 'Limited time deal',
        buttonText: 'Shop',
        buttonRoute: '/product?id=123&source=hero',
      );

      expect(slide.buttonRoute, contains('?'));
      expect(slide.buttonRoute, contains('id=123'));
    });

    test('should handle absolute vs relative routes', () {
      final absoluteSlide = HeroSlide(
        imageUrl: 'https://example.com/hero.jpg',
        title: 'Absolute',
        subtitle: 'Subtitle',
        buttonText: 'Click',
        buttonRoute: '/shop',
      );

      final relativeSlide = HeroSlide(
        imageUrl: 'https://example.com/hero.jpg',
        title: 'Relative',
        subtitle: 'Subtitle',
        buttonText: 'Click',
        buttonRoute: 'shop',
      );

      expect(absoluteSlide.buttonRoute, startsWith('/'));
      expect(relativeSlide.buttonRoute, isNot(startsWith('/')));
    });

    test('should handle multiline subtitle', () {
      final slide = HeroSlide(
        imageUrl: 'https://example.com/hero.jpg',
        title: 'Title',
        subtitle: 'Line 1\nLine 2\nLine 3',
        buttonText: 'Click',
        buttonRoute: '/shop',
      );

      expect(slide.subtitle, contains('\n'));
      expect(slide.subtitle.split('\n').length, 3);
    });

    test('should handle different image formats', () {
      final formats = ['jpg', 'png', 'webp', 'gif', 'svg'];
      
      for (final format in formats) {
        final slide = HeroSlide(
          imageUrl: 'https://example.com/hero.$format',
          title: 'Test',
          subtitle: 'Test',
          buttonText: 'Click',
          buttonRoute: '/shop',
        );

        expect(slide.imageUrl, endsWith(format));
      }
    });

    test('should handle CDN URLs', () {
      final slide = HeroSlide(
        imageUrl: 'https://cdn.shopify.com/s/files/hero.jpg',
        title: 'CDN Hero',
        subtitle: 'Hosted on CDN',
        buttonText: 'View',
        buttonRoute: '/shop',
      );

      expect(slide.imageUrl, contains('cdn'));
    });

    test('should create multiple slides with different content', () {
      final slide1 = HeroSlide(
        imageUrl: 'https://example.com/hero1.jpg',
        title: 'Slide 1',
        subtitle: 'First slide',
        buttonText: 'Click 1',
        buttonRoute: '/route1',
      );

      final slide2 = HeroSlide(
        imageUrl: 'https://example.com/hero2.jpg',
        title: 'Slide 2',
        subtitle: 'Second slide',
        buttonText: 'Click 2',
        buttonRoute: '/route2',
      );

      expect(slide1.title, isNot(equals(slide2.title)));
      expect(slide1.buttonRoute, isNot(equals(slide2.buttonRoute)));
    });

    test('should handle promotional content', () {
      final slide = HeroSlide(
        imageUrl: 'https://example.com/promo.jpg',
        title: '50% OFF EVERYTHING',
        subtitle: 'Black Friday Sale - Today Only!',
        buttonText: 'SHOP SALE',
        buttonRoute: '/sale',
      );

      expect(slide.title, contains('OFF'));
      expect(slide.subtitle, contains('Sale'));
      expect(slide.buttonRoute, '/sale');
    });
  });
}
