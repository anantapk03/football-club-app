
import 'package:dio/dio.dart';

class Network {
  static Dio dioClient() {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(seconds: 40),
    );
    final Dio dio = Dio(options);
    dio.interceptors.add(LogInterceptor(responseBody: true,requestBody: true, requestHeader: true));
    return dio;
  }

/// for retry usage soon
/// if (error.response?.statusCode == 401) {
///         int retry = error.requestOptions.extra['retryOption'] ?? 3;
///         retry = retry < 0 ? 3 : retry -1;
///         if (retry == 0) {
///           return handler.next(error);
///         } else {
///           await Future.delayed(Duration(milliseconds: 300));
///           final token = await storage.getToken();
///
///         }
///       }
}

class UnauthorizedException implements Exception {}