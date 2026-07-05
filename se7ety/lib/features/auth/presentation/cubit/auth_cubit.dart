import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/services/firebase/firestore_provider.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/auth/data/models/user_model.dart';
import 'package:se7ety/features/auth/data/models/user_type_enum.dart';

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
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      var user = credential.user;
      // id , email , name , userType(PhotoUrl)

      SharedPref.setUserData(
        UserModel(
          name: user?.displayName ?? "",
          email: user?.email ?? "",
          uid: user?.uid,
          userType: user?.photoURL ?? "",
        ),
      );

      var userType = UserTypeEnum.fromString(user?.photoURL ?? "");

      emit(AuthSuccessState(userType: userType));
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

  Future<void> register(UserTypeEnum userType) async {
    emit(AuthLoadingState());

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

      var user = credential.user;
      user?.updateDisplayName(nameController.text);
      // id, name, email, [role]

      // use photoUrl as role
      user?.updatePhotoURL(userType.value);

      //3) store user model in firestore
      if (userType == UserTypeEnum.doctor) {
        var doctorModel = DoctorModel(
          name: nameController.text,
          email: emailController.text,
          uid: user!.uid,
          rating: 3,
        );
        await FirestoreProvider.createDoctor(doctorModel);
      } else {
        var patientModel = PatientModel(
          name: nameController.text,
          email: emailController.text,
          uid: user!.uid,
        );
        await FirestoreProvider.createPatient(patientModel);
      }

      SharedPref.setUserData(
        UserModel(
          name: nameController.text,
          email: emailController.text,
          uid: user.uid,
          userType: userType.value,
        ),
      );

      emit(AuthSuccessState(userType: userType));
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

// role ()

// id => data
// id => filter by id => data
