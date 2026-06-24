import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/validations.dart';
import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/feature/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:bookia/feature/checkout/presentation/cubit/checkout_state.dart';
import 'package:bookia/feature/checkout/presentation/widgets/select_governorate_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({super.key, required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => pop(context),
              child: const CustomSvgPicture(path: AppImages.backSvg),
            ),
          ],
        ),
      ),
      body: MyBodyView(
        child: BlocConsumer<CheckoutCubit, CheckoutState>(
          listener: (context, state) {
            if (state is PlaceOrderLoading) {
              showLoadingDialog(context);
            } else if (state is PlaceOrderSuccess) {
              pushToBase(context, Routes.main, extra: 0);
            } else if (state is PlaceOrderError) {
              pop(context);
              showToast(context, 'Something went wrong');
            }
          },
          builder: (context, state) {
            var cubit = context.read<CheckoutCubit>();
            return SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Place Your Order', style: TextStyles.headline),
                    const Gap(10),
                    Text(
                      'Don\'t worry! It occurs. Please enter the email address linked with your account.',
                      style: TextStyles.caption1.copyWith(
                        color: AppColors.greyColor,
                      ),
                    ),
                    const Gap(30),
                    CustomTextFormField(
                      controller: cubit.nameController,
                      hintText: 'Full Name',
                      validator: (v) {
                        if (v != null && v.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const Gap(15),

                    CustomTextFormField(
                      controller: cubit.addressController,
                      hintText: 'Address',
                      validator: (v) {
                        if (v != null && v.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    const Gap(15),
                    CustomTextFormField(
                      controller: cubit.phoneController,
                      keyboardType: TextInputType.phone,
                      hintText: 'Phone',
                      validator: (v) {
                        if (v != null && v.isEmpty) {
                          return 'Please enter your phone';
                        } else if (!isEgyptianPhone(v!)) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                    const Gap(15),
                    CustomTextFormField(
                      readOnly: true,
                      controller: cubit.governorateController,
                      validator: (v) {
                        if (v != null && v.isEmpty) {
                          return 'Please select a governorate';
                        }
                        return null;
                      },
                      hintText: 'Governorate',
                      suffixIcon: const Icon(Icons.keyboard_arrow_down),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: AppColors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) {
                            return BlocProvider.value(
                              value: cubit,
                              child: const SelectGovernorateBottomSheet(),
                            );
                          },
                        );
                      },
                    ),
                    const Gap(100),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          var cubit = context.read<CheckoutCubit>();
          return Padding(
            padding: const EdgeInsets.fromLTRB(22, 10, 22, 22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyles.subtitle1.copyWith(
                        color: AppColors.greyColor,
                      ),
                    ),
                    Text(
                      '\$${total.toStringAsFixed(2)}',
                      style: TextStyles.subtitle1,
                    ),
                  ],
                ),
                const Gap(20),
                MainButton(
                  text: 'Submit Order',
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.placeOrder();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
