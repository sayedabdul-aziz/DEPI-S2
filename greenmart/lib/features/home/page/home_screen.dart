import 'package:flutter/material.dart';
import 'package:greenmart/core/constants/app_images.dart';
import 'package:greenmart/core/functions/navigations.dart';
import 'package:greenmart/core/styles/colors.dart';
import 'package:greenmart/core/widgets/custom_svg_picture.dart';
import 'package:greenmart/core/widgets/custom_text_form_field.dart';
import 'package:greenmart/features/home/widgets/all_products_builder.dart';
import 'package:greenmart/features/home/widgets/best_selling_builder.dart';
import 'package:greenmart/features/home/widgets/offers_builder.dart';
import 'package:greenmart/features/search/page/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomSvgPicture(
          path: AppImages.logoSvg,
          color: AppColors.primaryColor,
          height: 42,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            children: [
              GestureDetector(
                onTap: () {
                  pushTo(context, SearchScreen());
                },
                child: Hero(
                  tag: 'search',
                  child: Material(
                    child: CustomTextFormField(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search for products',
                      enabled: false,
                    ),
                  ),
                ),
              ),
              OffersBuilder(),
              BestSellingBuilder(),
              AllProductsBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
