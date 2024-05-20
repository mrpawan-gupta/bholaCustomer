class GetAddresses {
  GetAddresses({this.success, this.data, this.statusCode, this.message});
  GetAddresses.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    if (json["data"] != null) {
      data = <GetAddressesData>[];
      for (final dynamic v in json["data"] as List<dynamic>) {
        data!.add(GetAddressesData.fromJson(v));
      }
    }
    statusCode = json["statusCode"];
    message = json["message"];
  }
  bool? success;
  List<GetAddressesData>? data;
  int? statusCode;
  String? message;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["success"] = success;
    if (this.data != null) {
      data["data"] =
          this.data!.map((GetAddressesData v) => v.toJson()).toList();
    }
    data["statusCode"] = statusCode;
    data["message"] = message;
    return data;
  }
}

class GetAddressesData {
  GetAddressesData({
    this.sId,
    this.pinCode,
    this.street,
    this.city,
    this.country,
    this.latitude,
    this.longitude,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  GetAddressesData.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    pinCode = json["pinCode"];
    street = json["street"];
    city = json["city"];
    country = json["country"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    user = json["user"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    iV = json["__v"];
  }
  String? sId;
  String? pinCode;
  String? street;
  String? city;
  String? country;
  double? latitude;
  double? longitude;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["pinCode"] = pinCode;
    data["street"] = street;
    data["city"] = city;
    data["country"] = country;
    data["latitude"] = latitude;
    data["longitude"] = longitude;
    data["user"] = user;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = iV;
    return data;
  }
}
