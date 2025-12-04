import 'package:flutter/material.dart';
import '../models/hero_slide.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onPressed;

  const HeroSection({super.key, required this.onPressed});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  final List<HeroSlide> slides = [
    const HeroSlide(
      image: 'assets/images/essential_range_hero.png',
      title: 'Essential Range',
      subtitle: 'Discover our essential collection',
      buttonText: 'SHOP NOW',
      buttonRoute: '/collections',
    ),
    const HeroSlide(
      image: 'assets/images/print_shack_hero.png',
      title: 'Print Shack',
      subtitle: 'Custom printing & personalised gifts',
      buttonText: 'EXPLORE',
      buttonRoute: '/collection',
    ),
    const HeroSlide(
      image: 'assets/images/dominos_hero.png',
      title: 'Dominos',
      subtitle: 'Limited edition collaboration',
      buttonText: 'VIEW',
      buttonRoute: '/collections',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final height = width < 600 ? 280.0 : 420.0;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0e/Playboi_Carti_-_Music_album_cover.svg/1024px-Playboi_Carti_-_Music_album_cover.svg.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Container(
            height: height,
            width: double.infinity,
            color: Colors.black.withOpacity(0.68), 
          ),

          Positioned.fill(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'The Union Shop',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: width < 600 ? 26 : 34,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.15,
                        letterSpacing: 0.4,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      'Welcome to the Union Shop',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: width < 600 ? 16 : 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        height: 1.45,
                        letterSpacing: 0.2,
                      ),
                    ),

                    const SizedBox(height: 32),

                    SizedBox(
                      height: 46,
                      child: ElevatedButton(
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4d2963),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text(
                          'BROWSE COLLECTIONS',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
