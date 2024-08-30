class GetUserById {
  GetUserById({this.success, this.data, this.statusCode, this.message});

  GetUserById.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data = json["data"] != null ? GetUserByIdData.fromJson(json["data"]) : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }

  bool? success;
  GetUserByIdData? data;
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

class GetUserByIdData {
  GetUserByIdData({
    this.sId,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.email,
    this.approvalStatus,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.profile,
    this.deletedAt,
    this.currentLattitude,
    this.currentLongitude,
    this.language,
    this.isActive,
    this.joiningDate,
    this.lastLogin,
    this.role,
  });

  GetUserByIdData.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    phoneNumber = json["phoneNumber"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
    approvalStatus = json["approval_status"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    iV = json["__v"];
    profile =
        json["profile"] != null ? Profile.fromJson(json["profile"]) : null;
    deletedAt = json["deletedAt"];
    currentLattitude = json["current_lattitude"];
    currentLongitude = json["current_longitude"];
    language = json["language"];
    isActive = json["isActive"];
    joiningDate = json["joiningDate"];
    lastLogin = json["lastLogin"];
    role = json["role"];
  }

  String? sId;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? email;
  String? approvalStatus;
  String? createdAt;
  String? updatedAt;
  num? iV;
  Profile? profile;
  String? deletedAt;
  num? currentLattitude;
  num? currentLongitude;
  String? language;
  bool? isActive;
  String? joiningDate;
  String? lastLogin;
  String? role;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["phoneNumber"] = phoneNumber;
    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data["email"] = email;
    data["approval_status"] = approvalStatus;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = iV;
    if (profile != null) {
      data["profile"] = profile!.toJson();
    }
    data["deletedAt"] = deletedAt;
    data["current_lattitude"] = currentLattitude;
    data["current_longitude"] = currentLongitude;
    data["language"] = language;
    data["isActive"] = isActive;
    data["joiningDate"] = joiningDate;
    data["lastLogin"] = lastLogin;
    data["role"] = role;
    return data;
  }
}

class Profile {
  Profile({
    this.sId,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.aadharCardNumber,
    this.aadharCardPhoto,
    this.panCardNumber,
    this.panCardPhoto,
    this.profilePhoto,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    user = json["user"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    iV = json["__v"];
    aadharCardNumber = json["aadharCardNumber"];
    aadharCardPhoto = json["aadharCardPhoto"];
    panCardNumber = json["panCardNumber"];
    panCardPhoto = json["panCardPhoto"];
    profilePhoto = json["profilePhoto"];
  }

  String? sId;
  String? user;
  String? createdAt;
  String? updatedAt;
  num? iV;
  String? aadharCardNumber;
  String? aadharCardPhoto;
  String? panCardNumber;
  String? panCardPhoto;
  String? profilePhoto;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["user"] = user;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = iV;
    data["aadharCardNumber"] = aadharCardNumber;
    data["aadharCardPhoto"] = aadharCardPhoto;
    data["panCardNumber"] = panCardNumber;
    data["panCardPhoto"] = panCardPhoto;
    data["profilePhoto"] = profilePhoto;
    return data;
  }
}
