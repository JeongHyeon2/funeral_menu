class ImageModel {
  final String key;
  final String imageLink;
  final String name;
  ImageModel({
    required this.key,
    required this.imageLink,
    required this.name,
  });
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      key: json["key"],
      imageLink: json["imageLink"],
      name: json["name"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "key": key,
      "imageLink": imageLink,
      "name": name,
    };
  }
}
