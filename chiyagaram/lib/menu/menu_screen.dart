import 'package:chiyagaram/responsive/size_config.dart';
import 'package:chiyagaram/menu/specialties%20screens/hookah_screen.dart';
import 'package:chiyagaram/menu/specialties%20screens/snacks_screen.dart';
import 'package:chiyagaram/menu/specialties%20screens/traditional_chiya_screen.dart';
import 'package:chiyagaram/screens/widget/background_scaffold.dart';
import 'package:chiyagaram/theme/app_colors.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF3E2723);
    final subTextColor = isDark
        ? AppColors.igTextSecondary
        : const Color(0xFF5D4037);

    return BackgroundScaffold(
      body: Stack(
        children: [
          // 1. Background Shapes (Subtle)
          Positioned(
            top: -50.h,
            right: -50.w,
            child: _buildBackgroundCircle(
              200.w,
              isDark ? AppColors.igSurface : const Color(0xFFFFCCBC),
              0.3,
            ),
          ),

          // 2. Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Menu Title
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 15.h, 20.w, 5.h),
                  child: Text(
                    "Our Menu",
                    style: GoogleFonts.philosopher(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // Tagline Header
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 5.h,
                  ),
                  child: Text(
                    "Discover the taste of happiness",
                    style: GoogleFonts.philosopher(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: subTextColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100.h), // Space for navbar
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Today's Special Banner
                        _buildTodaysSpecialBanner(
                          isDark,
                          textColor,
                          subTextColor,
                        ),

                        SizedBox(height: 30.h),

                        // Specialties Header
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "Specialties",
                                  style: GoogleFonts.philosopher(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 15.w),
                              Expanded(
                                child: Container(
                                  height: 1.2,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: isDark
                                          ? [
                                              Colors.white.withValues(
                                                alpha: 0.0,
                                              ),
                                              Colors.white.withValues(
                                                alpha: 0.5,
                                              ),
                                              Colors.white.withValues(
                                                alpha: 0.0,
                                              ),
                                            ]
                                          : [
                                              const Color(
                                                0xFF8D6E63,
                                              ).withValues(alpha: 0.0),
                                              const Color(
                                                0xFF8D6E63,
                                              ).withValues(alpha: 0.3),
                                              const Color(
                                                0xFF8D6E63,
                                              ).withValues(alpha: 0.0),
                                            ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // Navigation Cards
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Column(
                            children: [
                              _buildNavigationCard(
                                title: "Traditional Chiya",
                                subtitle: "Experience the authentic taste",
                                imagePath: "images/bm1.png",
                                isDark: isDark,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const TraditionalChiyaScreen(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.h),
                              _buildNavigationCard(
                                title: "Snacks",
                                subtitle: "Delicious bites for every moment",
                                imagePath: "images/bm2.png",
                                isDark: isDark,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const SnacksScreen(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.h),
                              _buildNavigationCard(
                                title: "Hookah",
                                subtitle: "Relax and unwind in style",
                                imagePath: "images/bm3.png",
                                isDark: isDark,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const HookahScreen(),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaysSpecialBanner(
    bool isDark,
    Color textColor,
    Color subTextColor,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 140.h, maxHeight: 180.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.w),
        gradient: LinearGradient(
          colors: isDark
              ? [
                  AppColors.igSurface.withValues(alpha: 0.9),
                  AppColors.igDarkGrey.withValues(alpha: 0.8),
                ]
              : [
                  const Color(0xFFF8BBD0).withValues(alpha: 0.9),
                  const Color(0xFFD7CCC8).withValues(alpha: 0.8),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : const Color(0xFF8D6E63)).withValues(
              alpha: 0.2,
            ),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: (isDark
              ? AppColors.igBorder
              : Colors.white.withValues(alpha: 0.4)),
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Today's Special",
                    style: GoogleFonts.outfit(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.igTextSecondary
                          : const Color(0xFF5D4037),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  Flexible(
                    child: Text(
                      "Masala Chiya &\nCrispy Pakauda",
                      style: GoogleFonts.philosopher(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                        height: 1.1,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white : const Color(0xFF3E2723),
                      borderRadius: BorderRadius.circular(20.w),
                    ),
                    child: Text(
                      "Try Now",
                      style: GoogleFonts.outfit(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Flexible(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark
                        ? Colors.black12
                        : Colors.white.withValues(alpha: 0.4),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      "images/masal.png",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: isDark
                              ? AppColors.igSurface
                              : const Color(0xFFFFE0B2),
                          child: Icon(
                            Icons.local_cafe,
                            size: 40.sp,
                            color: isDark
                                ? Colors.white38
                                : const Color(0xFF8D6E63),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCard({
    required String title,
    required String subtitle,
    required String imagePath,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100.h,
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 90.h, maxHeight: 120.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.w),
          border: Border.all(
            color: (isDark
                ? AppColors.igBorder
                : Colors.white.withValues(alpha: 0.4)),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.w),
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  color: Colors.black.withValues(alpha: isDark ? 0.5 : 0.2),
                  colorBlendMode: BlendMode.darken,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: isDark
                          ? AppColors.igSurface
                          : const Color(0xFF3E2723),
                      child: Icon(
                        Icons.image,
                        size: 40.sp,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                    );
                  },
                ),
              ),

              // Gradient Overlay (Bottom Up)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Content Center
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.philosopher(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.5),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        subtitle,
                        style: GoogleFonts.outfit(
                          fontSize: 12.sp,
                          color: Colors.white.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20.w),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.5),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                "Explore Now",
                                style: GoogleFonts.outfit(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 14.sp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundCircle(double size, Color color, double opacity) {
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
