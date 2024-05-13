class AppRegex {
  factory AppRegex() {
    return _singleton;
  }

  AppRegex._internal();
  static final AppRegex _singleton = AppRegex._internal();

  bool isValidNameRegex(String s) {
    return RegExp(r"^([\u0A80-\u0AFF]+|[a-zA-Z]+|[\u0900-\u097F]+)$")
        .hasMatch(s);
  }

  bool panCardNoRegex(String input) {
    return RegExp(r"^[A-Z]{5}[0-9]{4}[A-Z]{1}$").hasMatch(input);
  }
}
