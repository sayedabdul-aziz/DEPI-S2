import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/checkout/data/models/governorates_response/governorate.dart';
import 'package:bookia/feature/checkout/data/models/place_order_params.dart';
import 'package:bookia/feature/checkout/data/repo/checkout_repo.dart';
import 'package:bookia/feature/checkout/presentation/cubit/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController governorateController = TextEditingController();

  Governorate? selectedGovernorate;
  List<Governorate> governorates = [];

  Future<void> getGovernorates() async {
    emit(GetGovernoratesLoading());
    var response = await CheckoutRepo.getGovernorates();
    if (response != null) {
      governorates = response.data ?? [];
      emit(GetGovernoratesLoaded(governorates));
    } else {
      emit(GetGovernoratesError());
    }
  }

  void selectGovernorate(Governorate governorate) {
    selectedGovernorate = governorate;
    governorateController.text = governorate.governorateNameEn ?? '';
    emit(GovernorateSelected(governorate));
  }

  Future<void> placeOrder() async {
    emit(PlaceOrderLoading());
    var params = PlaceOrderParams(
      governorateId: selectedGovernorate!.id ?? 0,
      address: addressController.text,
      email: SharedPref.getUserInfo()?.email ?? '',
      phone: phoneController.text,
      name: nameController.text,
    );
    var response = await CheckoutRepo.placeOrder(params);
    if (response) {
      emit(PlaceOrderSuccess());
    } else {
      emit(PlaceOrderError());
    }
  }
}
