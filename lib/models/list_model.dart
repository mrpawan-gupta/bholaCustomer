class ListModel {
  ListModel({this.success, this.data, this.statusCode, this.message});
  ListModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data = json["data"] != null ? ListModelData.fromJson(json["data"]) : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }
  bool? success;
  ListModelData? data;
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

class ListModelData {
  ListModelData({this.products, this.totalCount});

  ListModelData.fromJson(Map<String, dynamic> json) {
    if (json["products"] != null) {
      products = <Lists>[];
      for (final dynamic v in json["products"] as List<dynamic>) {
        products!.add(Lists.fromJson(v));
      }
    }
    totalCount = json["totalCount"];
  }
  List<Lists>? products;
  int? totalCount;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data["products"] = products!.map((Lists v) => v.toJson()).toList();
    }
    data["totalCount"] = totalCount;
    return data;
  }
}

class Lists {
  Lists({
    this.sId,
    this.name,
    this.description,
    this.unit,
    this.isDeleted,
    this.price,
    this.originalPrice,
    this.discount,
    this.category,
    this.itemCode,
    this.quantity,
    this.sold,
    this.sizePerQuantity,
    this.photo,
    this.video,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Lists.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    name = json["name"];
    description = json["description"];
    unit = json["unit"];
    isDeleted = json["isDeleted"];
    price = json["price"];
    originalPrice = json["originalPrice"];
    discount = json["discount"];
    category = json["category"] != null ? Category.fromJson(json["category"]) : null;
    itemCode = json["itemCode"];
    quantity = json["quantity"];
    sold = json["sold"];
    sizePerQuantity = json["sizePerQuantity"];
    photo = json["photo"];
    video = json["video"];
    status = json["status"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    iV = json["__v"];
  }

  String? sId;
  String? name;
  String? description;
  String? unit;
  bool? isDeleted;
  int? price;
  int? originalPrice;
  int? discount;
  Category? category;
  int? itemCode;
  int? quantity;
  int? sold;
  int? sizePerQuantity;
  String? photo;
  String? video;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["name"] = name;
    data["description"] = description;
    data["unit"] = unit;
    data["isDeleted"] = isDeleted;
    data["price"] = price;
    data["originalPrice"] = originalPrice;
    data["discount"] = discount;
    if (category != null) {
      data["category"] = category!.toJson();
    }
    data["itemCode"] = itemCode;
    data["quantity"] = quantity;
    data["sold"] = sold;
    data["sizePerQuantity"] = sizePerQuantity;
    data["photo"] = photo;
    data["video"] = video;
    data["status"] = status;
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
