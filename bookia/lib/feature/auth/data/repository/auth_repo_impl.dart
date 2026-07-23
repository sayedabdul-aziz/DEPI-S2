import 'package:bookia/core/services/apis/failures.dart';
import 'package:bookia/feature/auth/data/data_source/auth_remote_data_source.dart';
import 'package:bookia/feature/auth/data/models/auth_params.dart';
import 'package:bookia/feature/auth/data/models/auth_response/auth_response.dart';
import 'package:bookia/feature/auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDataSource authRemoteDataSource;

  AuthRepoImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, AuthResponse>> login(AuthParams params) {
    return authRemoteDataSource.login(params);
  }

  @override
  Future<Either<Failure, AuthResponse>> register(AuthParams params) {
    return authRemoteDataSource.register(params);
  }
}
