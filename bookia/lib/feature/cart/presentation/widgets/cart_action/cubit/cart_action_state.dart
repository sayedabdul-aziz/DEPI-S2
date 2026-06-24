abstract class CartActionState {}

class CartActionInitial extends CartActionState {}

class CartActionLoading extends CartActionState {}

class CartActionSuccess extends CartActionState {
  final String message;
  CartActionSuccess({required this.message});
}

class CartActionError extends CartActionState {
  final String message;
  CartActionError({required this.message});
}
