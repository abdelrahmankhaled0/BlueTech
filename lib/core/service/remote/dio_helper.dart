import 'package:beauty_app/core/service/remote/app_end_points.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppEndPoints.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

 static Future<Response> get({
    required String endPoint,
    Options? options,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.get(
      endPoint,
      options: options,

      queryParameters: queryParameters,
    );
  }
}
