import 'package:bmi_calculator/colors.dart';
import 'package:flutter/material.dart';

class GenderCard extends StatelessWidget {
  const GenderCard({
    super.key,
    required this.text,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String text;
  final IconData icon;
  final bool isSelected;
  final Function() onTap;

  // Color getColor() {
  //   if (isSelected) {
  //     return AppColors.primaryColor;
  //   } else {
  //     return AppColors.cardColor;
  //   }
  // }

  // variable = (condition) ? valueIfTrue : valueIfFalse

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : AppColors.cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 80, color: AppColors.whiteColor),
              Text(
                text,
                style: TextStyle(color: AppColors.whiteColor, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
