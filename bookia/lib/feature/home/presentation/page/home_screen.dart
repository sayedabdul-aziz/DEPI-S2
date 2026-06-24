import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/extenstions.dart';
import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/feature/home/presentation/widgets/best_seller_builder.dart';
import 'package:bookia/feature/home/presentation/widgets/home_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<HomeCubit>().loadInitData(),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [CustomSvgPicture(path: AppImages.logoSvg, height: 30)],
          ),
          actions: [
            IconButton(
              onPressed: () {
                // get locale
                // set another locale
                context.setLocale(
                  context.isArabic ? Locale('en') : Locale('ar'),
                );
              },
              icon: Icon(Icons.language_rounded),
            ),
            IconButton(
              onPressed: () {
                pushTo(context, Routes.search);
              },
              icon: CustomSvgPicture(path: AppImages.searchSvg),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: ClampingScrollPhysics(),
          ),
          child: Column(children: [HomeSlider(), Gap(20), BestSellerBuilder()]),
        ),
      ),
    );
  }
}
