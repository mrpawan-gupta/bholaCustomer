class GetAllServices {
  GetAllServices({this.success, this.data, this.statusCode, this.message});
  GetAllServices.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    if (json["data"] != null) {
      data = <GetAllServicesData>[];
      for (final dynamic v in json["data"] as List<dynamic>) {
        data!.add(GetAllServicesData.fromJson(v));
      }
    }
    statusCode = json["statusCode"];
    message = json["message"];
  }
  bool? success;
  List<GetAllServicesData>? data;
  int? statusCode;
  String? message;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["success"] = success;
    if (this.data != null) {
      data["data"] =
          this.data!.map((GetAllServicesData v) => v.toJson()).toList();
    }
    data["statusCode"] = statusCode;
    data["message"] = message;
    return data;
  }
}

class GetAllServicesData {
  GetAllServicesData({this.sId, this.name, this.category, this.photo});

  GetAllServicesData.fromJson(Map<String, dynamic> json) {
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
