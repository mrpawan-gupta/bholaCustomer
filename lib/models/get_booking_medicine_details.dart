class GetBookingMedicineDetails {
  GetBookingMedicineDetails({
    this.success,
    this.data,
    this.statusCode,
    this.message,
  });

  GetBookingMedicineDetails.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data = json["data"] != null
        ? MedicineDetailsData.fromJson(json["data"])
        : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }

  bool? success;
  MedicineDetailsData? data;
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

class MedicineDetailsData {
  MedicineDetailsData({
    this.medicines,
    this.totalMedicines,
    this.totalMedicinePrice,
    this.limit,
    this.page,
    this.totalcounts,
  });

  MedicineDetailsData.fromJson(Map<String, dynamic> json) {
    if (json["medicines"] != null) {
      medicines = <Medicines>[];
      for (final dynamic v in json["medicines"] as List<dynamic>) {
        medicines!.add(Medicines.fromJson(v));
      }
    }
    totalMedicines = json["totalMedicines"];
    totalMedicinePrice = json["totalMedicinePrice"];
    limit = json["limit"];
    page = json["page"];
    totalcounts = json["totalcounts"];
  }

  List<Medicines>? medicines;
  int? totalMedicines;
  int? totalMedicinePrice;
  int? limit;
  int? page;
  int? totalcounts;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (medicines != null) {
      data["medicines"] = medicines!.map((Medicines v) => v.toJson()).toList();
    }
    data["totalMedicines"] = totalMedicines;
    data["totalMedicinePrice"] = totalMedicinePrice;
    data["limit"] = limit;
    data["page"] = page;
    data["totalcounts"] = totalcounts;
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
  Medicine({this.sId, this.name, this.description, this.brand, this.photo});

  Medicine.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    name = json["name"];
    description = json["description"];
    brand = json["brand"];
    photo = json["photo"];
  }

  String? sId;
  String? name;
  String? description;
  String? brand;
  String? photo;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["name"] = name;
    data["description"] = description;
    data["brand"] = brand;
    data["photo"] = photo;
    return data;
  }
}
