// ignore_for_file: lines_longer_than_80_chars

import "package:customer/utils/localization/app_language_keys.dart";

class HiLanguage {
  factory HiLanguage() {
    return _singleton;
  }

  HiLanguage._internal();
  static final HiLanguage _singleton = HiLanguage._internal();

  Map<String, String> appHiINLanguage = <String, String>{
    AppLanguageKeys().strHelloWorld: "HelloWorld",
    AppLanguageKeys().strWelcomeToBhola: "भोला में आपका स्वागत है",
    AppLanguageKeys().strChooseYourLanguage: "अपनी भाषा चुनें",
    AppLanguageKeys().strContinue: "जारी रखें",
    AppLanguageKeys().strBySigning:
        "साइन अप करके, मैं नियम और शर्तों और गोपनीयता नीति से सहमत हूं।",
    AppLanguageKeys().strTurnOnNotifications: "सूचनाएं और स्थान चालू करें",
    AppLanguageKeys().strDontMissOut:
        "महत्वपूर्ण संदेशों, सूचनाओं और अन्य खाता गतिविधियों से न चूकें।",
    AppLanguageKeys().strOkay: "ठीक है",
    AppLanguageKeys().strEnterYourPhoneNumber: "अपना फोन नंबर डालें",
    AppLanguageKeys().strAConfirmationCode:
        "ऐप से जुड़ने के लिए आपके नंबर पर एक पुष्टिकरण कोड भेजा जाएगा।",
    AppLanguageKeys().strEnter6Digits: "Enter 6 digit code we have sent you on",
    AppLanguageKeys().strResend: "पुन: भेजें",
    AppLanguageKeys().strTermsAndConditions: "नियम एवं शर्तें",
    AppLanguageKeys().strTheseTermsAndConditions:
        "ये नियम और शर्तें वेबसाइट.कॉम पर स्थित कंपनी नाम की वेबसाइट के उपयोग के लिए नियमों और विनियमों को रेखांकित करती हैं।\n\nइस वेबसाइट तक पहुंचने पर हम मानते हैं कि आप इन नियमों और शर्तों को स्वीकार करते हैं। यदि आप इस पृष्ठ पर बताए गए सभी नियमों और शर्तों को मानने से सहमत नहीं हैं तो वेबसाइट नाम का उपयोग जारी न रखें।",
    AppLanguageKeys().strVendorAgreement: "विक्रेता समझौता",
    AppLanguageKeys().strTapToExpand: "विस्तार करने के लिए टैप करें",
    AppLanguageKeys().strAgreeTermsAndConditions: "नियमों और शर्तों पर सहमत",
    AppLanguageKeys().strAgreePrivacyPolicy: "मैं निजता नीति से सहमत हूं",
    AppLanguageKeys().strNext: "अगला",
    AppLanguageKeys().strFillInYourProfile: "अपना प्रोफ़ाइल भरें",
    AppLanguageKeys().strFirstName: "पहला नाम",
    AppLanguageKeys().strLastName: "उपनाम",
    AppLanguageKeys().strEmail: "ईमेल",
    AppLanguageKeys().strOptional: "वैकल्पिक",
    AppLanguageKeys().strFewStepsMore: "कुछ कदम और",
    AppLanguageKeys().strAadharCardNo: "आधार कार्ड नं",
    AppLanguageKeys().strPanCardNo: "पैन कार्ड नं",
    AppLanguageKeys().strActionPerform: "क्रिया प्रदर्शन",
    AppLanguageKeys().strCamera: "कैमरा",
    AppLanguageKeys().strPhotoLibrary: "चित्र पुस्तकालय",
    AppLanguageKeys().strBhola: "Bhola",
    AppLanguageKeys().strSearch: "Search here....",
    AppLanguageKeys().strTractor: "Tractor",
    AppLanguageKeys().strDrone: "Drone",
    AppLanguageKeys().strJCB: "JCB",
    AppLanguageKeys().strNashikIndia: "Nashik, India",
    AppLanguageKeys().strFriday: "Friday",
    AppLanguageKeys().strDegree: "26°",
    AppLanguageKeys().strSAT: "SAT",
    AppLanguageKeys().strDegree1: "29°",
    AppLanguageKeys().strSUN: "SUN",
    AppLanguageKeys().strDegree2: "23°",
    AppLanguageKeys().strMON: "MON",
    AppLanguageKeys().strDegree3: "25°",
    AppLanguageKeys().strTUE: "TUE",
    AppLanguageKeys().strWED: "WED",
    AppLanguageKeys().strDegree4: "29°",
    AppLanguageKeys().strDegree5: "28°",
    AppLanguageKeys().strTHU: "THU",
    AppLanguageKeys().strProduct: "Product",
    AppLanguageKeys().strCattleFeed: "Cattle Feed",
    AppLanguageKeys().strNursery: "Nursery",
    AppLanguageKeys().strFertilizer: "Fertilizer",
    AppLanguageKeys().strViewAll: "View All",
    AppLanguageKeys().strBajra: "Bajra",
    AppLanguageKeys().strGETOUOTE: "GET OUOTE",
    AppLanguageKeys().str15Acer: "15 Acer",
    AppLanguageKeys().strFarmArea: "Farm Arear",
    AppLanguageKeys().strSelect: "Please Select a Crop",
    AppLanguageKeys().strService: "Service",
    AppLanguageKeys().strNight: "Night",
    AppLanguageKeys().strEvening: "Evening",
    AppLanguageKeys().strAfternoon: "Afternoon",
    AppLanguageKeys().strMorning: "Morning",
    AppLanguageKeys().strSelect1: "Please Select a Date",
    AppLanguageKeys().strSchedule: "Schedule",
    AppLanguageKeys().strFarmLocation: "Farm Location",
    AppLanguageKeys().strBookService: "Book Service",
    AppLanguageKeys().strRent: "Rent will be",
    AppLanguageKeys().strSelectSlot: "Select Slot",
    AppLanguageKeys().strQuote: "Quote",
    AppLanguageKeys().strProceed: "Proceed T0 Payment",
    AppLanguageKeys().strView: "View Details",
    AppLanguageKeys().strFree: "Free",
    AppLanguageKeys().strOrder: "Order Total",
    AppLanguageKeys().strApply: "Apply Coupon",
    AppLanguageKeys().strDelivery: "Delivery Fee",
    AppLanguageKeys().strKnow: "Know More",
    AppLanguageKeys().strConvenience: "Convenience",
    AppLanguageKeys().strOrderAmount: "Order Amount",
    AppLanguageKeys().strDetails: "Order Payment Details",
    AppLanguageKeys().strCoupon: "Apply Coupon Code",
    AppLanguageKeys().strText: "Apollo Hospital Nashik, Plot No 1, Nashik, "
        "Maharashtra 422003, India",
    AppLanguageKeys().strDelete: "Delete",
    AppLanguageKeys().strShoppingBag: "Shopping Bag",
    AppLanguageKeys().strFarmTool: "Farm Tool",
    AppLanguageKeys().strDeliveryAddress: "Delivery Address",
    AppLanguageKeys().strRohan: "Rohan Patil",
    AppLanguageKeys().strAmul: "Amul Cattle Feed",
    AppLanguageKeys().strMRP: "MRP",
    AppLanguageKeys().strText1: "In addition to being a major source of starch "
        "and energy,"
        " wheat also provides substantial amounts of a number"
        " of components which are essential or beneficial for "
        "health, notably protein, vitamins "
        "(notably B vitamins), dietary fiber, "
        "and phytochemicals.",
    AppLanguageKeys().strReadLess: "Read Less",
    AppLanguageKeys().strReadMore: "Read More",
    AppLanguageKeys().strSuggested: "Suggested For You",
    AppLanguageKeys().strSeeAll: "See All",
    AppLanguageKeys().strHighlights: "Highlights",
    AppLanguageKeys().strKrishnaAgarwal: "Krishna Agarwal",
    AppLanguageKeys().strText2: "In addition to being a major "
        "source of starch and energy, "
        "wheat also provides substantial amounts of a number of"
        " components which are essential or beneficial for "
        "health, notabl, and phytochemicals.",
    AppLanguageKeys().strAdd: "Add to Cart",
    AppLanguageKeys().strPrice: "Price",
    AppLanguageKeys().strRatings: "Ratings & Review",
    AppLanguageKeys().strHighlight1: "Highlight 1",
    AppLanguageKeys().strHightlightDescription: "Hightlight description",
    AppLanguageKeys().strCrop: "Crop",
    AppLanguageKeys().strSlot: "Slot",
    AppLanguageKeys().strLivePending: "Live/Pending Order",
    AppLanguageKeys().strAshutoshPatil: "Ashutosh Patil",
    AppLanguageKeys().strAddress: "Nashik, Maharashtra",
    AppLanguageKeys().strLocation: "Nashik",
    AppLanguageKeys().strlocation2: "Dhule",
    AppLanguageKeys().strProgress: "Work In Progress",
    AppLanguageKeys().strName: "Name",
    AppLanguageKeys().strAddress1: "Address",
    AppLanguageKeys().strContact: "Contact",
    AppLanguageKeys().strBillAmount: "Bill/Amount",
  };
}
