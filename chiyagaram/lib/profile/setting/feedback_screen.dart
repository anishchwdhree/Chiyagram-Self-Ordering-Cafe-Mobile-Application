import 'package:chiyagaram/screens/widget/background_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:chiyagaram/theme/app_colors.dart';
import 'package:chiyagaram/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  double _rating = 0;

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios_new, color: textColor),
                ),
                Expanded(
                  child: Text(
                    "Send Feedback",
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
            SizedBox(height: 40.h),
            Text(
              "How was your experience?",
              style: GoogleFonts.outfit(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      _rating = index + 1.0;
                    });
                  },
                  icon: Icon(
                    index < _rating
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: Colors.amber,
                    size: 40.sp,
                  ),
                );
              }),
            ),
            SizedBox(height: 40.h),
            TextField(
              controller: _feedbackController,
              maxLines: 5,
              style: GoogleFonts.outfit(fontSize: 16.sp, color: textColor),
              decoration: InputDecoration(
                hintText: "Write your feedback here...",
                hintStyle: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  color: textColor.withValues(alpha: 0.4),
                ),
                filled: true,
                fillColor: isDark
                    ? AppColors.igSurface
                    : Colors.white.withValues(alpha: 0.6),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.w),
                  borderSide: isDark
                      ? const BorderSide(color: AppColors.igBorder)
                      : BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.w),
                  borderSide: isDark
                      ? const BorderSide(color: AppColors.igBorder)
                      : BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 40.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle generic feedback submission
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Thank you for your feedback!",
                        style: GoogleFonts.outfit(),
                      ),
                      backgroundColor: isDark
                          ? AppColors.igSurface
                          : const Color(0xFF3E2723),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark
                      ? Colors.white
                      : const Color(0xFF3E2723),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.w),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  "Submit Feedback",
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
