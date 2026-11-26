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
import 'package:chiyagaram/theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF3E2723);
    final subTextColor = isDark
        ? AppColors.igTextSecondary
        : const Color(0xFF795548);
    final cardColor = isDark
        ? AppColors.igSurface.withValues(alpha: 0.6)
        : Colors.white.withValues(alpha: 0.6);

    return BackgroundScaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: MediaQuery.of(context).padding.top + 20.h,
          bottom: 20.h,
        ),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            // Profile Header
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseAuth.instance.currentUser != null
                  ? FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots()
                  : null,
              builder: (context, snapshot) {
                final user = FirebaseAuth.instance.currentUser;
                final userData = snapshot.data?.data() as Map<String, dynamic>?;

                final displayName =
                    userData?['displayName'] ??
                    user?.displayName ??
                    "Guest User";
                final email = user?.email ?? "No email";
                // Check for Base64 image in Firestore first, then fallback to Auth photoURL
                final photoBase64 = userData?['photoBase64'] as String?;
                final photoUrl = user?.photoURL;

                return Column(
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
                        backgroundColor: isDark
                            ? AppColors.igSurface
                            : const Color(0xFFD7CCC8),
                        backgroundImage: photoBase64 != null
                            ? MemoryImage(base64Decode(photoBase64))
                            : (photoUrl != null
                                  ? NetworkImage(photoUrl)
                                  : null),
                        child: (photoBase64 == null && photoUrl == null)
                            ? Text(
                                _getInitials(displayName),
                                style: GoogleFonts.philosopher(
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xFF3E2723),
                                ),
                              )
                            : null,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      displayName,
                      style: GoogleFonts.philosopher(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      email,
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        color: subTextColor,
                      ),
                    ),
                  ],
                );
              },
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
                  MaterialPageRoute(builder: (context) => const EditProfile()),
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
                onPressed: () =>
                    _showLogoutConfirmation(context, isDark, textColor),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark
                      ? Colors.white
                      : const Color.fromARGB(255, 163, 61, 61),
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
                      color: isDark ? Colors.black : Colors.white,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Logout",
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.black : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 110.h), // Spacing for bottom nav bar
          ],
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
              border: Border.all(
                color: textColor.withValues(alpha: 0.1),
                width: 1.w,
              ),
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
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16.sp,
                  color: textColor.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation(
    BuildContext context,
    bool isDark,
    Color textColor,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.igSurface : const Color(0xFFFFF8E1),
        title: Text(
          "Logout",
          style: GoogleFonts.philosopher(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        content: Text(
          "Are you sure you want to logout?",
          style: GoogleFonts.outfit(color: textColor.withValues(alpha: 0.8)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: GoogleFonts.outfit(color: textColor)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            child: Text(
              "Logout",
              style: GoogleFonts.outfit(
                color: isDark ? Colors.redAccent : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return "";
    List<String> parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts.last[0]).toUpperCase();
  }
}
