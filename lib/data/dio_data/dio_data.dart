import 'package:dio/dio.dart';

import '../../utls/constant/end_point_constant.dart';

class DioHelper {
  static late Dio dio;

  static Future<void> init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPointConstant.baseUrl,
        queryParameters: {"api-key": EndPointConstant.apiKey},
        receiveDataWhenStatusError: false,
        followRedirects: true,
        receiveTimeout: const Duration(seconds: 60),
        // will not throw errors
        validateStatus: (status) => true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.get(
      url,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required FormData? data,
  }) async {
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map? data,
  }) async {
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    required FormData? data,
  }) async {
    return await dio.delete(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
