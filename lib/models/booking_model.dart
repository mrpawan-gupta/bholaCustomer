class BookingModel {
  BookingModel({this.success, this.data, this.statusCode, this.message});

  BookingModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    if (json["data"] != null) {
      data = <BookingModelData>[];
      for (final dynamic v in json["data"] as List<dynamic>) {
        data!.add(BookingModelData.fromJson(v));
      }
    }
    statusCode = json["statusCode"];
    message = json["message"];
  }
  bool? success;
  List<BookingModelData>? data;
  int? statusCode;
  String? message;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["success"] = success;
    if (this.data != null) {
      data["data"] =
          this.data!.map((BookingModelData v) => v.toJson()).toList();
    }
    data["statusCode"] = statusCode;
    data["message"] = message;
    return data;
  }
}

class BookingModelData {
  BookingModelData({
    this.sId,
    this.totalOrders,
    this.stock,
    this.categoryName,
    this.categoryImage,
  });

  BookingModelData.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    totalOrders = json["totalOrders"];
    stock = json["stock"];
    categoryName = json["categoryName"];
    categoryImage = json["categoryImage"];
  }
  String? sId;
  int? totalOrders;
  int? stock;
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
