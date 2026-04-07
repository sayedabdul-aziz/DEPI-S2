import 'package:bookia/app.dart';
import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioProvider.init();
  await SharedPref.init();
  runApp(
    DevicePreview(enabled: !kDebugMode, builder: (context) => const MainApp()),
  );
}

// data resources:
// 1) Apis (Backend Developer) (Remote)
// 2) Local Storage (Local)
// 3) Backend Services (Firebase, Supabase)
// 4) Assets (Json, Csv)
// 5) Static

// Apis
// Postman & Swagger
// BaseUrl
// Endpoints
// Methods (GET, POST, PATCH, DELETE, PUT)
// Requests (EP,Methods,[Body, Headers, Query Params])
// Responses (Status Code, Body)
// Authorization => token
// Response Body(Json) => Parsing to Dart Object => Logic

// Http, Dio => Http Client Api

// splash ==> check user is loggedIn (token is valid)
// TODO:
// 1) check token is Cached
// 2) if token is Cached => getProfile Api
// 3) if api has error => token is expired => WELCOME
// 4) if api has success => update user cached data => MAIN
