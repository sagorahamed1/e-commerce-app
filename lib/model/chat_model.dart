

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
  final dynamic offerId;
  final String? msg;
  final String? type;
  final bool? isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic>? attachments;

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
  };
}

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
