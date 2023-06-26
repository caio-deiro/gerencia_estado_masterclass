import 'package:dio/io.dart';

class DioService extends DioForNative {
  final DioService _dio;

  DioService(this._dio) {
    _dio.options.baseUrl = 'https://www.intoxianime.com/?rest_route=/wp/v2';
  }
}
