class PhonePePayloadModel {
  PhonePePayloadModel({
    this.success,
    this.data,
    this.statusCode,
    this.message,
  });

  PhonePePayloadModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }

  bool? success;
  Data? data;
  int? statusCode;
  String? message;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["success"] = success;
    if (this.data != null) {
      data["data"] = this.data!.toJson();
    }
    data["statusCode"] = statusCode;
    data["message"] = message;
    return data;
  }
}

class Data {
  Data({
    this.checksum,
    this.body,
    this.paymentGateway,
  });

  Data.fromJson(Map<String, dynamic> json) {
    checksum = json["checksum"];
    body = json["body"];
    paymentGateway = json["paymentGateway"];
  }

  String? checksum;
  String? body;
  String? paymentGateway;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["checksum"] = checksum;
    data["body"] = body;
    data["paymentGateway"] = paymentGateway;
    return data;
  }
}
