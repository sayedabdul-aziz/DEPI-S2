import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/cart/data/repo/cart_repo.dart';
import 'package:bookia/feature/cart/presentation/widgets/cart_action/cubit/cart_action_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartActionCubit extends Cubit<CartActionState> {
  CartActionCubit() : super(CartActionInitial());

  Future<void> addToCart(int productId) async {
    emit(CartActionLoading());
    var data = await CartRepo.addToCart(productId);
    if (data != null) {
      emit(
        CartActionSuccess(
          message: data.message ?? "Successfully added to cart",
        ),
      );
    } else {
      emit(CartActionError(message: "Something went wrong"));
    }
  }

  bool isProductInCart(int productId) {
    var cartIds = SharedPref.getCart();
    return cartIds.contains(productId);
  }
}
