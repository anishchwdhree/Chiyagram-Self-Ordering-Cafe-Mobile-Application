import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chiyagaram/responsive/size_config.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          const RepaintBoundary(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFF3E0),
                    Color(0xFFFFECB3),
                    Color(0xFFFBE9E7),
                  ],
                ),
              ),
              child: SizedBox.expand(),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Color(0xFF3E2723),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Privacy Policy",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.philosopher(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3E2723),
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
                      color: const Color(0xFF795548),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _buildSection(
                    "1. Information We Collect",
                    "We collect information you provide directly to us, such as when you create an account, update your profile, or place an order. This includes your name, email address, phone number, and payment information.",
                  ),
                  _buildSection(
                    "2. How We Use Your Information",
                    "We use the information we collect to provide, maintain, and improve our services, process your orders, communicate with you, and personalize your experience.",
                  ),
                  _buildSection(
                    "3. Data Security",
                    "We implement reasonable security measures to protect your personal information. However, please be aware that no method of transmission over the internet or electronic storage is 100% secure.",
                  ),
                  _buildSection(
                    "4. Your Rights",
                    "You have the right to access, correct, or delete your personal information. You can manage your account settings within the app or contact us for assistance.",
                  ),
                  _buildSection(
                    "5. Contact Us",
                    "If you have any questions about this Privacy Policy, please contact us at support@chiyagram.com.",
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
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
              color: const Color(0xFF3E2723),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            content,
            style: GoogleFonts.outfit(
              fontSize: 16.sp,
              color: const Color(0xFF5D4037),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
