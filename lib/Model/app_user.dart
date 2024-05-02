import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedular_project/Functions/functions.dart';

class AppUser {
  String? id, name, email, password, deviceToken;
  DateTime? created, updated;

  AppUser({
    this.id,
    this.name,
    this.password,
    this.created,
    this.deviceToken,
    this.email,
    this.updated,
  });

  factory AppUser.fromMap(var map) {
    return AppUser(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      deviceToken: map['deviceToken'],
      created: map['created'].toDate(),
      updated: map['updated'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['created'] = created ?? DateTime.now();
    map['deviceToken'] = deviceToken;
    map['updated'] = updated ?? DateTime.now();
    return map;
  }
}

class ReadingModel {
  UserReadings? intro,
      breathing,
      visualization,
      mindfulness,
      reading,
      er,
      connection,
      gratitude,
      movement,
      diet,
      cold,
      goals,
      bd,
      eating,
      productivity,
      sexual;

  ReadingModel({
    this.bd,
    this.breathing,
    this.cold,
    this.connection,
    this.diet,
    this.er,
    this.goals,
    this.gratitude,
    this.intro,
    this.mindfulness,
    this.movement,
    this.reading,
    this.visualization,
    this.eating,
    this.productivity,
    this.sexual,
  });

  factory ReadingModel.fromMap(var map) {
    return ReadingModel(
      bd: UserReadings.fromMap(map['behavioral design']),
      breathing: UserReadings.fromMap(map['breathing']),
      cold: UserReadings.fromMap(map['cold']),
      connection: UserReadings.fromMap(map['connection']),
      diet: UserReadings.fromMap(map['eating']),
      er: UserReadings.fromMap(map['emotional regulation']),
      goals: UserReadings.fromMap(map['goals']),
      gratitude: UserReadings.fromMap(map['gratitude']),
      intro: UserReadings.fromMap(map['intro']),
      mindfulness: UserReadings.fromMap(map['mindfulness']),
      movement: UserReadings.fromMap(map['movement']),
      productivity: UserReadings.fromMap(map['productivity']),
      reading: UserReadings.fromMap(map['reading']),
      visualization: UserReadings.fromMap(map['visualization']),
      sexual: UserReadings.fromMap(map['sexual']),
      eating: UserReadings.fromMap(map['eating']),
    );
  }
}

class UserReadings {
  int? value, element;
  String? id;

  UserReadings({this.value, this.element, this.id});

  factory UserReadings.fromMap(var map) {
    return UserReadings(
        value: map['value'], element: map['element'], id: map['id']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['value'] = value ?? 0;
    map['element'] = element ?? 0;
    map['id'] = id ?? '';
    return map;
  }
}

class FreeReading {
  String? id, date;
  int? seconds;
  DateTime? start, end;

  FreeReading({
    this.date,
    this.end,
    this.id,
    this.seconds,
    this.start,
  });

  factory FreeReading.fromMap(var map) {
    return FreeReading(
      id: map['id'],
      date: map['date'],
      start: map['start'].toDate(),
      end: map['end'].toDate(),
      seconds: map['seconds'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['date'] = date ?? formateDate(DateTime.now());
    map['end'] = end ?? DateTime.now();
    map['start'] = start ?? DateTime.now();
    map['seconds'] = seconds ?? 0;
    return map;
  }
}

class CurrentExercises {
  String? id;
  int? value,
      index,
      previousPractice,
      previousReading,
      count,
      connectedReading,
      connectedPractice;
  DateTime? time;
  bool? completed;

  CurrentExercises({
    this.id,
    this.index,
    this.value,
    this.time,
    this.previousPractice,
    this.previousReading,
    this.count,
    this.connectedPractice,
    this.connectedReading,
    this.completed,
  });

  factory CurrentExercises.fromMap(var map) {
    return CurrentExercises(
      id: map['id'],
      value: map['value'],
      index: map['index'],
      time: map['time'].toDate(),
      previousPractice: map['previous_practice'],
      previousReading: map['previous_reading'],
      count: map['count'],
      connectedPractice: map['connected_practice'],
      connectedReading: map['connected_reading'],
      completed: map['completed'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['value'] = value ?? 0;
    map['index'] = index ?? 0;
    map['time'] = time ?? DateTime.now();
    map['count'] = count ?? 0;
    map['previous_practice'] = previousReading ?? 0;
    map['previous_reading'] = previousPractice ?? 0;
    map['connected_reading'] = connectedReading ?? 0;
    map['connected_practice'] = connectedPractice ?? 0;
    map['completed'] = completed ?? false;
    return map;
  }
}

class FreeBreathing {
  String? id, date, category, topic;
  int? seconds, type;
  DateTime? start, end;

  FreeBreathing({
    this.id,
    this.date,
    this.end,
    this.seconds,
    this.start,
    this.type,
    this.category,
    this.topic,
  });

  factory FreeBreathing.fromMap(var map) {
    return FreeBreathing(
      id: map['id'],
      date: map['date'],
      seconds: map['seconds'],
      start: map['start'].toDate(),
      end: map['end'].toDate(),
      type: map['type'],
      category: map['category'],
      topic: map['topic'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['date'] = date ?? formateDate(DateTime.now());
    map['type'] = type ?? 0;
    map['seconds'] = seconds ?? 0;
    map['start'] = start ?? DateTime.now();
    map['end'] = end ?? DateTime.now();
    map['category'] = category ?? '';
    map['topic'] = topic ?? '';
    return map;
  }
}

class TodayRoutines {
  String? date;
  List<TRModel>? routines;

  TodayRoutines({
    this.date,
    this.routines,
  });

  factory TodayRoutines.fromMap(var map) {
    return TodayRoutines(
      date: map['date'],
      routines:
          map['routines'].map<TRModel>((e) => TRModel.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['date'] = date ?? formateDate(DateTime.now());
    if (routines == null) {
      map['routines'] = <TRModel>[];
    } else {
      map['routines'] = routines?.map((e) => e.toMap()).toList();
    }
    return map;
  }
}

class TRModel {
  String? routineid;
  List<TREModel>? indexes;

  TRModel({this.routineid, this.indexes});

  factory TRModel.fromMap(var map) {
    return TRModel(
      routineid: map['routineid'],
      indexes:
          map['indexes'].map<TREModel>((e) => TREModel.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['routineid'] = routineid ?? '';
    if (indexes == null) {
      map['indexes'] = [];
    } else {
      map['indexes'] = indexes?.map((e) => e.toMap()).toList();
    }
    return map;
  }
}

class TREModel {
  int? index;
  List<int>? elements;

  TREModel({this.index, this.elements});

  factory TREModel.fromMap(var map) {
    return TREModel(
      index: map['index'],
      elements: map['elements'].cast<int>(),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['index'] = index ?? 0;
    if (elements == null) {
      map['elements'] = [];
    } else {
      map['elements'] = elements?.cast<int>().toList();
    }
    return map;
  }
}

class SettingModel {
  bool? start, open;
  int? autoContinue;
  String? userid;

  SettingModel({this.start, this.open, this.autoContinue, this.userid});

  factory SettingModel.fromMap(var map) {
    return SettingModel(
      start: map['start'],
      open: map['open'],
      autoContinue: map['continue'],
      userid: map['userid'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['start'] = start ?? false;
    map['open'] = open ?? false;
    map['continue'] = autoContinue ?? 0;
    map['userid'] = userid ?? '';
    return map;
  }
}

class AccomplishmentModel {
  int? category, total, max;
  String? id, advanced;
  List<ARoutines>? routines;

  AccomplishmentModel({
    this.category,
    this.total,
    this.max,
    this.id,
    this.routines,
    this.advanced,
  });

  factory AccomplishmentModel.fromMap(var map) {
    return AccomplishmentModel(
      category: map['category'],
      total: map['total'],
      max: map['max'],
      id: map['id'],
      routines:
          map['exercises'].map<ARoutines>((e) => ARoutines.fromMap(e)).toList(),
      advanced: map['advanced'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    map['category'] = category ?? 0;
    map['total'] = total ?? 0;
    map['max'] = max ?? 0;
    if (routines == null) {
      map['exercises'] = <ARoutines>[];
    } else {
      map['exercises'] = routines?.map((e) => e.toMap()).toList();
    }
    map['advanced'] = advanced ?? '';
    return map;
  }
}

class ARoutines {
  String? id, name;
  int? count, duration, index, category;
  String? date, categoryName;

  ARoutines({
    this.id,
    this.count,
    this.duration,
    this.date,
    this.name,
    this.index,
    this.categoryName,
    this.category,
  });

  factory ARoutines.fromMap(var map) {
    return ARoutines(
      id: map['id'],
      count: map['count'],
      duration: map['duration'],
      date: map['date'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    map['count'] = count ?? FieldValue.increment(1);
    map['duration'] = duration ?? 0;
    map['date'] = date ?? formateDate(DateTime.now());
    map['name'] = name ?? '';
    return map;
  }
}

class AExercise {
  int? index, duration;
}
