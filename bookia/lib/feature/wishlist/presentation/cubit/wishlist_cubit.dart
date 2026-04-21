import 'package:bookia/feature/home/data/model/best_seller_response/product.dart';
import 'package:bookia/feature/wishlist/data/repo/wishlist_repo.dart';
import 'package:bookia/feature/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  List<Product> wishlistProducts = [];

  Future<void> getWishlist() async {
    emit(GetWishlistLoading());
    var response = await WishlistRepo.getWishlist();

    if (response != null) {
      wishlistProducts = response.data?.data ?? [];
      emit(GetWishlistLoaded());
    } else {
      emit(GetWishlistError());
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    // OFFLINE - FIRST
    // get product by ID ==> where
    // remove product from list - locally
    // emit state for refresh UI
    // call api
    // if api fail ==> add product back to list
    // emit state for refresh UI

    Product? product = wishlistProducts
        .where((product) => product.id == productId)
        .firstOrNull;

    if (product != null) {
      wishlistProducts.remove(product);
      emit(GetWishlistLoaded());
    }
    var response = await WishlistRepo.removeFromWishlist(productId);
    if (response != null) {
      emit(GetWishlistLoaded(message: response.message));
    } else {
      if (product != null) {
        wishlistProducts.add(product);
      }
      emit(GetWishlistError());
    }
  }
}
