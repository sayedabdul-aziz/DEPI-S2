import 'package:flutter/material.dart';
import 'package:taskati/core/styles/colors.dart';

void showErrorDialog(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.redColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(message),
    ),
  );
}
