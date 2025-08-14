import 'package:flutter/material.dart';

class AppTheme {
  // Color Palette
  static const Color primaryColor = Color(0xFF4A80F0); // Main blue color
  static const Color accentColor = Color(0xFFF5A623); // Orange accent
  static const Color primaryBackgroundColor = Color(
    0xFFF5F7FA,
  ); // Light gray background
  static const Color secondaryBackgroundColor = Colors.white; // White cards
  static const Color primaryTextColor = Color(0xFF2D3748); // Dark gray text
  static const Color secondaryTextColor = Color(0xFF718096); // Gray text
  static const Color weatherCardColor = Color(0xFF4A80F0); // Blue weather card
  static const Color errorColor = Color(0xFFE53E3E); // Red for errors

  // Text Styles
  static const TextStyle appBarTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: primaryTextColor,
    fontFamily: 'Poppins',
  );

  static const TextStyle cityNameStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: 'Poppins',
  );

  static const TextStyle temperatureStyle = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontFamily: 'Poppins',
  );

  static const TextStyle weatherConditionStyle = TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontFamily: 'Poppins',
  );

  static const TextStyle detailTitleStyle = TextStyle(
    fontSize: 14,
    color: primaryTextColor,
    fontFamily: 'Poppins',
  );

  static const TextStyle detailValueStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: primaryTextColor,
    fontFamily: 'Poppins',
  );

  // Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      // Colors
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        surface: secondaryBackgroundColor,
        background: primaryBackgroundColor,
        error: errorColor,
      ),

      // Scaffold
      scaffoldBackgroundColor: primaryBackgroundColor,

      // App Bar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: appBarTitleStyle,
        iconTheme: IconThemeData(color: primaryTextColor),
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.w300,
          color: primaryTextColor,
          fontFamily: 'Poppins',
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: primaryTextColor,
          fontFamily: 'Poppins',
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: secondaryTextColor,
          fontFamily: 'Poppins',
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontFamily: 'Poppins',
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white, // Ganti dengan warna yang sesuai
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        surfaceTintColor: Colors
            .transparent, // Tambahkan untuk menghilangkan efek tint di Material 3
      ),

      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
