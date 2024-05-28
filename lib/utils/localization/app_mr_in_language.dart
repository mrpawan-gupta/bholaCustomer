// ignore_for_file: lines_longer_than_80_chars

import "package:customer/utils/localization/app_language_keys.dart";

class MrLanguage {
  factory MrLanguage() {
    return _singleton;
  }

  MrLanguage._internal();
  static final MrLanguage _singleton = MrLanguage._internal();

  Map<String, String> appMrINLanguage = <String, String>{
    AppLanguageKeys().strHelloWorld: "हैलो वर्ल्ड",
    AppLanguageKeys().strWelcomeToBhola: "भोला स्वागत",
    AppLanguageKeys().strChooseYourLanguage: "तुमची भाषा निवडा",
    AppLanguageKeys().strContinue: "सुरू",
    AppLanguageKeys().strBySigning:
        "साइन अप करून, मी अटी आणि नियम आणि गोपनीयता धोरणाशी सहमत आहे.",
    AppLanguageKeys().strTurnOnNotifications: "सूचना आणि स्थान चालू करा",
    AppLanguageKeys().strDontMissOut:
        "महत्त्वाचे संदेश, सूचना आणि इतर खाते क्रियाकलाप चुकवू नका.",
    AppLanguageKeys().strOkay: "ठीक आहे",
    AppLanguageKeys().strEnterYourPhoneNumber: "तुमचा फोन नंबर एंटर करा",
    AppLanguageKeys().strAConfirmationCode:
        "ॲपशी कनेक्ट होण्यासाठी तुमच्या नंबरवर एक पुष्टीकरण कोड पाठवला जाईल.",
    AppLanguageKeys().strEnter6Digits:
        "आम्ही तुम्हाला पाठवलेला 6 अंकी कोड एंटर करा",
    AppLanguageKeys().strResend: "पुन्हा पाठवा",
    AppLanguageKeys().strTermsAndConditions: "अटी व शर्ती",
    AppLanguageKeys().strTheseTermsAndConditions:
        "या अटी आणि शर्ती Website.com वर असलेल्या कंपनीच्या नावाच्या वेबसाइटच्या वापरासाठी नियम आणि नियमांची रूपरेषा दर्शवितात.\n\nया वेबसाइटवर प्रवेश करून आम्ही असे गृहीत धरतो की तुम्ही या अटी व शर्ती स्वीकारता. आपण या पृष्ठावर नमूद केलेल्या सर्व अटी व शर्ती स्वीकारण्यास सहमत नसल्यास वेबसाइटचे नाव वापरणे सुरू ठेवू नका.",
    AppLanguageKeys().strVendorAgreement: "विक्रेता करार",
    AppLanguageKeys().strTapToExpand: "विस्तृत करण्यासाठी टॅप करा",
    AppLanguageKeys().strAgreeTermsAndConditions:
        "मी अटी, शर्ती आणि करारांना सहमती देतो",
    AppLanguageKeys().strAgreePrivacyPolicy: "मी गोपनीयता धोरणाशी सहमत आहे",
    AppLanguageKeys().strNext: "पुढे",
    AppLanguageKeys().strFillInYourProfile: "तुमचे प्रोफाइल भरा",
    AppLanguageKeys().strFirstName: "पहिले नाव",
    AppLanguageKeys().strLastName: "आडनाव",
    AppLanguageKeys().strEmail: "ईमेल",
    AppLanguageKeys().strOptional: "ऐच्छिक",
    AppLanguageKeys().strFewStepsMore: "आणखी काही पावले",
    AppLanguageKeys().strAadharCardNo: "आधार कार्ड क्र",
    AppLanguageKeys().strPanCardNo: "पॅन कार्ड क्र",
    AppLanguageKeys().strActionPerform: "कृती करा",
    AppLanguageKeys().strCamera: "कॅमेरा",
    AppLanguageKeys().strPhotoLibrary: "फोटो लायब्ररी",
    AppLanguageKeys().strHello: "नमस्कार",
  };
}
