class AppConstants {
  factory AppConstants() {
    return _singleton;
  }

  AppConstants._internal();
  static final AppConstants _singleton = AppConstants._internal();

  final String vpnAPIKey = "40f6cdcbaf9b4c139d4a276b9788dee6";
  final double elevation = 4.0;
  final Duration duration = const Duration(seconds: 4);
}
