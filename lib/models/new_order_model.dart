class NewOrderModel {
  NewOrderModel({this.success, this.data, this.statusCode, this.message});

  NewOrderModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data =
        json["data"] != null ? NewOrderModelData.fromJson(json["data"]) : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }

  bool? success;
  NewOrderModelData? data;
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

class NewOrderModelData {
  NewOrderModelData({this.bookings, this.limit, this.page, this.totalcounts});

  NewOrderModelData.fromJson(Map<String, dynamic> json) {
    if (json["bookings"] != null) {
      bookings = <Bookings>[];
      for (final dynamic v in json["bookings"] as List<dynamic>) {
        bookings!.add(Bookings.fromJson(v));
      }
    }
    limit = json["limit"];
    page = json["page"];
    totalcounts = json["totalcounts"];
  }

  List<Bookings>? bookings;
  int? limit;
  int? page;
  int? totalcounts;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bookings != null) {
      data["bookings"] = bookings!.map((Bookings v) => v.toJson()).toList();
    }
    data["limit"] = limit;
    data["page"] = page;
    data["totalcounts"] = totalcounts;
    return data;
  }
}

class Bookings {
  Bookings({
    this.sId,
    this.vehicleCategory,
    this.services,
    this.amount,
    this.deliveryAddress,
    this.scheduleDate = "2001-01-01T00:00:00.000Z",
    this.approxStartTime = "2001-01-01T00:00:00.000Z",
    this.approxEndTime = "2001-01-01T00:00:00.000Z",
    this.status,
    this.crop,
    this.farmArea,
    this.customer,
    this.vendor,
  });

  Bookings.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    vehicleCategory = json["vehicleCategory"] != null
        ? VehicleCategory.fromJson(json["vehicleCategory"])
        : null;
    if (json["services"] != null) {
      services = <Services>[];
      for (final dynamic v in json["services"] as List<dynamic>) {
        services!.add(Services.fromJson(v));
      }
    }
    amount = json["amount"];
    deliveryAddress = json["deliveryAddress"] != null
        ? DeliveryAddress.fromJson(json["deliveryAddress"])
        : null;
    scheduleDate = json["scheduleDate"];
    approxStartTime = json["approxStartTime"];
    approxEndTime = json["approxEndTime"];
    status = json["status"];
    crop = json["crop"];
    farmArea = json["farmArea"];
    customer =
        json["customer"] != null ? Customer.fromJson(json["customer"]) : null;
    vendor = json["vendor"] != null ? Vendor.fromJson(json["vendor"]) : null;
  }

  String? sId;
  VehicleCategory? vehicleCategory;
  List<Services>? services;
  int? amount;
  DeliveryAddress? deliveryAddress;
  String? scheduleDate;
  String? approxStartTime;
  String? approxEndTime;
  String? status;
  String? crop;
  int? farmArea;
  Customer? customer;
  Vendor? vendor;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    if (vehicleCategory != null) {
      data["vehicleCategory"] = vehicleCategory!.toJson();
    }
    if (services != null) {
      data["services"] = services!.map((Services v) => v.toJson()).toList();
    }
    data["amount"] = amount;
    if (deliveryAddress != null) {
      data["deliveryAddress"] = deliveryAddress!.toJson();
    }
    data["scheduleDate"] = scheduleDate;
    data["approxStartTime"] = approxStartTime;
    data["approxEndTime"] = approxEndTime;
    data["status"] = status;
    data["crop"] = crop;
    data["farmArea"] = farmArea;
    if (customer != null) {
      data["customer"] = customer!.toJson();
    }
    if (vendor != null) {
      data["vendor"] = vendor!.toJson();
    }
    return data;
  }
}

class VehicleCategory {
  VehicleCategory({this.sId, this.name, this.photo});

  VehicleCategory.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    name = json["name"];
    photo = json["photo"];
  }

  String? sId;
  String? name;
  String? photo;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["name"] = name;
    data["photo"] = photo;
    return data;
  }
}

class Services {
  Services({this.service, this.price, this.area});

  Services.fromJson(Map<String, dynamic> json) {
    service =
        json["service"] != null ? Service.fromJson(json["service"]) : null;
    price = json["price"];
    area = json["area"];
  }

  Service? service;
  num? price;
  num? area;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (service != null) {
      data["service"] = service!.toJson();
    }
    data["price"] = price;
    data["area"] = area;
    return data;
  }
}

class Service {
  Service({this.sId, this.name});

  Service.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    name = json["name"];
  }

  String? sId;
  String? name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["name"] = name;
    return data;
  }
}

class DeliveryAddress {
  DeliveryAddress({
    this.sId,
    this.pinCode,
    this.street,
    this.city,
    this.country,
  });

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    pinCode = json["pinCode"];
    street = json["street"];
    city = json["city"];
    country = json["country"];
  }

  String? sId;
  String? pinCode;
  String? street;
  String? city;
  String? country;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["pinCode"] = pinCode;
    data["street"] = street;
    data["city"] = city;
    data["country"] = country;
    return data;
  }
}

class Customer {
  Customer({
    this.sId,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.email,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    phoneNumber = json["phoneNumber"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
  }

  String? sId;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? email;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["phoneNumber"] = phoneNumber;
    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data["email"] = email;
    return data;
  }
}

class Vendor {
  Vendor({
    this.sId,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.email,
  });

  Vendor.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    phoneNumber = json["phoneNumber"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
  }

  String? sId;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? email;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["phoneNumber"] = phoneNumber;
    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data["email"] = email;
    return data;
  }
}
