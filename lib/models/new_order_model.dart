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
    this.type,
    this.vehicle,
    this.vehicleCategory,
    this.services,
    this.amount,
    this.commissionAmount,
    this.discount,
    this.finalAmount,
    this.senderAddress,
    this.deliveryAddress,
    this.scheduleDate = "2001-01-01T00:00:00.000Z",
    this.approxStartTime = "2001-01-01T00:00:00.000Z",
    this.approxEndTime = "2001-01-01T00:00:00.000Z",
    this.status,
    this.crop,
    this.farmArea,
    this.hours,
    this.customer,
    this.vendor,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.commissionPercentage,
    this.discountPercentage,
    this.medicines,
    this.totalMedicinePrice,
    this.totalMedicines,
  });

  Bookings.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    type = json["type"];
    vehicle =
        json["vehicle"] != null ? Vehicle.fromJson(json["vehicle"]) : null;
    vehicleCategory = json["vehicleCategory"] != null
        ? Vehicle.fromJson(json["vehicleCategory"])
        : null;
    if (json["services"] != null) {
      services = <Services>[];
      for (final dynamic v in json["services"] as List<dynamic>) {
        services!.add(Services.fromJson(v));
      }
    }
    amount = json["amount"];
    commissionAmount = json["commissionAmount"];
    discount = json["discount"];
    finalAmount = json["finalAmount"];
    senderAddress = json["senderAddress"] != null
        ? SenderAddress.fromJson(json["senderAddress"])
        : null;
    deliveryAddress = json["deliveryAddress"] != null
        ? SenderAddress.fromJson(json["deliveryAddress"])
        : null;
    scheduleDate = json["scheduleDate"];
    approxStartTime = json["approxStartTime"];
    approxEndTime = json["approxEndTime"];
    status = json["status"];
    crop = json["crop"] != null ? Service.fromJson(json["crop"]) : null;
    farmArea = json["farm_area"];
    hours = json["hours"];
    customer =
        json["customer"] != null ? Customer.fromJson(json["customer"]) : null;
    vendor = json["vendor"] != null ? Customer.fromJson(json["vendor"]) : null;
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    iV = json["__v"];
    commissionPercentage = json["commissionPercentage"];
    discountPercentage = json["discountPercentage"];
    if (json["medicines"] != null) {
      medicines = <Medicines>[];
      for (final dynamic v in json["medicines"] as List<dynamic>) {
        medicines!.add(Medicines.fromJson(v));
      }
    }
    totalMedicinePrice = json["totalMedicinePrice"];
    totalMedicines = json["totalMedicines"];
  }
  String? sId;
  String? type;
  Vehicle? vehicle;
  Vehicle? vehicleCategory;
  List<Services>? services;
  int? amount;
  int? commissionAmount;
  int? discount;
  int? finalAmount;
  SenderAddress? senderAddress;
  SenderAddress? deliveryAddress;
  String? scheduleDate;
  String? approxStartTime;
  String? approxEndTime;
  String? status;
  Service? crop;
  int? farmArea;
  int? hours;
  Customer? customer;
  Customer? vendor;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? commissionPercentage;
  int? discountPercentage;
  List<Medicines>? medicines;
  int? totalMedicinePrice;
  int? totalMedicines;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["type"] = type;
    if (vehicle != null) {
      data["vehicle"] = vehicle!.toJson();
    }
    if (vehicleCategory != null) {
      data["vehicleCategory"] = vehicleCategory!.toJson();
    }
    if (services != null) {
      data["services"] = services!.map((Services v) => v.toJson()).toList();
    }
    data["amount"] = amount;
    data["commissionAmount"] = commissionAmount;
    data["discount"] = discount;
    data["finalAmount"] = finalAmount;
    if (senderAddress != null) {
      data["senderAddress"] = senderAddress!.toJson();
    }
    if (deliveryAddress != null) {
      data["deliveryAddress"] = deliveryAddress!.toJson();
    }
    data["scheduleDate"] = scheduleDate;
    data["approxStartTime"] = approxStartTime;
    data["approxEndTime"] = approxEndTime;
    data["status"] = status;
    if (crop != null) {
      data["crop"] = crop!.toJson();
    }
    data["farm_area"] = farmArea;
    data["hours"] = hours;
    if (customer != null) {
      data["customer"] = customer!.toJson();
    }
    if (vendor != null) {
      data["vendor"] = vendor!.toJson();
    }
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = iV;
    data["commissionPercentage"] = commissionPercentage;
    data["discountPercentage"] = discountPercentage;
    if (medicines != null) {
      data["medicines"] = medicines!.map((Medicines v) => v.toJson()).toList();
    }
    data["totalMedicinePrice"] = totalMedicinePrice;
    data["totalMedicines"] = totalMedicines;
    return data;
  }
}

class Vehicle {
  Vehicle({this.sId, this.name, this.photo});

  Vehicle.fromJson(Map<String, dynamic> json) {
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
  int? price;
  int? area;

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

class SenderAddress {
  SenderAddress({this.sId, this.pinCode, this.street, this.city, this.country});

  SenderAddress.fromJson(Map<String, dynamic> json) {
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

class Medicines {
  Medicines({this.sId, this.medicine, this.quantity, this.totalPrice, this.iV});

  Medicines.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    medicine =
        json["medicine"] != null ? Medicine.fromJson(json["medicine"]) : null;
    quantity = json["quantity"];
    totalPrice = json["totalPrice"];
    iV = json["__v"];
  }
  String? sId;
  Medicine? medicine;
  int? quantity;
  int? totalPrice;
  int? iV;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    if (medicine != null) {
      data["medicine"] = medicine!.toJson();
    }
    data["quantity"] = quantity;
    data["totalPrice"] = totalPrice;
    data["__v"] = iV;
    return data;
  }
}

class Medicine {
  Medicine({this.sId, this.name, this.brand, this.description, this.photo});

  Medicine.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    name = json["name"];
    brand = json["brand"];
    description = json["description"];
    photo = json["photo"];
  }
  String? sId;
  String? name;
  String? brand;
  String? description;
  String? photo;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["name"] = name;
    data["brand"] = brand;
    data["description"] = description;
    data["photo"] = photo;
    return data;
  }
}
