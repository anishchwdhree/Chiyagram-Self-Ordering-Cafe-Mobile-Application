import 'package:chiyagaram/screens/widget/background_scaffold.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:chiyagaram/animations/fade_animation.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:chiyagaram/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      title: "Welcome to ChiyaGram",
      description:
          "Sip the authentic taste of tradition in our cozy, open-air haven. Whether you're catching up with friends or enjoying solitude, our ambiance is perfect for every mood.",
      image: "images/chiyagrm.png",
      color: const Color(0xFF8D6E63), // Brownish tea color
    ),
    OnboardingContent(
      title: "Discover Our Flavors",
      description:
          "Explore a curated menu of premium teas, refreshing coolers, and delightful snacks. Our chefs craft every item with love, ensuring a burst of flavor in every bite.",
      image: "images/m1.png",
      color: const Color(0xFF5D4037), // Darker brown
    ),
    OnboardingContent(
      title: "Special Offers & Events",
      description:
          "Unlock exclusive deals and stay tuned for exciting events at ChiyaGram. Join our community to enjoy member-only discounts and be part of our vibrant celebrations.",
      image: "images/m7.png",
      color: const Color(0xFF4E342E), // Deep brown
    ),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2), () {
      FlutterNativeSplash.remove();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _completeOnboarding() {
    // Navigate to Login Screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white70 : Colors.grey[600];

    return BackgroundScaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _contents.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(40.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeAnimation(
                        delay: 0.1,
                        child: Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white10 : Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: _contents[index].image != null
                              ? Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isDark
                                          ? Colors.white24
                                          : Colors.white,
                                      width: 4.w,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(70.w),
                                    child: Image.asset(
                                      _contents[index].image!,
                                      width: 152,
                                      height: 152,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Icon(
                                  _contents[index].icon,
                                  size: 120,
                                  color: _contents[index].color,
                                ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      FadeAnimation(
                        delay: 0.3,
                        beginOffset: const Offset(1.0, 0),
                        child: Text(
                          _contents[index].title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      FadeAnimation(
                        delay: 0.5,
                        beginOffset: const Offset(0, 1.0),
                        child: Text(
                          _contents[index].description,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: subTextColor,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Indicators
                Row(
                  children: List.generate(
                    _contents.length,
                    (index) => buildDot(index, isDark),
                  ),
                ),
                // Button
                FadeAnimation(
                  delay: 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage == _contents.length - 1) {
                        _completeOnboarding();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _contents[_currentPage].color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 15.h,
                      ),
                    ),
                    child: Text(
                      _currentPage == _contents.length - 1
                          ? "Get Started"
                          : "Next",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot(int index, bool isDark) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 8.w),
      height: 8.h,
      width: _currentPage == index ? 24.w : 8.w,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? _contents[index].color
            : (isDark ? Colors.white24 : Colors.grey[300]),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingContent {
  final String title;
  final String description;
  final IconData? icon;
  final String? image;
  final Color color;

  OnboardingContent({
    required this.title,
    required this.description,
    this.icon,
    this.image,
    required this.color,
  }) : assert(icon != null || image != null);
}
