import 'package:flutter/material.dart';

class Utils {
  static bool isChosenDateZeroTime(DateTime other) {
    print(other.toIso8601String());

    print(
        'isZeroTime ${(other.second == 0 && other.minute == 0 && other.hour == 0)}');
    return (other.second == 0 && other.minute == 0 && other.hour == 0);
  }

  static bool isDateToday(DateTime other) {
    final DateTime now = DateTime.now();

    return (now.day == other.day &&
        now.month == other.month &&
        now.year == other.year);
  }

  static String formatDate(DateTime dateTime) {
    //Mi. 14 Dez.
    return '${_weekdayToWeekdayString(dateTime.weekday)} ${dateTime.day} ${_monthToMonthString(dateTime.month)}';
  }

  static String formatTime(DateTime dateTime) {
    //15:30
    return '${dateTime.hour}:${dateTime.minute} Uhr';
  }

  static String _weekdayToWeekdayString(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mo.';
      case 2:
        return 'Di.';
      case 3:
        return 'Mi.';
      case 4:
        return 'Do.';
      case 5:
        return 'Fr.';
      case 6:
        return 'Sa.';
      case 7:
        return 'So.';
      default:
        return '';
    }
  }

  static String _monthToMonthString(int month) {
    switch (month) {
      case 1:
        return 'Jan.';
      case 2:
        return 'Feb.';
      case 3:
        return 'Mär.';
      case 4:
        return 'Apr.';
      case 5:
        return 'Mai';
      case 6:
        return 'Jun.';
      case 7:
        return 'Jul.';
      case 8:
        return 'Aug.';
      case 9:
        return 'Sep.';
      case 10:
        return 'Okt.';
      case 11:
        return 'Nov.';
      case 12:
        return 'Dez.';
      default:
        return '';
    }
  }

  /**
   * AppBar Height
   */
  static double ah(BuildContext context) => AppBar().preferredSize.height;

  /**
   * Width
   */
  static double w(BuildContext context) => MediaQuery.of(context).size.width;

  /**
   * Height
   */
  static double h(BuildContext context) => MediaQuery.of(context).size.height;
}
