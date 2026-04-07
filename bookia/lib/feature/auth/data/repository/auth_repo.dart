import 'dart:developer';

import 'package:bookia/core/services/apis/apis.dart';
import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/auth/data/models/auth_params.dart';
import 'package:bookia/feature/auth/data/models/auth_response/auth_response.dart';
import 'package:dio/src/response.dart';

class AuthRepo {
  static Future<AuthResponse?> login(AuthParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.login,
        data: params.toJson(),
      );

      if (response.statusCode == 200) {
        // convert json to model
        return handleAuthResponse(response);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<AuthResponse?> register(AuthParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.register,
        data: params.toJson(),
      );
      if (response.statusCode == 201) {
        return handleAuthResponse(response);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static AuthResponse handleAuthResponse(Response<dynamic> response) {
    var data = AuthResponse.fromJson(response.data);
    SharedPref.setToken(data.data?.token); // EP (Authorization)
    SharedPref.setUserInfo(data.data?.user); // Widget (UserData)
    return data;
  }
}

// data["user"]["name"]
// data.user.name
