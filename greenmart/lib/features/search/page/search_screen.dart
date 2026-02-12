import 'package:flutter/material.dart';
import 'package:greenmart/core/widgets/custom_text_form_field.dart';
import 'package:greenmart/features/home/data/dummy_data.dart';
import 'package:greenmart/features/search/widgets/filtered_products_builder.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchKey = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Hero(
          tag: 'search',
          child: Material(
            color: Colors.transparent,
            child: CustomTextFormField(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search for products',
              onChanged: (value) {
                setState(() {
                  searchKey = value;
                });
              },
            ),
          ),
        ),
        actions: [SizedBox(width: 10)],
      ),
      body: FilteredProductsBuilder(products: getProductsByName(searchKey)),
    );
  }
}

// Debouncer
