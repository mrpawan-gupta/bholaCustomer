import "dart:io";

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..maxConnectionsPerHost = 10
      ..idleTimeout = const Duration(minutes: 10)
      ..connectionTimeout = const Duration(minutes: 10)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
  }
}
