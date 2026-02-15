import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFFF9A20B);
  static const Color backgroundLight = Color(0xFFF8F7F5);
  static const Color backgroundDark = Color(0xFF231C0F);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF2D2415);
  static const Color textLight = Color(0xFF181511);
  static const Color textDark = Color(0xFFF3F4F6); // Gray-100 equivalent
  static const Color danger = Color(0xFFEF4444);
}

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        surface: AppColors.surfaceLight,
        onSurface: AppColors.textLight,
        primary: AppColors.primary,
        onPrimary: AppColors.textLight,
      ),
      textTheme: GoogleFonts.interTextTheme().apply(
        bodyColor: AppColors.textLight,
        displayColor: AppColors.textLight,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textLight,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.textDark,
        primary: AppColors.primary,
        onPrimary: AppColors.textLight,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme,
      ).apply(bodyColor: AppColors.textDark, displayColor: AppColors.textDark),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textDark,
      ),
    );
  }

  /// Replaces the current theme with colors from Telegram Web App params if available.
  static ThemeData fromTelegram(
    Map<String, String>? themeParams,
    Brightness brightness,
  ) {
    if (themeParams == null || themeParams.isEmpty) {
      return brightness == Brightness.dark ? dark : light;
    }

    final bgColor = _parseColor(themeParams['bg_color']);
    final textColor = _parseColor(themeParams['text_color']);
    final hintColor = _parseColor(themeParams['hint_color']);
    final buttonColor = _parseColor(themeParams['button_color']);
    final buttonTextColor = _parseColor(themeParams['button_text_color']);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      primaryColor: buttonColor ?? AppColors.primary,
      scaffoldBackgroundColor:
          bgColor ??
          (brightness == Brightness.dark
              ? AppColors.backgroundDark
              : AppColors.backgroundLight),
      colorScheme: ColorScheme.fromSeed(
        seedColor: buttonColor ?? AppColors.primary,
        brightness: brightness,
        surface:
            bgColor ??
            (brightness == Brightness.dark
                ? AppColors.surfaceDark
                : AppColors.surfaceLight),
        onSurface:
            textColor ??
            (brightness == Brightness.dark
                ? AppColors.textDark
                : AppColors.textLight),
        primary: buttonColor ?? AppColors.primary,
        onPrimary: buttonTextColor ?? AppColors.textLight,
      ),
      textTheme:
          GoogleFonts.interTextTheme(
            brightness == Brightness.dark
                ? ThemeData.dark().textTheme
                : ThemeData.light().textTheme,
          ).apply(
            bodyColor:
                textColor ??
                (brightness == Brightness.dark
                    ? AppColors.textDark
                    : AppColors.textLight),
            displayColor:
                textColor ??
                (brightness == Brightness.dark
                    ? AppColors.textDark
                    : AppColors.textLight),
          ),
      hintColor: hintColor,
    );
  }

  static Color? _parseColor(String? hex) {
    if (hex == null) return null;
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }
}
