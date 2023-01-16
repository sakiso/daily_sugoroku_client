import 'package:intl/intl.dart';

String formatDateTimeToYyyyMmDd(DateTime dateTime) {
  DateFormat outputFormat = DateFormat('yyyyMMdd');
  String date = outputFormat.format(dateTime);
  print(date);
  return date;
}
