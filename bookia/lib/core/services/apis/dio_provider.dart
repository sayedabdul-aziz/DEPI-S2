import 'package:bookia/core/services/apis/base_response.dart';
import 'package:bookia/core/services/apis/failures.dart';
import 'package:bookia/flavor_env.dart';
import 'package:chili_debug_view/chili_debug_view.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class DioProvider {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: UrlProvider.config.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
      ),
    );
    dio.interceptors.addAll([
      NetworkLoggerInterceptor(),
      // LogInterceptor(responseBody: true, requestHeader: true),
    ]);
  }

  static Future<Either<Failure, dynamic>> postApi({
    required String endpoint,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      var response = await dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  static Future<Either<Failure, dynamic>> getApi({
    required String endpoint,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      var response = await dio.get(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return _handleResponse(response);
      } else {
        return Left(Failure(message: response.data['message']));
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  static Either<Failure, dynamic> _handleResponse(Response<dynamic> response) {
    var json = response.data as Map<String, dynamic>;
    if (json.containsKey("data")) {
      try {
        var data = BaseResponse.fromJson(response.data);
        return Right(data.data);
      } on Exception catch (e) {
        return Left(ParsingFailure(message: e.toString()));
      }
    } else {
      return Right(response.data);
    }
  }

  static Failure _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.badResponse:
        return Failure(message: e.response?.data['message']);
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.cancel:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return Failure(message: e.message);
      default:
        return Failure(message: e.message);
    }
  }

  static Future<Response> post({
    required String endpoint,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.post(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  static Future<Response> get({
    required String endpoint,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.get(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  static Future<Response> patch({
    required String endpoint,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.patch(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  static Future<Response> put({
    required String endpoint,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.put(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  static Future<Response> delete({
    required String endpoint,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.delete(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }
}
