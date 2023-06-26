import 'package:exercicio/model/item_model.dart';

abstract class HomeRepository {
  Future<List<ItemModel>> getItensRepository(int page);
}
