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
    this.isAddedInCart,
    this.isAddedInWishlist,
    this.isAddedInPortfolio,
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
    isAddedInCart = json["isAddedInCart"];
    isAddedInWishlist = json["isAddedInWishlist"];
    isAddedInPortfolio = json["isAddedInPortfolio"];
  }

  String? sId;
  String? name;
  String? description;
  String? unit;
  num? price;
  num? discountedPrice;
  num? discountPercent;
  String? category;
  num? itemCode;
  num? sold;
  num? sizePerQuantity;
  String? photo;
  String? video;
  String? status;
  double? cumulativeRating;
  List<Ratings>? ratings;
  List<Reviews>? reviews;
  String? categoryName;
  num? reviewCount;
  num? ratingCount;
  num? wishlistCount;
  String? salePercent;
  String? saleAmount;
  bool? isAddedInCart;
  bool? isAddedInWishlist;
  bool? isAddedInPortfolio;

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
    data["isAddedInCart"] = isAddedInCart;
    data["isAddedInWishlist"] = isAddedInWishlist;
    data["isAddedInPortfolio"] = isAddedInPortfolio;
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

class Reviews {
  Reviews({
    this.customer,
    this.review,
    this.star,
    this.photos,
    this.isDeleted,
    this.sId,
    this.date,
    this.customerFirstName,
    this.customerLastName,
    this.customerProfilePhoto,
  });

  Reviews.fromJson(Map<String, dynamic> json) {
    customer = json["customer"];
    review = json["review"];
    star = json["star"];
    photos = (json["photos"] as List<dynamic>).cast<String>();
    isDeleted = json["isDeleted"];
    sId = json["_id"];
    date = json["date"];
    customerFirstName = json["customerFirstName"];
    customerLastName = json["customerLastName"];
    customerProfilePhoto = json["customerProfilePhoto"];
  }

  String? customer;
  String? review;
  num? star;
  List<String>? photos;
  bool? isDeleted;
  String? sId;
  String? date;
  String? customerFirstName;
  String? customerLastName;
  String? customerProfilePhoto;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["customer"] = customer;
    data["review"] = review;
    data["star"] = star;
    data["photos"] = photos;
    data["isDeleted"] = isDeleted;
    data["_id"] = sId;
    data["date"] = date;
    data["customerFirstName"] = customerFirstName;
    data["customerLastName"] = customerLastName;
    data["customerProfilePhoto"] = customerProfilePhoto;
    return data;
  }
}
