import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Functions/functions.dart';

/// 0:Action Journal Level 0
/// 1: Action Journal Level 1
/// 2: Action Journal Level 2
/// 3: Action Journal Level 3

class AJL0Model {
  String? id, userid, name, date;
  int? type, duration;
  DateTime? created;
  EnergeticModel? mostEnergetic;
  List<AEventModel>? scheduled, actual;
  RightNowModel? rightnow;

  AJL0Model({
    this.created,
    this.date,
    this.scheduled,
    this.id,
    this.mostEnergetic,
    this.name,
    this.type,
    this.userid,
    this.rightnow,
    this.actual,
    this.duration,
  });

  factory AJL0Model.fromMap(var map) {
    return AJL0Model(
      created: map['created'].toDate(),
      date: map['date'],
      scheduled: map['events']
          .map<AEventModel>((e) => AEventModel.fromMap(e))
          .toList(),
      id: map['id'],
      mostEnergetic: EnergeticModel.fromMap(map['energetic']),
      name: map['name'],
      type: map['type'],
      userid: map['userid'],
      rightnow: RightNowModel.fromMap(map['right_now']),
      actual: map['actual']
          .map<AEventModel>((e) => AEventModel.fromMap(e))
          .toList(),
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['duration'] = duration ?? 0;
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    if (scheduled == null) {
      map['events'] = <AEventModel>[];
    } else {
      map['events'] = scheduled?.map((e) => e.toMap()).toList();
    }
    map['id'] = id ?? '';
    if (mostEnergetic == null) {
      map['energetic'] = EnergeticModel().toMap();
    } else {
      map['energetic'] = mostEnergetic?.toMap();
    }
    map['name'] = name ?? '';
    map['type'] = type ?? 0;
    map['userid'] = userid ?? '';
    if (rightnow == null) {
      map['right_now'] = RightNowModel().toMap();
    } else {
      map['right_now'] = rightnow?.toMap();
    }
    if (actual == null) {
      map['actual'] = [];
    } else {
      map['actual'] = actual!.map((e) => e.toMap()).toList();
    }
    return map;
  }
}

class EnergeticModel {
  String? start, end;

  EnergeticModel({this.end, this.start});

  factory EnergeticModel.fromMap(var map) {
    return EnergeticModel(
      end: map['end'],
      start: map['start'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['end'] = end ?? TimeOfDay.now().format(Get.context!);
    map['start'] = start ?? TimeOfDay.now().format(Get.context!);
    return map;
  }
}

class AEventModel {
  String? description, catid, previousid, pdesc;
  bool? completed, actualEvent, scheduledEvent, previous, played;
  EventDuration? actual, scheduled;
  int? category, urgency, index, eventindex, jindex, type, intcatype;

  AEventModel({
    this.completed,
    this.description,
    this.actual,
    this.scheduled,
    this.category,
    this.urgency,
    this.intcatype,
    this.actualEvent,
    this.scheduledEvent,
    this.catid,
    required this.index,
    this.previous,
    this.previousid,
    this.eventindex,
    this.jindex,
    this.type,
    this.played,
    this.pdesc,
  });

  factory AEventModel.fromMap(var map) {
    return AEventModel(
      completed: map['completed'],
      description: map['description'],
      actual: EventDuration.fromMap(map['actual']),
      scheduled: EventDuration.fromMap(map['scheduled']),
      category: map['category'],
      urgency: map['urgency'],
      actualEvent: map['actual_event'],
      scheduledEvent: map['scheduled_event'],
      catid: map['catid'],
      index: map['index'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['completed'] = completed ?? false;
    map['description'] = description ?? '';
    if (actual == null) {
      map['actual'] = EventDuration().toMap();
    } else {
      map['actual'] = actual?.toMap();
    }
    if (scheduled == null) {
      map['scheduled'] = EventDuration().toMap();
    } else {
      map['scheduled'] = scheduled?.toMap();
    }
    map['category'] = category ?? -1;
    map['urgency'] = urgency ?? -1;
    map['actual_event'] = actualEvent ?? false;
    map['scheduled_event'] = scheduledEvent ?? true;
    map['catid'] = catid ?? '';
    map['index'] = index ?? FieldValue.increment(1);
    return map;
  }
}

class EventDuration {
  String? start, end, date;
  int? duration;

  EventDuration({this.duration, this.end, this.start, this.date});

  factory EventDuration.fromMap(var map) {
    return EventDuration(
      duration: map['duration'],
      end: map['end'],
      start: map['start'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['duration'] = duration ?? 0;
    map['end'] = end ?? '';
    map['start'] = start ?? '';
    map['date'] = date ?? formateDate(DateTime.now());
    return map;
  }
}

class AJL1Model {
  String? id, userid, name, date;
  DateTime? created;
  int? type, duration;
  EnergeticModel? energetic;
  List<AEventModel>? events, actual;
  RightNowModel? rightnow;

  AJL1Model({
    this.created,
    this.date,
    this.energetic,
    this.events,
    this.id,
    this.name,
    this.rightnow,
    this.type,
    this.userid,
    this.actual,
    this.duration,
  });

  factory AJL1Model.fromMap(var json) {
    return AJL1Model(
      created: json['created'].toDate(),
      date: json['date'],
      energetic: EnergeticModel.fromMap(json['energetic']),
      events: json['events']
          .map<AEventModel>((e) => AEventModel.fromMap(e))
          .toList(),
      id: json['id'],
      name: json['name'],
      rightnow: RightNowModel.fromMap(json['right_now']),
      type: json['type'],
      userid: json['userid'],
      actual: json['actual']
          .map<AEventModel>((e) => AEventModel.fromMap(e))
          .toList(),
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    if (energetic == null) {
      map['energetic'] = EnergeticModel().toMap();
    } else {
      map['energetic'] = energetic?.toMap();
    }
    if (events == null) {
      map['events'] = <AEventModel>[];
    } else {
      map['events'] = events?.map((e) => e.toMap()).toList();
    }
    map['id'] = id ?? '';
    map['name'] = name ?? '';
    if (rightnow == null) {
      map['right_now'] = RightNowModel().toMap();
    } else {
      map['right_now'] = rightnow?.toMap();
    }
    map['type'] = type ?? 1;
    map['userid'] = userid ?? '';
    if (actual == null) {
      map['actual'] = [];
    } else {
      map['actual'] = actual?.map((e) => e.toMap()).toList();
    }
    map['duration'] = duration ?? 0;
    return map;
  }
}

class RightNowModel {
  String? description, catid;
  int? category, urgency;
  EventDuration? duration;

  RightNowModel({
    this.category,
    this.description,
    this.duration,
    this.urgency,
    this.catid,
  });

  factory RightNowModel.fromMap(var map) {
    return RightNowModel(
      description: map['description'],
      category: map['category'],
      duration: EventDuration.fromMap(map['duration']),
      urgency: map['urgency'],
      catid: map['catid'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['description'] = description ?? '';
    map['category'] = category ?? -1;
    if (duration == null) {
      map['duration'] = EventDuration().toMap();
    } else {
      map['duration'] = duration?.toMap();
    }
    map['urgency'] = urgency ?? 0;
    map['catid'] = catid ?? '';
    return map;
  }
}

class AJL2Model {
  String? id, userid, name, date;
  int? type, duration;
  DateTime? created;
  EnergeticModel? energetic;
  RightNowModel? rightNow;
  List<AEventModel>? events, actual;

  AJL2Model({
    this.created,
    this.date,
    this.energetic,
    this.events,
    this.id,
    this.name,
    this.rightNow,
    this.type,
    this.userid,
    this.actual,
    this.duration,
  });

  factory AJL2Model.fromMap(var map) {
    return AJL2Model(
      created: map['created'].toDate(),
      date: map['date'],
      energetic: EnergeticModel.fromMap(map['energetic']),
      events: map['events']
          .map<AEventModel>((e) => AEventModel.fromMap(e))
          .toList(),
      id: map['id'],
      name: map['name'],
      rightNow: RightNowModel.fromMap(map['right_now']),
      type: map['type'],
      userid: map['userid'],
      actual: map['actual']
          .map<AEventModel>((e) => AEventModel.fromMap(e))
          .toList(),
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    if (energetic == null) {
      map['energetic'] = EnergeticModel().toMap();
    } else {
      map['energetic'] = energetic?.toMap();
    }
    if (events == null) {
      map['events'] = <AEventModel>[];
    } else {
      map['events'] = events?.map((e) => e.toMap()).toList();
    }
    map['id'] = id ?? '';
    map['name'] = name ?? '';
    if (rightNow == null) {
      map['right_now'] = RightNowModel().toMap();
    } else {
      map['right_now'] = rightNow?.toMap();
    }
    map['type'] = type ?? 2;
    map['userid'] = userid ?? '';
    if (actual == null) {
      map['actual'] = [];
    } else {
      map['actual'] = actual?.map((e) => e.toMap()).toList();
    }
    map['duration'] = duration ?? 0;
    return map;
  }
}

class AJL3Model {
  String? id, userid, name, date;
  int? type, pomodoro, pomodoroDuration, pomodoroRest, duration;
  DateTime? created;
  EnergeticModel? energetic;
  RightNowModel? rightNow;
  List<AEventModel>? events, actual;

  AJL3Model({
    this.created,
    this.date,
    this.energetic,
    this.events,
    this.id,
    this.name,
    this.rightNow,
    this.type,
    this.userid,
    this.pomodoro,
    this.actual,
    this.pomodoroDuration,
    this.pomodoroRest,
    this.duration,
  });

  factory AJL3Model.fromMap(var map) {
    return AJL3Model(
      created: map['created'].toDate(),
      date: map['date'],
      energetic: EnergeticModel.fromMap(map['energetic']),
      events: map['events']
          .map<AEventModel>((e) => AEventModel.fromMap(e))
          .toList(),
      id: map['id'],
      name: map['name'],
      rightNow: RightNowModel.fromMap(map['right_now']),
      type: map['type'],
      userid: map['userid'],
      pomodoro: map['pomodoro'],
      actual: map['actual']
          .map<AEventModel>((e) => AEventModel.fromMap(e))
          .toList(),
      pomodoroDuration: map['pomodoro_duration'],
      pomodoroRest: map['pomodoro_rest'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    if (energetic == null) {
      map['energetic'] = EnergeticModel().toMap();
    } else {
      map['energetic'] = energetic?.toMap();
    }
    if (events == null) {
      map['events'] = <AEventModel>[];
    } else {
      map['events'] = events?.map((e) => e.toMap()).toList();
    }
    map['id'] = id ?? '';
    map['name'] = name ?? '';
    if (rightNow == null) {
      map['right_now'] = RightNowModel().toMap();
    } else {
      map['right_now'] = rightNow?.toMap();
    }
    map['type'] = type ?? 3;
    map['userid'] = userid ?? '';
    map['pomodoro'] = pomodoro ?? 0;
    if (actual == null) {
      map['actual'] = [];
    } else {
      map['actual'] = actual?.map((e) => e.toMap()).toList();
    }
    map['pomodoro_duration'] = pomodoroDuration ?? 0;
    map['pomodoro_rest'] = pomodoroRest ?? 0;
    map['duration'] = duration ?? 0;
    return map;
  }
}
