// ignore_for_file: file_names

import 'package:dio/dio.dart';

import '../model/item_model.dart';
import 'datasource.dart';

class ApiDatasource implements Datasource {
  final Dio dio;

  ApiDatasource(this.dio);
  @override
  Future<List<ItemModel>> getItens(int page) async {
    try {
      var query = {
        'page': page,
        'per_page': 10,
      };
      var response = await dio.get(
          'https://www.intoxianime.com/?rest_route=/wp/v2/posts',
          queryParameters: query);
      return (response.data as List).map((e) => ItemModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
