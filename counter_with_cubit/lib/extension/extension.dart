// method(value)  ==> result

// value.extension

// verticalSpace(20)
// 20.h

import 'package:flutter/material.dart';

Widget verticalSpace(double height) {
  return SizedBox(height: height);
}

extension Spacing on num {
  Widget get h => SizedBox(height: toDouble());
}
