class PhonePeReqModel {
  PhonePeReqModel({
    this.merchantId,
    this.merchantTransactionId,
    this.merchantUserId,
    this.amount,
    this.redirectUrl,
    this.redirectMode,
    this.callbackUrl,
    this.mobileNumber,
    this.paymentInstrument,
  });

  PhonePeReqModel.fromJson(Map<String, dynamic> json) {
    merchantId = json["merchantId"];
    merchantTransactionId = json["merchantTransactionId"];
    merchantUserId = json["merchantUserId"];
    amount = json["amount"];
    redirectUrl = json["redirectUrl"];
    redirectMode = json["redirectMode"];
    callbackUrl = json["callbackUrl"];
    mobileNumber = json["mobileNumber"];
    paymentInstrument = json["paymentInstrument"] != null
        ? PaymentInstrument.fromJson(json["paymentInstrument"])
        : null;
  }

  String? merchantId;
  String? merchantTransactionId;
  String? merchantUserId;
  int? amount;
  String? redirectUrl;
  String? redirectMode;
  String? callbackUrl;
  String? mobileNumber;
  PaymentInstrument? paymentInstrument;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["merchantId"] = merchantId;
    data["merchantTransactionId"] = merchantTransactionId;
    data["merchantUserId"] = merchantUserId;
    data["amount"] = amount;
    data["redirectUrl"] = redirectUrl;
    data["redirectMode"] = redirectMode;
    data["callbackUrl"] = callbackUrl;
    data["mobileNumber"] = mobileNumber;
    if (paymentInstrument != null) {
      data["paymentInstrument"] = paymentInstrument!.toJson();
    }
    return data;
  }
}

class PaymentInstrument {
  PaymentInstrument({this.type});

  PaymentInstrument.fromJson(Map<String, dynamic> json) {
    type = json["type"];
  }

  String? type;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["type"] = type;
    return data;
  }
}
