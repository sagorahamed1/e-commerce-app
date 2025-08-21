// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  final Receiver? receiver;
  final List<Message>? messages;

  ChatModel({
    this.receiver,
    this.messages,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
    messages: json["messages"] == null ? [] : List<Message>.from(json["messages"]!.map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "receiver": receiver?.toJson(),
    "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
  };
}

class Message {
  final int? id;
  final String? senderId;
  final int? offerId;
  final String? msg;
  final Type? type;
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
    type: typeValues.map[json["type"]]!,
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
    "type": typeValues.reverse[type],
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
  final String? price;
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

enum Type {
  OFFER,
  TEXT
}

final typeValues = EnumValues({
  "offer": Type.OFFER,
  "text": Type.TEXT
});

class Receiver {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? image;

  Receiver({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "image": image,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
