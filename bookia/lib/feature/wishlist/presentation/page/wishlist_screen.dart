import 'dart:developer';

import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/core/widgets/shimmer/shimmer_grid_view.dart';
import 'package:bookia/feature/home/presentation/widgets/book_card.dart';
import 'package:bookia/feature/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/feature/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log(SharedPref.getToken());
    return Scaffold(
      appBar: AppBar(title: Text('Wishlist')),
      body: MyBodyView(
        child: BlocConsumer<WishlistCubit, WishlistState>(
          listener: (context, state) {
            if (state is GetWishlistLoaded &&
                state.message?.isNotEmpty == true) {
              showToast(context, state.message ?? "", DialogType.success);
            } else if (state is GetWishlistError) {
              showToast(context, 'Something went wrong');
            }
          },
          builder: (context, state) {
            var cubit = context.read<WishlistCubit>();

            if (state is! GetWishlistLoaded) {
              return ShimmerGridView(
                itemCount: 6,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 290,
              );
            }

            // GetWishlistLoaded
            if (cubit.wishlistProducts.isEmpty) {
              return Center(child: Text('Wishlist is empty'));
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 290,
              ),
              itemCount: cubit.wishlistProducts.length,
              itemBuilder: (BuildContext context, int index) {
                var book = cubit.wishlistProducts[index];
                return BookCard(
                  book: book,
                  onRemoveFromWishlist: () {
                    cubit.removeFromWishlist(book.id!);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
