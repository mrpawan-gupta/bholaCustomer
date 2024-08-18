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
  FeaturedModelData({this.categories, this.limit, this.page, this.totalcounts});

  FeaturedModelData.fromJson(Map<String, dynamic> json) {
    if (json["categories"] != null) {
      categories = <Categories>[];
      for (final dynamic v in json["categories"] as List<dynamic>) {
        categories!.add(Categories.fromJson(v));
      }
    }
    limit = json["limit"];
    page = json["page"];
    totalcounts = json["totalcounts"];
  }
  List<Categories>? categories;
  int? limit;
  int? page;
  int? totalcounts;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categories != null) {
      data["categories"] =
          categories!.map((Categories v) => v.toJson()).toList();
    }
    data["limit"] = limit;
    data["page"] = page;
    data["totalcounts"] = totalcounts;
    return data;
  }
}

class Categories {
  Categories({
    this.sId,
    this.name,
    this.photo,
    this.status,
    this.approvedServiceCount,
    this.productCount,
    this.itemCode,
    this.displayType,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    name = json["name"];
    photo = json["photo"];
    status = json["status"];
    approvedServiceCount = json["approvedServiceCount"];
    productCount = json["productCount"];
    itemCode = json["itemCode"];
    displayType = json["displayType"];
  }
  String? sId;
  String? name;
  String? photo;
  String? status;
  num? approvedServiceCount;
  num? productCount;
  String? itemCode;
  String? displayType;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["name"] = name;
    data["photo"] = photo;
    data["status"] = status;
    data["approvedServiceCount"] = approvedServiceCount;
    data["productCount"] = productCount;
    data["itemCode"] = itemCode;
    data["displayType"] = displayType;
    return data;
  }
}
