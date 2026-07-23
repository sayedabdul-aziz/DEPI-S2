import 'package:bookia/core/services/apis/failures.dart';
import 'package:bookia/feature/auth/data/models/auth_params.dart';
import 'package:bookia/feature/auth/data/models/auth_response/auth_response.dart';
import 'package:bookia/feature/auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  final AuthRepo authRepo;

  LoginUseCase({required this.authRepo});

  Future<Either<Failure, AuthResponse>> call(AuthParams params) {
    // do heavy logic
    // do mapping
    // do merging of data
    return authRepo.login(params);
  }
}
