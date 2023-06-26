// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../model/item_model.dart';

abstract class HomeStates {}

class HomeInitState extends HomeStates {}

class HomeLoading extends HomeStates {}

class HomeLoaded extends HomeStates {
  final List<ItemModel> list;
  HomeLoaded(this.list);
}

class HomeError extends HomeStates {
  final String error;

  HomeError(this.error);
}
