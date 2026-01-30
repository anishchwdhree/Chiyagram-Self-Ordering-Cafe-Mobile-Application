import 'dart:ui';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:chiyagaram/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Popular Section Widget - Simple Text Based
class PopularSection extends StatelessWidget {
  final bool isDark;
  const PopularSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
      child: Column(
        children: [
          // Main Heading
          Text(
            "Where Tea Meets Tradition",
            textAlign: TextAlign.center,
            style: GoogleFonts.philosopher(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF3E2723),
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),
          SizedBox(height: 16.h),

          // Caption/Description
          Container(
            constraints: BoxConstraints(maxWidth: 280.w),
            child: Text(
              "Experience authentic flavors and warm moments with every cup. From traditional chiya to modern delights, we bring happiness to your table.",
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                color: isDark
                    ? AppColors.igTextSecondary
                    : const Color(0xFF795548).withValues(alpha: 0.8),
                fontWeight: FontWeight.w400,
                height: 1.6,
                letterSpacing: 0.2,
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Decorative Glassmorphic Container
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        AppColors.igSurface.withValues(alpha: 0.6),
                        AppColors.igSurface.withValues(alpha: 0.2),
                      ]
                    : [
                        Colors.white.withValues(alpha: 0.4),
                        Colors.white.withValues(alpha: 0.1),
                      ],
              ),
              borderRadius: BorderRadius.circular(20.w),
              border: Border.all(
                color: isDark
                    ? AppColors.igBorder.withValues(alpha: 0.5)
                    : Colors.white.withValues(alpha: 0.6),
                width: 1.5.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: (isDark ? Colors.black : const Color(0xFF8D6E63))
                      .withValues(alpha: 0.1),
                  blurRadius: 20.w,
                  offset: Offset(0, 8.h),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.w),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Column(
                  children: [
                    Text(
                      "✨ Handcrafted with Love ✨",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.philosopher(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.white
                            : const Color(0xFFE64A19),
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Every item is prepared fresh daily with premium ingredients",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 12.sp,
                        color: isDark
                            ? AppColors.igTextSecondary
                            : const Color(0xFF795548),
                        fontWeight: FontWeight.w400,
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
