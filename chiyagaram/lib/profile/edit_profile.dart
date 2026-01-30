import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:chiyagaram/theme/app_colors.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController(
    text: "Anish Chaudhary",
  );
  final TextEditingController _emailController = TextEditingController(
    text: "anish@example.com",
  );

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF3E2723);

    return Scaffold(
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
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                          "Edit Profile",
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
                  SizedBox(height: 30.h),

                  // Profile Image
                  Stack(
                    alignment: Alignment.bottomRight,
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
                          radius: 60.w,
                          backgroundColor: isDark
                              ? AppColors.igSurface
                              : Colors.white,
                          backgroundImage: const AssetImage(
                            "images/profile.png",
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF3E2723),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark ? Colors.black : Colors.white,
                            width: 2.w,
                          ),
                        ),
                        child: Icon(
                          Iconsax.camera,
                          color: isDark ? Colors.black : Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),

                  // Form Fields
                  _buildTextField(
                    "Full Name",
                    "Anish Chaudhary",
                    Iconsax.user,
                    _nameController,
                    isDark,
                    textColor,
                  ),
                  SizedBox(height: 20.h),
                  _buildTextField(
                    "Email",
                    "anish@example.com",
                    Iconsax.sms,
                    _emailController,
                    isDark,
                    textColor,
                  ),

                  SizedBox(height: 50.h),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark
                            ? Colors.white
                            : const Color(0xFF3E2723),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.w),
                        ),
                        elevation: 5,
                        shadowColor:
                            (isDark ? Colors.black : const Color(0xFF3E2723))
                                .withValues(alpha: 0.3),
                      ),
                      child: Text(
                        "Save Changes",
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String placeholder,
    IconData icon,
    TextEditingController controller,
    bool isDark,
    Color textColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: textColor.withValues(alpha: 0.7),
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          style: GoogleFonts.outfit(
            fontSize: 16.sp,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: GoogleFonts.outfit(
              fontSize: 16.sp,
              color: textColor.withValues(alpha: 0.4),
            ),
            prefixIcon: Icon(
              icon,
              color: textColor.withValues(alpha: 0.6),
              size: 22.sp,
            ),
            filled: true,
            fillColor: isDark
                ? AppColors.igSurface
                : Colors.white.withValues(alpha: 0.6),
            contentPadding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 20.w,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.w),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.w),
              borderSide: BorderSide(
                color: isDark
                    ? AppColors.igBorder
                    : Colors.white.withValues(alpha: 0.5),
                width: 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.w),
              borderSide: BorderSide(
                color: textColor.withValues(alpha: 0.2),
                width: 1.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
