import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chiyagaram/profile/setting/change_password_screen.dart';
import 'package:chiyagaram/profile/setting/delete_account_screen.dart';
import 'package:chiyagaram/profile/setting/content_screen.dart';
import 'package:chiyagaram/profile/setting/feedback_screen.dart';
import 'package:chiyagaram/profile/setting/help_support_screen.dart';
import 'package:chiyagaram/profile/setting/privacy_policy_screen.dart';
import 'package:chiyagaram/profile/setting/terms_of_service_screen.dart';
import 'package:chiyagaram/responsive/size_config.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

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
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Custom App Bar
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
                          "Settings",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.philosopher(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3E2723),
                          ),
                        ),
                      ),
                      SizedBox(width: 40.w), // Balance back button
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Account Settings
                  _buildSectionHeader("Account"),
                  _buildArrowOption(
                    title: "Change Password",
                    icon: Iconsax.lock,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePasswordScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 12.h),
                  _buildArrowOption(
                    title: "Delete Account",
                    icon: Iconsax.trash,
                    isDestructive: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DeleteAccountScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 24.h),

                  // App Settings
                  _buildSectionHeader("App Settings"),
                  _buildSwitchOption(
                    title: "Push Notifications",
                    icon: Iconsax.notification,
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                  ),
                  SizedBox(height: 12.h),
                  _buildSwitchOption(
                    title: "Dark Mode",
                    icon: Iconsax.moon,
                    value: _darkModeEnabled,
                    onChanged: (value) {
                      setState(() {
                        _darkModeEnabled = value;
                      });
                    },
                  ),
                  SizedBox(height: 12.h),
                  _buildArrowOption(
                    title: "Language",
                    icon: Iconsax.global,
                    trailingText: "English",
                    onTap: () {},
                  ),
                  SizedBox(height: 24.h),

                  // Support
                  _buildSectionHeader("Support"),
                  _buildArrowOption(
                    title: "Help Center",
                    icon: Iconsax.message_question,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HelpSupportScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 12.h),
                  _buildArrowOption(
                    title: "Feedback",
                    icon: Iconsax.message_edit,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FeedbackScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 12.h),
                  _buildArrowOption(
                    title: "Privacy Policy",
                    icon: Iconsax.security_safe,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 12.h),
                  _buildArrowOption(
                    title: "Terms of Service",
                    icon: Iconsax.document_text,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TermsOfServiceScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 12.h),
                  _buildArrowOption(
                    title: "About App",
                    icon: Iconsax.info_circle,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ContentScreen(
                            title: "About App",
                            content:
                                "ChiyaGram v1.0.0\n\nA modern cafe application for self-ordering and managing your favorite snacks and beverages.",
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 40.h),
                  Center(
                    child: Text(
                      "Version 1.0.0",
                      style: GoogleFonts.outfit(
                        fontSize: 12.sp,
                        color: const Color(0xFF3E2723).withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, left: 8.w),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF3E2723).withValues(alpha: 0.6),
        ),
      ),
    );
  }

  Widget _buildSwitchOption({
    required String title,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20.w),
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
            child: Icon(icon, color: const Color(0xFF3E2723), size: 22.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF3E2723),
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: const Color(0xFF3E2723).withValues(alpha: 0.5),
            activeThumbColor: const Color(0xFF3E2723),
          ),
        ],
      ),
    );
  }

  Widget _buildArrowOption({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    bool isDestructive = false,
    String? trailingText,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(20.w),
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
                  color: isDestructive
                      ? Colors.red.withValues(alpha: 0.1)
                      : const Color(0xFF3E2723).withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isDestructive ? Colors.red : const Color(0xFF3E2723),
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isDestructive ? Colors.red : const Color(0xFF3E2723),
                  ),
                ),
              ),
              if (trailingText != null)
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Text(
                    trailingText,
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      color: const Color(0xFF3E2723).withValues(alpha: 0.5),
                    ),
                  ),
                ),
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
