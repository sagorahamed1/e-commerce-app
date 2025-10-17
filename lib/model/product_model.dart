

class ProductModel {
  final int? id;
  final String? userId;
  final String? productName;
  final String? status;
  final dynamic sellingPrice;
  final String? purchasingPrice;
  final String? category;
  final int? quantity;
  final String? description;
  final String? condition;
  final String? size;
  final String? brand;
  final dynamic height;
  final dynamic width;
  final dynamic length;
  final dynamic weight;
  final dynamic city;
  final dynamic addressLine1;
  final dynamic addressLine2;
  final dynamic isAddressResidential;
  final dynamic postalCode;
  final dynamic countryId;
  final dynamic countryCode;
  final dynamic country;
  final bool? isNegotiable;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Image>? images;
  final User? user;

  ProductModel({
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
    this.height,
    this.width,
    this.length,
    this.weight,
    this.city,
    this.addressLine1,
    this.addressLine2,
    this.isAddressResidential,
    this.postalCode,
    this.countryId,
    this.countryCode,
    this.country,
    this.isNegotiable,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.user,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
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
    height: json["height"],
    width: json["width"],
    length: json["length"],
    weight: json["weight"],
    city: json["city"],
    addressLine1: json["address_line_1"],
    addressLine2: json["address_line_2"],
    isAddressResidential: json["is_address_residential"],
    postalCode: json["postal_code"],
    countryId: json["country_id"],
    countryCode: json["country_code"],
    country: json["country"],
    isNegotiable: json["is_negotiable"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
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
    "height": height,
    "width": width,
    "length": length,
    "weight": weight,
    "city": city,
    "address_line_1": addressLine1,
    "address_line_2": addressLine2,
    "is_address_residential": isAddressResidential,
    "postal_code": postalCode,
    "country_id": countryId,
    "country_code": countryCode,
    "country": country,
    "is_negotiable": isNegotiable,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "user": user?.toJson(),
  };
}

class Image {
  final int? id;
  final int? productId;
  final String? image;
  final DateTime? timestampSecond;

  Image({
    this.id,
    this.productId,
    this.image,
    this.timestampSecond,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    productId: json["product_id"],
    image: json["image"],
    timestampSecond: json["TimestampSecond"] == null ? null : DateTime.parse(json["TimestampSecond"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "image": image,
    "TimestampSecond": timestampSecond?.toIso8601String(),
  };
}

class User {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? image;
  final String? address;
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
    this.address,
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
    address: json["address"],
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
    "address": address,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "isActive": isActive,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "deletedAt": deletedAt,
  };
}
