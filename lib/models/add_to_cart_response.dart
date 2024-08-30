class AddToCartResponse {
  AddToCartResponse({
    this.success,
    this.data,
    this.statusCode,
    this.message,
  });

  AddToCartResponse.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }

  bool? success;
  Data? data;
  num? statusCode;
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
    this.user,
    this.items,
    this.totalItems,
    this.grossAmount,
    this.discountAmount,
    this.coupon,
    this.couponAmount,
    this.netAmount,
    this.status,
    this.sId,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Data.fromJson(Map<String, dynamic> json) {
    user = json["user"];
    if (json["items"] != null) {
      items = <Items>[];
      for (final dynamic v in json["items"] as List<dynamic>) {
        items!.add(Items.fromJson(v));
      }
    }
    totalItems = json["totalItems"];
    grossAmount = json["grossAmount"];
    discountAmount = json["discountAmount"];
    coupon = json["coupon"];
    couponAmount = json["couponAmount"];
    netAmount = json["netAmount"];
    status = json["status"];
    sId = json["_id"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    iV = json["__v"];
  }

  String? user;
  List<Items>? items;
  num? totalItems;
  num? grossAmount;
  num? discountAmount;
  String? coupon;
  num? couponAmount;
  num? netAmount;
  String? status;
  String? sId;
  String? createdAt;
  String? updatedAt;
  num? iV;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["user"] = user;
    if (items != null) {
      data["items"] = items!.map((Items v) => v.toJson()).toList();
    }
    data["totalItems"] = totalItems;
    data["grossAmount"] = grossAmount;
    data["discountAmount"] = discountAmount;
    data["coupon"] = coupon;
    data["couponAmount"] = couponAmount;
    data["netAmount"] = netAmount;
    data["status"] = status;
    data["_id"] = sId;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = iV;
    return data;
  }
}

class Items {
  Items({
    this.product,
    this.quantity,
    this.price,
    this.discountedPrice,
    this.discountPercent,
    this.netAmount,
    this.sId,
    this.iV,
  });

  Items.fromJson(Map<String, dynamic> json) {
    product = json["product"];
    quantity = json["quantity"];
    price = json["price"];
    discountedPrice = json["discountedPrice"];
    discountPercent = json["discountPercent"];
    netAmount = json["netAmount"];
    sId = json["_id"];
    iV = json["__v"];
  }

  String? product;
  num? quantity;
  num? price;
  num? discountedPrice;
  num? discountPercent;
  num? netAmount;
  String? sId;
  num? iV;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["product"] = product;
    data["quantity"] = quantity;
    data["price"] = price;
    data["discountedPrice"] = discountedPrice;
    data["discountPercent"] = discountPercent;
    data["netAmount"] = netAmount;
    data["_id"] = sId;
    data["__v"] = iV;
    return data;
  }
}
