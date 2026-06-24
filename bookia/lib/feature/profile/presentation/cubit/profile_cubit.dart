import 'dart:io';

import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/profile/data/model/edit_profile_params.dart';
import 'package:bookia/feature/profile/data/repo/profile_repo.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  File? imageFile;

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      emit(ImagePickedState());
    }
  }

  void initProfile() {
    var user = SharedPref.getUserInfo();
    nameController.text = user?.name ?? '';
    phoneController.text = user?.phone?.toString() ?? '';
    cityController.text = user?.city?.toString() ?? '';
    addressController.text = user?.address?.toString() ?? '';
  }

  Future<void> updateProfile() async {
    emit(UpdateProfileLoading());
    var params = EditProfileParams(
      name: nameController.text,
      address: addressController.text,
      city: cityController.text,
      phone: phoneController.text,
      image: imageFile,
    );
    var response = await ProfileRepo.updateProfile(params);

    if (response != null) {
      emit(
        UpdateProfileSuccess(
          message: response.message ?? "Profile Updated Successfully",
        ),
      );
    } else {
      emit(UpdateProfileError(message: "Something went wrong"));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    cityController.dispose();
    addressController.dispose();
    return super.close();
  }
}
