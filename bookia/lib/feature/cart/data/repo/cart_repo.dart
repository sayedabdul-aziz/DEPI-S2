import 'dart:developer';

import 'package:bookia/core/services/apis/apis.dart';
import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/feature/cart/data/models/cart_response/cart_response.dart';

class CartRepo {
  static Future<CartResponse?> getCart() async {
    try {
      var response = await DioProvider.get(
        endpoint: Apis.cart,
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );
      if (response.statusCode == 200) {
        var data = CartResponse.fromJson(response.data);
        cacheCartProducts(data.data?.cartItems ?? []);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> addToCart(int productId) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.addToCart,
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
        data: {"product_id": productId},
      );
      if (response.statusCode == 201) {
        var data = CartResponse.fromJson(response.data);
        cacheCartProducts(data.data?.cartItems ?? []);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> removeFromCart(int cartItemId) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.removeFromCart,
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
        data: {"cart_item_id": cartItemId},
      );
      if (response.statusCode == 200) {
        var data = CartResponse.fromJson(response.data);
        cacheCartProducts(data.data?.cartItems ?? []);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());

      return null;
    }
  }

  static Future<CartResponse?> updateCart(
    int cartItemId, {
    required int quantity,
  }) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.updateCart,
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
        data: {"cart_item_id": cartItemId, "quantity": quantity},
      );
      if (response.statusCode == 201) {
        var data = CartResponse.fromJson(response.data);
        cacheCartProducts(data.data?.cartItems ?? []);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static void cacheCartProducts(List<CartItem> products) {
    List<int> ids = [];
    for (var product in products) {
      if (product.itemProductId != null) {
        ids.add(product.itemProductId!);
      }
    }
    SharedPref.setCart(ids);
  }
}

// Handle Add/Remove to/from Wishlist

// Caching wishlist products in SharedPreferences => List<int>

// when open details screen => check if productId exists in wishlist cached list

// if filled => remove from wishlist => show snackbar => remove from cache
// if empty => add to wishlist => show snackbar => add to cache
//
