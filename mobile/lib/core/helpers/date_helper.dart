import 'package:intl/intl.dart';

class DateHelper {
  static String formatInterval(DateTime start, DateTime end) {
    final format = DateFormat('HH:mm');
    return '${format.format(start)} - ${format.format(end)}';
  }

  static int calculateDurationInMinutes(DateTime start, DateTime end) {
    return end.difference(start).inMinutes;
  }
}
