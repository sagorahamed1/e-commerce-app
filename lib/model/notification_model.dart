

class NotificationModel {
  final int? id;
  final String? msg;
  final String? related;
  final String? action;
  final String? type;
  final int? targetId;
  final bool? isRead;
  final bool? isImportant;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NotificationModel({
    this.id,
    this.msg,
    this.related,
    this.action,
    this.type,
    this.targetId,
    this.isRead,
    this.isImportant,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["id"],
    msg: json["msg"],
    related: json["related"],
    action: json["action"],
    type: json["type"],
    targetId: json["target_id"],
    isRead: json["isRead"],
    isImportant: json["isImportant"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "msg": msg,
    "related": related,
    "action": action,
    "type": type,
    "target_id": targetId,
    "isRead": isRead,
    "isImportant": isImportant,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
