import 'package:exercicio/model/item_model.dart';
import 'package:exercicio/pages/home_states.dart';
import 'package:exercicio/repository/home_repository.dart';
import 'package:flutter/material.dart';

class HomeStore extends ChangeNotifier {
  HomeRepository repository;
  HomeStore(this.repository);

  HomeStates _state = HomeInitState();
  HomeStates get state => _state;

  int page = 1;

  List<ItemModel> itemList = [];

  _emit(HomeStates state) {
    _state = state;
    notifyListeners();
  }

  Future<void> getItems(int page) async {
    try {
      _emit(HomeLoading());
      print(_state.runtimeType);
      if (page != 1) {
        itemList.addAll(await repository.getItensRepository(page));
        _emit(HomeLoaded(itemList));
        print(_state.runtimeType);
      } else {
        itemList.clear();
        itemList = await repository.getItensRepository(page);
        _emit(HomeLoaded(itemList));
        print(_state.runtimeType);
      }
    } catch (e) {
      _emit(HomeError('Erro de requisição'));
      print(_state.runtimeType);
    }
  }
}
