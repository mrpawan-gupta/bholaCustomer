class GetAddresses {
  GetAddresses({this.success, this.data, this.statusCode, this.message});

  GetAddresses.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data =
        json["data"] != null ? GetAddressesData.fromJson(json["data"]) : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }
  bool? success;
  GetAddressesData? data;
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

class GetAddressesData {
  GetAddressesData({this.address, this.totalCount});

  GetAddressesData.fromJson(Map<String, dynamic> json) {
    if (json["address"] != null) {
      address = <Address>[];
      for (final dynamic v in json["address"] as List<dynamic>) {
        address!.add(Address.fromJson(v));
      }
    }
    totalCount = json["totalCount"];
  }
  List<Address>? address;
  int? totalCount;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (address != null) {
      data["address"] = address!.map((Address v) => v.toJson()).toList();
    }
    data["totalCount"] = totalCount;
    return data;
  }
}

class Address {
  Address({
    this.isPrimary,
    this.sId,
    this.pinCode,
    this.street,
    this.city,
    this.country,
    this.user,
    
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Address.fromJson(Map<String, dynamic> json) {
    isPrimary = json["isPrimary"];
    sId = json["_id"];
    pinCode = json["pinCode"];
    street = json["street"];
    city = json["city"];
    country = json["country"];
    user = json["user"];
   
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    iV = json["__v"];
  }
  bool? isPrimary;
  String? sId;
  String? pinCode;
  String? street;
  String? city;
  String? country;
  String? user;
   
  String? createdAt;
  String? updatedAt;
  int? iV;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["isPrimary"] = isPrimary;
    data["_id"] = sId;
    data["pinCode"] = pinCode;
    data["street"] = street;
    data["city"] = city;
    data["country"] = country;
    data["user"] = user;
    
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = iV;
    return data;
  }
}
