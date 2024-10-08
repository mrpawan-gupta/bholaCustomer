// ignore_for_file: lines_longer_than_80_chars

import "package:customer/utils/app_assets_lotties.dart";

class AppConstants {
  factory AppConstants() {
    return _singleton;
  }

  AppConstants._internal();
  static final AppConstants _singleton = AppConstants._internal();

  final double elevation = 0.0;
  final Duration duration = const Duration(seconds: 4);

  final String googleMapAPIKey = "AIzaSyAu0uQwt1solBKGQcExM9eJvU8rEPfbNNo";
  final String vpnAPIKey = "40f6cdcbaf9b4c139d4a276b9788dee6";
  final String whatsAppNumber = "+919765716231";

  final bool isEnabledBackendUpdateLocInfo = false;
  final bool isEnabledFirestoreUpdateLocInfo = false;
  final bool isEnabledFirestoreUpdatePkgInfo = false;
  final bool isEnabledFirestoreUpdateDevInfo = false;

  final Duration locationFetchDuration = const Duration(minutes: 5);

  final bool isEnabledReviewNotificationPermInHome = true;
  final bool isEnabledReviewLocationPermInHome = false;

  final String samplePDFThumb =
      "https://drive.usercontent.google.com/u/0/uc?id=1lANuruz2k7cpKGxLz4aIf2w7PtA153qO&export=pdf";
  final String samplePDFView =
      "https://drive.google.com/file/d/1lANuruz2k7cpKGxLz4aIf2w7PtA153qO/view";
  final String sampleImg =
      "https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTExL3BmLXMxMDgtcG0tNDExMy1tb2NrdXAuanBn.jpg";

  final String appURLsFeedbackForm = "https://forms.gle/4AwQFH9u5fnKutKU8";

  final String appURLsHomePage = "https://www.bhola.org.in/";
  final String appURLsAboutUs = "https://www.bhola.org.in/about-us/";
  final String appURLsPrivacyPolicy = "https://www.bhola.org.in/privacy/";
  final String appURLsRefundPolicy = "https://www.bhola.org.in/refund/";
  final String appURLsTAndCCustomer = "https://www.bhola.org.in/customer/";
  final String appURLsTAndCVendor = "https://www.bhola.org.in/vendor/";
  final String appURLsShippingPolicy = "https://www.bhola.org.in/shipping/";
  final String appURLsInstagram = "www.instagram.com/bhola_ahinsa";
  final String appURLsYoutube = "www.youtube.com/@bholatutorials";
  final String appURLsOfficeAddress = "maps.app.goo.gl/haoqFWgYBPMQmfNf8";

  final String pkgOfAdmin = "com.ahinsaaggregator.admin";
  final String pkgOfCustomer = "com.ahinsaaggregator.customer";
  final String pkgOfPartner = "com.ahinsaaggregator.partner";

  final String idOfAdmin = "284882215";
  final String idOfCustomer = "284882215";
  final String idOfPartner = "284882215";

  // Customer:
  final String custNotificationLottie = AppAssetsLotties().lottieNotification;
  final String custNotificationTitle = "Stay Updated with Bhola !!!";
  final String custNotificationBody =
      "Stay in the loop with real-time updates on your order status, new offers, personalized solutions, app updates, and more. To ensure you don't miss any important notifications, please enable notification access for Bhola.";

  final String custLocationLottie = AppAssetsLotties().lottieLocation;
  final String custLocationTitle = "Enable Location Services for Bhola";
  final String custLocationBody =
      "To help you select your farm location with ease and connect you with the nearest vendors, please enable location services for Bhola at all times. Bhola will use your location data in the background to provide you with the most relevant services based on your longitude and latitude.";

  final String custCamMicStorageLottie = AppAssetsLotties().lottieCamera;
  final String custCamMicStorageTitle = "Enhance Your Bhola Experience";
  final String custCamMicStorageBody =
      "Allow Bhola access to your gallery, camera, and microphone to personalize your profile, post reviews, and more. This enables you to add a profile picture and share your experiences with ease.";

  // Vendor:
  final String vendNotificationLottie = AppAssetsLotties().lottieNotification;
  final String vendNotificationTitle = "Stay Updated with Bhola !!!";
  final String vendNotificationBody =
      "Keep track of new orders, order statuses, offers, payment updates, app updates, and more. Enable notification access for Bhola to stay informed and never miss out on important updates.";

  final String vendLocationLottie = AppAssetsLotties().lottieLocation;
  final String vendLocationTitle = "Enable Location Services for Bhola";
  final String vendLocationBody =
      "To accurately select your equipment or shop location and connect effectively with nearby customers, please ensure that location permissions and services are enabled for Bhola at all times. Bhola utilizes your location data, both in the foreground and background, to match you with relevant customers based on your coordinates. This enables your business to find and engage with nearby customers more efficiently, enhancing service delivery and potentially increasing customer satisfaction and sales. For more information, please refer to our privacy policy below.";

  final String vendCamMicStorageLottie = AppAssetsLotties().lottieCamera;
  final String vendCamMicStorageTitle = "Optimize Your Bhola Profile";
  final String vendCamMicStorageBody =
      "Allow Bhola access to your gallery, camera, and microphone to enhance your profile, post reviews, submit KYC documents, and upload new product pictures. This helps you manage your profile and business efficiently.";

  final String commonNote =
      "Note: Your privacy and security are our top priorities. All data collected is used solely to improve your experience with Bhola.";

  final String disclosureForNotification =
      "Prominent Disclosure for Notification Permission";
  final String disclosureForLocation =
      "Prominent Disclosure for Location Permission";
  final String disclosureForCamMicStorage =
      "Prominent Disclosure for Cam, Mic & Storage Permission";
}
