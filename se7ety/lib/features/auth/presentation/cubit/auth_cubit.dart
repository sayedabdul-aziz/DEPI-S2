import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    emit(AuthLoadingState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthFailureState("البريد الالكتروني غير موجود"));
      } else if (e.code == 'wrong-password') {
        emit(AuthFailureState("كلمة السر غير صحيحة"));
      } else {
        emit(AuthFailureState("حدث خطأ ما"));
      }
    }
  }

  Future<void> register() async {
    emit(AuthLoadingState());

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

      var user = credential.user;
      user?.updateDisplayName(nameController.text);

      //3) store user model in firestore

      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthFailureState("كلمة السر ضعيفة"));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthFailureState("البريد الالكتروني مستخدم بالفعل"));
      } else {
        emit(AuthFailureState("حدث خطأ ما"));
      }
    } catch (e) {
      emit(AuthFailureState("حدث خطأ ما"));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    return super.close();
  }
}
