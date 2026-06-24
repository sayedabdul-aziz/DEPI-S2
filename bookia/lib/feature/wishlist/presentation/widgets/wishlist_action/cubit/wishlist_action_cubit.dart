import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/wishlist/data/repo/wishlist_repo.dart';
import 'package:bookia/feature/wishlist/presentation/widgets/wishlist_action/cubit/wishlist_action_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistActionCubit extends Cubit<WishlistActionState> {
  WishlistActionCubit() : super(WishlistActionInitial());

  Future<void> addToWishList(int id) async {
    emit(WishlistActionLoading());
    var data = await WishlistRepo.addToWishlist(id);
    if (data != null) {
      emit(WishlistActionSuccess(message: data.message ?? ""));
    } else {
      emit(WishlistActionError(message: "حدث خطأ"));
    }
  }

  Future<void> removeFromWishList(int id) async {
    emit(WishlistActionLoading());
    var data = await WishlistRepo.removeFromWishlist(id);
    if (data != null) {
      emit(WishlistActionSuccess(message: data.message ?? ""));
    } else {
      emit(WishlistActionError(message: "حدث خطأ"));
    }
  }

  bool isProductInWishlist(int id) {
    var wishlistIds = SharedPref.getWishlist();
    return wishlistIds.contains(id);
  }
}
