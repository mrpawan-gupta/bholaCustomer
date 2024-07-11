class ProductDetails {
  ProductDetails({this.success, this.data, this.statusCode, this.message});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data =
        json["data"] != null ? ProductDetailsData.fromJson(json["data"]) : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }
  bool? success;
  ProductDetailsData? data;
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

class ProductDetailsData {
  ProductDetailsData({
    this.sId,
    this.name,
    this.description,
    this.status,
    this.category,
    this.photo,
    this.video,
    this.cumulativeRating,
    this.reviews,
    this.ratings,
    this.categoryName,
    this.reviewCount,
    this.ratingCount,
    this.saleAmount,
    this.salePercent,
    this.wishlistCount,
    this.unit,
    this.price,
    this.discountedPrice,
    this.discountPercent,
    this.isAddedInCart,
    this.isAddedInPortfolio,
    this.isAddedInWishlist,
    this.itemCode,
    this.sizePerQuantity,
    this.sold,
    this.vendorProductId,
  });

  ProductDetailsData.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    name = json["name"];
    description = json["description"];
    status = json["status"];
    category = json["category"];
    photo = json["photo"];
    video = json["video"];
    cumulativeRating = json["cumulativeRating"];
    if (json["reviews"] != null) {
      reviews = <Reviews>[];
      for (final dynamic v in json["reviews"] as List<dynamic>) {
        reviews!.add(Reviews.fromJson(v));
      }
    }
    if (json["ratings"] != null) {
      ratings = <Ratings>[];
      for (final dynamic v in json["ratings"] as List<dynamic>) {
        ratings!.add(Ratings.fromJson(v));
      }
    }
    categoryName = json["categoryName"];
    reviewCount = json["reviewCount"];
    ratingCount = json["ratingCount"];
    saleAmount = json["saleAmount"];
    salePercent = json["salePercent"];
    wishlistCount = json["wishlistCount"];
    unit = json["unit"];
    price = json["price"];
    itemCode = json["itemCode"];
    sold = json["sold"];
    sizePerQuantity = json["sizePerQuantity"];
    discountPercent = json["discountPercent"];
    discountedPrice = json["discountedPrice"];
    isAddedInCart = json["isAddedInCart"];
    isAddedInWishlist = json["isAddedInWishlist"];
    isAddedInPortfolio = json["isAddedInPortfolio"];
    vendorProductId = json["vendor_product_id"];
  }
  String? sId;
  String? name;
  String? description;
  String? status;
  String? category;
  String? photo;
  String? video;
  double? cumulativeRating;
  List<Reviews>? reviews;
  List<Ratings>? ratings;
  String? categoryName;
  int? reviewCount;
  int? ratingCount;
  int? wishlistCount;
  String? unit;
  num? price;
  int? itemCode;
  int? sold;
  int? sizePerQuantity;
  String? saleAmount;
  String? salePercent;
  num? discountPercent;
  num? discountedPrice;
  bool? isAddedInCart;
  bool? isAddedInWishlist;
  int? isAddedInPortfolio;
  String? vendorProductId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["name"] = name;
    data["description"] = description;
    data["status"] = status;
    data["category"] = category;
    data["ratingCount"] = ratingCount;
    data["wishlistCount"] = wishlistCount;
    data["photo"] = photo;
    data["video"] = video;
    data["cumulativeRating"] = cumulativeRating;
    if (reviews != null) {
      data["reviews"] = reviews!.map((Reviews v) => v.toJson()).toList();
    }
    if (ratings != null) {
      data["ratings"] = ratings!.map((Ratings v) => v.toJson()).toList();
    }
    data["categoryName"] = categoryName;
    data["reviewCount"] = reviewCount;
    data["saleAmount"] = saleAmount;
    data["salePercent"] = salePercent;
    data["unit"] = unit;
    data["price"] = price;
    data["itemCode"] = itemCode;
    data["sold"] = sold;
    data["sizePerQuantity"] = sizePerQuantity;
    data["discountPercent"] = discountPercent;
    data["discountedPrice"] = discountedPrice;
    data["isAddedInCart"] = isAddedInCart;
    data["isAddedInWishlist"] = isAddedInWishlist;
    data["isAddedInPortfolio"] = isAddedInPortfolio;
    data["vendor_product_id"] = vendorProductId;
    return data;
  }
}

class Reviews {
  Reviews({
    this.customer,
    this.star,
    this.reviewPhotos,
    this.sId,
    this.date,
    this.isDeleted,
    this.review,
    this.customerFirstName,
    this.customerLastName,
    this.customerProfilePhoto,
  });

  Reviews.fromJson(Map<String, dynamic> json) {
    customer = json["customer"];
    star = json["star"];
    reviewPhotos = (json["photos"] as List<dynamic>).cast<String>();
    sId = json["_id"];
    date = json["date"];
    isDeleted = json["isDeleted"];
    review = json["review"];
    customerFirstName = json["customerFirstName"];
    customerLastName = json["customerLastName"];
    customerProfilePhoto = json["customerProfilePhoto"];
  }
  String? customer;
  int? star;
  List<String>? reviewPhotos;
  String? sId;
  String? date;
  String? review;
  bool? isDeleted;
  String? customerFirstName;
  String? customerLastName;
  String? customerProfilePhoto;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["customer"] = customer;
    data["review"] = review;
    data["star"] = star;
    data["photos"] = reviewPhotos;
    data["_id"] = sId;
    data["date"] = date;
    data["isDeleted"] = isDeleted;
    data["customerFirstName"] = customerFirstName;
    data["customerLastName"] = customerLastName;
    data["customerProfilePhoto"] = customerProfilePhoto;
    return data;
  }
}

class Ratings {
  Ratings({
    this.customer,
    this.star,
    this.sId,
    this.isDeleted,
  });

  Ratings.fromJson(Map<String, dynamic> json) {
    customer = json["customer"];
    star = json["star"];
    sId = json["_id"];
    isDeleted = json["isDeleted"];
  }
  String? customer;
  int? star;
  String? sId;
  bool? isDeleted;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["customer"] = customer;
    data["star"] = star;
    data["_id"] = sId;
    data["isDeleted"] = isDeleted;
    return data;
  }
}
