import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/profile/data/repo/profile_repo.dart';
import 'package:bookia/feature/splash/cubit/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitialState());

  Future<void> getInitData() async {
    if (SharedPref.getToken().isEmpty) {
      emit(SplashErrorState());
      return;
    }
    var data = await ProfileRepo.getProfile();
    if (data != null) {
      emit(SplashSuccessState());
    } else {
      emit(SplashErrorState());
    }
  }
}
