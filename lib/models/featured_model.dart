class FeaturedModel {
  FeaturedModel({this.success, this.data, this.statusCode, this.message});

  FeaturedModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data =
    json["data"] != null ? FeaturedModelData.fromJson(json["data"]) : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }
  bool? success;
  FeaturedModelData? data;
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

class FeaturedModelData {
  FeaturedModelData({
    this.categories,
    this.totalItems,
    this.limit,
    this.offset,
  });

  FeaturedModelData.fromJson(Map<String, dynamic> json) {
    if (json["categories"] != null) {
      categories = <Categories>[];
      for (final dynamic v in json["categories"] as List<dynamic>) {
        categories!.add(Categories.fromJson(v));
      }
    }
    totalItems = json["totalItems"];
    limit = json["limit"];
    offset = json["offset"];
  }
  List<Categories>? categories;
  int? totalItems;
  int? limit;
  int? offset;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categories != null) {
      data["categories"] =
          categories!.map((Categories v) => v.toJson()).toList();
    }
    data["totalItems"] = totalItems;
    data["limit"] = limit;
    data["offset"] = offset;
    return data;
  }
}

class Categories {
  Categories({this.sId, this.name, this.photo});

  Categories.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    name = json["name"];
    photo = json["photo"];
  }
  String? sId;
  String? name;
  String? photo;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["name"] = name;
    data["photo"] = photo;
    return data;
  }
}
