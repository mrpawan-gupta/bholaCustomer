class AddMedicineToBookingModel {
  AddMedicineToBookingModel({
    this.success,
    this.data,
    this.statusCode,
    this.message,
  });

  AddMedicineToBookingModel.fromJson(Map<String, dynamic> json) {
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
  Data({this.medicines});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["medicines"] != null) {
      medicines = <Medicines>[];
      for (final dynamic v in json["medicines"] as List<dynamic>) {
        medicines!.add(Medicines.fromJson(v));
      }
    }
  }
  List<Medicines>? medicines;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (medicines != null) {
      data["medicines"] = medicines!.map((Medicines v) => v.toJson()).toList();
    }
    return data;
  }
}

class Medicines {
  Medicines({this.medicine, this.quantity, this.totalPrice, this.sId});

  Medicines.fromJson(Map<String, dynamic> json) {
    medicine = json["medicine"];
    quantity = json["quantity"];
    totalPrice = json["totalPrice"];
    sId = json["_id"];
  }
  String? medicine;
  num? quantity;
  num? totalPrice;
  String? sId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["medicine"] = medicine;
    data["quantity"] = quantity;
    data["totalPrice"] = totalPrice;
    data["_id"] = sId;
    return data;
  }
}
