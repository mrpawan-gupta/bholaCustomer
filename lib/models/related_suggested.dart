class RelatedSuggested {
  RelatedSuggested({this.success, this.data, this.statusCode, this.message});

  RelatedSuggested.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data = json["data"] != null
        ? RelatedSuggestedData.fromJson(json["data"])
        : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }
  bool? success;
  RelatedSuggestedData? data;
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

class RelatedSuggestedData {
  RelatedSuggestedData({
    this.products,
    this.totalcounts,
    this.limit,
    this.page,
  });

  RelatedSuggestedData.fromJson(Map<String, dynamic> json) {
    if (json["products"] != null) {
      products = <Products>[];
      for (final dynamic v in json["products"] as List<dynamic>) {
        products!.add(Products.fromJson(v));
      }
    }
    totalcounts = json["totalcounts"];
    limit = json["limit"];
    page = json["page"];
  }
  List<Products>? products;
  int? totalcounts;
  int? limit;
  int? page;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data["products"] = products!.map((Products v) => v.toJson()).toList();
    }
    data["totalcounts"] = totalcounts;
    data["limit"] = limit;
    data["page"] = page;
    return data;
  }
}

class Products {
  Products({
    this.cumulativeRating,
    this.sId,
    this.name,
    this.description,
    this.unit,
    this.isDeleted,
    this.price,
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
    this.discountPercent,
    this.discountedPrice,
    this.isInWishList,
    this.isInCartList,
    this.cartItemQty,
  });

  Products.fromJson(Map<String, dynamic> json) {
    cumulativeRating = json["cumulativeRating"];
    sId = json["_id"];
    name = json["name"];
    description = json["description"];
    unit = json["unit"];
    isDeleted = json["isDeleted"];
    price = json["price"];
    category =
        json["category"] != null ? Category.fromJson(json["category"]) : null;
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
    discountPercent = json["discountPercent"];
    discountedPrice = json["discountedPrice"];
    isInWishList = json["isInWishList"];
    isInCartList = json["isInCartList"];
    cartItemQty = json["cartItemQty"];
  }
  double? cumulativeRating;
  String? sId;
  String? name;
  String? description;
  String? unit;
  bool? isDeleted;
  num? price;
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
  num? discountPercent;
  num? discountedPrice;
  bool? isInWishList;
  bool? isInCartList;
  num? cartItemQty;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["cumulativeRating"] = cumulativeRating;
    data["_id"] = sId;
    data["name"] = name;
    data["description"] = description;
    data["unit"] = unit;
    data["isDeleted"] = isDeleted;
    data["price"] = price;
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
    data["discountPercent"] = discountPercent;
    data["discountedPrice"] = discountedPrice;
    data["isInWishList"] = isInWishList;
    data["isInCartList"] = isInCartList;
    data["cartItemQty"] = cartItemQty;
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
