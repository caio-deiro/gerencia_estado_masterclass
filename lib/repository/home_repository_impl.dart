import 'package:exercicio/datasource/datasource.dart';
import 'package:exercicio/repository/home_repository.dart';

import '../model/item_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  Datasource datasource;

  HomeRepositoryImpl(this.datasource);
  @override
  Future<List<ItemModel>> getItensRepository(int page) async {
    try {
      return await datasource.getItens(page);
    } catch (e) {
      throw Exception(e);
    }
  }
}
