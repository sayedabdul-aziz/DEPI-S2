import 'package:bookia/feature/home/data/model/best_seller_response/best_seller_response.dart';
import 'package:bookia/feature/home/data/model/best_seller_response/product.dart';
import 'package:bookia/feature/home/data/model/sliders_reponse/slider.dart';
import 'package:bookia/feature/home/data/model/sliders_reponse/sliders_reponse.dart';
import 'package:bookia/feature/home/data/repo/home_repo.dart';
import 'package:bookia/feature/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<Product> products = [];
  List<Slider> sliders = [];

  Future<void> loadInitData() async {
    emit(HomeLoading());
    var results = await Future.wait([
      HomeRepo.getSliders(),
      HomeRepo.geBestSeller(),
    ]);

    var slidersResponse = results[0] as SlidersResponse?;
    var bestSellerResponse = results[1] as BestSellerResponse?;

    if (slidersResponse != null || bestSellerResponse != null) {
      products = bestSellerResponse?.data?.products ?? [];
      sliders = slidersResponse?.data?.sliders ?? [];
      emit(HomeLoaded());
    } else {
      emit(HomeError());
    }
  }
}
