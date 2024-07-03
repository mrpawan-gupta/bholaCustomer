class CouponListModel {
  CouponListModel({this.success, this.data, this.statusCode, this.message});

  CouponListModel.fromJson(Map<String, dynamic> json) {
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
  Data({this.coupons, this.totalcounts, this.limit, this.page});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["coupons"] != null) {
      coupons = <Coupons>[];
      for (final dynamic v in json["coupons"] as List<dynamic>) {
        coupons!.add(Coupons.fromJson(v));
      }
    }
    totalcounts = json["totalcounts"];
    limit = json["limit"];
    page = json["page"];
  }

  List<Coupons>? coupons;
  int? totalcounts;
  int? limit;
  int? page;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (coupons != null) {
      data["coupons"] = coupons!.map((Coupons v) => v.toJson()).toList();
    }
    data["totalcounts"] = totalcounts;
    data["limit"] = limit;
    data["page"] = page;
    return data;
  }
}

class Coupons {
  Coupons({
    this.sId,
    this.code,
    this.couponType,
    this.isActive,
    this.discountPercent,
    this.maxamount,
  });

  Coupons.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    code = json["code"];
    couponType = json["couponType"];
    isActive = json["isActive"];
    discountPercent = json["discountPercent"];
    maxamount = json["maxamount"];
  }

  String? sId;
  String? code;
  String? couponType;
  bool? isActive;
  int? discountPercent;
  int? maxamount;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["code"] = code;
    data["couponType"] = couponType;
    data["isActive"] = isActive;
    data["discountPercent"] = discountPercent;
    data["maxamount"] = maxamount;
    return data;
  }
}
