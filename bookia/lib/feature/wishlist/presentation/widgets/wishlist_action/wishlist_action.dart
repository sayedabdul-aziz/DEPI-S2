import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/feature/wishlist/presentation/widgets/wishlist_action/cubit/wishlist_action_cubit.dart';
import 'package:bookia/feature/wishlist/presentation/widgets/wishlist_action/cubit/wishlist_action_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistActionWidget extends StatelessWidget {
  const WishlistActionWidget({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistActionCubit(),
      child: BlocConsumer<WishlistActionCubit, WishlistActionState>(
        listener: (context, state) {
          if (state is WishlistActionLoading) {
            showLoadingDialog(context);
          } else if (state is WishlistActionSuccess) {
            pop(context);
            showToast(context, state.message, DialogType.success);
          } else if (state is WishlistActionError) {
            pop(context);
            showToast(context, state.message);
          }
        },
        builder: (context, state) {
          var cubit = context.read<WishlistActionCubit>();
          bool isWishlist = cubit.isProductInWishlist(id);
          return IconButton(
            onPressed: () {
              if (isWishlist) {
                cubit.removeFromWishList(id);
              } else {
                cubit.addToWishList(id);
              }
            },
            icon: CustomSvgPicture(
              path: AppImages.bookmarkSvg,
              color: isWishlist ? AppColors.primaryColor : null,
            ),
          );
        },
      ),
    );
  }
}
