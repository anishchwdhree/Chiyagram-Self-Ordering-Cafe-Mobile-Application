import 'package:chiyagaram/profile/edit_profile.dart';
import 'package:chiyagaram/profile/settings_screen.dart';
import 'package:chiyagaram/screens/widget/background_scaffold.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chiyagaram/profile/setting/help_support_screen.dart';
import 'package:chiyagaram/profile/my_orders_screen.dart';
import 'package:chiyagaram/screens/auth/login_screen.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF3E2723);
    final subTextColor = isDark ? Colors.white70 : const Color(0xFF795548);
    final cardColor = isDark
        ? const Color(0xFF5D4037).withOpacity(0.4)
        : Colors.white.withValues(alpha: 0.6);

    return BackgroundScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              // Profile Header
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: textColor.withValues(alpha: 0.1),
                        width: 2.w,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 50.w,
                      backgroundColor: isDark ? const Color(0xFF4E342E) : Colors.white,
                      backgroundImage: const AssetImage(
                        'images/profile.png',
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Anish Chaudhary",
                    style: GoogleFonts.philosopher(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "anish@example.com",
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      color: subTextColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),

              // Menu Options
              _buildProfileOption(
                title: "Edit Profile",
                icon: Iconsax.edit,
                textColor: textColor,
                cardColor: cardColor,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    ),
                  );
                },
              ),
              _buildProfileOption(
                title: "My Orders",
                icon: Iconsax.bag_2,
                textColor: textColor,
                cardColor: cardColor,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyOrdersScreen(),
                    ),
                  );
                },
              ),
              _buildProfileOption(
                title: "Settings",
                icon: Iconsax.setting_2,
                textColor: textColor,
                cardColor: cardColor,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
              ),
              _buildProfileOption(
                title: "Help & Support",
                icon: Iconsax.support,
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

              SizedBox(height: 30.h),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _showLogoutConfirmation(context, isDark, textColor),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 163, 61, 61),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.w),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.logout,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Logout",
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 100.h), // Spacing for bottom nav bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required Color textColor,
    required Color cardColor,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Material(
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
                  color: textColor.withValues(alpha: 0.05),
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
                  child: Icon(
                    icon,
                    color: textColor,
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
                      color: textColor,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16.sp,
                  color: textColor.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context, bool isDark, Color textColor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF4E342E) : const Color(0xFFFFF8E1),
        title: Text(
          "Logout",
          style: GoogleFonts.philosopher(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        content: Text(
          "Are you sure you want to logout?",
          style: GoogleFonts.outfit(color: textColor.withOpacity(0.8)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: GoogleFonts.outfit(color: textColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            child: Text(
              "Logout",
              style: GoogleFonts.outfit(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
