import "package:customer/models/review_rating_model.dart";

class GenericProduct {
  GenericProduct({
    this.success,
    this.data,
    this.statusCode,
    this.message,
  });

  GenericProduct.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data =
        json["data"] != null ? GenericProductData.fromJson(json["data"]) : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }

  bool? success;
  GenericProductData? data;
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

class GenericProductData {
  GenericProductData({
    this.sId,
    this.name,
    this.description,
    this.unit,
    this.price,
    this.discountedPrice,
    this.discountPercent,
    this.category,
    this.itemCode,
    this.sold,
    this.sizePerQuantity,
    this.photo,
    this.video,
    this.status,
    this.cumulativeRating,
    this.ratings,
    this.reviews,
    this.categoryName,
    this.reviewCount,
    this.ratingCount,
    this.wishlistCount,
    this.salePercent,
    this.saleAmount,
    this.isInPortfolio,
    this.isInWishList,
    this.cartQty,
    this.cartId,
    this.cartItemId,
    this.vendorProductId,
  });

  GenericProductData.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    name = json["name"];
    description = json["description"];
    unit = json["unit"];
    price = json["price"];
    discountedPrice = json["discountedPrice"];
    discountPercent = json["discountPercent"];
    category = json["category"];
    itemCode = json["itemCode"];
    sold = json["sold"];
    sizePerQuantity = json["sizePerQuantity"];
    photo = json["photo"];
    video = json["video"];
    status = json["status"];
    cumulativeRating = json["cumulativeRating"];
    if (json["ratings"] != null) {
      ratings = <Ratings>[];
      for (final dynamic v in json["ratings"] as List<dynamic>) {
        ratings!.add(Ratings.fromJson(v));
      }
    }
    if (json["reviews"] != null) {
      reviews = <Reviews>[];
      for (final dynamic v in json["reviews"] as List<dynamic>) {
        reviews!.add(Reviews.fromJson(v));
      }
    }
    categoryName = json["categoryName"];
    reviewCount = json["reviewCount"];
    ratingCount = json["ratingCount"];
    wishlistCount = json["wishlistCount"];
    salePercent = json["salePercent"];
    saleAmount = json["saleAmount"];
    isInPortfolio = json["isAddedInPortfolio"];
    isInWishList = json["isAddedInWishlist"];
    cartQty = json["cart_qty"];
    cartId = json["cart_id"];
    cartItemId = json["cart_item_id"];
    vendorProductId = json["vendor_product_id"];
  }

  String? sId;
  String? name;
  String? description;
  String? unit;
  num? price;
  num? discountedPrice;
  num? discountPercent;
  String? category;
  String? itemCode;
  num? sold;
  num? sizePerQuantity;
  String? photo;
  String? video;
  String? status;
  num? cumulativeRating;
  List<Ratings>? ratings;
  List<Reviews>? reviews;
  String? categoryName;
  num? reviewCount;
  num? ratingCount;
  num? wishlistCount;
  String? salePercent;
  String? saleAmount;
  bool? isInPortfolio;
  bool? isInWishList;
  num? cartQty;
  String? cartId;
  String? cartItemId;
  String? vendorProductId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["name"] = name;
    data["description"] = description;
    data["unit"] = unit;
    data["price"] = price;
    data["discountedPrice"] = discountedPrice;
    data["discountPercent"] = discountPercent;
    data["category"] = category;
    data["itemCode"] = itemCode;
    data["sold"] = sold;
    data["sizePerQuantity"] = sizePerQuantity;
    data["photo"] = photo;
    data["video"] = video;
    data["status"] = status;
    data["cumulativeRating"] = cumulativeRating;
    if (ratings != null) {
      data["ratings"] = ratings!.map((Ratings v) => v.toJson()).toList();
    }
    if (reviews != null) {
      data["reviews"] = reviews!.map((Reviews v) => v.toJson()).toList();
    }
    data["categoryName"] = categoryName;
    data["reviewCount"] = reviewCount;
    data["ratingCount"] = ratingCount;
    data["wishlistCount"] = wishlistCount;
    data["salePercent"] = salePercent;
    data["saleAmount"] = saleAmount;
    data["isAddedInPortfolio"] = isInPortfolio;
    data["isAddedInWishlist"] = isInWishList;
    data["cart_qty"] = cartQty;
    data["cart_id"] = cartId;
    data["cart_item_id"] = cartItemId;
    data["vendor_product_id"] = vendorProductId;
    return data;
  }
}

class Ratings {
  Ratings({
    this.customer,
    this.star,
    this.isDeleted,
    this.sId,
  });

  Ratings.fromJson(Map<String, dynamic> json) {
    customer = json["customer"];
    star = json["star"];
    isDeleted = json["isDeleted"];
    sId = json["_id"];
  }

  String? customer;
  num? star;
  bool? isDeleted;
  String? sId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["customer"] = customer;
    data["star"] = star;
    data["isDeleted"] = isDeleted;
    data["_id"] = sId;
    return data;
  }
}
