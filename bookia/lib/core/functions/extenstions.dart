import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension Localization on BuildContext {
  bool get isArabic => locale.languageCode == 'ar';
}

// context.isArabic
