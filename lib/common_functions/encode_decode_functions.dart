import "dart:convert";

String encodeStringToBase64({required String decodedString}) {
  final List<int> encodedUnits = decodedString.codeUnits;
  final String encodedString = base64.encode(encodedUnits);
  return encodedString;
}

String decodeBase64toString({required String encodedString}) {
  final List<int> decodedint = base64.decode(encodedString);
  final String decodedstring = utf8.decode(decodedint);
  return decodedstring;
}
