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
            "जहाँ चियाको बाफसँगै उठ्छन् पुराना सम्झनाहरू",
            textAlign: TextAlign.center,
            style: GoogleFonts.philosopher(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: isDark
                  ? Colors.white
                  : const Color.fromARGB(255, 63, 45, 41),
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),
          SizedBox(height: 15.h),
          // Caption/Description
          Container(
            constraints: BoxConstraints(maxWidth: 280.w),
            child: Text(
              "हरेक घूंटमा आमाको माया र घरको न्यानोपन। स्वाद मात्र होइन, आत्माको सन्तुष्टि।",
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
        ],
      ),
    );
  }
}
