class GetAllMedicinesModel {
  GetAllMedicinesModel({
    this.success,
    this.data,
    this.statusCode,
    this.message,
  });

  GetAllMedicinesModel.fromJson(Map<String, dynamic> json) {
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
  Data({this.cropMedicines, this.totalCounts, this.limit, this.page});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["cropMedicines"] != null) {
      cropMedicines = <CropMedicines>[];
      for (final dynamic v in json["cropMedicines"] as List<dynamic>) {
        cropMedicines!.add(CropMedicines.fromJson(v));
      }
    }
    totalCounts = json["totalCounts"];
    limit = json["limit"];
    page = json["page"];
  }
  List<CropMedicines>? cropMedicines;
  int? totalCounts;
  int? limit;
  int? page;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cropMedicines != null) {
      data["cropMedicines"] =
          cropMedicines!.map((CropMedicines v) => v.toJson()).toList();
    }
    data["totalCounts"] = totalCounts;
    data["limit"] = limit;
    data["page"] = page;
    return data;
  }
}

class CropMedicines {
  CropMedicines({
    this.sId,
    this.name,
    this.description,
    this.price,
    this.unit,
    this.crop,
    this.brand,
    this.status,
    this.photo,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  CropMedicines.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    name = json["name"];
    description = json["description"];
    price = json["price"];
    unit = json["unit"];
    crop = json["crop"];
    brand = json["brand"];
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
  int? price;
  String? unit;
  String? crop;
  String? brand;
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
    data["price"] = price;
    data["unit"] = unit;
    data["crop"] = crop;
    data["brand"] = brand;
    data["status"] = status;
    data["photo"] = photo;
    data["isDeleted"] = isDeleted;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = iV;
    return data;
  }
}
