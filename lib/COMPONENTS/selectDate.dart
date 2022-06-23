import 'package:intl/intl.dart';

class CustomDate {
  DateTime date = DateTime.now();
  String? fromdt;
  String? todt;
  getDate(int dayindex) {
    if (dayindex == 1) {
      fromdt = DateFormat('yyyy-MM-dd').format(date);
      todt = DateFormat('yyyy-MM-dd').format(date);
    } else if (dayindex == 2) {
      DateTime preday = DateTime(date.year, date.month, date.day - 2);
      fromdt = DateFormat('yyyy-MM-dd').format(preday);
      todt = DateFormat('yyyy-MM-dd').format(date);
    } else if (dayindex == 3) {
      DateTime preday = DateTime(date.year, date.month - 2, 1);
      fromdt =  DateFormat('yyyy-MM-dd').format(preday);
      todt = DateFormat('yyyy-MM-dd').format(date);
    }
  }
}
