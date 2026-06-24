import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var user = SharedPref.getUserInfo();
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileLoading) {
          showLoadingDialog(context);
        } else if (state is UpdateProfileSuccess) {
          pop(context); // pop loading
          pop(context); // go back to profile
        } else if (state is UpdateProfileError) {
          pop(context); // pop loading
          showToast(context, state.message);
        }
      },
      builder: (context, state) {
        var cubit = context.read<ProfileCubit>();
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () => pop(context),
                  child: const CustomSvgPicture(path: AppImages.backSvg),
                ),
                const Expanded(child: Center(child: Text('Edit Profile'))),
                const Gap(40), // spacer to center the title
              ],
            ),
          ),
          body: MyBodyView(
            child: SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    const Gap(20),
                    Stack(
                      children: [
                        if (cubit.imageFile != null)
                          ClipOval(
                            child: Image.file(
                              cubit.imageFile!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          )
                        else
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: user?.image ?? '',
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  const CircleAvatar(
                                    radius: 60,
                                    backgroundColor: AppColors.borderColor,
                                    child: Icon(
                                      Icons.person,
                                      size: 60,
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                            ),
                          ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              cubit.pickImage();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: AppColors.backgroundColor,
                                shape: BoxShape.circle,
                              ),
                              child: const CustomSvgPicture(
                                path: AppImages.cameraSvg,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(40),
                    CustomTextFormField(
                      controller: cubit.nameController,
                      hintText: 'Full Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    const Gap(15),
                    CustomTextFormField(
                      controller: cubit.phoneController,
                      hintText: 'Phone',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const Gap(15),
                    CustomTextFormField(
                      controller: cubit.cityController,
                      hintText: 'City',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your city';
                        }
                        return null;
                      },
                    ),
                    const Gap(15),
                    CustomTextFormField(
                      controller: cubit.addressController,
                      hintText: 'Address',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(22),
            child: MainButton(
              text: 'Update Profile',
              onPressed: () {
                if (cubit.formKey.currentState!.validate()) {
                  cubit.updateProfile();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
