class BookingQuoteModel {
  BookingQuoteModel({this.success, this.data, this.statusCode, this.message});

  BookingQuoteModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    if (json["data"] != null) {
      data = <BookingQuoteModelData>[];
      for (final dynamic v in json["data"] as List<dynamic>) {
        data!.add(BookingQuoteModelData.fromJson(v));
      }
    }
    statusCode = json["statusCode"];
    message = json["message"];
  }
  bool? success;
  List<BookingQuoteModelData>? data;
  int? statusCode;
  String? message;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["success"] = success;
    if (this.data != null) {
      data["data"] =
          this.data!.map((BookingQuoteModelData v) => v.toJson()).toList();
    }
    data["statusCode"] = statusCode;
    data["message"] = message;
    return data;
  }
}

class BookingQuoteModelData {
  BookingQuoteModelData({
    this.sId,
  });

  BookingQuoteModelData.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
  }
  String? sId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    return data;
  }
}
