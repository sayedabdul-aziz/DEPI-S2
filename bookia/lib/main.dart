import 'package:bookia/app.dart';
import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioProvider.init();
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
