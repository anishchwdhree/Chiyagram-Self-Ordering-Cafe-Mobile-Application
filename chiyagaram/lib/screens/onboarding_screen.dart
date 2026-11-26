import 'package:chiyagaram/responsive/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const OnboardingScreen({super.key, required this.onComplete});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  // Exact same accent & primary colors from the shoes app
  static const Color _accent = Color(0xFFF59E0B);
  static const Color _primary = Color(0xFF1E293B);
  static const Color _textSecondary = Color(0xFF64748B);

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      title: "Welcome to\nChiya Ki Tapari",
      description:
          "Sip the authentic taste of tradition in our cozy, open-air haven. Whether you're catching up with friends or enjoying solitude, our ambiance is perfect for every mood.",
      image: "images/chiyaki.png",
      isCircular: false,
    ),
    OnboardingContent(
      title: "Discover Our\nFlavors",
      description:
          "Explore a curated menu of premium teas, refreshing coolers, and delightful snacks. Our chefs craft every item with love, ensuring a burst of flavor in every bite.",
      image: "images/onb1.png",
      isCircular: false,
    ),
    OnboardingContent(
      title: "Special Offers\n& Events",
      description:
          "Unlock exclusive deals and stay tuned for exciting events at Chiya Ki Tapari. Join our community to enjoy member-only discounts and be part of our vibrant celebrations.",
      image: "images/onb.png",
      isCircular: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    widget.onComplete();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFFFFF), Color(0xFFFFFDF5), Color(0xFFF1F5F9)],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Skip Button
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextButton(
                      onPressed: _completeOnboarding,
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          color: _textSecondary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                // Page View
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: _contents.length,
                    itemBuilder: (context, index) {
                      return _OnboardingPageContent(
                        content: _contents[index],
                        index: index,
                        pageController: _pageController,
                      );
                    },
                  ),
                ),

                // Bottom Section (Dots & Button)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 30.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Dot Indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _contents.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            height: 8.0,
                            width: _currentIndex == index ? 24.0 : 8.0,
                            decoration: BoxDecoration(
                              color: _currentIndex == index
                                  ? _accent
                                  : _accent.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                        ),
                      ),

                      // Next / Get Started Button
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 60,
                        width: _currentIndex == _contents.length - 1 ? 160 : 60,
                        decoration: BoxDecoration(
                          color: _primary,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: _primary.withValues(alpha: 0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            if (_currentIndex < _contents.length - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeInOutCubic,
                              );
                            } else {
                              _completeOnboarding();
                            }
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Center(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: _currentIndex == _contents.length - 1
                                  ? const Text(
                                      "Get Started",
                                      key: ValueKey('text'),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.arrow_forward_ios,
                                      key: ValueKey('icon'),
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OnboardingPageContent extends StatelessWidget {
  final OnboardingContent content;
  final int index;
  final PageController pageController;

  static const Color _accent = Color(0xFFF59E0B);
  static const Color _primary = Color(0xFF1E293B);
  static const Color _textSecondary = Color(0xFF64748B);

  const _OnboardingPageContent({
    required this.content,
    required this.index,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        double position = 0.0;
        if (pageController.position.haveDimensions) {
          position = pageController.page! - index;
        } else {
          position = -index.toDouble();
        }

        position = position.clamp(-1.0, 1.0);

        final double opacity = (1.0 - position.abs()).clamp(0.0, 1.0);
        final double baseTranslation = position * screenWidth;
        final double iconYOffset = -position.abs() * 150.0;
        final double textYOffset = position.abs() * 150.0;

        return Stack(
          children: [
            // Image/Icon section — slides down from top
            Positioned.fill(
              child: Align(
                alignment: const Alignment(0, -0.3),
                child: Transform.translate(
                  offset: Offset(baseTranslation, iconYOffset),
                  child: Opacity(
                    opacity: opacity,
                    child: Container(
                      height: 240,
                      width: 240,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            _accent.withValues(alpha: 0.15),
                            _accent.withValues(alpha: 0.02),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _accent.withValues(alpha: 0.05),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: Center(
                        child: content.image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(120),
                                child: Image.asset(
                                  content.image!,
                                  width: 160,
                                  height: 160,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(content.icon, size: 100, color: _accent),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Text section — slides up from bottom
            Positioned.fill(
              child: Align(
                alignment: const Alignment(0, 0.5),
                child: Transform.translate(
                  offset: Offset(baseTranslation, textYOffset),
                  child: Opacity(
                    opacity: opacity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            content.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: _primary,
                              height: 1.2,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            content.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: _textSecondary,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class OnboardingContent {
  final String title;
  final String description;
  final IconData? icon;
  final String? image;
  final bool isCircular;

  OnboardingContent({
    required this.title,
    required this.description,
    this.icon,
    this.image,
    this.isCircular = true,
  }) : assert(icon != null || image != null);
}
