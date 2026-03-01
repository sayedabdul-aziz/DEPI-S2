import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/styles/colors.dart';
import 'package:taskati/core/styles/themes.dart';
import 'package:taskati/feature/splash/splash_screen.dart';

// add light and dark themeData to MaterialApp
// use ThemeMode to change theme
// handle theme change in home screen
// cache theme mode

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initializeDateFormatting('ar');
  // await SharedPref.init();
  await HiveHelper.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarBrightness: Brightness.light,
    //     statusBarColor: AppColors.redColor,
    //   ),
    // );
    return ValueListenableBuilder(
      valueListenable: HiveHelper.userBox.listenable(),
      builder: (context, box, child) {
        bool isDarkMode = HiveHelper.getData(HiveHelper.isDarkModeKey) == true;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          builder: (context, child) {
            final overlayStyle = isDarkMode
                ? const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.light,
                    statusBarBrightness: Brightness.dark,
                  )
                : const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark,
                    statusBarBrightness: Brightness.light,
                  );

            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: overlayStyle,
              child: SafeArea(
                top: false,
                bottom: Platform.isAndroid,
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: isDarkMode
                          ? AppColors.blackColor
                          : AppColors.backgroundColor,
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
              ),
            );
          },
          home: SplashScreen(),
        );
      },
    );
  }
}
