class BookingModel {
  BookingModel({this.success, this.data, this.statusCode, this.message});

  BookingModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data =
        json["data"] != null ? BookingModelData.fromJson(json["data"]) : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }

  bool? success;
  BookingModelData? data;
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

class BookingModelData {
  BookingModelData({this.bookings, this.page, this.limit});

  BookingModelData.fromJson(Map<String, dynamic> json) {
    if (json["bookings"] != null) {
      bookings = <Bookings>[];
      for (final dynamic v in json["bookings"] as List<dynamic>) {
        bookings!.add(Bookings.fromJson(v));
      }
    }
    page = json["page"];
    limit = json["limit"];
  }

  List<Bookings>? bookings;
  num? page;
  num? limit;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bookings != null) {
      data["bookings"] = bookings!.map((Bookings v) => v.toJson()).toList();
    }
    data["page"] = page;
    data["limit"] = limit;
    return data;
  }
}

class Bookings {
  Bookings({
    this.sId,
    this.totalOrders,
    this.stock,
    this.categoryName,
    this.categoryImage,
  });

  Bookings.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    totalOrders = json["totalOrders"];
    stock = json["stock"];
    categoryName = json["categoryName"];
    categoryImage = json["categoryImage"];
  }

  String? sId;
  num? totalOrders;
  num? stock;
  String? categoryName;
  String? categoryImage;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["totalOrders"] = totalOrders;
    data["stock"] = stock;
    data["categoryName"] = categoryName;
    data["categoryImage"] = categoryImage;
    return data;
  }
}
