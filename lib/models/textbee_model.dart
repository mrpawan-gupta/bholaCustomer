class TextbeeModel {
  TextbeeModel({this.data});

  TextbeeModel.fromJson(Map<String, dynamic> json) {
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Data? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data["data"] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Data({this.responses, this.successCount, this.failureCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["responses"] != null) {
      responses = <Responses>[];
      for (final dynamic v in json["responses"] as List<dynamic>) {
        responses!.add(Responses.fromJson(v));
      }
    }
    successCount = json["successCount"];
    failureCount = json["failureCount"];
  }

  List<Responses>? responses;
  int? successCount;
  int? failureCount;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (responses != null) {
      data["responses"] = responses!.map((Responses v) => v.toJson()).toList();
    }
    data["successCount"] = successCount;
    data["failureCount"] = failureCount;
    return data;
  }
}

class Responses {
  Responses({this.success, this.messageId});

  Responses.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    messageId = json["messageId"];
  }

  bool? success;
  String? messageId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["success"] = success;
    data["messageId"] = messageId;
    return data;
  }
}
