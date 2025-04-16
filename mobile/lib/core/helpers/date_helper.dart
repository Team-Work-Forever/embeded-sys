import 'package:intl/intl.dart';

class DateHelper {
  static String formatInterval(DateTime start, DateTime end) {
    final format = DateFormat('HH:mm');
    return '${format.format(start)} - ${format.format(end)}';
  }

  static int calculateDurationInMinutes(DateTime start, DateTime end) {
    return end.difference(start).inMinutes;
  }

  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isSameMonth(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month;
  }

  static bool isSameYear(DateTime a, DateTime b) {
    return a.year == b.year;
  }
}
