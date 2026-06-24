import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/feature/cart/presentation/widgets/cart_action/cubit/cart_action_cubit.dart';
import 'package:bookia/feature/cart/presentation/widgets/cart_action/cubit/cart_action_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartActionWidget extends StatelessWidget {
  const CartActionWidget({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartActionCubit(),
      child: BlocConsumer<CartActionCubit, CartActionState>(
        listener: (context, state) {
          if (state is CartActionLoading) {
            showLoadingDialog(context);
          } else if (state is CartActionSuccess) {
            pop(context);
            showToast(context, state.message, DialogType.success);
          } else if (state is CartActionError) {
            pop(context);
            showToast(context, state.message);
          }
        },
        builder: (context, state) {
          var cubit = context.read<CartActionCubit>();
          bool isInCart = cubit.isProductInCart(productId);
          return MainButton(
            minWidth: 200,
            text: isInCart ? 'Added To Cart' : 'Add To Cart',
            bgColor: isInCart ? AppColors.darkColor : AppColors.primaryColor,
            onPressed: () {
              if (!isInCart) {
                cubit.addToCart(productId);
              }
            },
          );
        },
      ),
    );
  }
}
