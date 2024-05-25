import "package:intl/intl.dart";

String formattedDateTime({required String dateTimeString}) {
  final DateTime dateTime = DateTime.parse(dateTimeString);
  final String formatted = DateFormat.yMd().add_jms().format(dateTime);

  return formatted;
}
