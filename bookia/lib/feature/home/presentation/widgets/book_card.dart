import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/feature/home/data/model/best_seller_response/product.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
    this.onRemoveFromWishlist,
    this.onRefresh,
  });

  final Product book;

  final VoidCallback? onRemoveFromWishlist;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushTo(context, Routes.details, extra: book).then((value) {
          onRefresh?.call();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: book.id ?? '',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    book.image ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Text('Error'));
                    },
                  ),
                ),
              ),
            ),
            Gap(10),
            SizedBox(
              height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    book.name ?? '',
                    style: TextStyles.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(book.price ?? '', style: TextStyles.body),
                onRemoveFromWishlist != null
                    ? IconButton(
                        onPressed: onRemoveFromWishlist,
                        icon: Icon(Icons.delete, color: AppColors.errorColor),
                      )
                    : MainButton(
                        minHeight: 35,
                        minWidth: 60,
                        bgColor: AppColors.darkColor,

                        text: 'Buy',
                        onPressed: () {},
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
