import 'package:flutter/material.dart';
import 'package:greenmart/core/widgets/custom_text_form_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Hero(
            tag: 'search',
            child: CustomTextFormField(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search for products',
            ),
          ),
        ],
      ),
    );
  }
}
