

class ChatUserModel {
  final int? id;
  final String? name;
  final dynamic image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Participant>? participants;
  final Lastmsg? lastmsg;

  ChatUserModel({
    this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.participants,
    this.lastmsg,
  });

  factory ChatUserModel.fromJson(Map<String, dynamic> json) => ChatUserModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
    lastmsg: json["lastmsg"] == null ? null : Lastmsg.fromJson(json["lastmsg"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
    "lastmsg": lastmsg?.toJson(),
  };
}

class Lastmsg {
  final int? id;
  final String? senderId;
  final dynamic offerId;
  final String? msg;
  final String? type;
  final bool? isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Lastmsg({
    this.id,
    this.senderId,
    this.offerId,
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
