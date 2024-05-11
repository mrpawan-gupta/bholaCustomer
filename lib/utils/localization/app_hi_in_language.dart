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
    AppLanguageKeys().strAmuldhan:"Amuldhan",
    AppLanguageKeys().str50Kg: "50Kg ",
    AppLanguageKeys().strSave:"Save",
    AppLanguageKeys().strInter:"Inter",
    AppLanguageKeys().strAddProductDetails:"Add Product Details",
    AppLanguageKeys().strCategories:"Categories",
    AppLanguageKeys().strCattleFeed:" Cattle Feed ",
    AppLanguageKeys().strNursery:"Nursery",
    AppLanguageKeys().strFertilizer:"Fertilizer",
    AppLanguageKeys().strName:"Name",
    AppLanguageKeys().strSearchname:"Search name ",
    AppLanguageKeys().strLiveOrderPending:" Live Order Pending",
    AppLanguageKeys().strContact:"Contact",
    AppLanguageKeys().strAddress:"Address",
    AppLanguageKeys().strBillAmount:" Bill Amount",
    AppLanguageKeys().strAshutoshPatil:"Ashutosh Patil",
    AppLanguageKeys().str8866725361:"8866725361",
    AppLanguageKeys().strMumabiMaharashtra:"Mumabi ,Maharashtra",
    AppLanguageKeys().str5200:"5200",
    AppLanguageKeys().str5July2024:"5 July,2024",
    AppLanguageKeys().strKolhapur:"strKolhapur",
    AppLanguageKeys().str8July2024:"8 July,2024",
    AppLanguageKeys().strDhule :"Dhule",
    AppLanguageKeys().strWorkinProgress :"Work in Progress",
    AppLanguageKeys().strRotavator:"Rotavator",
    AppLanguageKeys().strCultivator :"Cultivator",
    AppLanguageKeys().strQuantity :"Quantity",
    AppLanguageKeys().strMRP:"MRP",
    AppLanguageKeys().strSellingPrice:"Selling Price",
    AppLanguageKeys().strAddVehicleDetails:"Add Vehicle Details",
    AppLanguageKeys().strVehicleImage:"Vehicle Image",
    AppLanguageKeys().strVehicleVideo:"Vehicle Video",
    AppLanguageKeys().strVehicleRC:"Vehicle RC",
    AppLanguageKeys().strSearchhere:"Search here...",
    AppLanguageKeys().strService:"Service",
    AppLanguageKeys().strPriceAcre:"Price/Acre",
    AppLanguageKeys().strSelectCategory:"Select Category",
    AppLanguageKeys().strVehicle :"Vehicle",
    AppLanguageKeys().strAdd:"Add",
    AppLanguageKeys().strProducts:"Products",
    AppLanguageKeys().strDescription:"Description",
    AppLanguageKeys().strEdit:"Edit",
    AppLanguageKeys().strLoreumipsumissimplydummy:"Loreum ipsum is simply dummy",
    AppLanguageKeys().str2minago:"2 min ago",
    AppLanguageKeys().strGayatrijadhav:"Gayatri jadhav",
    AppLanguageKeys().strArinvaMarium:"Arinva Marium",
    AppLanguageKeys().strViewMore:"View More",
    AppLanguageKeys().strReviews:"Reviews",
    AppLanguageKeys().strSale:"Sale",
    AppLanguageKeys().strpeoplesavethisproduct:"people save this product",
    AppLanguageKeys().strProductHighlights:"Product Highlights",
    AppLanguageKeys().strMAHINDRATRACTOR:"MAHINDRA TRACTOR",
    AppLanguageKeys().strViewProductDetails:"View Product Details",
    AppLanguageKeys().strOFF :"OFF",
    AppLanguageKeys().strViewVehicleDetails:"View Vehicle Details",
    AppLanguageKeys().strVehicleHighlights:"Vehicle Highlights",
    AppLanguageKeys().strpeoplesavethisvehicle:"people save this vehicle",
    AppLanguageKeys().strView :"View",
    AppLanguageKeys().strCompleted:"Completed",
    AppLanguageKeys().strLive:"Live",
    AppLanguageKeys().strVIEWORDER :"VIEW ORDER",
    AppLanguageKeys().strReviewRating :"Review Rating",
    AppLanguageKeys().strViewAll:"View All",
    AppLanguageKeys().strHelloDharam:" Hello, Dharam!",
    AppLanguageKeys().strFeaturedService:"Featured Service",
    AppLanguageKeys().strRecentlyAddedProduct:"Recently Added Product",

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
    AppLanguageKeys().strEnter4Digits: "Enter 4 digit code we have sent you on",
    AppLanguageKeys().strResend: "पुन: भेजें",
    AppLanguageKeys().strTermsAndConditions: "नियम एवं शर्तें",
    AppLanguageKeys().strTheseTermsAndConditions:
        "ये नियम और शर्तें वेबसाइट.कॉम पर स्थित कंपनी नाम की वेबसाइट के उपयोग के लिए नियमों और विनियमों को रेखांकित करती हैं।\n\nइस वेबसाइट तक पहुंचने पर हम मानते हैं कि आप इन नियमों और शर्तों को स्वीकार करते हैं। यदि आप इस पृष्ठ पर बताए गए सभी नियमों और शर्तों को मानने से सहमत नहीं हैं तो वेबसाइट नाम का उपयोग जारी न रखें।",
    AppLanguageKeys().strVendorAgreement: "विक्रेता समझौता",
    AppLanguageKeys().strTapToExpand: "विस्तार करने के लिए टैप करें",
    AppLanguageKeys().strAgreeTermsAndConditions: "नियमों और शर्तों पर सहमत",
    AppLanguageKeys().strAgreePrivacyPolicy: "मैं निजता नीति से सहमत हूं",
  };
}
