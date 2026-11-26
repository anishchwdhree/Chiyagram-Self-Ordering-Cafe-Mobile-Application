import 'package:chiyagaram/screens/widget/background_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:chiyagaram/theme/app_colors.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF3E2723);

    return BackgroundScaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(
          top: MediaQuery.of(context).padding.top + 10.h,
          bottom: 20.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios_new, color: textColor),
                ),
                Expanded(
                  child: Text(
                    "Privacy Policy",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.philosopher(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
                SizedBox(width: 40.w),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              "Last Updated: January 2026",
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                color: isDark
                    ? AppColors.igTextSecondary
                    : const Color(0xFF795548),
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 20.h),
            _buildSection(
              "1. Information We Collect",
              "We collect information you provide directly to us, such as when you create an account, update your profile, or place an order. This includes your name, email address, phone number, and payment information.",
              isDark,
              textColor,
            ),
            _buildSection(
              "2. How We Use Your Information",
              "We use the information we collect to provide, maintain, and improve our services, process your orders, communicate with you, and personalize your experience.",
              isDark,
              textColor,
            ),
            _buildSection(
              "3. Data Security",
              "We implement reasonable security measures to protect your personal information. However, please be aware that no method of transmission over the internet or electronic storage is 100% secure.",
              isDark,
              textColor,
            ),
            _buildSection(
              "4. Your Rights",
              "You have the right to access, correct, or delete your personal information. You can manage your account settings within the app or contact us for assistance.",
              isDark,
              textColor,
            ),
            _buildSection(
              "5. Contact Us",
              "If you have any questions about this Privacy Policy, please contact us at support@chiyaki.com.",
              isDark,
              textColor,
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    String content,
    bool isDark,
    Color textColor,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            content,
            style: GoogleFonts.outfit(
              fontSize: 16.sp,
              color: isDark
                  ? AppColors.igTextSecondary
                  : const Color(0xFF5D4037),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
