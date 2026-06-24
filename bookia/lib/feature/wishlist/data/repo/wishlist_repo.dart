import 'dart:developer';

import 'package:bookia/core/services/apis/apis.dart';
import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/home/data/model/best_seller_response/product.dart';
import 'package:bookia/feature/wishlist/data/models/wishlist_response/wishlist_response.dart';

class WishlistRepo {
  static Future<WishlistResponse?> getWishlist() async {
    try {
      var response = await DioProvider.get(
        endpoint: Apis.wishlist,
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );
      if (response.statusCode == 200) {
        var data = WishlistResponse.fromJson(response.data);
        cacheWishlistProducts(data.data?.data ?? []);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<WishlistResponse?> addToWishlist(int productId) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.addToWishlist,
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
        data: {"product_id": productId},
      );
      if (response.statusCode == 200) {
        var data = WishlistResponse.fromJson(response.data);
        cacheWishlistProducts(data.data?.data ?? []);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<WishlistResponse?> removeFromWishlist(int productId) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.removeFromWishlist,
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
        data: {"product_id": productId},
      );
      if (response.statusCode == 200) {
        var data = WishlistResponse.fromJson(response.data);
        cacheWishlistProducts(data.data?.data ?? []);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static void cacheWishlistProducts(List<Product> products) {
    //  List<int> ids = data.data?.data?.map((e) => e.id ?? 0).toList() ?? [];
    List<int> ids = [];
    for (var product in products) {
      if (product.id != null) {
        ids.add(product.id!);
      }
    }
    SharedPref.setWishlist(ids);
  }
}

// Handle Add/Remove to/from Wishlist

// Caching wishlist products in SharedPreferences => List<int>

// when open details screen => check if productId exists in wishlist cached list

// if filled => remove from wishlist => show snackbar => remove from cache
// if empty => add to wishlist => show snackbar => add to cache
//
