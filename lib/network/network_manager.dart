import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:todo_bootcamp/network/end_point.dart';

/// The NetworkManager class provide an API network requests
class NetworkManager {
  static final NetworkManager _apiService = NetworkManager._internal();

  Dio _dio = Dio();

  bool isContentTypeJson = true;
  bool _isHttpRequest = false;
  bool _urlEncode = false;
  String baseUrl = Endpoints.baseURL;
  String? appUrl;

  factory NetworkManager() {
    return _apiService;
  }

  NetworkManager._internal();

  Dio getDio({isJsonType = true, isHttpRequest = false, isUrlEncoded = false}) {
    isContentTypeJson = isJsonType;
    _urlEncode = isUrlEncoded;
    _isHttpRequest = isHttpRequest;
    _init();
    return _dio;
  }

  static NetworkManager get instance => _apiService;

  _init() async {
    _dio = Dio();
    _dio.options.baseUrl = baseUrl;
    _dio.options.contentType = Headers.jsonContentType;
    _dio.interceptors.add(LogInterceptor());
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      compact: false,
    ));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // if (AppManager.statusHelper.getLoginStatus) {
          //   String postToken = GetStorage().read(Constants.token);
          //   options.headers["Authorization"] = "Bearer $postToken";
          // }

          if (isContentTypeJson) {
            options.headers["Content-Type"] = "application/json";
          }

          if (_urlEncode) {
            options.headers["Content-Type"] =
                "application/x-www-form-urlencoded";
          }

          if (_isHttpRequest) {
            options.headers["X-Requested-With"] = "XMLHttpRequest";
          }
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          return handler.next(response); // continue
        },
        onError: (e, handler) {
          if (!kReleaseMode) {}
          return handler.next(e); //continue
        },
      ),
    );

    _dio.options.receiveTimeout = const Duration(milliseconds: 30000);
  }
}
