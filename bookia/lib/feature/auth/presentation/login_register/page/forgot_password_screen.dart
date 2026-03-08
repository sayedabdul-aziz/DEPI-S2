import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/feature/auth/presentation/login_register/page/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => pop(context),
              child: CustomSvgPicture(path: AppImages.backSvg),
            ),
          ],
        ),
      ),
      body: MyBodyView(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot Password?',
                style: TextStyles.headline,
              ),
              Gap(10),
              Text(
                'Don\'t worry! It occurs. Please enter the email address linked with your account.',
                style: TextStyles.body.copyWith(
                  color: AppColors.darkGreyColor,
                ),
              ),
              Gap(32),
              CustomTextFormField(hintText: 'Enter your email'),
              Gap(40),
              MainButton(text: 'Send Code', onPressed: () {}),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Remember Password? ',
              style: TextStyles.caption1.copyWith(
                color: AppColors.darkGreyColor,
              ),
            ),
            TextButton(
              onPressed: () {
                pushReplacement(context, const LoginScreen());
              },
              child: Text(
                'Login',
                style: TextStyles.caption1.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
