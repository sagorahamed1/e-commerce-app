// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  final Receiver? receiver;
  final Conversation? conversation;
  final List<Message>? messages;

  ChatModel({
    this.receiver,
    this.conversation,
    this.messages,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
    conversation: json["conversation"] == null ? null : Conversation.fromJson(json["conversation"]),
    messages: json["messages"] == null ? [] : List<Message>.from(json["messages"]!.map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "receiver": receiver?.toJson(),
    "conversation": conversation?.toJson(),
    "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
  };
}

class Conversation {
  final int? id;
  final String? name;
  final dynamic image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;

  Conversation({
    this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "product": product?.toJson(),
  };
}

class Product {
  final int? id;
  final String? productName;
  final String? purchasingPrice;
  final List<dynamic>? images;
  final User? user;

  Product({
    this.id,
    this.productName,
    this.purchasingPrice,
    this.images,
    this.user,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    productName: json["product_name"],
    purchasingPrice: json["purchasing_price"],
    images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "purchasing_price": purchasingPrice,
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
  final dynamic status;
  final dynamic rating;
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

class Message {
  final int? id;
  final String? senderId;
  final int? offerId;
  final String? msg;
  final String? type;
  final bool? isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic>? attachments;
  final Offer? offer;

  Message({
    this.id,
    this.senderId,
    this.offerId,
    this.msg,
    this.type,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.attachments,
    this.offer,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    senderId: json["sender_id"],
    offerId: json["offer_id"],
    msg: json["msg"],
    type: json["type"],
    isRead: json["isRead"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    attachments: json["attachments"] == null ? [] : List<dynamic>.from(json["attachments"]!.map((x) => x)),
    offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_id": senderId,
    "offer_id": offerId,
    "msg": msg,
    "type": type,
    "isRead": isRead,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x)),
    "offer": offer?.toJson(),
  };
}

class Offer {
  final int? id;
  final String? sellerId;
  final String? buyerId;
  final dynamic orderId;
  final int? productId;
  final dynamic? price;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Offer({
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

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
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

class Receiver {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final dynamic image;
  final bool? isActive;

  Receiver({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
    this.isActive,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
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
