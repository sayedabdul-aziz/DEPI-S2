import 'package:flutter/material.dart';

SizedBox verticalSpace(double height) {
  return SizedBox(height: height);
}

extension SpaceExtension on num {
  SizedBox get h {
    return SizedBox(height: toDouble());
  }
}

// h(9) // Function
// 9.h  // Extension
