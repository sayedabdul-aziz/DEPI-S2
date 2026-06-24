import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/core/widgets/shimmer/shimmer_list_view.dart';
import 'package:bookia/feature/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/feature/cart/presentation/cubit/cart_state.dart';
import 'package:bookia/feature/cart/presentation/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: MyBodyView(
        child: BlocConsumer<CartCubit, CartState>(
          buildWhen: (previous, current) =>
              current is GetCartLoading || current is GetCartLoaded,
          listener: (context, state) {
            if (state is GetCartError) {
              showToast(context, 'Something went wrong');
            } else if (state is CheckoutLoading) {
              showLoadingDialog(context);
            } else if (state is CheckoutLoaded) {
              pop(context);
              pushTo(
                context,
                Routes.placeOrder,
                extra: context.read<CartCubit>().total,
              );
            }
          },
          builder: (context, state) {
            var cubit = context.read<CartCubit>();

            if (state is! GetCartLoaded) {
              return ShimmerListView(itemCount: 3);
            }

            // GetCartLoaded
            if (cubit.cartItems.isEmpty) {
              return Center(child: Text('Cart is empty'));
            }
            return ListView.separated(
              itemCount: cubit.cartItems.length,
              separatorBuilder: (context, index) => const Gap(10),
              itemBuilder: (BuildContext context, int index) {
                var item = cubit.cartItems[index];
                return CartItemWidget(
                  item: item,
                  onDelete: () {
                    cubit.removeFromCart(item.itemId ?? 0);
                  },
                  onDecrement: () {
                    int quantity = item.itemQuantity ?? 0;
                    if (quantity > 1) {
                      cubit.updateCart(item.itemId ?? 0, quantity - 1);
                    } else {
                      cubit.removeFromCart(item.itemId ?? 0);
                    }
                  },
                  onIncrement: () {
                    int quantity = item.itemQuantity ?? 0;
                    int stock = item.itemProductStock ?? 0;

                    if (quantity < stock) {
                      cubit.updateCart(item.itemId ?? 0, quantity + 1);
                    } else {
                      showToast(context, 'Product is out of stock');
                    }
                  },
                );
              },
            );
          },
        ),
      ),

      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          var cubit = context.read<CartCubit>();
          if (cubit.cartItems.isEmpty) {
            return const SizedBox.shrink();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total:', style: TextStyles.subtitle1),
                    Text(
                      "\$${cubit.total.ceil()}",
                      style: TextStyles.subtitle1,
                    ),
                  ],
                ),
                const Gap(10),
                MainButton(
                  text: "Checkout",
                  onPressed: () {
                    cubit.checkout();
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
