import "dart:convert";

class AppPrettyPrintJSON {
  factory AppPrettyPrintJSON() {
    return _singleton;
  }

  AppPrettyPrintJSON._internal();
  static final AppPrettyPrintJSON _singleton = AppPrettyPrintJSON._internal();

  String prettyPrint(Map<String, dynamic> map) {
    return const JsonEncoder.withIndent("  ").convert(map);
  }
}
