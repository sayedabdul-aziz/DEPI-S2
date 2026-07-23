import 'package:bookia/core/services/apis/apis.dart';
import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:bookia/core/services/apis/failures.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/auth/data/models/auth_params.dart';
import 'package:bookia/feature/auth/data/models/auth_response/auth_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class AuthDataSource {
  Future<Either<Failure, AuthResponse>> login(AuthParams params);
  Future<Either<Failure, AuthResponse>> register(AuthParams params);
}

class AuthRemoteDataSourceImpl implements AuthDataSource {
  @override
  Future<Either<Failure, AuthResponse>> login(AuthParams params) async {
    var response = await DioProvider.postApi(
      endpoint: Apis.login,
      data: params.toJson(),
    );

    return response.fold(
      (l) {
        return Left(l);
      },
      (r) {
        return Right(handleAuthResponse(r));
      },
    );
  }

  @override
  Future<Either<Failure, AuthResponse>> register(AuthParams params) async {
    var response = await DioProvider.postApi(
      endpoint: Apis.register,
      data: params.toJson(),
    );

    return response.fold(
      (l) {
        return Left(l);
      },
      (r) {
        return Right(handleAuthResponse(r));
      },
    );
  }

  static AuthResponse handleAuthResponse(Response<dynamic> response) {
    var data = AuthResponse.fromJson(response.data);
    SharedPref.setToken(data.token); // EP (Authorization)
    SharedPref.setUserInfo(data.user); // Widget (UserData)
    return data;
  }
}

// data["user"]["name"]
// data.user.name
