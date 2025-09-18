

class ChatUserModel {
  final int? id;
  final String? name;
  final dynamic image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Participant>? participants;
  final Product? product;
  final Lastmsg? lastmsg;

  ChatUserModel({
    this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.participants,
    this.product,
    this.lastmsg,
  });

  factory ChatUserModel.fromJson(Map<String, dynamic> json) => ChatUserModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    lastmsg: json["lastmsg"] == null ? null : Lastmsg.fromJson(json["lastmsg"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
    "product": product?.toJson(),
    "lastmsg": lastmsg?.toJson(),
  };
}

class Lastmsg {
  final int? id;
  final String? senderId;
  final dynamic offerId;
  final int? conversationId;
  final String? msg;
  final String? type;
  final bool? isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Lastmsg({
    this.id,
    this.senderId,
    this.offerId,
    this.conversationId,
    this.msg,
    this.type,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  factory Lastmsg.fromJson(Map<String, dynamic> json) => Lastmsg(
    id: json["id"],
    senderId: json["sender_id"],
    offerId: json["offer_id"],
    conversationId: json["conversation_id"],
    msg: json["msg"],
    type: json["type"],
    isRead: json["isRead"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_id": senderId,
    "offer_id": offerId,
    "conversation_id": conversationId,
    "msg": msg,
    "type": type,
    "isRead": isRead,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Participant {
  final int? id;
  final bool? isMuted;
  final DateTime? joinedAt;
  final User? user;

  Participant({
    this.id,
    this.isMuted,
    this.joinedAt,
    this.user,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
    id: json["id"],
    isMuted: json["isMuted"],
    joinedAt: json["joined_at"] == null ? null : DateTime.parse(json["joined_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "isMuted": isMuted,
    "joined_at": joinedAt?.toIso8601String(),
    "user": user?.toJson(),
  };
}

class User {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? image;
  final bool? isActive;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
    this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    image: json["image"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "image": image,
    "isActive": isActive,
  };
}

class Product {
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
  final DateTime? boostStartTime;
  final dynamic boostEndTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Image>? images;

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
