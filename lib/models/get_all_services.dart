class GetAllServices {
  GetAllServices({this.success, this.data, this.statusCode, this.message});

  GetAllServices.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data =
        json["data"] != null ? GetAllServicesData.fromJson(json["data"]) : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }
  bool? success;
  GetAllServicesData? data;
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

class GetAllServicesData {
  GetAllServicesData({this.services, this.limit, this.page, this.totalcounts});

  GetAllServicesData.fromJson(Map<String, dynamic> json) {
    if (json["services"] != null) {
      services = <Services>[];
      for (final dynamic v in json["services"] as List<dynamic>) {
        services!.add(Services.fromJson(v));
      }
    }
    limit = json["limit"];
    page = json["page"];
    totalcounts = json["totalcounts"];
  }
  List<Services>? services;
  num? limit;
  num? page;
  num? totalcounts;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (services != null) {
      data["services"] = services!.map((Services v) => v.toJson()).toList();
    }
    data["limit"] = limit;
    data["page"] = page;
    data["totalcounts"] = totalcounts;
    return data;
  }
}

class Services {
  Services({this.sId, this.name, this.category, this.photo});

  Services.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    name = json["name"];
    category = json["category"];
    photo = json["photo"];
  }
  String? sId;
  String? name;
  String? category;
  String? photo;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["name"] = name;
    data["category"] = category;
    data["photo"] = photo;
    return data;
  }
}
