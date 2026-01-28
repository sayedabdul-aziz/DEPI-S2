import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenmart/core/constants/app_images.dart';
import 'package:greenmart/core/styles/colors.dart';
import 'package:greenmart/core/styles/text_styles.dart';
import 'package:greenmart/core/widgets/main_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // image
          Image.asset(
            AppImages.welcome,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          // content
          Positioned(
            bottom: 60,
            left: 30,
            right: 30,
            child: Column(
              children: [
                SvgPicture.asset(
                  AppImages.carrotSvg,
                  colorFilter: ColorFilter.mode(
                    AppColors.backgroundColor,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  'Welcome',
                  textAlign: TextAlign.center,
                  style: TextStyles.headline.copyWith(
                    color: AppColors.backgroundColor,
                  ),
                ),
                Text(
                  'to our store',
                  textAlign: TextAlign.center,
                  style: TextStyles.headline.copyWith(
                    color: AppColors.backgroundColor,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Ger your groceries in as fast as one hour',
                  textAlign: TextAlign.center,
                  style: TextStyles.body.copyWith(
                    color: AppColors.backgroundColor,
                  ),
                ),
                SizedBox(height: 30),
                MainButton(
                  text: 'Get Started',
                  onPressed: () {},
                  textStyle: TextStyles.subtitle.copyWith(
                    color: AppColors.backgroundColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
