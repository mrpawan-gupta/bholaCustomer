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

class TransactionDetailsData {
  TransactionDetailsData({
    this.sId,
    this.paymentGateway,
    this.transactionId,
    this.amount,
    this.status,
    this.currency,
    this.payerId,
    this.payeeId,
    this.transactionType,
    this.referenceNumber,
    this.fee,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.paymentDetails,
    this.transactionTime,
  });

  TransactionDetailsData.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    paymentGateway = json["paymentGateway"];
    transactionId = json["transactionId"];
    amount = json["amount"];
    status = json["status"];
    currency = json["currency"];
    payerId = json["payerId"];
    payeeId = json["payeeId"];
    transactionType = json["transactionType"];
    referenceNumber = json["referenceNumber"];
    fee = json["fee"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    iV = json["__v"];
    paymentDetails = json["paymentDetails"] != null
        ? PaymentDetails.fromJson(json["paymentDetails"])
        : null;
    transactionTime = json["transactionTime"];
  }

  String? sId;
  String? paymentGateway;
  String? transactionId;
  num? amount;
  String? status;
  String? currency;
  String? payerId;
  String? payeeId;
  String? transactionType;
  String? referenceNumber;
  num? fee;
  String? createdAt;
  String? updatedAt;
  int? iV;
  PaymentDetails? paymentDetails;
  String? transactionTime;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = sId;
    data["paymentGateway"] = paymentGateway;
    data["transactionId"] = transactionId;
    data["amount"] = amount;
    data["status"] = status;
    data["currency"] = currency;
    data["payerId"] = payerId;
    data["payeeId"] = payeeId;
    data["transactionType"] = transactionType;
    data["referenceNumber"] = referenceNumber;
    data["fee"] = fee;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = iV;
    if (paymentDetails != null) {
      data["paymentDetails"] = paymentDetails!.toJson();
    }
    data["transactionTime"] = transactionTime;
    return data;
  }
}

class PaymentDetails {
  PaymentDetails({
    this.transactionId,
    this.amount,
    this.state,
    this.responseCode,
    this.paymentInstrument,
  });

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    transactionId = json["transactionId"];
    amount = json["amount"];
    state = json["state"];
    responseCode = json["responseCode"];
    paymentInstrument = json["paymentInstrument"] != null
        ? PaymentInstrument.fromJson(json["paymentInstrument"])
        : null;
  }

  String? transactionId;
  num? amount;
  String? state;
  String? responseCode;
  PaymentInstrument? paymentInstrument;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["transactionId"] = transactionId;
    data["amount"] = amount;
    data["state"] = state;
    data["responseCode"] = responseCode;
    if (paymentInstrument != null) {
      data["paymentInstrument"] = paymentInstrument!.toJson();
    }
    return data;
  }
}

class PaymentInstrument {
  PaymentInstrument({
    this.type,
    this.pgTransactionId,
    this.pgServiceTransactionId,
    this.bankTransactionId,
    this.bankId,
  });

  PaymentInstrument.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    pgTransactionId = json["pgTransactionId"];
    pgServiceTransactionId = json["pgServiceTransactionId"];
    bankTransactionId = json["bankTransactionId"];
    bankId = json["bankId"];
  }

  String? type;
  String? pgTransactionId;
  String? pgServiceTransactionId;
  String? bankTransactionId;
  String? bankId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["type"] = type;
    data["pgTransactionId"] = pgTransactionId;
    data["pgServiceTransactionId"] = pgServiceTransactionId;
    data["bankTransactionId"] = bankTransactionId;
    data["bankId"] = bankId;
    return data;
  }
}
