import 'package:bookia/app.dart';
import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/utils/bloc_observer.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  DioProvider.init();
  await SharedPref.init();
  Bloc.observer = MyBlocObserver();
  runApp(
    DevicePreview(
      enabled: !kDebugMode,
      builder: (context) => EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: const MainApp(),
      ),
    ),
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

// Bookia
// - UI
// - State Management
// - Local Storage (Shared Preferences)
// - Apis (Dio)
// - structure of the app (core / features (data/ presentation))

// - localization
// 1) widgets layout (RTL / LTR)
// 2) translations (ar, en, fr, ur). ==> static / dynamic
// flutter_localizations + caching , easy_localization

// Response Body (nameAr, nameEn) , header {'lang': 'ar'}

// flutter pub run easy_localization:generate -S assets/translations -f keys -o locale_keys.g.dart

// - api error handling (dartz)
// - clean architecture (domain / data / presentation)
// - dependency Injection (GetIt)
