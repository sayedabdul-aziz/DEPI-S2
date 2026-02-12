import 'package:flutter/material.dart';
import 'package:greenmart/core/styles/colors.dart';
import 'package:greenmart/core/styles/text_styles.dart';
import 'package:greenmart/features/home/data/product_model.dart';

class PriceWithCounter extends StatelessWidget {
  const PriceWithCounter({
    super.key,
    required this.model,
  });

  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {},
          icon: Icon(Icons.remove),
        ),
        SizedBox(width: 10),
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '10',
              style: TextStyles.body.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        IconButton(
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {},
          icon: Icon(Icons.add, color: AppColors.primaryColor),
        ),
        Spacer(),
        Text(
          '\$${model.price}',
          style: TextStyles.subtitle.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
