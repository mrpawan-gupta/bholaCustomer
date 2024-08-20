class WishAndCartCountModel {
  WishAndCartCountModel({
    this.success,
    this.data,
    this.statusCode,
    this.message,
  });

  WishAndCartCountModel.fromJson(Map<String, dynamic> json) {
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
  Data({this.cartTotalCount, this.wishlistTotalCount});

  Data.fromJson(Map<String, dynamic> json) {
    cartTotalCount = json["cartTotalCount"];
    wishlistTotalCount = json["wishlistTotalCount"];
  }

  num? cartTotalCount;
  num? wishlistTotalCount;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["cartTotalCount"] = cartTotalCount;
    data["wishlistTotalCount"] = wishlistTotalCount;
    return data;
  }
}
