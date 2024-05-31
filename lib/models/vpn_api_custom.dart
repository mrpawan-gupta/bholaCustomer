class VPNAPICustom {
  VPNAPICustom({this.success, this.data, this.statusCode, this.message});
  
  VPNAPICustom.fromJson(Map<String, dynamic> json) {
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
  Data({
    this.city,
    this.region,
    this.country,
    this.continent,
    this.regionCode,
    this.countryCode,
    this.continentCode,
    this.latitude,
    this.longitude,
    this.timeZone,
    this.localeCode,
    this.metroCode,
    this.isInEuropeanUnion,
  });

  Data.fromJson(Map<String, dynamic> json) {
    city = json["city"];
    region = json["region"];
    country = json["country"];
    continent = json["continent"];
    regionCode = json["region_code"];
    countryCode = json["country_code"];
    continentCode = json["continent_code"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    timeZone = json["time_zone"];
    localeCode = json["locale_code"];
    metroCode = json["metro_code"];
    isInEuropeanUnion = json["is_in_european_union"];
  }

  String? city;
  String? region;
  String? country;
  String? continent;
  String? regionCode;
  String? countryCode;
  String? continentCode;
  String? latitude;
  String? longitude;
  String? timeZone;
  String? localeCode;
  String? metroCode;
  bool? isInEuropeanUnion;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["city"] = city;
    data["region"] = region;
    data["country"] = country;
    data["continent"] = continent;
    data["region_code"] = regionCode;
    data["country_code"] = countryCode;
    data["continent_code"] = continentCode;
    data["latitude"] = latitude;
    data["longitude"] = longitude;
    data["time_zone"] = timeZone;
    data["locale_code"] = localeCode;
    data["metro_code"] = metroCode;
    data["is_in_european_union"] = isInEuropeanUnion;
    return data;
  }
}
