class WishListModel {
  WishListModel({this.success, this.data, this.statusCode, this.message});

  WishListModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data =
        json["data"] != null ? WishListModelData.fromJson(json["data"]) : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }

  bool? success;
  WishListModelData? data;
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

class WishListModelData {
  WishListModelData({this.items, this.totalcounts, this.limit, this.page});

  WishListModelData.fromJson(Map<String, dynamic> json) {
    if (json["items"] != null) {
      items = <WishListItems>[];
      for (final dynamic v in json["items"] as List<dynamic>) {
        items!.add(WishListItems.fromJson(v));
      }
    }
    totalcounts = json["totalcounts"];
    limit = json["limit"];
    page = json["page"];
  }

  List<WishListItems>? items;
  int? totalcounts;
  int? limit;
  int? page;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data["items"] = items!.map((WishListItems v) => v.toJson()).toList();
    }
    data["totalcounts"] = totalcounts;
    data["limit"] = limit;
    data["page"] = page;
    return data;
  }
}

class WishListItems {
  WishListItems({
    this.sId,
    this.name,
    this.description,
    this.price,
    this.category,
    this.photo,
    this.cumulativeRating,
    this.discountPercent,
    this.discountedPrice,
    this.quantity,
    this.unit,
    this.isInPortfolio,
    this.isInWishList,
    this.cartQty,
    this.cartId,
    this.cartItemId,
    this.vendorProductId,
  });

  WishListItems.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    name = json["name"];
    description = json["description"];
    price = json["price"];
    category =
        json["category"] != null ? Category.fromJson(json["category"]) : null;
    photo = json["photo"];
    cumulativeRating = json["cumulativeRating"];
    discountPercent = json["discountPercent"];
    discountedPrice = json["discountedPrice"];
    quantity = json["quantity"];
    unit = json["unit"];
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
  int? price;
  Category? category;
  String? photo;
  double? cumulativeRating;
  int? discountPercent;
  int? discountedPrice;
  int? quantity;
  String? unit;
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
    data["price"] = price;
    if (category != null) {
      data["category"] = category!.toJson();
    }
    data["photo"] = photo;
    data["cumulativeRating"] = cumulativeRating;
    data["discountPercent"] = discountPercent;
    data["discountedPrice"] = discountedPrice;
    data["quantity"] = quantity;
    data["unit"] = unit;
    data["isAddedInPortfolio"] = isInPortfolio;
    data["isAddedInWishlist"] = isInWishList;
    data["cart_qty"] = cartQty;
    data["cart_id"] = cartId;
    data["cart_item_id"] = cartItemId;
    data["vendor_product_id"] = vendorProductId;
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
