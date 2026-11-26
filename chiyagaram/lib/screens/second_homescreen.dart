import 'package:chiyagaram/screens/widget/background_scaffold.dart';
import 'package:chiyagaram/theme/app_colors.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:chiyagaram/bottom%20bar%20screens/bottom_navbar.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chiyagaram/screens/widget/hero_carousel.dart';
import 'package:chiyagaram/screens/widget/popular_section.dart';
import 'package:chiyagaram/screens/widget/recommendation_section.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:chiyagaram/bottom%20bar%20screens/cart_screen.dart';
import 'package:chiyagaram/screens/notification_screen.dart';
import 'package:chiyagaram/services/notification_provider.dart';
import 'package:chiyagaram/services/navigation_provider.dart';
import 'package:chiyagaram/menu/menu_screen.dart';
import 'package:chiyagaram/profile/profile_screen.dart';

class SecondHomescreen extends StatefulWidget {
  const SecondHomescreen({super.key});

  @override
  State<SecondHomescreen> createState() => _SecondHomescreenState();
}

class _SecondHomescreenState extends State<SecondHomescreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    final navProvider = Provider.of<NavigationProvider>(context, listen: false);
    _pageController = PageController(initialPage: navProvider.currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    Provider.of<NavigationProvider>(context, listen: false).setIndex(index);
  }

  void _onNavBarTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, navProvider, child) {
        // Ensure PageController is in sync with provider index
        // This handles cases where index is changed from outside (e.g. specialty screens)
        if (_pageController.hasClients &&
            _pageController.page?.round() != navProvider.currentIndex) {
          _pageController.animateToPage(
            navProvider.currentIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }

        return BackgroundScaffold(
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              // PageView for Swipe Navigation
              PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                physics: const BouncingScrollPhysics(),
                children: [
                  const HomeTab(),
                  const MenuScreen(), // Index 1
                  const CartScreen(), // Index 2
                  ProfileScreen(), // Index 3 (was 4)
                ],
              ),

              // Bottom Navigation Bar
              Align(
                alignment: Alignment.bottomCenter,
                child: GlassBottomNavBar(
                  currentIndex: navProvider.currentIndex,
                  onTap: _onNavBarTapped,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF3E2723);

    return Stack(
      children: [
        // 1. Background Shapes
        Stack(
          children: [
            Positioned(
              top: -50.h,
              right: -50.w,
              child: BackgroundCircle(
                size: 200.w,
                color: isDark ? AppColors.igSurface : const Color(0xFFFFCCBC),
                opacity: 0.4,
              ),
            ),
            Positioned(
              bottom: 150.h,
              left: -30.w,
              child: BackgroundCircle(
                size: 140.w,
                color: isDark ? AppColors.igDarkGrey : const Color(0xFFFFE0B2),
                opacity: 0.3,
              ),
            ),
            Positioned(
              top: 400.h,
              right: 0,
              child: BackgroundCircle(
                size: 120.w,
                color: isDark ? AppColors.igBlack : const Color(0xFFD7CCC8),
                opacity: 0.2,
              ),
            ),
          ],
        ),

        // 2. Foreground Content
        SingleChildScrollView(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 10.h,
            bottom: 110.h,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 2.w,
                  right: 120.w,
                  top: 10.h,
                  bottom: 10.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),
                    Text(
                      "Chiya Ki Tapari",
                      style: GoogleFonts.philosopher(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                        letterSpacing: -1.2,
                        height: 1,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "Brewing Happiness, One Cup at a Time",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.outfit(
                        fontSize: 13.sp,
                        color: isDark
                            ? AppColors.igTextSecondary
                            : const Color(0xFF795548).withValues(alpha: 0.6),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              const HeroCarousel(),
              const SizedBox(height: 30),
              RecommendationSection(isDark: isDark),
              SizedBox(height: 10.h),
              PopularSection(isDark: isDark),
              SizedBox(height: 40.h),
            ],
          ),
        ),

        // 3. Notification Icon
        Positioned(
          top: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10.h,
              right: 20.w,
            ),
            child: Consumer<NotificationProvider>(
              builder: (context, provider, child) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      onPressed: () async {
                        provider.markAllRead(); // Clear badge
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Iconsax.notification,
                        size: 28.sp,
                        color: textColor,
                      ),
                    ),
                    if (provider.unreadCount > 0)
                      Positioned(
                        right: 8.w,
                        top: 8.h,
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: const BoxDecoration(
                            color: Color(0xFFE91E63),
                            shape: BoxShape.circle,
                          ),
                          constraints: BoxConstraints(
                            minWidth: 16.w,
                            minHeight: 16.w,
                          ),
                          child: Center(
                            child: Text(
                              '${provider.unreadCount}',
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class BackgroundCircle extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;

  const BackgroundCircle({
    super.key,
    required this.size,
    required this.color,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: opacity),
            color.withValues(alpha: 0.0),
          ],
          stops: const [0.2, 1.0],
        ),
      ),
    );
  }
}
