class DateTimeService {
  DateTime now = DateTime.now();
  List<String> days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
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
    final toDate = now.day.toString();
    return toDate;
  }

  String daY() {
    final toDay = days[now.weekday - 1];
    return toDay;
  }

  String monTh() {
    final toMonth = months[now.month - 1];
    return toMonth;
  }

  String formattedDate() {
    final toDate = now.day.toString();
    final toDay = days[now.weekday - 1];
    final toMonth = months[now.month - 1];
    final value = "$toDate $toMonth, $toDay";
    return value;
  }
}