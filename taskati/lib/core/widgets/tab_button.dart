import 'package:flutter/material.dart';
import 'package:taskati/core/styles/colors.dart';
import 'package:taskati/core/styles/text_styles.dart';

class TabButton extends StatelessWidget {
  const TabButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.bgColor = AppColors.accentColor,
    this.height = 35,
    this.width = 50,
    this.textStyle,
  });
  final String text;
  final Function() onPressed;
  final Color bgColor;
  final double height;
  final double width;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        minimumSize: Size(width, height),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style:
            textStyle ??
            TextStyles.caption1.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
