import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  // ========== LIGHT THEME ==========
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.white,
        error: AppColors.errorRed,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.textDark,
        onError: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.transparent, // Important for gradients
      // Text Theme
      textTheme: GoogleFonts.outfitTextTheme().apply(
        bodyColor: AppColors.primary,
        displayColor: AppColors.primary,
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.primary),
        titleTextStyle: GoogleFonts.outfit(
          color: AppColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Card Theme
      cardTheme: const CardThemeData(
        color: AppColors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.grey300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.errorRed),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: AppColors.primary),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.grey300,
        selectedColor: AppColors.primary,
        labelStyle: GoogleFonts.outfit(color: AppColors.textDark),
        secondaryLabelStyle: GoogleFonts.outfit(color: AppColors.white),
      ),
    );
  }

  // ========== DARK THEME ==========
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        primary: AppColors.white, // High contrast
        secondary: AppColors.igTextSecondary,
        surface: AppColors.igBlack,
        error: AppColors.errorRed,
        onPrimary: AppColors.igBlack,
        onSecondary: AppColors.igBlack,
        onSurface: AppColors.igTextPrimary,
        onError: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.igBlack,

      // Text Theme
      textTheme: GoogleFonts.outfitTextTheme().apply(
        bodyColor: AppColors.white,
        displayColor: AppColors.white,
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.igBlack,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.white),
        titleTextStyle: GoogleFonts.outfit(
          color: AppColors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Card Theme
      cardTheme: const CardThemeData(
        color: AppColors.igDarkGrey,
        elevation: 0, // Instagram uses flat cards with subtle borders
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.igSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.igBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.igBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.white, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.errorRed),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: AppColors.white),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.white,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkBrown,
        selectedColor: AppColors.secondary,
        labelStyle: GoogleFonts.outfit(color: AppColors.white),
        secondaryLabelStyle: GoogleFonts.outfit(color: AppColors.white),
      ),
    );
  }
}
