import 'dart:io';

import 'package:crm_mobile_app/core/utils/constants.dart';
import 'package:dio/dio.dart';

class DioClient {
  late Dio _dio;

  DioClient() {
    Map<String, String> headersMap = {};
    headersMap[HttpHeaders.contentTypeHeader] = 'application/json';
    BaseOptions options = BaseOptions(
        baseUrl: Constants.baseUrlDev,
        connectTimeout: const Duration(seconds: 90),
        responseType: ResponseType.json,
        headers: headersMap);

    _dio = Dio(options);

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Dio get dio => _dio;
}
