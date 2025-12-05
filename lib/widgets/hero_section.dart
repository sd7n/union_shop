import 'package:flutter/material.dart';
import 'dart:async';
import '../models/hero_slide.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onPressed;

  const HeroSection({super.key, required this.onPressed});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  late PageController _pageController;
  int currentPage = 0;
  bool isPaused = false;
  Timer? autoTimer;

  final List<HeroSlide> slides = [
    const HeroSlide(
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0e/Playboi_Carti_-_Music_album_cover.svg/1024px-Playboi_Carti_-_Music_album_cover.svg.png',
      title: 'Essential Range',
      subtitle: 'Discover our essential collection',
      buttonText: 'SHOP NOW',
      buttonRoute: '/collection-detail',
    ),
    const HeroSlide(
      imageUrl: 'https://uk.rarevinyl.com/cdn/shop/files/playboy-carti-i-am-music-black-vinyl-sealed-uk-2-lp-vinyl-record-double-7814833-868119_1024x1024.jpg?v=1750953953',
      title: 'Print Shack',
      subtitle: 'Custom printing & personalised gifts',
      buttonText: 'EXPLORE',
      buttonRoute: '/printshack-about',
    ),
    const HeroSlide(
      imageUrl: 'https://static.vecteezy.com/system/resources/thumbnails/039/315/327/small/balenciaga-logo-icons-and-pattern-editorial-use-vinnitsa-ukraine-february-15-2024-free-vector.jpg',
      title: 'Balenciaga',
      subtitle: 'Limited edition collaboration',
      buttonText: 'VIEW',
      buttonRoute: '/collection-detail',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  @override
  void dispose() {
    autoTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    autoTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!isPaused && mounted) {
        int nextPage = (currentPage + 1) % slides.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final height = width < 600 ? 280.0 : 420.0;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                currentPage = page;
              });
            },
            itemCount: slides.length,
            itemBuilder: (context, index) {
              final slide = slides[index];
              return Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(slide.imageUrl),
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
                              slide.title,
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
                              slide.subtitle,
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
                                onPressed: () {
                                  Navigator.pushNamed(context, slide.buttonRoute);
                                },
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
                                child: Text(
                                  slide.buttonText,
                                  style: const TextStyle(
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
              );
            },
          ),
          // Navigation buttons
          Positioned(
            left: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  int prevPage = (currentPage - 1 + slides.length) % slides.length;
                  _pageController.animateToPage(
                    prevPage,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  int nextPage = (currentPage + 1) % slides.length;
                  _pageController.animateToPage(
                    nextPage,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
          // Dot indicators
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  slides.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: currentPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: currentPage == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Pause/Play button
          Positioned(
            bottom: 16,
            right: 16,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isPaused = !isPaused;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isPaused ? Icons.play_arrow : Icons.pause,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
