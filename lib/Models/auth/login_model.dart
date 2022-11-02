class LoginModel {
  LoginModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  Data? data;

  factory LoginModel.fromJson(Map<String, dynamic>? json) => LoginModel(
        status: json?["status"],
        code: json?["code"],
        msg: json?["msg"],
        data: json?["data"] == null ? null : Data.fromJson(json?["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.photo,
    this.deviceToken,
    this.pharmacyId,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.token,
  });

  int? id;
  String? name;
  String? email;
  String? phone;
  dynamic photo;
  String? deviceToken;
  int? pharmacyId;
  int? active;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? token;

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
        id: json?["id"],
        name: json?["name"],
        email: json?["email"],
        phone: json?["phone"],
        photo: json?["photo"],
        deviceToken: json?["device_token"],
        pharmacyId: json?["pharmacy_id"],
        active: json?["active"],
        createdAt: json?["created_at"] == null
            ? null
            : DateTime.parse(json?["created_at"]),
        updatedAt: json?["updated_at"] == null
            ? null
            : DateTime.parse(json?["updated_at"]),
        deletedAt: json?["deleted_at"],
        token: json?["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "photo": photo,
        "device_token": deviceToken,
        "pharmacy_id": pharmacyId,
        "active": active,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
        "token": token,
      };
}
