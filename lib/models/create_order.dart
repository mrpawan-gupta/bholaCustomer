class CreateOrder {
  CreateOrder({this.success, this.data, this.statusCode, this.message});

  CreateOrder.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data = json["data"] != null ? CreateOrderData.fromJson(json["data"]) : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }

  bool? success;
  CreateOrderData? data;
  num? statusCode;
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

class CreateOrderData {
  CreateOrderData({this.paymentReceived, this.sId});

  CreateOrderData.fromJson(Map<String, dynamic> json) {
    paymentReceived = json["paymentReceived"];
    sId = json["_id"];
  }

  bool? paymentReceived;
  String? sId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["paymentReceived"] = paymentReceived;
    data["_id"] = sId;
    return data;
  }
}
