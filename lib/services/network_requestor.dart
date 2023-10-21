import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shining_india_survey/utils/exceptions.dart';

class NetworkService {
  late final Dio _dio;

  NetworkService() {
    prepareRequest();
  }

  void prepareRequest() {
    BaseOptions dioOptions = BaseOptions(
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
      baseUrl: "http://15.207.164.179",
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );

    _dio = Dio(dioOptions);

    _dio.interceptors.clear();

    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler requestInterceptorHandler) =>
            requestInterceptor(options, requestInterceptorHandler)
      )
    );

    _dio.interceptors.add(LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        logPrint: _printLog));
  }

  dynamic requestInterceptor(RequestOptions options,
      RequestInterceptorHandler requestInterceptorHandler) async {

    requestInterceptorHandler.next(options);
  }

  _printLog(Object object) => log(object.toString());

  Future<Response> get({
    required String path,
    Map<String, dynamic>? query,
    required String token
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: query,
        options: Options(
          headers: {'Accept': Headers.jsonContentType, 'Authorization': 'Bearer $token'},
        )
      );
      return returnResponse(response);
    } on DioException catch (error) {
      throwSocketException(error);
      rethrow;
    }
  }

  Future<Response> post({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token
  }) async {
    try {
      final response = await _dio.post(
        path,
        queryParameters: query,
        data: data,
        options: Options(
          headers: {'Accept': Headers.jsonContentType, 'Authorization': 'Bearer $token'},
        )
      );
      return returnResponse(response);
    } on DioException catch (error) {
      throwSocketException(error);
      rethrow;
    }
  }

  Future<Response> put({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    required String token
  }) async {
    try {
      final response = await _dio.put(
        path,
        queryParameters: query,
        data: data,
        options: Options(
          headers: {'Accept': Headers.jsonContentType, 'Authorization': 'Bearer $token'},
        )
      );
      return returnResponse(response);
    } on DioError catch (error) {
      throwSocketException(error);
      rethrow;
    }
  }

  Future<Response> patch({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    required String token
  }) async {
    try {
      final response = await _dio.patch(
        path,
        queryParameters: query,
        data: data,
        options: Options(
          headers: {'Accept': Headers.jsonContentType, 'Authorization': 'Bearer $token'},
        )
      );
      return returnResponse(response);
    } on DioError catch (error) {
      throwSocketException(error);
      rethrow;
    }
  }

  Future<Response> delete({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    required String token
  }) async {
    try {
      final response = await _dio.delete(
        path,
        queryParameters: query,
        data: data,
        options: Options(
          headers: {'Accept': Headers.jsonContentType, 'Authorization': 'Bearer $token'},
        )
      );
      return returnResponse(response);
    } on DioError catch (error) {
      throwSocketException(error);
      rethrow;
    }
  }

  void throwSocketException(DioError error){
    if (error.error is SocketException ||
        error.type == DioErrorType.connectionTimeout) {
      throw const SocketException('No Internet');
    }
  }

  Response returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 201:
        return response;
      case 400:
        throw BadRequestExceptionDio(response.data['error'] ?? 'Bad response');
      case 403:
        throw UnauthorisedExceptionDio(response.data['error'] ?? 'Unauthorised error');
      case 409:
        throw ConflictExceptionDio(response.data['error'] ?? 'Conflict error');
      case 500:
        throw InternalServerErrorDio(response.data['error'] ?? 'Internal server error');
      default:
        throw UnexpectedExceptionDio(response.data['error'] ?? 'Unexpected error');
    }
  }
}