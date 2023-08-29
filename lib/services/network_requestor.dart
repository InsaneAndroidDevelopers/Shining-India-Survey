import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shining_india_survey/utils/exceptions.dart';

class NetworkRequester {
  late final Dio _dio;

  NetworkRequester() {
    prepareRequest();
  }

  void prepareRequest() {
    BaseOptions dioOptions = BaseOptions(
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
      baseUrl: "",
      contentType: Headers.formUrlEncodedContentType,
      responseType: ResponseType.json,
      headers: {'Accept': Headers.jsonContentType},
    );

    _dio = Dio(dioOptions);

    _dio.interceptors.clear();

    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options,
            RequestInterceptorHandler requestInterceptorHandler) =>
            requestInterceptor(options, requestInterceptorHandler)));

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
    // options.queryParameters.addAll(RequestModelApiKey().toJson());
    requestInterceptorHandler.next(options);
  }

  _printLog(Object object) => log(object.toString());

  Future<Response> get({
    required String path,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: query);
      return returnResponse(response);
    } on DioError catch (error) {
      throwSocketException(error);
      rethrow;
    }
  }

  Future<Response> post({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(
        path,
        queryParameters: query,
        data: data,
      );
      return returnResponse(response);
    } on DioError catch (error) {
      throwSocketException(error);
      rethrow;
    }
  }

  Future<Response> put({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.put(path, queryParameters: query, data: data);
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
  }) async {
    try {
      final response = await _dio.patch(path, queryParameters: query, data: data);
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
  }) async {
    try {
      final response = await _dio.delete(path, queryParameters: query, data: data);
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
      case 400:
        throw BadRequestExceptionDio();
      case 403:
        throw UnauthorisedExceptionDio();
      case 500:
        throw InternalServerErrorDio();
      default:
        throw UnexpectedExceptionDio();
    }
  }
}