import 'package:flutter/material.dart';

class AppColors {
  // ========== PRIMARY & SECONDARY ==========
  static const Color primary = Color(
    0xFF3E2723,
  ); // Dark brown - Main brand color
  static const Color secondary = Color(
    0xFF795548,
  ); // Medium brown - Secondary brand color

  // ========== BACKGROUND GRADIENTS ==========
  static const Color backgroundGradientStart = Color(0xFFFFF3E0); // Light cream
  static const Color backgroundGradientMiddle = Color(
    0xFFFFECB3,
  ); // Light yellow
  static const Color backgroundGradientEnd = Color(0xFFFBE9E7); // Light pink

  // ========== BROWN PALETTE EXTENSIONS ==========
  static const Color deepBrown = Color(
    0xFF4E342E,
  ); // For headings, deep elements
  static const Color darkBrown = Color(0xFF5D4037); // For containers, buttons
  static const Color mediumBrown = Color(0xFF8D6E63); // For cards with opacity

  // ========== CARD BACKGROUND COLORS ==========
  static const Color cardOrange = Color(0xFFFFCCBC); // Category cards
  static const Color cardYellow = Color(0xFFFFE0B2); // Category cards
  static const Color cardBeige = Color(0xFFD7CCC8); // Category cards
  static const Color warningBackground = Color(
    0xFFFFF8E1,
  ); // Warning/alert backgrounds

  // ========== FUNCTIONAL COLORS ==========
  static const Color accentRed = Color(0xFFE57373); // Logout button, warnings
  static const Color accentPink = Color(0xFFE91E63); // Badges, notifications
  static const Color priceHighlight = Color(
    0xFFE64A19,
  ); // Deep orange for prices
  static const Color successGreen = Color(0xFF4CAF50); // Success states
  static const Color warningOrange = Color(0xFFFF9800); // Warnings
  static const Color errorRed = Colors.redAccent; // Errors, delete actions

  // ========== NOTIFICATION CATEGORY COLORS ==========
  static const Color notificationOrder = Color(
    0xFF4CAF50,
  ); // Green - Order notifications
  static const Color notificationOffer = Color(
    0xFFFF9800,
  ); // Orange - Offer notifications
  static const Color notificationSystem = Color(
    0xFF607D8B,
  ); // Blue-grey - System notifications

  // ========== TEXT COLORS ==========
  static const Color textDark = Colors.black87; // Primary text
  static const Color textMedium = Color(
    0xFF795548,
  ); // Secondary text (same as secondary)
  static const Color textLight = Color(0xFF8D6E63); // Tertiary text
  static const Color textSubtle = Color(
    0xFFBDBDBD,
  ); // Disabled/placeholder text

  // ========== NEUTRAL COLORS ==========
  static const Color white = Colors.white;
  static const Color black = Color(0xFF000000);
  static const Color grey300 = Color(0xFFE0E0E0); // Dividers
  static const Color grey600 = Color(0xFF757575); // Icons
  static const Color transparent = Colors.transparent;
}
