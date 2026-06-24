import 'package:bookia/core/services/apis/apis.dart';
import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/checkout/data/models/governorates_response/governorates_response.dart';
import 'package:bookia/feature/checkout/data/models/place_order_params.dart';

class CheckoutRepo {
  static Future<bool> checkout() async {
    try {
      var response = await DioProvider.get(
        endpoint: Apis.checkout,
        headers: {"authorization": "Bearer ${SharedPref.getToken()}"},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> placeOrder(PlaceOrderParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.placeOrder,
        data: params.toJson(),
        headers: {"authorization": "Bearer ${SharedPref.getToken()}"},
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<GovernoratesResponse?> getGovernorates() async {
    try {
      var response = await DioProvider.get(endpoint: Apis.governorates);
      if (response.statusCode == 200) {
        return GovernoratesResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
