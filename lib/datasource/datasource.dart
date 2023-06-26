import '../model/item_model.dart';

abstract class Datasource {
  Future<List<ItemModel>> getItens(int page);
}
