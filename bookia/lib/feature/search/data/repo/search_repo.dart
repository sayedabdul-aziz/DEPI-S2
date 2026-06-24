import 'dart:developer';

import 'package:bookia/core/services/apis/apis.dart';
import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/search/data/model/search_response/search_response.dart';

class SearchRepo {
  static Future<SearchResponse?> searchProducts(
    String name, {
    int page = 1,
  }) async {
    try {
      var response = await DioProvider.get(
        endpoint: Apis.productsSearch,
        queryParameters: {'name': name, 'page': page},
        headers: {'Authorization': 'Bearer ${SharedPref.getToken()}'},
      );
      if (response.statusCode == 200) {
        return SearchResponse.fromJson(response.data);
      }
      return null;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
