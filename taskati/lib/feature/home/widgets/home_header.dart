import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/extensions.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/styles/text_styles.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String name = '';
  String path = '';
  @override
  void initState() {
    getCachedData();
    super.initState();
  }

  Future<void> getCachedData() async {
    name = HiveHelper.getData(HiveHelper.nameKey);
    path = HiveHelper.getData(HiveHelper.imageKey);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: path.isEmpty
              ? Image.asset(AppImages.user, height: 50)
              : Image.file(
                  File(path),
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(AppImages.user, height: 50);
                  },
                ),
        ),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello', style: TextStyles.caption1),
              Text(name, style: TextStyles.title),
            ],
          ),
        ),

        IconButton(
          onPressed: () {
            bool isDarkMode = context.isDarkMode;
            HiveHelper.cacheData(HiveHelper.isDarkModeKey, !isDarkMode);
            setState(() {});
          },
          icon: Icon(context.isDarkMode ? Icons.light_mode : Icons.dark_mode),
        ),
      ],
    );
  }
}
