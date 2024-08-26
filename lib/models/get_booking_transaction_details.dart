class GetBookingTransactionDetails {
  GetBookingTransactionDetails({
    this.success,
    this.data,
    this.statusCode,
    this.message,
  });

  GetBookingTransactionDetails.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data = json["data"] != null
        ? TransactionDetailsData.fromJson(json["data"])
        : null;
    statusCode = json["statusCode"];
    message = json["message"];
  }

  bool? success;
  TransactionDetailsData? data;
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

class TransactionDetailsData {
  TransactionDetailsData({
    this.transaction,
    this.amount,
    this.status,
    this.transactionTime = "2001-01-01T00:00:00.000Z",
  });

  TransactionDetailsData.fromJson(Map<String, dynamic> json) {
    transaction = json["transaction"];
    amount = json["amount"];
    status = json["status"];
    transactionTime = json["transactionTime"];
  }

  String? transaction;
  num? amount;
  String? status;
  String? transactionTime;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["transaction"] = transaction;
    data["amount"] = amount;
    data["status"] = status;
    data["transactionTime"] = transactionTime;
    return data;
  }
}
