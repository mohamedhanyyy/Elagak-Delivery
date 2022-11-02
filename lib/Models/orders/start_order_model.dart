class StartOrderModel {
  StartOrderModel({
    this.status,
    this.code,
    this.msg,
  });

  bool? status;
  int? code;
  String? msg;

  factory StartOrderModel.fromJson(Map<String, dynamic>? json) =>
      StartOrderModel(
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
