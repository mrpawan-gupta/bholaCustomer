class AddressModel {
  AddressModel({this.success, this.data, this.statusCode, this.message});
  AddressModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    if (json["data"] != null) {
      data = <AddressModelData>[];
      for (final dynamic v in json["data"] as List<dynamic>) {
        data!.add(AddressModelData.fromJson(v));
      }
    }
    statusCode = json["statusCode"];
    message = json["message"];
  }

  bool? success;
  List<AddressModelData>? data;
  int? statusCode;
  String? message;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["success"] = success;
    if (this.data != null) {
      data["data"] =
          this.data!.map((AddressModelData v) => v.toJson()).toList();
    }
    data["statusCode"] = statusCode;
    data["message"] = message;
    return data;
  }
}

class AddressModelData {
  AddressModelData({
    this.sId,
    this.pinCode,
    this.street,
    this.city,
    this.country,
    this.latitude,
    this.longitude,
  });

  AddressModelData.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    pinCode = json["pinCode"];
    street = json["street"];
    city = json["city"];
    country = json["country"];
    latitude = json["latitude"];
    longitude = json["longitude"];
  }
  String? sId;
  String? pinCode;
  String? street;
  String? city;
  String? country;
  double? latitude;
  double? longitude;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["pinCode"] = pinCode;
    data["street"] = street;
    data["city"] = city;
    data["country"] = country;
    data["latitude"] = latitude;
    data["longitude"] = longitude;

    return data;
  }
}
