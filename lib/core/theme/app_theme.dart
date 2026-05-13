import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Netflix + Geo Cinema Dark Colors
  static const Color darkBg = Color(0xFF0F0F0F);
  static const Color darkCard = Color(0xFF1A1A1A);
  static const Color neonGreen = Color(0xFF00FF88);
  static const Color neonRed = Color(0xFFFF0055);
  static const Color neonBlue = Color(0xFF00D9FF);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB3B3B3);
  static const Color accent = Color(0xFF2E2E2E);

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBg,
    primaryColor: neonGreen,
    canvasColor: darkCard,
    
    colorScheme: ColorScheme.dark(
      primary: neonGreen,
      secondary: neonRed,
      tertiary: neonBlue,
      surface: darkCard,
      error: neonRed,
      onPrimary: darkBg,
      onSecondary: textPrimary,
      onSurface: textPrimary,
    ),

    textTheme: TextTheme(
      displayLarge: GoogleFonts.roboto(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      displayMedium: GoogleFonts.roboto(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      headlineLarge: GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      headlineMedium: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleLarge: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleMedium: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: 16,
        color: textPrimary,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 14,
        color: textSecondary,
      ),
      bodySmall: GoogleFonts.roboto(
        fontSize: 12,
        color: textSecondary,
      ),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: darkBg,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: accent,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: accent),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: accent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: neonGreen),
      ),
      hintStyle: GoogleFonts.roboto(color: textSecondary),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: neonGreen,
        foregroundColor: darkBg,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
    ),

    iconTheme: const IconThemeData(color: neonGreen),
  );
}
