

class CategoryModel {
  final int? id;
  final String? name;
  final String? image;

  CategoryModel({
    this.id,
    this.name,
    this.image
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image
  };
}
