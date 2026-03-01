import 'package:flutter/material.dart';
import 'package:taskati/core/services/hive_helper.dart';

SizedBox verticalSpace(double height) {
  return SizedBox(height: height);
}

extension SpaceExtension on num {
  SizedBox get h {
    return SizedBox(height: toDouble());
  }
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  Color get cardColor => theme.cardColor;
  Color get hoverColor => theme.hoverColor;
  bool get isDarkMode => HiveHelper.getData(HiveHelper.isDarkModeKey) == true;
}

// h(9) // Function
// 9.h  // Extension
