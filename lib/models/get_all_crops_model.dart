class GetAllCropsModel {
  GetAllCropsModel({this.success, this.data, this.statusCode, this.message});

  GetAllCropsModel.fromJson(Map<String, dynamic> json) {
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
  Data({this.crops, this.totalCounts, this.limit, this.page});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["crops"] != null) {
      crops = <Crops>[];
      for (final dynamic v in json["crops"] as List<dynamic>) {
        crops!.add(Crops.fromJson(v));
      }
    }
    totalCounts = json["totalCounts"];
    limit = json["limit"];
    page = json["page"];
  }
  List<Crops>? crops;
  int? totalCounts;
  int? limit;
  int? page;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (crops != null) {
      data["crops"] = crops!.map((Crops v) => v.toJson()).toList();
    }
    data["totalCounts"] = totalCounts;
    data["limit"] = limit;
    data["page"] = page;
    return data;
  }
}

class Crops {
  Crops({
    this.sId,
    this.name,
    this.description,
    this.category,
    this.status,
    this.photo,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Crops.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    name = json["name"];
    description = json["description"];
    category =
        json["category"] != null ? Category.fromJson(json["category"]) : null;
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
  Category? category;
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
    if (category != null) {
      data["category"] = category!.toJson();
    }
    data["status"] = status;
    data["photo"] = photo;
    data["isDeleted"] = isDeleted;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = iV;
    return data;
  }
}

class Category {
  Category({this.sId, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    name = json["name"];
  }
  String? sId;
  String? name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["name"] = name;
    return data;
  }
}
