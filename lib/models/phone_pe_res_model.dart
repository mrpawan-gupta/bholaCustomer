class PhonePeResModel {
  PhonePeResModel({
    this.success,
    this.data,
    this.statusCode,
    this.message,
  });

  PhonePeResModel.fromJson(Map<String, dynamic> json) {
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
    this.transaction,
  });

  Data.fromJson(Map<String, dynamic> json) {
    transaction = json["transaction"];
  }

  String? transaction;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["transaction"] = transaction;
    return data;
  }
}
