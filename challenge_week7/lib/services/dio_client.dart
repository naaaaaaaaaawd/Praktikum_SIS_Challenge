import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode) {
            debugPrint('[HTTP REQUEST] ${options.method} ${options.uri}');
            if (options.data != null) {
              debugPrint('[BODY] ${options.data}');
            }
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            debugPrint(
              '[HTTP RESPONSE] ${response.statusCode} ${response.requestOptions.uri}',
            );
          }
          handler.next(response);
        },
        onError: (error, handler) {
          if (kDebugMode) {
            debugPrint(
              '[HTTP ERROR] ${error.response?.statusCode} '
              '${error.message} on ${error.requestOptions.uri}',
            );
          }
          handler.next(error);
        },
      ),
    );

    return dio;
  }
}
