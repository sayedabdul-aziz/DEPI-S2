import 'dart:io';

import 'package:bookia/core/styles/themes.dart';
import 'package:bookia/feature/splash/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DevicePreview(enabled: !kDebugMode, builder: (context) => const MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(1.0)),
          child: SafeArea(
            top: false,
            bottom: Platform.isAndroid,
            child: child!,
          ),
        );
      },
      home: SplashScreen(),
    );
  }
}
