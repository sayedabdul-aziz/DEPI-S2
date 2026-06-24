import 'package:bookia/feature/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/feature/cart/data/repo/cart_repo.dart';
import 'package:bookia/feature/cart/presentation/cubit/cart_state.dart';
import 'package:bookia/feature/checkout/data/repo/checkout_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  List<CartItem> cartItems = [];
  double total = 0;

  Future<void> getCart({bool isLoading = true}) async {
    if (isLoading) {
      emit(GetCartLoading());
    }
    var response = await CartRepo.getCart();

    if (response != null) {
      cartItems = response.data?.cartItems ?? [];
      total = response.data?.total ?? 0;
      emit(GetCartLoaded());
    } else {
      emit(GetCartError());
    }
  }

  Future<void> removeFromCart(int cartItemId) async {
    // OFFLINE - FIRST
    // get product by ID ==> where
    // remove product from list - locally
    // emit state for refresh UI
    // call api
    // if api fail ==> add product back to list
    // emit state for refresh UI

    var product = cartItems
        .where((product) => product.itemId == cartItemId)
        .firstOrNull;

    if (product != null) {
      cartItems.remove(product);
      total -= product.itemTotal ?? 0;
      emit(GetCartLoaded());
    }
    var response = await CartRepo.removeFromCart(cartItemId);
    if (response != null) {
      emit(GetCartLoaded(message: response.message));
    } else {
      if (product != null) {
        cartItems.add(product);
        total += product.itemTotal ?? 0;
      }
      emit(GetCartError());
    }
  }

  Future<void> updateCart(int cartItemId, int quantity) async {
    // OFFLINE FIRST
    // get product by Cart Item ID
    // store old quantity and total
    // update quantity and total locally
    // emit state
    // call api
    // if fail ==> restore old quantity and total
    // emit state

    var product = cartItems
        .where((product) => product.itemId == cartItemId)
        .firstOrNull;

    var oldQuantity = product?.itemQuantity;
    var oldTotal = product?.itemTotal;

    var newTotal = ((product?.itemProductPriceAfterDiscount ?? 0) * quantity);

    if (product != null) {
      product.itemQuantity = quantity;
      product.itemTotal = newTotal;

      total = total - oldTotal! + newTotal;

      emit(GetCartLoaded());
    }
    var response = await CartRepo.updateCart(cartItemId, quantity: quantity);
    if (response != null) {
      emit(GetCartLoaded(message: response.message));
    } else {
      if (product != null) {
        product.itemQuantity = oldQuantity;
        product.itemTotal = oldTotal;
        total = total - newTotal + oldTotal!;
      }
      emit(GetCartError());
    }
  }

  Future<void> checkout() async {
    emit(CheckoutLoading());
    var response = await CheckoutRepo.checkout();
    if (response) {
      emit(CheckoutLoaded());
    } else {
      emit(GetCartError());
    }
  }
}
