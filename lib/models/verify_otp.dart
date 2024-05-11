class VerifyOTPModel {
  VerifyOTPModel({this.success, this.data, this.statusCode, this.message});

  VerifyOTPModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data =
        json["data"] != null ? VerifyOTPModelData.fromJson(json["data"]) : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }
  bool? success;
  VerifyOTPModelData? data;
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

class VerifyOTPModelData {
  VerifyOTPModelData({
    this.sId,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.role,
    this.agreementStatus,
    this.token,
    this.currentLattitude,
    this.currentLongitude,
    this.isNewUser,
  });

  VerifyOTPModelData.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    phoneNumber = json["phoneNumber"];
    email = json["email"];
    role = json["role"];
    agreementStatus = json["agreement_status"];
    token = json["token"];
    currentLattitude = json["current_lattitude"];
    currentLongitude = json["current_longitude"];
    isNewUser = json["isNewUser"];
  }
  String? sId;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? role;
  bool? agreementStatus;
  String? token;
  num? currentLattitude;
  num? currentLongitude;
  bool? isNewUser;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data["phoneNumber"] = phoneNumber;
    data["email"] = email;
    data["role"] = role;
    data["agreement_status"] = agreementStatus;
    data["token"] = token;
    data["current_lattitude"] = currentLattitude;
    data["current_longitude"] = currentLongitude;
    data["isNewUser"] = isNewUser;
    return data;
  }
}
