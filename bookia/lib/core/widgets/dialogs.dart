import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

enum DialogType { error, success }

void showToast(
  BuildContext context,
  String errorMsg, [
  DialogType type = DialogType.error,
]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      duration: const Duration(milliseconds: 700),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: type == DialogType.error
          ? AppColors.errorColor
          : AppColors.primaryColor,
      content: Row(
        children: [
          Icon(
            type == DialogType.error ? Icons.error : Icons.check_circle,
            color: AppColors.backgroundColor,
            size: 20,
          ),
          const Gap(10),
          Text(errorMsg),
        ],
      ),
    ),
  );
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: AppColors.darkColor.withValues(alpha: 0.7),
    builder: (context) => Center(child: Lottie.asset(AppImages.loadingJson)),
  );
}
