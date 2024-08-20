import "package:customer/models/product_model.dart";

class RelatedSuggested {
  RelatedSuggested({this.success, this.data, this.statusCode, this.message});

  RelatedSuggested.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data = json["data"] != null
        ? RelatedSuggestedData.fromJson(json["data"])
        : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }
  bool? success;
  RelatedSuggestedData? data;
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

class RelatedSuggestedData {
  RelatedSuggestedData({
    this.products,
    this.totalcounts,
    this.limit,
    this.page,
  });

  RelatedSuggestedData.fromJson(Map<String, dynamic> json) {
    if (json["products"] != null) {
      products = <Products>[];
      for (final dynamic v in json["products"] as List<dynamic>) {
        products!.add(Products.fromJson(v));
      }
    }
    totalcounts = json["totalcounts"];
    limit = json["limit"];
    page = json["page"];
  }
  List<Products>? products;
  num? totalcounts;
  num? limit;
  num? page;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data["products"] = products!.map((Products v) => v.toJson()).toList();
    }
    data["totalcounts"] = totalcounts;
    data["limit"] = limit;
    data["page"] = page;
    return data;
  }
}
