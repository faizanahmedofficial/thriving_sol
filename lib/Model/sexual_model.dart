import 'package:schedular_project/Functions/functions.dart';

/// 0: PC Journal Level 0
/// 1: PC Journal Level 1
///

class PCJ0Model {
  String? id, userid, name, date;
  int? type, duration;
  bool? find;
  DateTime? created;

  PCJ0Model({
    this.created,
    this.date,
    this.find,
    this.id,
    this.name,
    this.type,
    this.userid,
    this.duration,
  });

  factory PCJ0Model.fromMap(var map) {
    return PCJ0Model(
      created: map['created'].toDate(),
      date: map['date'],
      find: map['Did you find your PC muscle'],
      id: map['id'],
      name: map['name'],
      type: map['type'],
      userid: map['userid'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    map['Did you find your PC muscle'] = find ?? false;
    map['id'] = id ?? '';
    map['name'] = name ?? '';
    map['type'] = type ?? 0;
    map['userid'] = userid ?? '';
    map['duration']= duration ?? 0;
    return map;
  }
}

class PCJ1Model {
  String? id, userid, name, date;
  DateTime? created;
  int? type, goal, level, exercise, total, rest, eset, duration;

  PCJ1Model({
    this.created,
    this.date,
    this.exercise,
    this.goal,
    this.id,
    this.level,
    this.name,
    this.type,
    this.userid,
    this.rest,
    this.eset,
    this.total,
   this.duration,
  });

  factory PCJ1Model.fromMap(var map) {
    return PCJ1Model(
      created: map['created'].toDate(),
      date: map['date'],
      exercise: map['exercise'],
      goal: map['goal'],
      id: map['id'],
      level: map['level'],
      name: map['name'],
      type: map['type'],
      userid: map['userid'],
      eset: map['eset'],
      rest: map['rest'],
      total: map['total'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    map['exercise'] = exercise ?? 1;
    map['goal'] = goal ?? 0;
    map['id'] = id ?? 0;
    map['level'] = level ?? 1;
    map['type'] = type ?? 1;
    map['userid'] = userid ?? '';
    map['rest'] = rest ?? 0;
    map['eset'] = eset ?? 1;
    map['name'] = name ?? '';
    map['total'] = total ?? 0;
    map['duration']= duration ?? 0;
    return map;
  }
}
