class CreateBooking {
  CreateBooking({this.success, this.data, this.statusCode, this.message});

  CreateBooking.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data =
        json["data"] != null ? CreateBookingData.fromJson(json["data"]) : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }

  bool? success;
  CreateBookingData? data;
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

class CreateBookingData {
  CreateBookingData({this.booking, this.vendorsAvailable});

  CreateBookingData.fromJson(Map<String, dynamic> json) {
    booking =
        json["booking"] != null ? Booking.fromJson(json["booking"]) : null;
    vendorsAvailable = json["vendorsAvailable"];
  }

  Booking? booking;
  bool? vendorsAvailable;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (booking != null) {
      data["booking"] = booking!.toJson();
    }
    data["vendorsAvailable"] = vendorsAvailable;
    return data;
  }
}

class Booking {
  Booking({this.services, this.amount, this.farmArea, this.sId});

  Booking.fromJson(Map<String, dynamic> json) {
    if (json["services"] != null) {
      services = <CreateBookingDataServices>[];
      for (final dynamic v in json["services"] as List<dynamic>) {
        services!.add(CreateBookingDataServices.fromJson(v));
      }
    }
    amount = json["amount"];
    farmArea = json["farm_area"];
    sId = json["_id"];
  }
  List<CreateBookingDataServices>? services;
  int? amount;
  int? farmArea;
  String? sId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (services != null) {
      data["services"] =
          services!.map((CreateBookingDataServices v) => v.toJson()).toList();
    }
    data["amount"] = amount;
    data["farm_area"] = farmArea;
    data["_id"] = sId;
    return data;
  }
}

class CreateBookingDataServices {
  CreateBookingDataServices({this.service, this.price, this.area});

  CreateBookingDataServices.fromJson(Map<String, dynamic> json) {
    service = json["service"];
    price = json["price"];
    area = json["area"];
  }

  String? service;
  num? price;
  num? area;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["service"] = service;
    data["price"] = price;
    data["area"] = area;
    return data;
  }
}
