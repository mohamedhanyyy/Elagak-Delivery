class EndOrderModel {
  EndOrderModel({
    this.status,
    this.code,
    this.msg,
  });

  bool? status;
  int? code;
  String? msg;

  factory EndOrderModel.fromJson(Map<String, dynamic>? json) => EndOrderModel(
        status: json?["status"],
        code: json?["code"],
        msg: json?["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
      };
}
