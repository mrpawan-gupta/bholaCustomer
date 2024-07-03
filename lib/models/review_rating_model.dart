class ReviewRatingModel {
  bool? success;
  Data? data;
  int? statusCode;
  String? message;

  ReviewRatingModel({this.success, this.data, this.statusCode, this.message});

  ReviewRatingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  List<Reviews>? reviews;
  int? totalReviews;
  int? page;
  int? limit;

  Data({this.reviews, this.totalReviews, this.page, this.limit});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    totalReviews = json['totalReviews'];
    page = json['page'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    data['totalReviews'] = this.totalReviews;
    data['page'] = this.page;
    data['limit'] = this.limit;
    return data;
  }
}

class Reviews {
  String? customer;
  String? review;
  List<String>? photos;
  String? sId;
  String? date;
  int? star;
  bool? isDeleted;
  String? customerFirstName;
  String? customerLastName;
  String? customerProfilePhoto;

  Reviews(
      {this.customer,
        this.review,
        this.photos,
        this.sId,
        this.date,
        this.star,
        this.isDeleted,
        this.customerFirstName,
        this.customerLastName,
        this.customerProfilePhoto});

  Reviews.fromJson(Map<String, dynamic> json) {
    customer = json['customer'];
    review = json['review'];
    photos = json['photos'].cast<String>();
    sId = json['_id'];
    date = json['date'];
    star = json['star'];
    isDeleted = json['isDeleted'];
    customerFirstName = json['customerFirstName'];
    customerLastName = json['customerLastName'];
    customerProfilePhoto = json['customerProfilePhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer'] = this.customer;
    data['review'] = this.review;
    data['photos'] = this.photos;
    data['_id'] = this.sId;
    data['date'] = this.date;
    data['star'] = this.star;
    data['isDeleted'] = this.isDeleted;
    data['customerFirstName'] = this.customerFirstName;
    data['customerLastName'] = this.customerLastName;
    data['customerProfilePhoto'] = this.customerProfilePhoto;
    return data;
  }
}
