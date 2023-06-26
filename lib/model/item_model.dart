class ItemModel {
  final String slug;

  ItemModel({required this.slug});

  factory ItemModel.fromJson(Map<dynamic, dynamic> map) {
    return ItemModel(slug: map['slug']);
  }
}
