import 'dart:io';

import 'package:base_flutter/src/core/data/constants.dart';
import 'package:base_flutter/src/core/networks/logging_interceptor.dart';
import 'package:base_flutter/src/utils/app_helper.dart';
import 'package:dio/io.dart';
import 'package:flutter/services.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:dio/dio.dart';

class NetworkHelper {
  NetworkHelper({String? url}) {
    _options = BaseOptions(
      baseUrl: url ?? Constants.baseUrl,
      connectTimeout: Duration(seconds: Constants.REQUEST_TIME_OUT),
      receiveTimeout: Duration(seconds: Constants.REQUEST_TIME_OUT),
      sendTimeout: Duration(seconds: Constants.REQUEST_TIME_OUT),
    );
    _dio = Dio(_options);
    setupSslPinning();
    if (isInDebugMode) {
      _dio.interceptors.add(LoggingInterceptor());
    }
  }

  late Dio _dio;
  late BaseOptions _options;

  DioAdapter mockAdapter() {
    final dioAdapter = DioAdapter(dio: _dio);
    _dio.httpClientAdapter = dioAdapter;
    return dioAdapter;
  }

  Future<void> setupSslPinning() async {
    final sslCert = await rootBundle.load('assets/certificate/certificate.pem');
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      SecurityContext securityContext =
          SecurityContext(withTrustedRoots: false);
      securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
      HttpClient httpClient = HttpClient(context: securityContext);
      return httpClient;
    };
  }

  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? query,
  }) async {
    dynamic response;
    try {
      response = await _dio.get<dynamic>(url, queryParameters: query);
    } catch (err) {
      rethrow;
    }
    return response;
  }

  // Send Http POST Request
  Future<Response> postMultipart({
    required String url,
    dynamic data,
    int? contentLength,
  }) async {
    dynamic response;
    try {
      response = _dio.post<dynamic>(
        url,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            'Accept': 'application/json',
            Headers.contentLengthHeader: contentLength,
          },
        ),
      );
    } catch (err) {
      rethrow;
    }
    return response;
  }
}
