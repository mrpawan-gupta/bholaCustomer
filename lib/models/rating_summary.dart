class RatingSummary {
  RatingSummary({this.success, this.data, this.statusCode, this.message});

  RatingSummary.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data =
        json["data"] != null ? RatingSummaryData.fromJson(json["data"]) : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }

  bool? success;
  RatingSummaryData? data;
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

class RatingSummaryData {
  RatingSummaryData({
    this.ratingsSummary,
    this.averageRating,
    this.totalRatings,
  });

  RatingSummaryData.fromJson(Map<String, dynamic> json) {
    ratingsSummary = json["ratingsSummary"] != null
        ? RatingsSummary.fromJson(json["ratingsSummary"])
        : null;
    averageRating = json["averageRating"];
    totalRatings = json["totalRatings"];
  }

  RatingsSummary? ratingsSummary;
  num? averageRating;
  num? totalRatings;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ratingsSummary != null) {
      data["ratingsSummary"] = ratingsSummary!.toJson();
    }
    data["averageRating"] = averageRating;
    data["totalRatings"] = totalRatings;
    return data;
  }
}

class RatingsSummary {
  RatingsSummary({this.i1, this.i2, this.i3, this.i4, this.i5});

  RatingsSummary.fromJson(Map<String, dynamic> json) {
    i1 = json["1"];
    i2 = json["2"];
    i3 = json["3"];
    i4 = json["4"];
    i5 = json["5"];
  }
  num? i1;
  num? i2;
  num? i3;
  num? i4;
  num? i5;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["1"] = i1;
    data["2"] = i2;
    data["3"] = i3;
    data["4"] = i4;
    data["5"] = i5;
    return data;
  }
}
