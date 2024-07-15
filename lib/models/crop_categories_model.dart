class CropCategoriesModel {
  CropCategoriesModel({this.success, this.data, this.statusCode, this.message});

  CropCategoriesModel.fromJson(Map<String, dynamic> json) {
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
  Data({this.cropCategories, this.totalCounts, this.limit, this.page});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["cropCategories"] != null) {
      cropCategories = <CropCategories>[];
      for (final dynamic v in json["cropCategories"] as List<dynamic>) {
        cropCategories!.add(CropCategories.fromJson(v));
      }
    }
    totalCounts = json["totalCounts"];
    limit = json["limit"];
    page = json["page"];
  }

  List<CropCategories>? cropCategories;
  int? totalCounts;
  int? limit;
  int? page;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cropCategories != null) {
      data["cropCategories"] =
          cropCategories!.map((CropCategories v) => v.toJson()).toList();
    }
    data["totalCounts"] = totalCounts;
    data["limit"] = limit;
    data["page"] = page;
    return data;
  }
}

class CropCategories {
  CropCategories({
    this.sId,
    this.name,
    this.description,
    this.status,
    this.photo,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  CropCategories.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    name = json["name"];
    description = json["description"];
    status = json["status"];
    photo = json["photo"];
    isDeleted = json["isDeleted"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    iV = json["__v"];
  }
  
  String? sId;
  String? name;
  String? description;
  String? status;
  String? photo;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["name"] = name;
    data["description"] = description;
    data["status"] = status;
    data["photo"] = photo;
    data["isDeleted"] = isDeleted;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = iV;
    return data;
  }
}
