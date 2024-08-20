class CreateBooking {
  CreateBooking({this.success, this.data, this.statusCode, this.message});

  CreateBooking.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data =
        json["data"] != null ? CreateBookingData.fromJson(json["data"]) : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }

  bool? success;
  CreateBookingData? data;
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

class CreateBookingData {
  CreateBookingData({this.sId, this.vendorsAvailable});

  CreateBookingData.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    vendorsAvailable = json["vendorsAvailable"];
  }

  String? sId;
  bool? vendorsAvailable;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["vendorsAvailable"] = vendorsAvailable;
    return data;
  }
}
