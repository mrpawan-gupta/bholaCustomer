class AppAssetsLotties {
  factory AppAssetsLotties() {
    return _singleton;
  }

  AppAssetsLotties._internal();

  static final AppAssetsLotties _singleton = AppAssetsLotties._internal();

  final String lottieCamera = "assets/lotties/lottie_camera.json";
  final String lottieLocation = "assets/lotties/lottie_location.json";
  final String lottieNotification = "assets/lotties/lottie_notification.json";
}
