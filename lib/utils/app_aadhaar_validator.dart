// ignore_for_file: unnecessary_raw_strings

class AppAadhaarValidator {
  bool isValid(String? aadhaar) {
    if (aadhaar == null) {
      return false;
    }
    final String aadhaarWithoutSpace = aadhaar.replaceAll(RegExp(r"\s+"), "");
    if (aadhaarWithoutSpace.length != 12) {
      return false;
    }
    final RegExp aadhaarRegEx = RegExp(r"[2-9]{1}[0-9]{3}[0-9]{4}[0-9]{4}");
    if (!aadhaarRegEx.hasMatch(aadhaarWithoutSpace)) {
      return false;
    }
    return VerhoeffAlgorithm().validateVerhoeff(aadhaarWithoutSpace);
  }

  String? format(String? format) {
    String? aadhaar = format;
    if (aadhaar == null) {
      return null;
    }
    aadhaar = aadhaar.replaceAll(RegExp(r"\s+"), "");
    return aadhaar.replaceAllMapped(
      RegExp(r".{4}"),
      (Match match) {
        return "${match.group(0)} ";
      },
    ).trim();
  }
}

class VerhoeffAlgorithm {
  final List<List<int>> _d = <List<int>>[
    <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    <int>[1, 2, 3, 4, 0, 6, 7, 8, 9, 5],
    <int>[2, 3, 4, 0, 1, 7, 8, 9, 5, 6],
    <int>[3, 4, 0, 1, 2, 8, 9, 5, 6, 7],
    <int>[4, 0, 1, 2, 3, 9, 5, 6, 7, 8],
    <int>[5, 9, 8, 7, 6, 0, 4, 3, 2, 1],
    <int>[6, 5, 9, 8, 7, 1, 0, 4, 3, 2],
    <int>[7, 6, 5, 9, 8, 2, 1, 0, 4, 3],
    <int>[8, 7, 6, 5, 9, 3, 2, 1, 0, 4],
    <int>[9, 8, 7, 6, 5, 4, 3, 2, 1, 0],
  ];

  final List<List<int>> _p = <List<int>>[
    <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    <int>[1, 5, 7, 6, 2, 8, 3, 0, 9, 4],
    <int>[5, 8, 0, 3, 7, 9, 6, 1, 4, 2],
    <int>[8, 9, 1, 6, 0, 4, 3, 5, 2, 7],
    <int>[9, 4, 5, 3, 1, 2, 6, 8, 7, 0],
    <int>[4, 2, 8, 6, 5, 7, 3, 9, 0, 1],
    <int>[2, 7, 9, 3, 8, 0, 6, 4, 1, 5],
    <int>[7, 0, 4, 6, 9, 1, 3, 2, 5, 8],
  ];

  bool validateVerhoeff(String num) {
    int c = 0;
    final List<int> myArray = _stringToReversedIntArray(num);
    for (int i = 0; i < myArray.length; i++) {
      c = _d[c][_p[(i % 8)][myArray[i]]];
    }
    return c == 0;
  }

  List<int> _stringToReversedIntArray(String num) {
    final List<int> myArray = <int>[];
    for (int i = 0; i < num.length; i++) {
      myArray.add(int.parse(num.substring(i, i + 1)));
    }
    return myArray.reversed.toList();
  }
}
