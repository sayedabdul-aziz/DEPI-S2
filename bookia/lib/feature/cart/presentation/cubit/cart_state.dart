abstract class CartState {}

class CartInitial extends CartState {}

class GetCartLoading extends CartState {}

class GetCartLoaded extends CartState {
  final String? message;
  GetCartLoaded({this.message});
}

class CheckoutLoading extends CartState {}

class CheckoutLoaded extends CartState {}

class GetCartError extends CartState {}
