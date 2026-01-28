import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chiyagaram/responsive/size_config.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

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
                          "Terms of Service",
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
                    "1. Acceptance of Terms",
                    "By accessing and using ChiyaGram, you agree to be bound by these Terms of Service and all applicable laws and regulations.",
                  ),
                  _buildSection(
                    "2. User Accounts",
                    "You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account.",
                  ),
                  _buildSection(
                    "3. Ordering and Payment",
                    "All orders are subject to availability. Prices are subject to change without notice. We reserve the right to refuse or cancel any order for any reason.",
                  ),
                  _buildSection(
                    "4. Limitation of Liability",
                    "ChiyaGram shall not be liable for any indirect, incidental, special, consequential, or punitive damages resulting from your use of the service.",
                  ),
                  _buildSection(
                    "5. Changes to Terms",
                    "We reserve the right to modify these terms at any time. Your continued use of the app after any changes indicates your acceptance of the new terms.",
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
