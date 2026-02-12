import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:greenmart/core/styles/colors.dart';
import 'package:greenmart/core/styles/text_styles.dart';
import 'package:greenmart/core/widgets/main_button.dart';
import 'package:greenmart/features/details/widgets/checkout_bottom_sheet.dart';
import 'package:greenmart/features/details/widgets/price_with_counter.dart';
import 'package:greenmart/features/home/data/product_model.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.model});
  final ProductModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF2F3F2),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * .3,
              decoration: BoxDecoration(
                color: Color(0xffF2F3F2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.all(30),
              child: Image.network(model.image),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(model.name, style: TextStyles.subtitle),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(model.quantityForPrice.toString()),
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: Icon(Icons.favorite_border_rounded),
                    ),
                  ),
                  SizedBox(height: 20),
                  PriceWithCounter(model: model),
                  SizedBox(height: 20),
                  Divider(),
                  ExpansionTile(
                    title: Text('Product Detail', style: TextStyles.subtitle),
                    childrenPadding: EdgeInsets.zero,
                    tilePadding: EdgeInsets.zero,
                    children: [
                      Text(
                        'Apples are nutritious. Apples may be good for weight loss. apples may be good for your heart. As part of a healtful and varied diet.',
                        style: TextStyles.caption1.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 30),
                  Row(
                    children: [
                      Text('Reviews', style: TextStyles.subtitle),
                      Spacer(),
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemSize: 24,
                        itemBuilder: (context, _) =>
                            Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {},
                      ),
                      Icon(Icons.chevron_right_rounded, size: 30),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: MainButton(
          text: 'Add to Cart',
          onPressed: () {
            showCheckoutBottomSheet(context);
          },
        ),
      ),
    );
  }
}
