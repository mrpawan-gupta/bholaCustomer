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
    this.services,
    this.registrationNumber,
    this.vehicleRc,
    this.photo,
    this.video,
    this.cumulativeRating,
    this.reviews,
    this.categoryName,
    this.reviewCount,
    this.saleAmount,
    this.salePercent,
  });

  ProductDetailsData.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    name = json["name"];
    description = json["description"];
    status = json["status"];
    category = json["category"];
    if (json["services"] != null) {
      services = <Services>[];
      for (final dynamic v in json["services"] as List<dynamic>) {
        services!.add(Services.fromJson(v));
      }
    }
    registrationNumber = json["registrationNumber"];
    vehicleRc = json["vehicleRc"];
    photo = json["photo"];
    video = json["video"];
    cumulativeRating = json["cumulativeRating"];
    if (json["reviews"] != null) {
      reviews = <Reviews>[];
      for (final dynamic v in json["reviews"] as List<dynamic>) {
        reviews!.add(Reviews.fromJson(v));
      }
    }
    categoryName = json["categoryName"];
    reviewCount = json["reviewCount"];
    saleAmount = json["saleAmount"];
    salePercent = json["salePercent"];
  }
  String? sId;
  String? name;
  String? description;
  String? status;
  String? category;
  List<Services>? services;
  String? registrationNumber;
  String? vehicleRc;
  String? photo;
  String? video;
  double? cumulativeRating;
  List<Reviews>? reviews;
  String? categoryName;
  int? reviewCount;
  String? saleAmount;
  String? salePercent;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["name"] = name;
    data["description"] = description;
    data["status"] = status;
    data["category"] = category;
    if (services != null) {
      data["services"] = services!.map((Services v) => v.toJson()).toList();
    }
    data["registrationNumber"] = registrationNumber;
    data["vehicleRc"] = vehicleRc;
    data["photo"] = photo;
    data["video"] = video;
    data["cumulativeRating"] = cumulativeRating;
    if (reviews != null) {
      data["reviews"] = reviews!.map((Reviews v) => v.toJson()).toList();
    }
    data["categoryName"] = categoryName;
    data["reviewCount"] = reviewCount;
    data["saleAmount"] = saleAmount;
    data["salePercent"] = salePercent;
    return data;
  }
}

class Services {
  Services({this.price, this.name, this.code});

  Services.fromJson(Map<String, dynamic> json) {
    price = json["price"];
    name = json["name"];
    code = json["code"];
  }
  int? price;
  String? name;
  String? code;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["price"] = price;
    data["name"] = name;
    data["code"] = code;
    return data;
  }
}

class Reviews {
  Reviews({
    this.customer,
    this.text,
    this.star,
    this.reviewPhotos,
    this.sId,
    this.date,
    this.customerFirstName,
    this.customerLastName,
    this.customerProfilePhoto,
  });

  Reviews.fromJson(Map<String, dynamic> json) {
    customer = json["customer"];
    text = json["text"];
    star = json["star"];
    reviewPhotos = (json["review_photos"] as List<dynamic>).cast<String>();
    sId = json["_id"];
    date = json["date"];
    customerFirstName = json["customerFirstName"];
    customerLastName = json["customerLastName"];
    customerProfilePhoto = json["customerProfilePhoto"];
  }
  String? customer;
  String? text;
  int? star;
  List<String>? reviewPhotos;
  String? sId;
  String? date;
  String? customerFirstName;
  String? customerLastName;
  String? customerProfilePhoto;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["customer"] = customer;
    data["text"] = text;
    data["star"] = star;
    data["review_photos"] = reviewPhotos;
    data["_id"] = sId;
    data["date"] = date;
    data["customerFirstName"] = customerFirstName;
    data["customerLastName"] = customerLastName;
    data["customerProfilePhoto"] = customerProfilePhoto;
    return data;
  }
}
