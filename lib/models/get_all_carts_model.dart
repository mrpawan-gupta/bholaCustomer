class GetAllCartsModel {
  GetAllCartsModel({this.success, this.data, this.statusCode, this.message});

  GetAllCartsModel.fromJson(Map<String, dynamic> json) {
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
  Data({this.carts, this.totalcounts, this.limit, this.page});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["carts"] != null) {
      carts = <Carts>[];
      for (final dynamic v in json["carts"] as List<dynamic>) {
        carts!.add(Carts.fromJson(v));
      }
    }
    totalcounts = json["totalcounts"];
    limit = json["limit"];
    page = json["page"];
  }

  List<Carts>? carts;
  int? totalcounts;
  int? limit;
  int? page;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (carts != null) {
      data["carts"] = carts!.map((Carts v) => v.toJson()).toList();
    }
    data["totalcounts"] = totalcounts;
    data["limit"] = limit;
    data["page"] = page;
    return data;
  }
}

class Carts {
  Carts({
    this.sId,
    this.user,
    this.items,
    this.isCouponApplied,
    this.totalQuantity,
    this.totalItems,
    this.totalPriceWithDiscount,
    this.totalPriceWithoutDiscount,
    this.couponCode,
    this.couponAmount,
    this.deliveryAmount,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Carts.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    user = json["user"];
    if (json["items"] != null) {
      items = <Items>[];
      for (final dynamic v in json["items"] as List<dynamic>) {
        items!.add(Items.fromJson(v));
      }
    }
    isCouponApplied = json["isCouponApplied"];
    totalQuantity = json["totalQuantity"];
    totalItems = json["totalItems"];
    totalPriceWithDiscount = json["totalPriceWithDiscount"];
    totalPriceWithoutDiscount = json["totalPriceWithoutDiscount"];
    couponCode = json["couponCode"];
    couponAmount = json["couponAmount"];
    deliveryAmount = json["deliveryAmount"];
    status = json["status"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
  }

  String? sId;
  String? user;
  List<Items>? items;
  bool? isCouponApplied;
  num? totalQuantity;
  num? totalItems;
  num? totalPriceWithDiscount;
  num? totalPriceWithoutDiscount;
  String? couponCode;
  num? couponAmount;
  num? deliveryAmount;
  String? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["user"] = user;
    if (items != null) {
      data["items"] = items!.map((Items v) => v.toJson()).toList();
    }
    data["isCouponApplied"] = isCouponApplied;
    data["totalQuantity"] = totalQuantity;
    data["totalItems"] = totalItems;
    data["totalPriceWithDiscount"] = totalPriceWithDiscount;
    data["totalPriceWithoutDiscount"] = totalPriceWithoutDiscount;
    data["couponCode"] = couponCode;
    data["couponAmount"] = couponAmount;
    data["deliveryAmount"] = deliveryAmount;
    data["status"] = status;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    return data;
  }
}

class Items {
  Items({
    this.sId,
    this.productId,
    this.categoryId,
    this.productName,
    this.categoryName,
    this.productImage,
    this.price,
    this.quantity,
    this.totalPrice,
  });

  Items.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    productId = json["product_id"];
    categoryId = json["category_id"];
    productName = json["product_name"];
    categoryName = json["category_name"];
    productImage = json["product_image"];
    price = json["price"];
    quantity = json["quantity"];
    totalPrice = json["total_price"];
  }

  String? sId;
  String? productId;
  String? categoryId;
  String? productName;
  String? categoryName;
  String? productImage;
  num? price;
  num? quantity;
  num? totalPrice;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["product_id"] = productId;
    data["category_id"] = categoryId;
    data["product_name"] = productName;
    data["category_name"] = categoryName;
    data["product_image"] = productImage;
    data["price"] = price;
    data["quantity"] = quantity;
    data["total_price"] = totalPrice;
    return data;
  }
}
