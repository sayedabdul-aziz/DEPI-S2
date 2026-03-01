import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskati/core/constants/app_fonts.dart';
import 'package:taskati/core/styles/colors.dart';
import 'package:taskati/core/styles/text_styles.dart';

class AppThemes {
  static ThemeData get light => ThemeData(
    fontFamily: AppFonts.lexendDeca,
    scaffoldBackgroundColor: Colors.transparent,
    primaryColor: AppColors.primaryColor,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
        minimumSize: Size.zero,
        foregroundColor: AppColors.primaryColor,
      ),
    ),
    dividerColor: Colors.transparent,
    cardColor: AppColors.backgroundColor,
    hoverColor: AppColors.accentColor,
    dividerTheme: DividerThemeData(color: AppColors.secondaryColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.backgroundColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: TextStyles.title.copyWith(
        color: AppColors.blackColor,
        fontFamily: AppFonts.lexendDeca,
      ),
    ),
    // tabBarTheme: TabBarThemeData(
    //   labelColor: AppColors.primaryColor,
    //   unselectedLabelColor: AppColors.secondaryColor,
    // ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      onSurface: AppColors.blackColor,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: AppColors.blackColor),
    ),
    iconTheme: IconThemeData(color: AppColors.blackColor),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.backgroundColor,
      headerForegroundColor: AppColors.primaryColor,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.backgroundColor,
      hourMinuteColor: AppColors.primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.backgroundColor,
      filled: true,
      hintStyle: TextStyles.caption1.copyWith(color: AppColors.secondaryColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    ),
  );

  static ThemeData get dark => ThemeData(
    fontFamily: AppFonts.lexendDeca,
    scaffoldBackgroundColor: Colors.transparent,

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
        minimumSize: Size.zero,
        foregroundColor: AppColors.primaryColor,
      ),
    ),
    dividerColor: Colors.transparent,
    primaryColor: AppColors.primaryColor,
    cardColor: AppColors.blackColor,
    hoverColor: AppColors.blackColor,
    dividerTheme: DividerThemeData(color: AppColors.secondaryColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.backgroundColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: TextStyles.title.copyWith(
        color: AppColors.backgroundColor,
        fontFamily: AppFonts.lexendDeca,
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.blackColor,
      headerForegroundColor: AppColors.primaryColor,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.blackColor,
      hourMinuteColor: AppColors.primaryColor,
      dialBackgroundColor: AppColors.secondaryColor,
    ),
    // tabBarTheme: TabBarThemeData(
    //   labelColor: AppColors.primaryColor,
    //   unselectedLabelColor: AppColors.secondaryColor,
    // ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      onSurface: AppColors.backgroundColor, // text color
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: AppColors.backgroundColor),
    ),
    iconTheme: IconThemeData(color: AppColors.backgroundColor),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.blackColor,
      filled: true,
      hintStyle: TextStyles.caption1.copyWith(color: AppColors.secondaryColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
