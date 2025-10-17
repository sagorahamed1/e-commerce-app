

class PurchesHistoryModel {
  final int? id;
  final String? sellerId;
  final String? buyerId;
  final int? offerId;
  final String? protectionFee;
  final String? total;
  final String? deliveryCharge;
  final dynamic deliveryId;
  String? status;
  final String? paymentStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;
  final AcceptedOffer? acceptedOffer;
  final dynamic delivery;
  final Buyer? buyer;
  final Buyer? seller;

  PurchesHistoryModel({
    this.id,
    this.sellerId,
    this.buyerId,
    this.offerId,
    this.protectionFee,
    this.total,
    this.deliveryCharge,
    this.deliveryId,
    this.status,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.acceptedOffer,
    this.delivery,
    this.buyer,
    this.seller,
  });

  factory PurchesHistoryModel.fromJson(Map<String, dynamic> json) => PurchesHistoryModel(
    id: json["id"],
    sellerId: json["seller_id"],
    buyerId: json["buyer_id"],
    offerId: json["offer_id"],
    protectionFee: json["protectionFee"],
    total: json["total"],
    deliveryCharge: json["deliveryCharge"],
    deliveryId: json["delivery_id"],
    status: json["status"],
    paymentStatus: json["paymentStatus"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    acceptedOffer: json["accepted_offer"] == null ? null : AcceptedOffer.fromJson(json["accepted_offer"]),
    delivery: json["delivery"],
    buyer: json["buyer"] == null ? null : Buyer.fromJson(json["buyer"]),
    seller: json["seller"] == null ? null : Buyer.fromJson(json["seller"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seller_id": sellerId,
    "buyer_id": buyerId,
    "offer_id": offerId,
    "protectionFee": protectionFee,
    "total": total,
    "deliveryCharge": deliveryCharge,
    "delivery_id": deliveryId,
    "status": status,
    "paymentStatus": paymentStatus,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "product": product?.toJson(),
    "accepted_offer": acceptedOffer?.toJson(),
    "delivery": delivery,
    "buyer": buyer?.toJson(),
    "seller": seller?.toJson(),
  };
}

class AcceptedOffer {
  final int? id;
  final String? sellerId;
  final String? buyerId;
  final dynamic orderId;
  final int? productId;
  final String? price;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AcceptedOffer({
    this.id,
    this.sellerId,
    this.buyerId,
    this.orderId,
    this.productId,
    this.price,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory AcceptedOffer.fromJson(Map<String, dynamic> json) => AcceptedOffer(
    id: json["id"],
    sellerId: json["seller_id"],
    buyerId: json["buyer_id"],
    orderId: json["order_id"],
    productId: json["product_id"],
    price: json["price"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seller_id": sellerId,
    "buyer_id": buyerId,
    "order_id": orderId,
    "product_id": productId,
    "price": price,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Buyer {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? image;
  final String? status;
  final int? rating;
  final String? address;
  final String? phone;
  final List<String>? roles;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  Buyer({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
    this.status,
    this.rating,
    this.address,
    this.phone,
    this.roles,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Buyer.fromJson(Map<String, dynamic> json) => Buyer(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    image: json["image"],
    status: json["status"],
    rating: json["rating"],
    address: json["address"],
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
    "phone": phone,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "isActive": isActive,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "deletedAt": deletedAt,
  };
}

class Product {
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
  final bool? isNegotiable;
  final bool? isBoosted;
  final DateTime? boostStartTime;
  final dynamic boostEndTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Image>? images;
  final Buyer? user;

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
    boostStartTime: json["boost_start_time"] == null ? null : DateTime.parse(json["boost_start_time"]),
    boostEndTime: json["boost_end_time"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    user: json["user"] == null ? null : Buyer.fromJson(json["user"]),
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
    "boost_start_time": boostStartTime?.toIso8601String(),
    "boost_end_time": boostEndTime,
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



extension PurchesHistoryModelCopy on PurchesHistoryModel {
  PurchesHistoryModel copyWith({
    String? status,
    String? paymentStatus,
  }) {
    return PurchesHistoryModel(
      id: id,
      sellerId: sellerId,
      buyerId: buyerId,
      offerId: offerId,
      protectionFee: protectionFee,
      total: total,
      deliveryCharge: deliveryCharge,
      deliveryId: deliveryId,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      createdAt: createdAt,
      updatedAt: updatedAt,
      product: product,
      acceptedOffer: acceptedOffer,
      delivery: delivery,
      buyer: buyer,
      seller: seller,
    );
  }
}
