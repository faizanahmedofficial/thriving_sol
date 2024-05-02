import 'package:schedular_project/Functions/functions.dart';

class RoutineModel {
  String? id, userid, duration, date;
  int? time, goal, type, seconds; // type [0: Manual, 1: Personalized]
  DateTime? created;
  bool? completed;
  List<Routines>? routines; // 0: Morning, 1: Afternoon, 2: evening,

  RoutineModel({
    this.completed,
    this.created,
    this.goal,
    this.id,
    this.routines,
    this.time,
    this.type,
    this.userid,
    this.duration,
    this.seconds,
    this.date,
  });

  factory RoutineModel.fromMap(var map) {
    return RoutineModel(
      id: map['id'],
      userid: map['userid'],
      type: map['type'],
      created: map['created'].toDate(),
      time: map['time'],
      goal: map['goal'],
      duration: map['duration'],
      seconds: map['seconds'],
      completed: map['completed'],
      routines:
          map['routines'].map<Routines>((e) => Routines.fromMap(e)).toList(),
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    map['userid'] = userid ?? '';
    map['time'] = time ?? 5;
    map['goal'] = goal ?? 0;
    map['duration'] = duration ?? '';
    map['seconds'] = seconds ?? 0;
    map['type'] = type ?? 1;
    map['completed'] = completed ?? false;
    map['created'] = created ?? DateTime.now();
    if (routines == []) {
      map['routines'] = [Routines().toMap()];
    } else {
      map['routines'] = routines!.map((e) => e.toMap()).toList();
    }
    map['date'] = date ?? formateDate(DateTime.now());
    return map;
  }
}

class Routines {
  String? starttime, name, actualtime, duration;
  int? color, seconds, alarm;
  bool? completed;
  List<RoutineElements>? elements;
  Nudges? nudges;
  List<bool>? days;
  NudgeCompleted? nCompleted;

  Routines({
    this.completed,
    this.elements,
    this.name,
    this.starttime,
    this.actualtime,
    this.nudges,
    this.color,
    this.duration,
    this.seconds,
    this.days,
    this.nCompleted,
    this.alarm,
  });

  factory Routines.fromMap(var map) {
    return Routines(
      starttime: map['time'],
      name: map['name'],
      completed: map['completed'],
      elements: map['elements']
          .map<RoutineElements>((e) => RoutineElements.fromMap(e))
          .toList(),
      actualtime: map['actualtime'],
      nudges: Nudges.fromMap(map['nudges']),
      color: map['color'],
      duration: map['duration'],
      seconds: map['seconds'],
      days: map['days'].cast<bool>().toList(),
      nCompleted: NudgeCompleted.fromMap(map['n_completed']),
      alarm: map['alarm'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['time'] = starttime ?? '';
    map['completed'] = completed ?? false;
    map['name'] = name ?? '';
    map['actualtime'] = actualtime ?? '';
    map['color'] = color ?? 0xff000000;
    map['duration'] = duration ?? '';
    if (elements == []) {
      map['elements'] = [RoutineElements().toMap()];
    } else {
      map['elements'] = elements!.map((e) => e.toMap()).toList();
    }
    if (nudges == null) {
      map['nudges'] = Nudges().toMap();
    } else {
      map['nudges'] = nudges?.toMap();
    }
    if (map['days'] == []) {
      map['days'] = <bool>[true,true,true,true,true,true,true];
    } else {
      map['days'] = days!.toList();
    }
    if (nCompleted == null) {
      map['n_completed'] = NudgeCompleted().toMap();
    } else {
      map['n_completed'] = nCompleted?.toMap();
    }
    map['seconds'] = seconds ?? 0;
    map['alarm']= alarm ?? 0;
    return map;
  }
}

class RoutineElements {
  int? category, seconds, index, type;
  String? duration;
  bool? completed;

  RoutineElements({
    this.category,
    this.seconds,
    this.duration,
    this.index,
    this.completed,
    this.type,
  });

  factory RoutineElements.fromMap(var map) {
    return RoutineElements(
      category: map['category'],
      seconds: map['seconds'],
      duration: map['duration'],
      index: map['index'],
      completed: map['completed'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['category'] = category ?? 0;
    map['seconds'] = seconds ?? 0;
    map['duration'] = duration ?? '';
    map['index'] = index ?? 0;
    map['completed'] = completed ?? false;
    return map;
  }
}

class Nudges {
  String? setup, wcue, wchain, wreward;
  int? cue, chain, reward;

  Nudges({
    this.setup,
    this.chain,
    this.cue,
    this.reward,
    this.wchain,
    this.wcue,
    this.wreward,
  });

  factory Nudges.fromMap(var map) {
    return Nudges(
      setup: map['setup'],
      chain: map['chain'],
      cue: map['cue'],
      reward: map['reward'],
      wchain: map['chain_writein'],
      wcue: map['cue_writein'],
      wreward: map['reward_write'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['setup'] = setup ?? '';
    map['chain'] = chain ?? 0;
    map['cue'] = cue ?? 3;
    map['reward'] = reward ?? 8;
    map['cue_writein'] = wcue ?? '';
    map['chain_writein'] = wchain ?? '';
    map['reward_writein'] = wreward ?? '';
    return map;
  }
}

class NudgeCompleted {
  bool? setup, cue, chain, reward;

  NudgeCompleted({this.setup, this.chain, this.cue, this.reward});

  factory NudgeCompleted.fromMap(var map) {
    return NudgeCompleted(
      setup: map['setup'],
      chain: map['chain'],
      cue: map['cue'],
      reward: map['reward'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['setup'] = setup ?? false;
    map['chain'] = chain ?? false;
    map['cue'] = cue ?? false;
    map['reward'] = reward ?? false;
    return map;
  }
}
