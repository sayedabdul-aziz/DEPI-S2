import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/styles/colors.dart';
import 'package:taskati/core/styles/themes.dart';
import 'package:taskati/feature/splash/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light,
      builder: (context, child) {
        return SafeArea(
          top: false,
          bottom: Platform.isAndroid,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                color: AppColors.backgroundColor,
              ),
              Image.asset(
                AppImages.bg,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              child ?? Container(),
            ],
          ),
        );
      },
      home: SplashScreen(),
    );
  }
}
