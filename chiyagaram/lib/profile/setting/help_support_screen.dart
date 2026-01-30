import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:chiyagaram/theme/app_colors.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF3E2723);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Help & Support",
          style: GoogleFonts.philosopher(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background Gradient
          RepaintBoundary(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          AppColors.igBlack,
                          AppColors.igDarkGrey,
                          AppColors.igBlack,
                        ]
                      : [
                          const Color(0xFFFFF3E0),
                          const Color(0xFFFFECB3),
                          const Color(0xFFFBE9E7),
                        ],
                ),
              ),
              child: const SizedBox.expand(),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("Frequently Asked Questions", textColor),
                  SizedBox(height: 16.h),
                  _buildFAQItem(
                    "How do I track my order?",
                    "You can track your order status in real-time from the 'My Orders' section in your profile.",
                    isDark,
                    textColor,
                  ),
                  _buildFAQItem(
                    "How does the self-ordering work?",
                    "Simply browse the menu, add items to your cart, and place your order. You'll be notified when your order is ready.",
                    isDark,
                    textColor,
                  ),
                  _buildFAQItem(
                    "What payment methods do you accept?",
                    "We accept credit/debit cards, digital wallets, and cash payments at the counter.",
                    isDark,
                    textColor,
                  ),
                  _buildFAQItem(
                    "How do I contact customer support?",
                    "You can reach us via email at support@chiyagram.com or call us directly using the contact options below.",
                    isDark,
                    textColor,
                  ),
                  SizedBox(height: 32.h),
                  _buildSectionTitle("Contact Us", textColor),
                  SizedBox(height: 16.h),
                  _buildContactCard(
                    icon: Iconsax.sms,
                    title: "Email Support",
                    subtitle: "support@chiyagram.com",
                    isDark: isDark,
                    textColor: textColor,
                    onTap: () {
                      // Implement email launch
                    },
                  ),
                  SizedBox(height: 16.h),
                  _buildContactCard(
                    icon: Iconsax.call,
                    title: "Phone Support",
                    subtitle: "+977 9800000000",
                    isDark: isDark,
                    textColor: textColor,
                    onTap: () {
                      // Implement phone launch
                    },
                  ),
                  SizedBox(height: 16.h),
                  _buildContactCard(
                    icon: Iconsax.location,
                    title: "Visit Us",
                    subtitle: "Kathmandu, Nepal",
                    isDark: isDark,
                    textColor: textColor,
                    onTap: () {},
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color textColor) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );
  }

  Widget _buildFAQItem(
    String question,
    String answer,
    bool isDark,
    Color textColor,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.igSurface
            : Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16.w),
        border: Border.all(
          color: isDark ? AppColors.igBorder : Colors.white,
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : const Color(0xFF3E2723)).withValues(
              alpha: 0.05,
            ),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: textColor,
          collapsedIconColor: textColor,
          title: Text(
            question,
            style: GoogleFonts.outfit(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: Text(
                answer,
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  color: isDark
                      ? AppColors.igTextSecondary
                      : const Color(0xFF795548),
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDark,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.w),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.igSurface
                : Colors.white.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(16.w),
            border: Border.all(
              color: isDark ? AppColors.igBorder : Colors.white,
              width: 1.w,
            ),
            boxShadow: [
              BoxShadow(
                color: (isDark ? Colors.black : const Color(0xFF3E2723))
                    .withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: textColor.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: textColor, size: 24.sp),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      color: isDark
                          ? AppColors.igTextSecondary
                          : const Color(0xFF795548),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16.sp,
                color: textColor.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
