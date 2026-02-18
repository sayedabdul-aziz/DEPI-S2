import 'package:flutter/material.dart';
import 'package:taskati/core/styles/colors.dart';
import 'package:taskati/core/styles/text_styles.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.bgColor = AppColors.primaryColor,
    this.height = 55,
    this.width = double.infinity,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        minimumSize: Size(width, height),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style:
            textStyle ??
            TextStyles.body.copyWith(
              color: AppColors.backgroundColor,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
