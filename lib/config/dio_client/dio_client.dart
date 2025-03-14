import 'dart:io';

import 'package:crm_mobile_app/core/utils/apis.dart';
import 'package:crm_mobile_app/core/utils/constants.dart';
import 'package:dio/dio.dart';

class DioClient {
  late Dio _dio;

  DioClient() {
    Map<String, String> headersMap = {};
    headersMap[HttpHeaders.contentTypeHeader] = 'application/json';
    headersMap[HttpHeaders.acceptHeader] = 'application/json';
    BaseOptions options = BaseOptions(
      baseUrl: ApiEndPoints.Base_Url,
      connectTimeout: const Duration(seconds: 90),
      responseType: ResponseType.json,
      headers: headersMap,
      validateStatus: (status) {
        return status != null; // Allow all status codes to be processed
      },
    );

    _dio = Dio(options);
    //dio.options.extra = {'withCredentials': true};
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Dio get dio => _dio;
}
