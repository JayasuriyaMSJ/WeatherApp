import 'package:intl/intl.dart';

class DateTimeService {
  DateTime now = DateTime.now();

  List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  String daTe() {
    return now.day.toString();
  }

  String daY() {
    return days[now.weekday - 1];
  }

  String monTh() {
    return months[now.month - 1];
  }

  String formattedDate() {
    return "${daTe()} ${monTh()} ${daY()}";
  }

  String formattedDateWithOffset(int offsetDays) {
    final adjustedDate = now.add(Duration(days: offsetDays));
    final DateFormat format = DateFormat('yyyy-MM-dd');
    return format.format(adjustedDate);
  }

  String formattedDayWithOffset(int offsetDays) {
    final adjustedDate = now.add(Duration(days: offsetDays));
    return days[adjustedDate.weekday - 1];
  }
}
