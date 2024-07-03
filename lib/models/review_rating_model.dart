class ReviewRatingModel {
  ReviewRatingModel({this.success, this.data, this.statusCode, this.message});

  ReviewRatingModel.fromJson(Map<String, dynamic> json) {
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
  Data({this.reviews, this.totalReviews, this.page, this.limit});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["reviews"] != null) {
      reviews = <Reviews>[];
      for (final dynamic v in json["reviews"] as List<dynamic>) {
        reviews!.add(Reviews.fromJson(v));
      }
    }
    totalReviews = json["totalReviews"];
    page = json["page"];
    limit = json["limit"];
  }

  List<Reviews>? reviews;
  int? totalReviews;
  int? page;
  int? limit;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reviews != null) {
      data["reviews"] = reviews!.map((Reviews v) => v.toJson()).toList();
    }
    data["totalReviews"] = totalReviews;
    data["page"] = page;
    data["limit"] = limit;
    return data;
  }
}

class Reviews {
  Reviews({
    this.customer,
    this.review,
    this.photos,
    this.sId,
    this.date,
    this.star,
    this.isDeleted,
    this.customerFirstName,
    this.customerLastName,
    this.customerProfilePhoto,
  });

  Reviews.fromJson(Map<String, dynamic> json) {
    customer = json["customer"];
    review = json["review"];
    photos = (json["photos"] as List<dynamic>).cast<String>();
    sId = json["_id"];
    date = json["date"];
    star = json["star"];
    isDeleted = json["isDeleted"];
    customerFirstName = json["customerFirstName"];
    customerLastName = json["customerLastName"];
    customerProfilePhoto = json["customerProfilePhoto"];
  }
  
  String? customer;
  String? review;
  List<String>? photos;
  String? sId;
  String? date;
  num? star;
  bool? isDeleted;
  String? customerFirstName;
  String? customerLastName;
  String? customerProfilePhoto;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["customer"] = customer;
    data["review"] = review;
    data["photos"] = photos;
    data["_id"] = sId;
    data["date"] = date;
    data["star"] = star;
    data["isDeleted"] = isDeleted;
    data["customerFirstName"] = customerFirstName;
    data["customerLastName"] = customerLastName;
    data["customerProfilePhoto"] = customerProfilePhoto;
    return data;
  }
}
