

class MyCardModel {
  final int? id;
  final String? userId;
  final String? productName;
  final String? status;
  final String? sellingPrice;
  final String? purchasingPrice;
  final String? category;
  final int? quantity;
  final String? description;
  final String? condition;
  final String? size;
  final String? brand;
  final bool? isNegotiable;
  final bool? isBoosted;
  final dynamic boostStartTime;
  final dynamic boostEndTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic>? images;
  final User? user;

  MyCardModel({
    this.id,
    this.userId,
    this.productName,
    this.status,
    this.sellingPrice,
    this.purchasingPrice,
    this.category,
    this.quantity,
    this.description,
    this.condition,
    this.size,
    this.brand,
    this.isNegotiable,
    this.isBoosted,
    this.boostStartTime,
    this.boostEndTime,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.user,
  });

  factory MyCardModel.fromJson(Map<String, dynamic> json) => MyCardModel(
    id: json["id"],
    userId: json["user_id"],
    productName: json["product_name"],
    status: json["status"],
    sellingPrice: json["selling_price"],
    purchasingPrice: json["purchasing_price"],
    category: json["category"],
    quantity: json["quantity"],
    description: json["description"],
    condition: json["condition"],
    size: json["size"],
    brand: json["brand"],
    isNegotiable: json["is_negotiable"],
    isBoosted: json["is_boosted"],
    boostStartTime: json["boost_start_time"],
    boostEndTime: json["boost_end_time"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_name": productName,
    "status": status,
    "selling_price": sellingPrice,
    "purchasing_price": purchasingPrice,
    "category": category,
    "quantity": quantity,
    "description": description,
    "condition": condition,
    "size": size,
    "brand": brand,
    "is_negotiable": isNegotiable,
    "is_boosted": isBoosted,
    "boost_start_time": boostStartTime,
    "boost_end_time": boostEndTime,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "user": user?.toJson(),
  };
}

class User {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final dynamic image;
  final String? status;
  final int? rating;
  final List<String>? roles;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
    this.status,
    this.rating,
    this.roles,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    image: json["image"],
    status: json["status"],
    rating: json["rating"],
    roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
    isActive: json["isActive"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    deletedAt: json["deletedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "image": image,
    "status": status,
    "rating": rating,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "isActive": isActive,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "deletedAt": deletedAt,
  };
}
