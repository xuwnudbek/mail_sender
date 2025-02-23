import 'package:flutter/material.dart';
import 'package:mail_sender/utils/color/app_colors.dart';

class AppThemes {
  static ThemeData get themeData => ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.primary, // 📌 Primary rang
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primary, // 📌 Global primary rang
          secondary: AppColors.white, // 📌 Ikkinchi rang
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Montserrat",
        scaffoldBackgroundColor: AppColors.primary.withValues(alpha: 0.05),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: AppColors.transparent,
            fixedSize: Size.fromHeight(40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textTheme: TextTheme(
          titleSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          // filled: true,
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primary,
              width: 0.5,
            ),
          ),
          fillColor: AppColors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          visualDensity: VisualDensity.comfortable,
          side: BorderSide(
            color: AppColors.primary,
            width: 1,
          ),
          checkColor: WidgetStateProperty.all(AppColors.white),
          overlayColor: WidgetStateProperty.all(AppColors.primary.withValues(alpha: 0.0)),
        ),
      );
}
