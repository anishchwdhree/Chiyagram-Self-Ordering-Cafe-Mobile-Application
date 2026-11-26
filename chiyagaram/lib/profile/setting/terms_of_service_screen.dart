import 'package:chiyagaram/screens/widget/background_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:chiyagaram/theme/app_colors.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

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
                    "Terms of Service",
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
              "1. Acceptance of Terms",
              "By accessing and using Chiya Ki Tapari, you agree to be bound by these Terms of Service and all applicable laws and regulations.",
              isDark,
              textColor,
            ),
            _buildSection(
              "2. User Accounts",
              "You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account.",
              isDark,
              textColor,
            ),
            _buildSection(
              "3. Ordering and Payment",
              "All orders are subject to availability. Prices are subject to change without notice. We reserve the right to refuse or cancel any order for any reason.",
              isDark,
              textColor,
            ),
            _buildSection(
              "4. Limitation of Liability",
              "ChiyaGram shall not be liable for any indirect, incidental, special, consequential, or punitive damages resulting from your use of the service.",
              isDark,
              textColor,
            ),
            _buildSection(
              "5. Changes to Terms",
              "We reserve the right to modify these terms at any time. Your continued use of the app after any changes indicates your acceptance of the new terms.",
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
