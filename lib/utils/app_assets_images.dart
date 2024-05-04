class AppAssetsImages {
  factory AppAssetsImages() {
    return _singleton;
  }

  AppAssetsImages._internal();
  static final AppAssetsImages _singleton = AppAssetsImages._internal();

  final String iconFlutter = "assets/images/icon_flutter.png";
}
