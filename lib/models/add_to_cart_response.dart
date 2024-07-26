class AddToCartResponse {
  AddToCartResponse({this.success, this.data, this.statusCode, this.message});

  AddToCartResponse.fromJson(Map<String, dynamic> json) {
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
  Data({
    this.sId,
    this.user,
    this.items,
    this.totalItems,
    this.totalPrice,
    this.discountedprice,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.discountedPrice,
    this.maxamount,
    this.coupon,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    user = json["user"];
    if (json["items"] != null) {
      items = <Items>[];
      for (final dynamic v in json["items"] as List<dynamic>) {
        items!.add(Items.fromJson(v));
      }
    }
    totalItems = json["totalItems"];
    totalPrice = json["totalPrice"];
    discountedprice = json["discountedprice"];
    status = json["status"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    iV = json["__v"];
    discountedPrice = json["discountedPrice"];
    maxamount = json["maxamount"];
    coupon = json["coupon"];
  }

  String? sId;
  String? user;
  List<Items>? items;
  num? totalItems;
  num? totalPrice;
  num? discountedprice;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  num? discountedPrice;
  num? maxamount;
  String? coupon;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["user"] = user;
    if (items != null) {
      data["items"] = items!.map((Items v) => v.toJson()).toList();
    }
    data["totalItems"] = totalItems;
    data["totalPrice"] = totalPrice;
    data["discountedprice"] = discountedprice;
    data["status"] = status;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = iV;
    data["discountedPrice"] = discountedPrice;
    data["maxamount"] = maxamount;
    data["coupon"] = coupon;
    return data;
  }
}

class Items {
  Items({this.sId, this.product, this.quantity, this.totalPrice, this.iV});

  Items.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    product = json["product"];
    quantity = json["quantity"];
    totalPrice = json["totalPrice"];
    iV = json["__v"];
  }

  String? sId;
  String? product;
  num? quantity;
  num? totalPrice;
  int? iV;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["product"] = product;
    data["quantity"] = quantity;
    data["totalPrice"] = totalPrice;
    data["__v"] = iV;
    return data;
  }
}
