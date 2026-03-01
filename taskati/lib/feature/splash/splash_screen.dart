import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/styles/colors.dart';
import 'package:taskati/core/styles/text_styles.dart';
import 'package:taskati/feature/complete_profile/page/complete_profile_screen.dart';
import 'package:taskati/feature/home/page/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    bool isUploaded = HiveHelper.getData(HiveHelper.isUploadedKey) == true;
    Future.delayed(const Duration(seconds: 3), () {
      if (isUploaded) {
        pushReplacement(context, const HomeScreen());
      } else {
        pushReplacement(context, const CompleteProfileScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 18,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AppImages.logoJson, width: 250),
            const Text('Taskati', style: TextStyles.headline),
            Text(
              'It’s time to get organized',
              style: TextStyles.caption1.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
