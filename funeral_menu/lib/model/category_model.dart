class CategoryModel {
  final String key;
  final String category;
  CategoryModel({
    required this.key,
    required this.category,
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      key: json["key"],
      category: json["category"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "key": key,
      "category": category,
    };
  }
}
