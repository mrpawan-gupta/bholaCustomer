// ignore_for_file: lines_longer_than_80_chars

import "package:customer/utils/localization/app_language_keys.dart";

class EnLanguage {
  factory EnLanguage() {
    return _singleton;
  }

  EnLanguage._internal();
  static final EnLanguage _singleton = EnLanguage._internal();

  Map<String, String> appEnINLanguage = <String, String>{
    AppLanguageKeys().strHelloWorld: "Hello World",
    AppLanguageKeys().strWelcomeToBhola: "Welcome to Bhola",
    AppLanguageKeys().strChooseYourLanguage: "Choose Your Language",
    AppLanguageKeys().strContinue: "Continue",
    AppLanguageKeys().strBySigning:
        "By signing up, I agree to the Terms and Conditions and Privacy Policy.",
    AppLanguageKeys().strTurnOnNotifications:
        "Turn on notifications and location",
    AppLanguageKeys().strDontMissOut:
        "Don't miss out on important messages, notifications and other account activities.",
    AppLanguageKeys().strOkay: "Okay",
    AppLanguageKeys().strEnterYourPhoneNumber: "Enter your phone number",
    AppLanguageKeys().strAConfirmationCode:
        "A confirmation code will be sent to your number to connect with the app.",
    AppLanguageKeys().strEnter6Digits: "Enter 6 digit code we have sent you on",
    AppLanguageKeys().strResend: "Resend",
    AppLanguageKeys().strTermsAndConditions: "Terms & Conditions",
    AppLanguageKeys().strTheseTermsAndConditions:
        "These terms and conditions outline the rules and regulations for the use of Company Name's Website, located at Website.com.\n\nBy accessing this website we assume you accept these terms and conditions. Do not continue to use Website Name if you do not agree to take all of the terms and conditions stated on this page.",
    AppLanguageKeys().strVendorAgreement: "Vendor agreement",
    AppLanguageKeys().strTapToExpand: "Tap to expand",
    AppLanguageKeys().strAgreeTermsAndConditions:
        "I agree to Terms and Conditions",
    AppLanguageKeys().strAgreePrivacyPolicy: "I agree to Privacy Policy",
    AppLanguageKeys().strNext: "Next",
    AppLanguageKeys().strFillInYourProfile: "Fill In Your Profile",
    AppLanguageKeys().strFirstName: "First Name",
    AppLanguageKeys().strLastName: "Last Name",
    AppLanguageKeys().strEmail: "Email",
    AppLanguageKeys().strOptional: "Optional",
    AppLanguageKeys().strFewStepsMore: "Few Steps More",
    AppLanguageKeys().strAadharCardNo: "Aadhar Card No",
    AppLanguageKeys().strPanCardNo: "PAN Card No",
    AppLanguageKeys().strActionPerform: "Action Perform",
    AppLanguageKeys().strCamera: "Camera",
    AppLanguageKeys().strPhotoLibrary: "Photo Library",
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
    AppLanguageKeys().strText1:
        "In addition to being a major source of starch and energy,"
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
    AppLanguageKeys().strText2:
        "In addition to being a major source of starch and energy, "
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
    AppLanguageKeys().strProceeding: "By proceeding, you agree to the ",
    AppLanguageKeys().strCondition: "Terms & Conditions",
    AppLanguageKeys().strAnd: " and ",
    AppLanguageKeys().strPrivacyPolicy: "Privacy Policy",
    AppLanguageKeys().strBuild: "Build for Bhola Family",
    AppLanguageKeys().strAmuldhan: "Amuldhan",
    AppLanguageKeys().str50Kg: "50Kg",
    AppLanguageKeys().strSave: "Save",
    AppLanguageKeys().strInter: "Inter",
    AppLanguageKeys().strAddProductDetails: "Add Product Details",
    AppLanguageKeys().strCategories: "Categories",
    AppLanguageKeys().strCattleFeed: "CattleFeed",
    AppLanguageKeys().strNursery: "Nursery",
    AppLanguageKeys().strFertilizer: "Fertilizer",
    AppLanguageKeys().strName: "Name",
    AppLanguageKeys().strSearchname: "Search name",
    AppLanguageKeys().strLiveOrderPending: "Live Order Pending",
    AppLanguageKeys().strContact: "Contact",
    AppLanguageKeys().strAddress: "Address",
    AppLanguageKeys().strBillAmount: "Bill Amount",
    AppLanguageKeys().strAshutoshPatil: "Ashutosh Patil",
    AppLanguageKeys().str8866725361: "8866725361",
    AppLanguageKeys().strMumabiMaharashtra: "Mumbai,Maharashtra",
    AppLanguageKeys().str5200: "5200",
    AppLanguageKeys().str5July2024: "5 July,2024",
    AppLanguageKeys().strKolhapur: "strKolhapur",
    AppLanguageKeys().str8July2024: "8 July,2024",
    AppLanguageKeys().strDhule: "Dhule",
    AppLanguageKeys().strWorkinProgress: "Work in Progress",
    AppLanguageKeys().strRotavator: "Rotavator",
    AppLanguageKeys().strCultivator: "Cultivator",
    AppLanguageKeys().strQuantity: "Quantity",
    AppLanguageKeys().strMRP: "MRP",
    AppLanguageKeys().strSellingPrice: "Selling Price",
    AppLanguageKeys().strAddVehicleDetails: "Add Vehicle Details",
    AppLanguageKeys().strVehicleImage: "Vehicle Image",
    AppLanguageKeys().strVehicleVideo: "Vehicle Video",
    AppLanguageKeys().strVehicleRC: "Vehicle RC",
    AppLanguageKeys().strSearchhere: "Search here...",
    AppLanguageKeys().strService: "Service",
    AppLanguageKeys().strPriceAcre: "Price/Acre",
    AppLanguageKeys().strSelectCategory: "Select Category",
    AppLanguageKeys().strVehicle: "Vehicle",
    AppLanguageKeys().strAdd: "Add",
    AppLanguageKeys().strProducts: "Products",
    AppLanguageKeys().strDescription: "Description",
    AppLanguageKeys().strEdit: "Edit",
    AppLanguageKeys().strLoreumipsumissimplydummy:
        "Loreum ipsum is simply dummy",
    AppLanguageKeys().str2minago: "2 min ago",
    AppLanguageKeys().strGayatrijadhav: "Gayatri jadhav",
    AppLanguageKeys().strArinvaMarium: "Arinva Marium",
    AppLanguageKeys().strViewMore: "View More",
    AppLanguageKeys().strReviews: "Reviews",
    AppLanguageKeys().strSale: "Sale",
    AppLanguageKeys().strpeoplesavethisproduct: "people save this product",
    AppLanguageKeys().strProductHighlights: "Product Highlights",
    AppLanguageKeys().strMAHINDRATRACTOR: "MAHINDRA TRACTOR",
    AppLanguageKeys().strViewProductDetails: "View Product Details",
    AppLanguageKeys().strOFF: "OFF",
    AppLanguageKeys().strViewVehicleDetails: "View Vehicle Details",
    AppLanguageKeys().strVehicleHighlights: "Vehicle Highlights",
    AppLanguageKeys().strpeoplesavethisvehicle: "people save this vehicle",
    AppLanguageKeys().strView: "View",
    AppLanguageKeys().strCompleted: "Completed",
    AppLanguageKeys().strLive: "Live",
    AppLanguageKeys().strVIEWORDER: "VIEW ORDER",
    AppLanguageKeys().strReviewRating: "Review Rating",
    AppLanguageKeys().strViewAll: "View All",
    AppLanguageKeys().strHelloDharam: " Hello, Dharam!",
    AppLanguageKeys().strFeaturedService: "Featured Service",
    AppLanguageKeys().strRecentlyAddedProduct: "Recently Added Product",
    AppLanguageKeys().strStartTime: "Start Time",
    AppLanguageKeys().strEndTime: "End Time",
  };
}
