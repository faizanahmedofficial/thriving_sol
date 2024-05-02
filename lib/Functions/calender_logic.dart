// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

List<Map<String, dynamic>> decidedates(DateTime date) {
  List<Map<String, dynamic>> day = <Map<String, dynamic>>[];
  switch (date.weekday) {
    case 1:
      print('Monday');

      /// give index of how many next days are there [next+1]
      // _day = getNextdaysAndDates(date, 7);
      for (int i = 0; i < 7; i++) {
        day.add(
            {'day': getNextDate(date, i).day, 'date': getNextDate(date, i)});
      }
      // print(_day);
      return day;
    // break;
    case 2:
      print('Tuesday');

      /// give index of how many previous days are there [previous+1]
      for (int i = 1; i < 2; i++) {
        day.add({
          'day': getPreviousDate(i, date).day,
          'date': getPreviousDate(i, date)
        });
      }
      // print('Days: $_day');
      for (int i = 0; i < 6; i++) {
        day.add(
            {'day': getNextDate(date, i).day, 'date': getNextDate(date, i)});
      }
      print(day);
      // getPreviousdaysAndDate(date, 2);
      // getNextdaysAndDates(date, 6);
      // break;
      return day;
    case 3:
      print('wednesday');
      for (int i = 1; i < 3; i++) {
        day.add({
          'day': getPreviousDate(i, date).day,
          'date': getPreviousDate(i, date)
        });
      }
      print('Days: $day');
      day = day.reversed.toList();
      print('Reversed List: $day');
      for (int i = 0; i < 5; i++) {
        day.add(
            {'day': getNextDate(date, i).day, 'date': getNextDate(date, i)});
      }
      // print(_day);
      // getPreviousdaysAndDate(date, 3);
      // getNextdaysAndDates(date, 5);
      return day;
    // break;
    case 4:
      print('Thursday');
      for (int i = 1; i < 4; i++) {
        day.add({
          'day': getPreviousDate(i, date).day,
          'date': getPreviousDate(i, date)
        });
      }
      print('Days: $day');
      day = day.reversed.toList();
      print('Reversed List: $day');
      for (int i = 0; i < 4; i++) {
        day.add(
            {'day': getNextDate(date, i).day, 'date': getNextDate(date, i)});
      }
      // print(_day);
      // getPreviousdaysAndDate(date, 4);
      // getNextdaysAndDates(date, 4);
      return day;
    // break;
    case 5:
      print('Friday');
      for (int i = 1; i < 5; i++) {
        day.add({
          'day': getPreviousDate(i, date).day,
          'date': getPreviousDate(i, date)
        });
      }
      // print('Days: $_day');
      day = day.reversed.toList();
      print('Reversed List: $day');
      for (int i = 0; i < 3; i++) {
        day.add(
            {'day': getNextDate(date, i).day, 'date': getNextDate(date, i)});
      }
      // print(_day);
      // getPreviousdaysAndDate(date, 5);
      // getNextdaysAndDates(date, 3);
      return day;
    // break;
    case 6:
      print('Saturday');
      for (int i = 1; i < 6; i++) {
        day.add({
          'day': getPreviousDate(i, date).day,
          'date': getPreviousDate(i, date)
        });
      }
      // print('Days: $_day');
      day = day.reversed.toList();
      print('Reversed List: $day');
      for (int i = 0; i < 2; i++) {
        day.add(
            {'day': getNextDate(date, i).day, 'date': getNextDate(date, i)});
      }
      // print(_day);
      // getPreviousdaysAndDate(date, 6);
      // getNextdaysAndDates(date, 2);
      return day;
    // break; return _day;
    case 7:
      print('Sunday');
      // getPreviousdaysAndDate(date, 7);
      for (int i = 1; i < 7; i++) {
        day.add({
          'day': getPreviousDate(i, date).day,
          'date': getPreviousDate(i, date)
        });
      }
      // print('Days: $_day');
      day = day.reversed.toList();
      print('Reversed List: $day');
      return day;
    // break;
    default:
      return day;
  }
}

void getPreviousdaysAndDate(DateTime date, int index) {
  List<Map> dates = <Map>[];

  ///
  for (int i = 1; i < index; i++) {
    var _date = getPreviousDate(i, date);
    var _weekday = getDay(_date);
    dates.add({
      'date': _date,
      'day_num': _weekday,
      'day_name': nameOfDay(_weekday),
    });
  }
  print(dates.reversed);
}

DateTime getPreviousDate(int duration, DateTime date) {
  return date.subtract(Duration(days: duration));
}

void getNextdaysAndDates(DateTime date, int index) {
  List<Map> dates = <Map>[];

  ///
  for (int i = 0; i < index; i++) {
    var _date = getNextDate(date, i);
    var _weekday = getDay(_date);
    dates.add({
      'date': _date,
      'day_num': _weekday,
      'day_name': nameOfDay(_weekday),
    });
  }
  print(dates.toString());
}

DateTime getNextDate(DateTime date, int duration) {
  return date.add(Duration(days: duration));
}

int getDay(DateTime date) {
  return date.weekday;
}

String nameOfDay(int weekday) {
//   String name = '';
  switch (weekday) {
    case 1:
      return 'M';
    case 2:
      return 'T';
    case 3:
      return 'W';
    case 4:
      return 'Th';
    case 5:
      return 'F';
    case 6:
      return 'Sa';
    case 7:
      return 'Su';
    default:
      return '';
  }
}
