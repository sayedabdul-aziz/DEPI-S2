import 'package:bookia/feature/checkout/data/models/governorates_response/governorate.dart';

abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

// Get Governorates
class GetGovernoratesLoading extends CheckoutState {}

class GetGovernoratesLoaded extends CheckoutState {
  final List<Governorate> governorates;
  GetGovernoratesLoaded(this.governorates);
}

class GetGovernoratesError extends CheckoutState {}

// Place Order
class PlaceOrderLoading extends CheckoutState {}

class PlaceOrderSuccess extends CheckoutState {}

class PlaceOrderError extends CheckoutState {}

class GovernorateSelected extends CheckoutState {
  final Governorate governorate;
  GovernorateSelected(this.governorate);
}
