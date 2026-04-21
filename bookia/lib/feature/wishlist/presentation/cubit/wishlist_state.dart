abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class GetWishlistLoading extends WishlistState {}

class GetWishlistLoaded extends WishlistState {
  final String? message;
  GetWishlistLoaded({this.message});
}


class GetWishlistError extends WishlistState {}
