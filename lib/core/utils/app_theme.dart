import 'package:beauty_app/core/constants/app_colors.dart';
import 'package:beauty_app/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppFonts.notoSans,
      scaffoldBackgroundColor: AppColors.lightBackground,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.lightTextPrimary,
        selectionHandleColor: AppColors.lightTextPrimary,
        selectionColor: AppColors.lightTextPrimary.withOpacity(0.5),
      ),
      appBarTheme: AppBarThemeData(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.lightBackground,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: AppColors.lightTextPrimary,
        ),
      ),
      cardTheme: CardThemeData(color: AppColors.lightCard),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.lightTextPrimary,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppFonts.notoSans,
      scaffoldBackgroundColor: AppColors.darkBackground,
      appBarTheme: AppBarThemeData(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.darkBackground,
      ),
      cardTheme: CardThemeData(color: AppColors.darkCard),
    );
  }
}
