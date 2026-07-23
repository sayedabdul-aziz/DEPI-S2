import 'package:bookia/core/di/service_locator.dart';
import 'package:bookia/feature/auth/data/models/auth_params.dart';
import 'package:bookia/feature/auth/domain/usecases/login_usecase.dart';
import 'package:bookia/feature/auth/domain/usecases/register_usecase.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  final LoginUseCase loginUseCase = getIt<LoginUseCase>();

  final RegisterUseCase registerUseCase = getIt<RegisterUseCase>();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  Future<void> login() async {
    emit(AuthLoadingState());
    var params = AuthParams(
      password: passwordController.text,
      email: emailController.text,
    );
    var data = await loginUseCase.call(params);
    data.fold(
      (l) {
        emit(AuthErrorState(l.message ?? ''));
      },
      (r) {
        emit(AuthSuccessState());
      },
    );
  }

  Future<void> register() async {
    emit(AuthLoadingState());
    var params = AuthParams(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      passwordConfirmation: passwordConfirmationController.text,
    );
    var data = await registerUseCase.call(params);
    data.fold(
      (l) {
        emit(AuthErrorState(l.message ?? ''));
      },
      (r) {
        emit(AuthSuccessState());
      },
    );
  }
}
