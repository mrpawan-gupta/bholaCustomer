class GetAllCartsModel {
  GetAllCartsModel({
    this.success,
    this.data,
    this.statusCode,
    this.message,
  });

  GetAllCartsModel.fromJson(Map<String, dynamic> json) {
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
    this.carts,
    this.totalcounts,
    this.limit,
    this.page,
  });

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
  num? totalcounts;
  num? limit;
  num? page;

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
    this.coupon,
    this.totalQuantity,
    this.totalItems,
    this.totalPriceWithDiscount,
    this.totalPriceWithoutDiscount,
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
    coupon = json["coupon"] != null ? Coupon.fromJson(json["coupon"]) : null;
    totalQuantity = json["totalQuantity"];
    totalItems = json["totalItems"];
    totalPriceWithDiscount = json["totalPriceWithDiscount"];
    totalPriceWithoutDiscount = json["totalPriceWithoutDiscount"];
    deliveryAmount = json["deliveryAmount"];
    status = json["status"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
  }

  String? sId;
  String? user;
  List<Items>? items;
  Coupon? coupon;
  num? totalQuantity;
  num? totalItems;
  num? totalPriceWithDiscount;
  num? totalPriceWithoutDiscount;
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
    if (coupon != null) {
      data["coupon"] = coupon!.toJson();
    }
    data["totalQuantity"] = totalQuantity;
    data["totalItems"] = totalItems;
    data["totalPriceWithDiscount"] = totalPriceWithDiscount;
    data["totalPriceWithoutDiscount"] = totalPriceWithoutDiscount;
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

class Coupon {
  Coupon({
    this.code,
    this.maxamount,
    this.discountPercent,
    this.sId,
    this.couponType,
    this.isActive,
  });

  Coupon.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    maxamount = json["maxamount"];
    discountPercent = json["discountPercent"];
    sId = json["_id"];
    couponType = json["couponType"];
    isActive = json["isActive"];
  }

  String? code;
  num? maxamount;
  num? discountPercent;
  String? sId;
  String? couponType;
  bool? isActive;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["code"] = code;
    data["maxamount"] = maxamount;
    data["discountPercent"] = discountPercent;
    data["_id"] = sId;
    data["couponType"] = couponType;
    data["isActive"] = isActive;
    return data;
  }
}
