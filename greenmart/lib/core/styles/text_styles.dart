import 'package:flutter/material.dart';
import 'package:greenmart/core/styles/colors.dart';

class TextStyles {
  static const TextStyle headline = TextStyle(
    fontSize: 48,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    // height: 48 / 24, // 2
    // letterSpacing: 0,
    color: AppColors.blackColor,
  );

  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    height: 32 / 24,
    color: AppColors.blackColor,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    color: AppColors.blackColor,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontFamily: 'Poppins',
    color: AppColors.blackColor,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontFamily: 'Poppins',
    color: AppColors.blackColor,
  );
}
