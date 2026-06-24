import 'dart:developer';

import 'package:bookia/core/services/apis/apis.dart';
import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/profile/data/model/edit_profile_params.dart';
import 'package:bookia/feature/profile/data/model/profile_response/profile_response.dart';

class ProfileRepo {
  static Future<ProfileResponse?> getProfile() async {
    try {
      var response = await DioProvider.get(
        endpoint: Apis.profile,
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );

      if (response.statusCode == 200) {
        var data = ProfileResponse.fromJson(response.data);
        SharedPref.setUserInfo(data.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<ProfileResponse?> updateProfile(
    EditProfileParams params,
  ) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.updateProfile,
        headers: {
          "Authorization": "Bearer ${SharedPref.getToken()}",
          'Content-Type': 'multipart/form-data',
        },
        data: await params.toFormData(),
      );

      if (response.statusCode == 200) {
        var data = ProfileResponse.fromJson(response.data);
        SharedPref.setUserInfo(data.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
