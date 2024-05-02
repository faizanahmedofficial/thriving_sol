// ignore_for_file: prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedular_project/Functions/date_picker.dart';
import 'package:schedular_project/Functions/time_picker.dart';

import '../Constants/constants.dart';
import '../Model/routine_model.dart';

Future<String> dateTimePicker(BuildContext context) async {
  String datetime = '';
  await customTimePicker(context, initialTime: TimeOfDay.now())
      .then((value) async {
    var time = value.format(context);
    var date;
    await customDatePicker(
      context,
      initialDate: DateTime.now(),
      firstDate: DateTime.utc(1900),
      lastDate: DateTime.utc(2100),
    ).then((value) {
      date = DateFormat('MM, dd, yyyy').format(value);
      datetime = '$time , $date';
    });
  });
  return datetime;
}

String getDurationString(int duration) {
  var _duration = Duration(seconds: duration);
  return '${_duration.inHours.toString().padLeft(2, '0')}:${(_duration.inMinutes % 60).toString().padLeft(2, '0')}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}';
}

String formatTime(int milliseconds) {
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');

  return "$hours:$minutes:$seconds";
}

int getDurationSeconds(int milliseconds) =>
    Duration(milliseconds: milliseconds).inSeconds;

int getTimeDifferenceInSeconds(DateTime start, DateTime end) =>
    end.difference(start).inSeconds;

TimeOfDay getTimeFromString(String _time) {
  int hh = 0;
  if (_time.endsWith('PM')) hh = 12;
  var time = _time.split(' ')[0];
  return TimeOfDay(
    hour: _time.endsWith('AM')
        ? int.parse(time.split(":")[0]) == 12
            ? 00
            : int.parse(time.split(":")[0])
        : int.parse(time.split(":")[0]) == 12
            ? int.parse(time.split(":")[0])
            : hh + int.parse(time.split(":")[0]) % 24,
    minute: int.parse(time.split(":")[1]) % 60,
  );
}

DateTime convertToDateTime(String date) => DateFormat('MM/dd/yy').parse(date);

DateTime getDateFromStringTime(String time) {
  DateTime date = DateTime.now();
  final _time = getTimeFromString(time);
  date = DateTime(date.year, date.month, date.day, _time.hour, _time.minute);
  return date;
}

String getDay(int duration) =>
    DateFormat('dd').format(DateTime.now().subtract(Duration(days: duration)));

String formateDate(DateTime date) => DateFormat('MM/dd/yy').format(date);

String formatTitelDate(DateTime date) =>
    '. ${DateFormat('dd.MM.yy').format(date)}';

String generateId([int len = 15]) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

TimeOfDay plusMinutes(TimeOfDay time, int minutes) {
  if (minutes == 0) {
    return time;
  } else {
    int mofd = time.hour * 60 + time.minute;
    int newMofd = ((minutes % 1440) + mofd + 1440) % 1440;
    if (mofd == newMofd) {
      return time;
    } else {
      int newHour = newMofd ~/ 60;
      int newMinute = newMofd % 60;
      return TimeOfDay(hour: newHour, minute: newMinute);
    }
  }
}

int categoryIndex(int value) =>
    categoryList.indexWhere((element) => element.value == value);

int fiveMinutes() => const Duration(minutes: 5).inSeconds;

RoutineElements addElements() => RoutineElements(
    category: 0, seconds: 0, duration: getDurationString(0), index: 0);

Nudges nudges() {
  return Nudges(setup: '', chain: 0, cue: 0, reward: 0);
}

int goalIndex(int value) =>
    goalsList.indexWhere((element) => element.value == value);

int readingListIndex(int value) =>
    readingList.indexWhere((element) => element.value == value);

int breathingListIndex(int value) =>
    breathingList.indexWhere((element) => element.value == value);

Future<Duration?> customDurationPicker({
  int initialMinutes = 5,
  BaseUnit baseunit = BaseUnit.second,
}) async {
  return await showDurationPicker(
    context: Get.context!,
    snapToMins: 2.0,
    baseUnit: baseunit,
    initialTime: baseunit == BaseUnit.second
        ? Duration(seconds: initialMinutes)
        : Duration(minutes: initialMinutes),
  );
}

int freeBLIndex(int value) =>
    freeBreathingList.indexWhere((element) => element.value == value);

int mindfulnessListIndex(int value) =>
    mindfulnessList.indexWhere((element) => element.value == value);

int freeMLIndex(int value) =>
    freeMindfulList.indexWhere((element) => element.value == value);

int visualizationIndex(int value) =>
    visualizationList.indexWhere((element) => element.value == value);

int optionsIndex(int value) =>
    scriptOption.indexWhere((element) => element.value == value);

int coldexercisesIndex(int value) =>
    coldexercises.indexWhere((element) => element.option == value);

int acIndex(int value) =>
    actionCategoryList.indexWhere((element) => element.value == value);

int nrIndex(int value) =>
    nudgeRoutineList.indexWhere((element) => element.value == value);

int alarmIndex(int value) =>
    alarmSoundList.indexWhere((element) => element.value == value);

int pomodoroIndex(int value) =>
    pomodoroList.indexWhere((element) => element.value == value);

int introIndex(int value) =>
    introList.indexWhere((element) => element.value == value);

int connectionIndex(int value) =>
    connectionList.indexWhere((element) => element.value == value);

int erListIndex(int value) =>
    erList.indexWhere((element) => element.value == value);

int gratitudeIndex(int value) =>
    gratitudeList.indexWhere((element) => element.value == value);

int coldListIndex(int value) =>
    coldList.indexWhere((element) => element.value == value);

int dietListIndex(int value) =>
    dietList.indexWhere((element) => element.value == value);

int sexualListIndex(int value) =>
    sexualList.indexWhere((element) => element.value == value);

int movementListIndex(int value) =>
    movementList.indexWhere((element) => element.value == value);

int bdListIndex(int value) =>
    bdList.indexWhere((element) => element.value == value);

int goalsListIndex(int value) =>
    valueGoalList.indexWhere((element) => element.value == value);

DateTime dateFromString(String date) => DateFormat('MM/dd/yy').parse(date);

double secondsToHours(int seconds) => seconds / 3600;

int acategoryIndex(int value) =>
    actionCategoryList.indexWhere((element) => element.value == value);

int calculatePercentage(int value, int total) {
  int percent = 0;
  int _value = value * 100;
  percent = _value ~/ total;
  return percent;
}

int movementGoalsIndex(int value) =>
    movementGoals.indexWhere((element) => element.value == value);

int dedicatedTimeIndex(int value) =>
    dedicatedTimeList.indexWhere((element) => element.value == value);

int resistenceTrainingIndex(int value) =>
    resistanceTraining.indexWhere((element) => element.value == value);

int cardioTrainingIndex(int value) =>
    cardioTrainingList.indexWhere((element) => element.value == value);

int minViableIndex(int type) =>
    cardioTrainingList.indexWhere((element) => element.type == type);

int weightTrainingIndex(int value) =>
    weightTraings.indexWhere((element) => element.value == value);

int scriptOptionIndex(int value) =>
    scriptOption.indexWhere((element) => element.value == value);

int freeColdIndex(int value) => freeColdOptions.indexWhere((element) => element.value == value);

int guidedColdIndex(int value) => guidedColdOptions.indexWhere((element) => element.value == value);