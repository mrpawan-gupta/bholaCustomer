import "package:pinput/pinput.dart";
import "package:smart_auth/smart_auth.dart";

class AppSMSRetrieverImplementation implements SmsRetriever {
  @override
  Future<String?> getSmsCode() async {
    final SmsCodeResult result = await SmartAuth().getSmsCode();

    return result.code;
  }

  @override
  Future<void> dispose() async {
    await SmartAuth().removeSmsListener();
  }

  @override
  bool get listenForMultipleSms => false;
}
