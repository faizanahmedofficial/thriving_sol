import 'package:schedular_project/Functions/functions.dart';

/// 0: 30 second routine creator
/// 1: movement journal
/// 2: journal entry
///

class MovementJournalEntry {
  String? id, userid, name, date, start, end, notes;
  int? type, durationSeconds, duration;
  List<RoutineWorkouts>? workouts;

  MovementJournalEntry({
    this.date,
    this.duration,
    this.durationSeconds,
    this.end,
    this.id,
    this.name,
    this.notes,
    this.start,
    this.type,
    this.userid,
    this.workouts,
  });

  factory MovementJournalEntry.fromMap(var map) {
    return MovementJournalEntry(
      date: map['date'],
      duration: map['duration'],
      durationSeconds: map['seconds'],
      end: map['end'],
      id: map['id'],
      name: map['name'],
      notes: map['notes'],
      start: map['start'],
      type: map['type'],
      userid: map['userid'],
      workouts: map['workouts']
          .map<RoutineWorkouts>((e) => RoutineWorkouts.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['date'] = date ?? formateDate(DateTime.now());
    map['duration'] = duration ?? 0;
    map['seconds'] = durationSeconds ?? 0;
    map['end'] = end ?? '';
    map['id'] = id ?? '';
    map['name'] = name ?? '';
    map['notes'] = notes ?? '';
    map['start'] = start ?? '';
    map['type'] = type ?? 2;
    map['userid'] = userid ?? '';
    if (workouts == null) {
      map['workouts'] = <RoutineWorkouts>[];
    } else {
      map['workouts'] = workouts?.map((e) => e.toMap()).toList();
    }
    return map;
  }
}

class MovementWorkoutJournal {
  String? id, userid, name, date;
  int? type,
      calisthetics,
      weightTraining,
      intervalTraining,
      length,
      duration,
      seconds;
  List<RoutineWorkouts>? exercises;

  MovementWorkoutJournal({
    this.exercises,
    this.length,
    this.name,
    this.intervalTraining,
    this.date,
    this.userid,
    this.type,
    this.id,
    this.weightTraining,
    this.calisthetics,
    this.duration,
    this.seconds,
  });

  factory MovementWorkoutJournal.fromMap(var map) {
    return MovementWorkoutJournal(
      exercises: map['exercises']
          .map<RoutineWorkouts>((e) => RoutineWorkouts.fromMap(e))
          .toList(),
      length: map['length'],
      name: map['name'],
      intervalTraining: map['cardio'],
      date: map['date'],
      userid: map['userid'],
      type: map['type'],
      id: map['id'],
      weightTraining: map['strength'],
      calisthetics: map['workout_type'],
      duration: map['duration'],
      seconds: map['seconds'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['length'] = length ?? 0;
    map['name'] = name ?? '';
    map['cardio'] = intervalTraining ?? 0;
    map['date'] = date ?? formateDate(DateTime.now());
    map['userid'] = userid ?? '';
    map['type'] = type ?? 1;
    map['id'] = id ?? '';
    map['strength'] = weightTraining ?? 0;
    map['workout_type'] = calisthetics ?? 0;
    if (exercises == null) {
      map['exercises'] = <RoutineWorkouts>[];
    } else {
      map['exercises'] = exercises?.map((e) => e.toMap()).toList();
    }
    map['duration'] = duration ?? 0;
    map['seconds'] = seconds ?? 0;
    return map;
  }
}

class RoutineCreator {
  String? id, userid, name, date;
  int? type, importantgoal, resistanceTraining, cardio, days, time, duration;
  List<RoutineExercise>? exercises;

  RoutineCreator({
    this.importantgoal,
    this.days,
    this.name,
    this.resistanceTraining,
    this.cardio,
    this.date,
    this.exercises,
    this.id,
    this.time,
    this.type,
    this.userid,
    this.duration,
  });

  factory RoutineCreator.fromMap(var map) {
    return RoutineCreator(
      importantgoal: map['important_goal'],
      days: map['days'],
      name: map['name'],
      resistanceTraining: map['resistance_training'],
      cardio: map['cardio'],
      date: map['date'],
      exercises: map['exercises']
          .map<RoutineExercise>((e) => RoutineExercise.fromMap(e))
          .toList(),
      id: map['id'],
      time: map['time'],
      type: map['type'],
      userid: map['userid'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['important_goal'] = importantgoal ?? 0;
    map['days'] = days ?? 0;
    map['name'] = name ?? '';
    map['resistance_training'] = resistanceTraining ?? 0;
    map['cardio'] = cardio ?? 0;
    map['date'] = date ?? formateDate(DateTime.now());
    if (exercises == null) {
      map['exercises'] = <RoutineExercise>[];
    } else {
      map['exercises'] = exercises?.map((e) => e.toMap()).toList();
    }
    map['id'] = id ?? '';
    map['time'] = time ?? 0;
    map['type'] = type ?? 0;
    map['userid'] = userid ?? '';
    map['duration'] = duration ?? 0;
    return map;
  }
}

class RoutineExercise {
  String? name, start, end;
  int? duration;
  bool? alarm, calendar, workouts;
  bool? completed;
  List<bool>? days;
  List<RoutineWorkouts>? rworkouts;

  RoutineExercise({
    this.alarm,
    this.days,
    this.duration,
    this.end,
    this.name,
    this.start,
    this.completed,
    this.calendar,
    this.workouts,
    this.rworkouts,
  });

  factory RoutineExercise.fromMap(var map) {
    return RoutineExercise(
      alarm: map['alarm'],
      days: map['days'].cast<bool>(),
      duration: map['duration'],
      end: map['end'],
      name: map['name'],
      start: map['start'],
      completed: map['completed'],
      calendar: map['calendar'],
      workouts: map['workouts'],
      rworkouts: map['rworkouts']
          .map<RoutineWorkouts>((e) => RoutineWorkouts.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['alarm'] = alarm ?? false;
    if (days == null) {
      map['days'] = [false, false, false, false, false, false, false];
    } else {
      map['days'] = days?.cast<bool>();
    }
    map['duration'] = duration ?? '';
    map['end'] = end ?? '';
    map['name'] = name ?? '';
    map['start'] = start ?? '';
    map['completed'] = completed ?? false;
    map['workouts'] = workouts ?? false;
    map['calendar'] = calendar ?? false;
    if (rworkouts == null) {
      map['rworkouts'] = <RoutineWorkouts>[];
    } else {
      map['rworkouts'] = rworkouts?.map((e) => e.toMap()).toList();
    }
    return map;
  }
}

class RoutineWorkouts {
  String? name;
  bool? show;
  List<WorkoutExercise>? exercises;

  RoutineWorkouts({this.name, this.show, this.exercises});

  factory RoutineWorkouts.fromMap(var map) {
    return RoutineWorkouts(
      name: map['name'],
      show: map['show'],
      exercises: map['exercises']
          .map<WorkoutExercise>((e) => WorkoutExercise.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name ?? '';
    map['show'] = show ?? false;
    if (exercises == null) {
      map['exercises'] = <WorkoutExercise>[];
    } else {
      map['exercises'] = exercises?.map((e) => e.toMap()).toList();
    }
    return map;
  }
}

class WorkoutExercise {
  String? name;
  List<WorkoutSets>? sets;

  WorkoutExercise({this.name, this.sets});

  factory WorkoutExercise.fromMap(var map) {
    return WorkoutExercise(
      name: map['name'],
      sets:
          map['sets'].map<WorkoutSets>((e) => WorkoutSets.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name ?? '';
    if (sets == null) {
      map['sets'] = <WorkoutSets>[];
    } else {
      map['sets'] = sets?.map((e) => e.toMap()).toList();
    }
    return map;
  }
}

class WorkoutSets {
  int? index;
  Sementics? reps, duration, rest;

  WorkoutSets({
    this.index,
    this.duration,
    this.reps,
    this.rest,
  });

  factory WorkoutSets.fromMap(var map) {
    return WorkoutSets(
      index: map['index'],
      duration: Sementics.fromMap(map['durations']),
      reps: Sementics.fromMap(map['reps']),
      rest: Sementics.fromMap(map['rest']),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['index'] = index ?? 0;
    if (duration == null) {
      map['durations'] = Sementics().toMap();
    } else {
      map['durations'] = duration?.toMap();
    }
    if (reps == null) {
      map['reps'] = Sementics().toMap();
    } else {
      map['reps'] = reps?.toMap();
    }
    if (rest == null) {
      map['rest'] = Sementics().toMap();
    } else {
      map['rest'] = rest?.toMap();
    }
    return map;
  }
}

class Sementics {
  int? value, type;

  Sementics({this.value, this.type});

  factory Sementics.fromMap(var map) {
    return Sementics(
      type: map['type'],
      value: map['value'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['type'] = type ?? 0;
    map['value'] = value ?? 0;
    return map;
  }
}
