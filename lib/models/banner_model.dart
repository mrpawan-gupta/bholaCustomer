class BannerModel {
  BannerModel({this.success, this.data, this.statusCode, this.message});

  BannerModel.fromJson(Map<String, dynamic> json) {
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
  Data({this.banners, this.totalItems, this.limit, this.offset});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["banners"] != null) {
      banners = <Banners>[];
      for (final dynamic v in json["banners"] as List<dynamic>) {
        banners!.add(Banners.fromJson(v));
      }
    }
    totalItems = json["totalItems"];
    limit = json["limit"];
    offset = json["offset"];
  }
  List<Banners>? banners;
  int? totalItems;
  int? limit;
  int? offset;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (banners != null) {
      data["banners"] = banners!.map((Banners v) => v.toJson()).toList();
    }
    data["totalItems"] = totalItems;
    data["limit"] = limit;
    data["offset"] = offset;
    return data;
  }
}

class Banners {
  Banners({
    this.sId,
    this.image,
    this.text,
    this.url,
    this.data,
    this.type,
    this.iV,
  });
  Banners.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    image = json["image"];
    text = json["text"];
    url = json["url"];
    data = json["data"];
    type = json["type"];
    iV = json["__v"];
  }
  String? sId;
  String? image;
  String? text;
  String? url;
  String? data;
  String? type;
  int? iV;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["image"] = image;
    data["text"] = text;
    data["url"] = url;
    data["data"] = this.data;
    data["type"] = type;
    data["__v"] = iV;
    return data;
  }
}
