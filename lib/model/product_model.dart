

class ProductModel {
  final int? id;
  final String? userId;
  final String? productName;
  final String? status;
  final double? sellingPrice;
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
  final String? weight;
  final String? length;
  final dynamic servicePointId;
  final String? width;
  final String? height;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Image>? images;
  final User? user;
  final CollectionAddress? collectionAddress;
  final double? buyerProtection;
  final String? currency;

  ProductModel({
    this.id,
    this.userId,
    this.productName,
    this.status,
    this.sellingPrice,
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
    this.weight,
    this.length,
    this.servicePointId,
    this.width,
    this.height,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.user,
    this.collectionAddress,
    this.buyerProtection,
    this.currency,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    userId: json["user_id"],
    productName: json["product_name"],
    status: json["status"],
    sellingPrice: json["selling_price"]?.toDouble(),
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
    weight: json["weight"],
    length: json["length"],
    servicePointId: json["service_point_id"],
    width: json["width"],
    height: json["height"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    collectionAddress: json["collectionAddress"] == null ? null : CollectionAddress.fromJson(json["collectionAddress"]),
    buyerProtection: json["buyer_protection"]?.toDouble(),
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_name": productName,
    "status": status,
    "selling_price": sellingPrice,
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
    "weight": weight,
    "length": length,
    "service_point_id": servicePointId,
    "width": width,
    "height": height,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "user": user?.toJson(),
    "collectionAddress": collectionAddress?.toJson(),
    "buyer_protection": buyerProtection,
    "currency": currency,
  };
}

class CollectionAddress {
  final int? id;
  final String? name;
  final String? companyName;
  final String? email;
  final String? telephone;
  final String? address;
  final String? houseNumber;
  final String? address2;
  final String? city;
  final String? country;
  final String? postalCode;

  CollectionAddress({
    this.id,
    this.name,
    this.companyName,
    this.email,
    this.telephone,
    this.address,
    this.houseNumber,
    this.address2,
    this.city,
    this.country,
    this.postalCode,
  });

  factory CollectionAddress.fromJson(Map<String, dynamic> json) => CollectionAddress(
    id: json["id"],
    name: json["name"],
    companyName: json["company_name"],
    email: json["email"],
    telephone: json["telephone"],
    address: json["address"],
    houseNumber: json["house_number"],
    address2: json["address_2"],
    city: json["city"],
    country: json["country"],
    postalCode: json["postal_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "company_name": companyName,
    "email": email,
    "telephone": telephone,
    "address": address,
    "house_number": houseNumber,
    "address_2": address2,
    "city": city,
    "country": country,
    "postal_code": postalCode,
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
  final dynamic image;
  final String? status;
  final int? rating;
  final String? address;
  final String? currency;
  final String? phone;
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
    this.address,
    this.currency,
    this.phone,
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
    address: json["address"],
    currency: json["currency"],
    phone: json["phone"],
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
    "address": address,
    "currency": currency,
    "phone": phone,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "isActive": isActive,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "deletedAt": deletedAt,
  };
}
