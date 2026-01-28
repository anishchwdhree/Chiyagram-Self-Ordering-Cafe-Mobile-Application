import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chiyagaram/responsive/size_config.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF3E2723),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Help & Support",
          style: GoogleFonts.philosopher(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF3E2723),
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background Gradient (Consistent with ProfileScreen)
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
                  _buildSectionTitle("Frequently Asked Questions"),
                  SizedBox(height: 16.h),
                  _buildFAQItem(
                    "How do I track my order?",
                    "You can track your order status in real-time from the 'My Orders' section in your profile.",
                  ),
                  _buildFAQItem(
                    "How does the self-ordering work?",
                    "Simply browse the menu, add items to your cart, and place your order. You'll be notified when your order is ready.",
                  ),
                  _buildFAQItem(
                    "What payment methods do you accept?",
                    "We accept credit/debit cards, digital wallets, and cash payments at the counter.",
                  ),
                  _buildFAQItem(
                    "How do I contact customer support?",
                    "You can reach us via email at support@chiyagram.com or call us directly using the contact options below.",
                  ),
                  SizedBox(height: 32.h),
                  _buildSectionTitle("Contact Us"),
                  SizedBox(height: 16.h),
                  _buildContactCard(
                    icon: Iconsax.sms,
                    title: "Email Support",
                    subtitle: "support@chiyagram.com",
                    onTap: () {
                      // Implement email launch
                    },
                  ),
                  SizedBox(height: 16.h),
                  _buildContactCard(
                    icon: Iconsax.call,
                    title: "Phone Support",
                    subtitle: "+977 9800000000",
                    onTap: () {
                      // Implement phone launch
                    },
                  ),
                  SizedBox(height: 16.h),
                  _buildContactCard(
                    icon: Iconsax.location,
                    title: "Visit Us",
                    subtitle: "Kathmandu, Nepal",
                    onTap: () {},
                  ),
                  SizedBox(height: 32.h),
                  // _buildSectionTitle("Social Media"),
                  // SizedBox(height: 16.h),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     _buildSocialButton(Iconsax.instagram, () {}),
                  //     _buildSocialButton(Iconsax.facebook, () {}),
                  //     _buildSocialButton(Iconsax.global, () {}),
                  //   ],
                  // ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF3E2723),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16.w),
        border: Border.all(color: Colors.white, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3E2723).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: const Color(0xFF3E2723),
          collapsedIconColor: const Color(0xFF3E2723),
          title: Text(
            question,
            style: GoogleFonts.outfit(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3E2723),
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: Text(
                answer,
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  color: const Color(0xFF795548),
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
            color: Colors.white.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(16.w),
            border: Border.all(color: Colors.white, width: 1.w),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3E2723).withValues(alpha: 0.05),
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
                  color: const Color(0xFF3E2723).withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: const Color(0xFF3E2723), size: 24.sp),
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
                      color: const Color(0xFF3E2723),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      color: const Color(0xFF795548),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16.sp,
                color: const Color(0xFFA1887F),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
