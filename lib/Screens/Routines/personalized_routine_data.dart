// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'package:flutter/cupertino.dart';

import '../../Functions/functions.dart';
import '../../Model/routine_model.dart';

class PRModel {
  int category, value, type;
  List<int> durations;
  String title;

  PRModel(
    this.title,
    this.category,
    this.type,
    this.value,
    this.durations,
  );
}

List<PRModel> personalizedRoutines = <PRModel>[
  // type=> 0: morning, 1: evening
  PRModel(
    'Cold',
    10,
    0,
    10,
    [10, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30],
  ),
  PRModel(
    'Mindfulness',
    2,
    0,
    2,
    [0, 60, 120, 300, 600, 900, 1200, 1500, 1800, 2400, 3000, 3600, 3600],
  ),
  PRModel(
    'Visualization',
    1,
    0,
    1,
    [10, 60, 120, 300, 600, 900, 1200, 1500, 1800, 2400, 3000, 3600, 3600],
  ),
  PRModel(
    'Gratitude',
    5,
    0,
    5,
    [10, 60, 120, 300, 600, 900, 1200, 1500, 1800, 1800, 1800, 1800, 1800],
  ),
  PRModel(
    'Movement',
    8,
    0,
    8,
    [30, 240, 240, 390, 600, 900, 1200, 1500, 1800, 2400, 3000, 3600, 5100],
  ),
  PRModel(
    'Productivity & Behavioral Design',
    7,
    0,
    7,
    [10, 60, 120, 300, 600, 900, 1200, 1500, 1800, 1800, 1800, 1800, 1800],
  ),
  PRModel(
    'Connection',
    4,
    1,
    4,
    [10, 60, 120, 300, 600, 900, 1200, 1500, 1800, 2400, 3000, 3600, 5100],
  ),
  PRModel(
    'Breathing',
    0,
    1,
    0,
    [10, 60, 120, 300, 600, 900, 1200, 1500, 1800, 2400, 3000, 3600, 5100],
  ),
  PRModel(
    'Emotional Regulation',
    3,
    1,
    3,
    [30, 60, 120, 300, 600, 900, 1200, 1500, 1800, 2400, 3000, 3600, 5100],
  ),
  PRModel(
    'Diet',
    9,
    1,
    9,
    [10, 60, 120, 180, 180, 180, 180, 180, 180, 180, 180, 180, 180],
  ),
  // PRModel('Sexual', 11, 1, 11, []),
  PRModel(
    'Reading',
    12,
    1,
    12,
    [10, 60, 120, 300, 600, 900, 1200, 1500, 1800, 2400, 3000, 3600, 5100],
  ),
  PRModel(
    'Goals & Values',
    6,
    1,
    6,
    [30, 60, 120, 300, 600, 900, 1200, 1500, 1800, 2400, 3000, 3600, 5100],
  ),
];

RoutineElements addElement(int category, int seconds, int index, int type) {
  return RoutineElements(
    category: category,
    seconds: seconds,
    duration: getDurationString(seconds),
    index: index,
    type: type,
  );
}

List<PRModel> selectElements(int type) =>
    personalizedRoutines.where((element) => element.type == type).toList();

int prIndex(int value) =>
    personalizedRoutines.indexWhere((element) => element.value == value);

int prIndexbyCategory(int category) =>
    personalizedRoutines.indexWhere((element) => element.category == category);

// duration shuold be in seconds,
List<RoutineElements> setRoutines(int goal, int duration) {
  print('Duration: $duration');
  List<RoutineElements> mrElements = <RoutineElements>[];
  // if (duration == 0 || duration <= 5100) {
  mrElements = generateBabyRoutineList(personalizedRoutines, duration);
  // } else {
  //   print('more than 85');
  //   mrElements = generateRoutineList(personalizedRoutines);
  // }

  if (duration == 0) {
    return mrElements;
  } else {
    switch (goal) {
      case 0:
        // return mtotalWellness(mrElements, goal, duration);
        return totalWelness(mrElements, goal, duration);
      case 1:
        return mHappiness(mrElements, goal, duration);
      case 2:
        return mphysicalHealth(mrElements, goal, duration);
      case 3:
        return mMentalHealth(mrElements, goal, duration);
      case 4:
        return mfinancialHealth(mrElements, goal, duration);
      default:
        return <RoutineElements>[];
    }
  }
}

List<RoutineElements> generateBabyRoutineList(
    List<PRModel> list, int duration) {
  List<RoutineElements> _elements = <RoutineElements>[];
  for (int i = 0; i < list.length; i++) {
    final val = list[i];
    _elements.add(
      addElement(
        val.category,
        duration != 0 ? val.durations[0] : val.durations[12],
        i,
        val.type,
      ),
    );
  }
  return _elements;
}

// total wellness
List<RoutineElements> totalWelness(
    List<RoutineElements> list, int goal, int duration) {
  debugPrint('total wellness');
  int total = 0;
  updateTotal(int value) => total = total + value;
  for (int i = 0; i < list.length; i++) {
    updateTotal(list[i].seconds!);
  }
  debugPrint('baby total: $total');
  int index = 1;
  for (index; total < duration; index++) {
    if (index > 12) return list;
    debugPrint('index: $index');
    // connection
    final connection =
        list[list.indexWhere((element) => element.category == 4)];
    int _conCurrent = connection.seconds!;
    total = total - connection.seconds!;
    final connectionmodel =
        personalizedRoutines[prIndexbyCategory(connection.category!)];
    connection.seconds = connectionmodel.durations[index];
    connection.duration = getDurationString(connection.seconds!);
    total = total + connection.seconds!;
    if (total == duration) {
      return list;
    } else if (total > duration) {
      total = total - connection.seconds!;
      connection.seconds = _conCurrent;
      connection.duration = getDurationString(connection.seconds!);
      total = total + _conCurrent;
      return list;
    }
    debugPrint('total connection: $total');
    // movement
    final movement = list[list.indexWhere((element) => element.category == 8)];
    int _movCurrent = movement.seconds!;
    total = total - movement.seconds!;
    final prmodel = personalizedRoutines[prIndexbyCategory(movement.category!)];
    movement.seconds = prmodel.durations[index];
    movement.duration = getDurationString(movement.seconds!);
    total = total + movement.seconds!;
    if (total == duration) {
      return list;
    } else if (total > duration) {
      total = total - movement.seconds!;
      movement.seconds = _movCurrent;
      movement.duration = getDurationString(movement.seconds!);
      total = total + _movCurrent;
      return list;
    }
    debugPrint('total movement: $total');
    // breathing
    final breathing = list[list.indexWhere((element) => element.category == 0)];
    int _bcurrent = breathing.seconds!;
    total = total - breathing.seconds!;
    final breathingmodel =
        personalizedRoutines[prIndexbyCategory(breathing.category!)];
    breathing.seconds = breathingmodel.durations[index];
    breathing.duration = getDurationString(breathing.seconds!);
    total = total + breathing.seconds!;
    if (total == duration) {
      return list;
    } else if (total > duration) {
      total = total - breathing.seconds!;
      breathing.seconds = _bcurrent;
      breathing.duration = getDurationString(breathing.seconds!);
      total = total + _bcurrent;
      return list;
    }
    debugPrint('total breathing: $total');
    // gratitude
    final gratitude = list[list.indexWhere((element) => element.category == 5)];
    int _gcurrent = gratitude.seconds!;
    total = total - gratitude.seconds!;
    final gratitudemodel =
        personalizedRoutines[prIndexbyCategory(gratitude.category!)];
    gratitude.seconds = gratitudemodel.durations[index];
    gratitude.duration = getDurationString(gratitude.seconds!);
    total = total + gratitude.seconds!;
    if (total == duration) {
      return list;
    } else if (total > duration) {
      total = total - gratitude.seconds!;
      gratitude.seconds = _gcurrent;
      gratitude.duration = getDurationString(gratitude.seconds!);
      total = total + _gcurrent;
      return list;
    }
    debugPrint('total gratitude: $total');

    /// goal
    final goal = list[list.indexWhere((element) => element.category == 6)];
    int _goalcurrent = goal.seconds!;
    total = total - goal.seconds!;
    final goalmodel = personalizedRoutines[prIndexbyCategory(goal.category!)];
    goal.seconds = goalmodel.durations[index];
    goal.duration = getDurationString(goal.seconds!);
    total = total + goal.seconds!;
    if (total == duration) {
      return list;
    } else if (total > duration) {
      total = total - goal.seconds!;
      goal.seconds = _goalcurrent;
      goal.duration = getDurationString(goal.seconds!);
      total = total + _goalcurrent;
      return list;
    }
    debugPrint('total goal: $total');
    // emotional regulation (ER)
    final er = list[list.indexWhere((element) => element.category == 3)];
    int _ecurrent = er.seconds!;
    total = total - er.seconds!;
    final ermodel = personalizedRoutines[prIndexbyCategory(er.category!)];
    er.seconds = ermodel.durations[index];
    er.duration = getDurationString(er.seconds!);
    total = total + er.seconds!;
    if (total == duration) {
      return list;
    } else if (total > duration) {
      total = total - er.seconds!;
      er.seconds = _ecurrent;
      er.duration = getDurationString(er.seconds!);
      total = total + _ecurrent;
      return list;
    }
    debugPrint('total er: $total');
    // mindfulness
    final mindfulness =
        list[list.indexWhere((element) => element.category == 2)];
    int _mcurrent = mindfulness.seconds!;
    total = total - mindfulness.seconds!;
    final mindfulnessmodel =
        personalizedRoutines[prIndexbyCategory(mindfulness.category!)];
    mindfulness.seconds = mindfulnessmodel.durations[index];
    mindfulness.duration = getDurationString(mindfulness.seconds!);
    total = total + mindfulness.seconds!;
    if (total == duration) {
      return list;
    } else if (total > duration) {
      total = total - mindfulness.seconds!;
      mindfulness.seconds = _mcurrent;
      mindfulness.duration = getDurationString(mindfulness.seconds!);
      total = total + _mcurrent;
      // return list;
      return list;
    }
    debugPrint('total mindfulness: $total');
    // reading
    final reading = list[list.indexWhere((element) => element.category == 12)];
    int _rcurrent = reading.seconds!;
    total = total - reading.seconds!;
    final readmodel =
        personalizedRoutines[prIndexbyCategory(reading.category!)];
    reading.seconds = readmodel.durations[index];
    reading.duration = getDurationString(reading.seconds!);
    total = total + reading.seconds!;
    if (total == duration) {
      return list;
    } else if (total > duration) {
      total = total - reading.seconds!;
      reading.seconds = _rcurrent;
      reading.duration = getDurationString(reading.seconds!);
      total = total + _rcurrent;
      return list;
    }
    debugPrint('total reading: $total');
    // bd
    final bd = list[list.indexWhere((element) => element.category == 7)];
    int _bdcurrent = bd.seconds!;
    total = total - bd.seconds!;
    final bdmodel = personalizedRoutines[prIndexbyCategory(bd.category!)];
    bd.seconds = bdmodel.durations[index];
    bd.duration = getDurationString(bd.seconds!);
    total = total + bd.seconds!;
    if (total == duration) {
      return list;
    } else if (total > duration) {
      total = total - bd.seconds!;
      bd.seconds = _bdcurrent;
      bd.duration = getDurationString(bd.seconds!);
      total = total + _bdcurrent;
      return list;
    }
    debugPrint('total bd: $total');
    // diet
    final diet = list[list.indexWhere((element) => element.category == 9)];
    int _dcurrent = diet.seconds!;
    total = total - diet.seconds!;
    final dietmodel = personalizedRoutines[prIndexbyCategory(diet.category!)];
    diet.seconds = dietmodel.durations[index];
    diet.duration = getDurationString(diet.seconds!);
    total = total + diet.seconds!;
    if (total == duration) {
      return list;
    } else if (total > duration) {
      total = total - diet.seconds!;
      diet.seconds = _dcurrent;
      diet.duration = getDurationString(_dcurrent);
      total = total + _dcurrent;
      return list;
    }
    debugPrint('total diet: $total');
    // visualization
    final visualization =
        list[list.indexWhere((element) => element.category == 1)];
    int _vcurrent = visualization.seconds!;
    total = total - visualization.seconds!;
    final visualizationmodel =
        personalizedRoutines[prIndexbyCategory(visualization.category!)];
    visualization.seconds = visualizationmodel.durations[index];
    visualization.duration = getDurationString(visualization.seconds!);
    total = total + visualization.seconds!;
    if (total == duration) {
      return list;
    } else if (total > duration) {
      total = total - visualization.seconds!;
      visualization.seconds = _vcurrent;
      visualization.duration = getDurationString(_vcurrent);
      total = total - _vcurrent;
      return list;
    }
    debugPrint('total visualization: $total');
    // cold
    final cold = list[list.indexWhere((element) => element.category == 10)];
    int _coldCurrent = cold.seconds!;
    total = total - cold.seconds!;
    final coldmodel = personalizedRoutines[prIndexbyCategory(cold.category!)];
    cold.seconds = coldmodel.durations[index];
    cold.duration = getDurationString(cold.seconds!);
    total = total + cold.seconds!;
    if (total == duration) {
      return list;
    } else if (total > duration) {
      total = total - cold.seconds!;
      cold.seconds = _coldCurrent;
      cold.duration = getDurationString(cold.seconds!);
      total = total + _coldCurrent;
      return list;
    }
    debugPrint('total After cold: $total');
  }
  return list;
}

List<RoutineElements> generateRoutineList(List<PRModel> list) {
  List<RoutineElements> _elements = <RoutineElements>[];
  for (int i = 0; i < list.length; i++) {
    final val = list[i];
    _elements.add(addElement(val.category, val.durations[12], i, val.type));
  }
  return _elements;
}

/// morning: cold, mindfulness, visualization, gratitude, movement, planning & behavioral design
/// evening: connection, breathing, emotional regulation, diet, reading, goals
/// happiness
List<RoutineElements> mHappiness(
    List<RoutineElements> list, int goal, int totalDuration) {
  print('happiness');
  int total = 0;
  for (int i = 0; i < list.length; i++) {
    total = total + list[i].seconds!;
  }
  print('baby total: $total');
  int index = 1;
  while (total < totalDuration && index <= 12) {
    // gratitude
    final gratitude = list[list.indexWhere((element) => element.category == 5)];
    int _gcurrent = gratitude.seconds!;
    total = total - gratitude.seconds!;
    final gratitudemodel =
        personalizedRoutines[prIndexbyCategory(gratitude.category!)];
    gratitude.seconds = gratitudemodel.durations[index];
    gratitude.duration = getDurationString(gratitude.seconds!);
    total = total + gratitude.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - gratitude.seconds!;
      gratitude.seconds = _gcurrent;
      gratitude.duration = getDurationString(gratitude.seconds!);
      total = total + _gcurrent;
      return list;
    }
    debugPrint('total gratitude: $total');
    // connection
    final connection =
        list[list.indexWhere((element) => element.category == 4)];
    int _conCurrent = connection.seconds!;
    total = total - connection.seconds!;
    final connectionmodel =
        personalizedRoutines[prIndexbyCategory(connection.category!)];
    connection.seconds = connectionmodel.durations[index];
    connection.duration = getDurationString(connection.seconds!);
    total = total + connection.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - connection.seconds!;
      connection.seconds = _conCurrent;
      connection.duration = getDurationString(connection.seconds!);
      total = total + _conCurrent;
      return list;
    }
    debugPrint('total connection: $total');
    // breathing
    final breathing = list[list.indexWhere((element) => element.category == 0)];
    int _bcurrent = breathing.seconds!;
    total = total - breathing.seconds!;
    final breathingmodel =
        personalizedRoutines[prIndexbyCategory(breathing.category!)];
    breathing.seconds = breathingmodel.durations[index];
    breathing.duration = getDurationString(breathing.seconds!);
    total = total + breathing.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - breathing.seconds!;
      breathing.seconds = _bcurrent;
      breathing.duration = getDurationString(breathing.seconds!);
      total = total + _bcurrent;
      return list;
    }
    debugPrint('total breathing: $total');
    // movement
    final movement = list[list.indexWhere((element) => element.category == 8)];
    int _movCurrent = movement.seconds!;
    total = total - movement.seconds!;
    final prmodel = personalizedRoutines[prIndexbyCategory(movement.category!)];
    movement.seconds = prmodel.durations[index];
    movement.duration = getDurationString(movement.seconds!);
    total = total + movement.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - movement.seconds!;
      movement.seconds = _movCurrent;
      movement.duration = getDurationString(movement.seconds!);
      total = total + _movCurrent;
      return list;
    }
    debugPrint('total movement: $total');

    ///  mindfulness
    final mindfulness =
        list[list.indexWhere((element) => element.category == 2)];
    int _mcurrent = mindfulness.seconds!;
    total = total - mindfulness.seconds!;
    final mindfulnessmodel =
        personalizedRoutines[prIndexbyCategory(mindfulness.category!)];
    mindfulness.seconds = mindfulnessmodel.durations[index];
    mindfulness.duration = getDurationString(mindfulness.seconds!);
    total = total + mindfulness.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - mindfulness.seconds!;
      mindfulness.seconds = _mcurrent;
      mindfulness.duration = getDurationString(mindfulness.seconds!);
      total = total + _mcurrent;
      return list;
    }
    debugPrint('total mindfulness: $total');

    /// cold
    final cold = list[list.indexWhere((element) => element.category == 10)];
    int _coldCurrent = cold.seconds!;
    total = total - cold.seconds!;
    final coldmodel = personalizedRoutines[prIndexbyCategory(cold.category!)];
    cold.seconds = coldmodel.durations[index];
    cold.duration = getDurationString(cold.seconds!);
    total = total + cold.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - cold.seconds!;
      cold.seconds = _coldCurrent;
      cold.duration = getDurationString(cold.seconds!);
      total = total + _coldCurrent;
      return list;
    }
    debugPrint('total cold: $total');

    /// goal
    final goal = list[list.indexWhere((element) => element.category == 6)];
    int _goalcurrent = goal.seconds!;

    total = total - goal.seconds!;
    final goalmodel = personalizedRoutines[prIndexbyCategory(goal.category!)];
    goal.seconds = goalmodel.durations[index];
    goal.duration = getDurationString(goal.seconds!);
    total = total + goal.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - goal.seconds!;
      goal.seconds = _goalcurrent;
      goal.duration = getDurationString(goal.seconds!);
      total = total + _goalcurrent;
      return list;
    }
    debugPrint('total goal: $total');
    // emotional regulation (ER)
    final er = list[list.indexWhere((element) => element.category == 3)];
    int _ecurrent = er.seconds!;
    total = total - er.seconds!;
    final ermodel = personalizedRoutines[prIndexbyCategory(er.category!)];
    er.seconds = ermodel.durations[index];
    er.duration = getDurationString(er.seconds!);
    total = total + er.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - er.seconds!;
      er.seconds = _ecurrent;
      er.duration = getDurationString(er.seconds!);
      total = total + _ecurrent;
      return list;
    }
    debugPrint('total er: $total');

    /// reading
    final reading = list[list.indexWhere((element) => element.category == 12)];
    int _rcurrent = reading.seconds!;
    total = total - reading.seconds!;
    final readmodel =
        personalizedRoutines[prIndexbyCategory(reading.category!)];
    reading.seconds = readmodel.durations[index];
    reading.duration = getDurationString(reading.seconds!);
    total = total + reading.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - reading.seconds!;
      reading.seconds = _rcurrent;
      reading.duration = getDurationString(reading.seconds!);
      total = total + _rcurrent;
      return list;
    }
    debugPrint('total reading: $total');
    //
    index = index + 1;
  }
  return list;
}

/// mental health
List<RoutineElements> mMentalHealth(
    List<RoutineElements> list, int goal, int totalDuration) {
  print('mental health');
  int total = 0;
  for (int i = 0; i < list.length; i++) {
    total = total + list[i].seconds!;
  }
  debugPrint('baby total: $total');
  int index = 1;
  while (total < totalDuration && index <= 12) {
    // breathing
    final breathing = list[list.indexWhere((element) => element.category == 0)];
    int _bcurrent = breathing.seconds!;
    total = total - breathing.seconds!;
    final breathingmodel =
        personalizedRoutines[prIndexbyCategory(breathing.category!)];
    breathing.seconds = breathingmodel.durations[index];
    breathing.duration = getDurationString(breathing.seconds!);
    total = total + breathing.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - breathing.seconds!;
      breathing.seconds = _bcurrent;
      breathing.duration = getDurationString(breathing.seconds!);
      total = total + _bcurrent;
      return list;
    }
    debugPrint('total breathing: $total');
    // emotional regulation (ER)
    final er = list[list.indexWhere((element) => element.category == 3)];
    int _ecurrent = er.seconds!;
    total = total - er.seconds!;
    final ermodel = personalizedRoutines[prIndexbyCategory(er.category!)];
    er.seconds = ermodel.durations[index];
    er.duration = getDurationString(er.seconds!);
    total = total + er.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - er.seconds!;
      er.seconds = _ecurrent;
      er.duration = getDurationString(er.seconds!);
      total = total + _ecurrent;
      return list;
    }
    debugPrint('total er: $total');
    // connection
    final connection =
        list[list.indexWhere((element) => element.category == 4)];
    int _conCurrent = connection.seconds!;
    total = total - connection.seconds!;
    final connectionmodel =
        personalizedRoutines[prIndexbyCategory(connection.category!)];
    connection.seconds = connectionmodel.durations[index];
    connection.duration = getDurationString(connection.seconds!);
    total = total + connection.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - connection.seconds!;
      connection.seconds = _conCurrent;
      connection.duration = getDurationString(connection.seconds!);
      total = total + _conCurrent;
      return list;
    }
    debugPrint('total connection: $total');
    // gratitude
    final gratitude = list[list.indexWhere((element) => element.category == 5)];
    int _gcurrent = gratitude.seconds!;
    total = total - gratitude.seconds!;
    final gratitudemodel =
        personalizedRoutines[prIndexbyCategory(gratitude.category!)];
    gratitude.seconds = gratitudemodel.durations[index];
    gratitude.duration = getDurationString(gratitude.seconds!);
    total = total + gratitude.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - gratitude.seconds!;
      gratitude.seconds = _gcurrent;
      gratitude.duration = getDurationString(gratitude.seconds!);
      total = total + _gcurrent;
      return list;
    }
    debugPrint('total gratitude: $total');
    // mindfulness
    final mindfulness =
        list[list.indexWhere((element) => element.category == 2)];
    int _mcurrent = mindfulness.seconds!;
    total = total - mindfulness.seconds!;
    final mindfulnessmodel =
        personalizedRoutines[prIndexbyCategory(mindfulness.category!)];
    mindfulness.seconds = mindfulnessmodel.durations[index];
    mindfulness.duration = getDurationString(mindfulness.seconds!);
    total = total + mindfulness.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - mindfulness.seconds!;
      mindfulness.seconds = _mcurrent;
      mindfulness.duration = getDurationString(mindfulness.seconds!);
      total = total + _mcurrent;
      return list;
    }
    debugPrint('total mindfulness: $total');
    // visualization
    final visualization =
        list[list.indexWhere((element) => element.category == 1)];
    int _vcurrent = visualization.seconds!;
    total = total - visualization.seconds!;
    final visualizationmodel =
        personalizedRoutines[prIndexbyCategory(visualization.category!)];
    visualization.seconds = visualizationmodel.durations[index];
    visualization.duration = getDurationString(visualization.seconds!);
    total = total + visualization.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - visualization.seconds!;
      visualization.seconds = _vcurrent;
      visualization.duration = getDurationString(_vcurrent);
      total = total - _vcurrent;
      return list;
    }
    debugPrint('total visualization: $total');
    // cold
    final cold = list[list.indexWhere((element) => element.category == 10)];
    int _coldCurrent = cold.seconds!;
    total = total - cold.seconds!;
    final coldmodel = personalizedRoutines[prIndexbyCategory(cold.category!)];
    cold.seconds = coldmodel.durations[index];
    cold.duration = getDurationString(cold.seconds!);
    total = total + cold.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - cold.seconds!;
      cold.seconds = _coldCurrent;
      cold.duration = getDurationString(cold.seconds!);
      total = total + _coldCurrent;
      return list;
    }
    debugPrint('total cold: $total');
// reading
    final reading = list[list.indexWhere((element) => element.category == 12)];
    int _rcurrent = reading.seconds!;
    total = total - reading.seconds!;
    final readmodel =
        personalizedRoutines[prIndexbyCategory(reading.category!)];
    reading.seconds = readmodel.durations[index];
    reading.duration = getDurationString(reading.seconds!);
    total = total + reading.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - reading.seconds!;
      reading.seconds = _rcurrent;
      reading.duration = getDurationString(reading.seconds!);
      total = total + _rcurrent;
      return list;
    }
    debugPrint('total reading: $total');
    //
    index = index + 1;
  }
  return list;
}

/// physical health
List<RoutineElements> mphysicalHealth(
    List<RoutineElements> list, int goal, int totalDuration) {
  print('physical health');
  int total = 0;
  for (int i = 0; i < list.length; i++) {
    total = total + list[i].seconds!;
  }
  debugPrint('baby total: $total');
  int index = 1;
  while (total < totalDuration && index <= 12) {
    // movement
    final movement = list[list.indexWhere((element) => element.category == 8)];
    int _movCurrent = movement.seconds!;
    total = total - movement.seconds!;
    final prmodel = personalizedRoutines[prIndexbyCategory(movement.category!)];
    movement.seconds = prmodel.durations[index];
    movement.duration = getDurationString(movement.seconds!);
    total = total + movement.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - movement.seconds!;
      movement.seconds = _movCurrent;
      movement.duration = getDurationString(movement.seconds!);
      total = total + _movCurrent;
      return list;
    }
    debugPrint('total movement: $total');
    // diet
    final diet = list[list.indexWhere((element) => element.category == 9)];
    int _dcurrent = diet.seconds!;
    total = total - diet.seconds!;
    final dietmodel = personalizedRoutines[prIndexbyCategory(diet.category!)];
    diet.seconds = dietmodel.durations[index];
    diet.duration = getDurationString(diet.seconds!);
    total = total + diet.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - diet.seconds!;
      diet.seconds = _dcurrent;
      diet.duration = getDurationString(_dcurrent);
      total = total + diet.seconds!;
      return list;
    }
    debugPrint('total diet: $total');
    // connection
    final connection =
        list[list.indexWhere((element) => element.category == 4)];
    int _conCurrent = connection.seconds!;
    total = total - connection.seconds!;
    final connectionmodel =
        personalizedRoutines[prIndexbyCategory(connection.category!)];
    connection.seconds = connectionmodel.durations[index];
    connection.duration = getDurationString(connection.seconds!);
    total = total + connection.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - connection.seconds!;
      connection.seconds = _conCurrent;
      connection.duration = getDurationString(connection.seconds!);
      total = total + _conCurrent;
      return list;
    }
    debugPrint('total connection: $total');

    // breathing
    final breathing = list[list.indexWhere((element) => element.category == 0)];
    int _bcurrent = breathing.seconds!;
    total = total - breathing.seconds!;
    final breathingmodel =
        personalizedRoutines[prIndexbyCategory(breathing.category!)];
    breathing.seconds = breathingmodel.durations[index];
    breathing.duration = getDurationString(breathing.seconds!);
    total = total + breathing.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - breathing.seconds!;
      breathing.seconds = _bcurrent;
      breathing.duration = getDurationString(breathing.seconds!);
      total = total + _bcurrent;
      return list;
    }
    debugPrint('total breathing: $total');
    // gratitude
    final gratitude = list[list.indexWhere((element) => element.category == 5)];
    int _gcurrent = gratitude.seconds!;
    total = total - gratitude.seconds!;
    final gratitudemodel =
        personalizedRoutines[prIndexbyCategory(gratitude.category!)];
    gratitude.seconds = gratitudemodel.durations[index];
    gratitude.duration = getDurationString(gratitude.seconds!);
    total = total + gratitude.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - gratitude.seconds!;
      gratitude.seconds = _gcurrent;
      gratitude.duration = getDurationString(gratitude.seconds!);
      total = total + _gcurrent;
      return list;
    }
    debugPrint('total gratitude: $total');
    // cold
    final cold = list[list.indexWhere((element) => element.category == 10)];
    int _coldCurrent = cold.seconds!;
    total = total - cold.seconds!;
    final coldmodel = personalizedRoutines[prIndexbyCategory(cold.category!)];
    cold.seconds = coldmodel.durations[index];
    cold.duration = getDurationString(cold.seconds!);
    total = total + cold.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - cold.seconds!;
      cold.seconds = _coldCurrent;
      cold.duration = getDurationString(cold.seconds!);
      total = total + _coldCurrent;
      return list;
    }
    debugPrint('total cold: $total');
    // mindfulness
    final mindfulness =
        list[list.indexWhere((element) => element.category == 2)];
    int _mcurrent = mindfulness.seconds!;
    total = total - mindfulness.seconds!;
    final mindfulnessmodel =
        personalizedRoutines[prIndexbyCategory(mindfulness.category!)];
    mindfulness.seconds = mindfulnessmodel.durations[index];
    mindfulness.duration = getDurationString(mindfulness.seconds!);
    total = total + mindfulness.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - mindfulness.seconds!;
      mindfulness.seconds = _mcurrent;
      mindfulness.duration = getDurationString(mindfulness.seconds!);
      total = total + _mcurrent;
      return list;
    }
    debugPrint('total mindfulness: $total');
    //
    index = index + 1;
  }
  return list;
}

/// financial health
List<RoutineElements> mfinancialHealth(
    List<RoutineElements> list, int goal, int totalDuration) {
  print('financial health');
  int total = 0;
  for (int i = 0; i < list.length; i++) {
    total = total + list[i].seconds!;
  }
  debugPrint('baby total: $total');
  int index = 1;
  while (total < totalDuration && index <= 12) {
    // goal
    final goal = list[list.indexWhere((element) => element.category == 6)];
    int _gcurrent = goal.seconds!;

    total = total - goal.seconds!;
    final goalmodel = personalizedRoutines[prIndexbyCategory(goal.category!)];
    goal.seconds = goalmodel.durations[index];
    goal.duration = getDurationString(goal.seconds!);
    total = total + goal.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - goal.seconds!;
      goal.seconds = _gcurrent;
      goal.duration = getDurationString(goal.seconds!);
      total = total + _gcurrent;
      return list;
    }
    debugPrint('total goal: $total');
    // bd
    final bd = list[list.indexWhere((element) => element.category == 7)];
    int _bcurrent = bd.seconds!;
    total = total - bd.seconds!;
    final bdmodel = personalizedRoutines[prIndexbyCategory(bd.category!)];
    bd.seconds = bdmodel.durations[index];
    bd.duration = getDurationString(bd.seconds!);
    total = total + bd.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - bd.seconds!;
      bd.seconds = _bcurrent;
      bd.duration = getDurationString(bd.seconds!);
      total = total + _bcurrent;
      return list;
    }
    debugPrint('total bd: $total');

    // connection
    final connection =
        list[list.indexWhere((element) => element.category == 4)];
    int _conCurrent = connection.seconds!;
    total = total - connection.seconds!;
    final connectionmodel =
        personalizedRoutines[prIndexbyCategory(connection.category!)];
    connection.seconds = connectionmodel.durations[index];
    connection.duration = getDurationString(connection.seconds!);
    total = total + connection.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - connection.seconds!;
      connection.seconds = _conCurrent;
      connection.duration = getDurationString(connection.seconds!);
      total = total + _conCurrent;
      return list;
    }
    debugPrint('total connection: $total');
    // reading
    final reading = list[list.indexWhere((element) => element.category == 12)];
    int _rcurrent = reading.seconds!;
    total = total - reading.seconds!;
    final readmodel =
        personalizedRoutines[prIndexbyCategory(reading.category!)];
    reading.seconds = readmodel.durations[index];
    reading.duration = getDurationString(reading.seconds!);
    total = total + reading.seconds!;
    if (total == totalDuration) {
      return list;
    } else if (total > totalDuration) {
      total = total - reading.seconds!;
      reading.seconds = _rcurrent;
      reading.duration = getDurationString(reading.seconds!);
      total = total + _rcurrent;
      return list;
    }
    debugPrint('total reading: $total');
    //
    index = index + 1;
  }
  return list;
}
