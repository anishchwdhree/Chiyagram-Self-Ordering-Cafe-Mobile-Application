import 'package:chiyagaram/theme/theme_provider.dart';
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
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF3E2723);
    final cardColor = isDark
        ? const Color(0xFF5D4037).withOpacity(0.4)
        : Colors.white.withValues(alpha: 0.6);

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          RepaintBoundary(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: isDark
                    ? const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF2D1B18),
                          Color(0xFF3E2723),
                          Color(0xFF1A1210),
                        ],
                      )
                    : const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFFFF3E0),
                          Color(0xFFFFECB3),
                          Color(0xFFFBE9E7),
                        ],
                      ),
              ),
              child: const SizedBox.expand(),
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
                        icon: Icon(Icons.arrow_back_ios_new, color: textColor),
                      ),
                      Expanded(
                        child: Text(
                          "Settings",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.philosopher(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 40.w), // Balance back button
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Account Settings
                  _buildSectionHeader("Account", textColor),
                  _buildArrowOption(
                    title: "Change Password",
                    icon: Iconsax.lock,
                    textColor: textColor,
                    cardColor: cardColor,
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
                    textColor: textColor,
                    cardColor: cardColor,
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
                  _buildSectionHeader("App Settings", textColor),
                  _buildSwitchOption(
                    title: "Push Notifications",
                    icon: Iconsax.notification,
                    value: _notificationsEnabled,
                    textColor: textColor,
                    cardColor: cardColor,
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
                    value: themeProvider.themeMode == ThemeMode.dark,
                    textColor: textColor,
                    cardColor: cardColor,
                    onChanged: (value) {
                      themeProvider.toggleTheme(value);
                    },
                  ),
                  SizedBox(height: 12.h),
                  _buildArrowOption(
                    title: "Language",
                    icon: Iconsax.global,
                    trailingText: "English",
                    textColor: textColor,
                    cardColor: cardColor,
                    onTap: () {},
                  ),
                  SizedBox(height: 24.h),

                  // Support
                  _buildSectionHeader("Support", textColor),
                  _buildArrowOption(
                    title: "Help Center",
                    icon: Iconsax.message_question,
                    textColor: textColor,
                    cardColor: cardColor,
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
                    textColor: textColor,
                    cardColor: cardColor,
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
                    textColor: textColor,
                    cardColor: cardColor,
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
                    textColor: textColor,
                    cardColor: cardColor,
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
                    textColor: textColor,
                    cardColor: cardColor,
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
                        color: textColor.withOpacity(0.5),
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

  Widget _buildSectionHeader(String title, Color textColor) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, left: 8.w),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: textColor.withOpacity(0.6),
        ),
      ),
    );
  }

  Widget _buildSwitchOption({
    required String title,
    required IconData icon,
    required bool value,
    required Color textColor,
    required Color cardColor,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20.w),
        border: Border.all(color: textColor.withOpacity(0.1), width: 1.w),
        boxShadow: [
          BoxShadow(
            color: textColor.withOpacity(0.05),
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
              color: textColor.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: textColor, size: 22.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: textColor.withOpacity(0.5),
            activeThumbColor: textColor,
          ),
        ],
      ),
    );
  }

  Widget _buildArrowOption({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required Color textColor,
    required Color cardColor,
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
            color: cardColor,
            borderRadius: BorderRadius.circular(20.w),
            border: Border.all(color: textColor.withOpacity(0.1), width: 1.w),
            boxShadow: [
              BoxShadow(
                color: textColor.withOpacity(0.05),
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
                      ? Colors.red.withOpacity(0.1)
                      : textColor.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isDestructive ? Colors.red : textColor,
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
                    color: isDestructive ? Colors.red : textColor,
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
                      color: textColor.withOpacity(0.5),
                    ),
                  ),
                ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16.sp,
                color: isDestructive
                    ? Colors.red.withOpacity(0.5)
                    : textColor.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
