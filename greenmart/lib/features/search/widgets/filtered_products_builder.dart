import 'package:flutter/material.dart';
import 'package:greenmart/features/home/data/product_model.dart';
import 'package:greenmart/features/home/widgets/item_card.dart';

class FilteredProductsBuilder extends StatelessWidget {
  const FilteredProductsBuilder({super.key, required this.products});
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisExtent: 300,
      ),
      itemBuilder: (context, index) {
        return ItemCard(model: products[index]);
      },
      itemCount: products.length,
    );
  }
}
