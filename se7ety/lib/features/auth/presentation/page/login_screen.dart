import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/components/dialogs.dart';
import 'package:se7ety/components/inputs/custom_text_field.dart';
import 'package:se7ety/components/inputs/password_text_field.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/extentions/app_regex.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/user_type_enum.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.userType});
  final UserTypeEnum userType;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String handleUserType() {
    return widget.userType == UserTypeEnum.doctor ? 'دكتور' : 'مريض';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: const BackButton(color: AppColors.primaryColor),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            showLoadingDialog(context);
          } else if (state is AuthFailureState) {
            Navigator.pop(context);
            showMyDialog(context, state.message);
          } else if (state is AuthSuccessState) {
            if (state.userType == UserTypeEnum.doctor) {
              // pushToBase(context, Routes.mainDoctor);
            } else {
              pushToBase(context, Routes.mainPatient);
            }
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: cubit.formKey,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.logo, height: 200),
                    const SizedBox(height: 20),
                    Text(
                      'سجل دخول الان كـ "${handleUserType()}"',
                      style: TextStyles.title,
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      controller: cubit.emailController,
                      hintText: 'Sayed@example.com',
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.end,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.email_rounded),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل الايميل';
                        } else if (!AppRegex.isEmailValid(value)) {
                          return 'من فضلك ادخل الايميل صحيحا';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25.0),
                    PasswordTextField(
                      controller: cubit.passwordController,
                      prefixIcon: const Icon(Icons.lock),
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isEmpty) return 'من فضلك ادخل كلمة السر';
                        return null;
                      },
                    ),
                    const Gap(30),
                    MainButton(
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.login();
                        }
                      },
                      text: "تسجيل الدخول",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ليس لدي حساب ؟',
                            style: TextStyles.body.copyWith(
                              color: AppColors.darkColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              pushWithReplacement(
                                context,
                                Routes.register,
                                extra: widget.userType,
                              );
                            },
                            child: Text(
                              'سجل الان',
                              style: TextStyles.body.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
