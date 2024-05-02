import 'package:schedular_project/Functions/functions.dart';

/// Journals
/// 0: Connection Journal Level 0
/// 1: Connection Journal Level 1
/// 2: Connection Journal Level 2

class CJL0Model {
  String? id, userid, title, date;
  int? type, duration;
  ReachOutModel? reachout;
  DateTime? created;

  CJL0Model({
    this.created,
    this.date,
    this.id,
    this.reachout,
    this.title,
    this.type,
    this.userid,
    this.duration,
  });

  factory CJL0Model.fromMap(var map) {
    return CJL0Model(
      created: map['created'].toDate(),
      date: map['date'],
      id: map['id'],
      reachout: ReachOutModel.fromMap(map['reachout']),
      title: map['title'],
      type: map['type'],
      userid: map['userid'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    map['id'] = id ?? '';
    if (reachout == null) {
      map['reachout'] = ReachOutModel().toMap();
    } else {
      map['reachout'] = reachout?.toMap();
    }
    map['title'] = title ?? '';
    map['type'] = type ?? 0;
    map['userid'] = userid ?? '';
    map['duration']= duration ??0;
    return map;
  }
}

class ReachOutModel {
  bool? reachout, acknowledged, kindness, toHelp, forHelp;
  String? how;

  ReachOutModel({
    this.acknowledged,
    this.forHelp,
    this.how,
    this.kindness,
    this.reachout,
    this.toHelp,
  });

  factory ReachOutModel.fromMap(var map) {
    return ReachOutModel(
      acknowledged: map['Acknowledged somone'],
      forHelp: map['Asked for help'],
      how: map['how'],
      kindness: map['Random act of kindness'],
      reachout: map['Did you reach out to someone'],
      toHelp: map['Asked to help'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['Acknowledged somone'] = acknowledged ?? false;
    map['Asked for help'] = forHelp ?? false;
    map['how'] = how ?? '';
    map['Random act of kindness'] = kindness ?? false;
    map['Did you reach out to someone'] = reachout ?? false;
    map['Asked to help'] = toHelp ?? false;
    return map;
  }
}

class CJL1Model {
  DateTime? created;
  String? id, userid, title, date;
  int? type, duration;
  ReachOutModel? reachout;
  List<MREvent>? events;

  CJL1Model({
    this.created,
    this.date,
    this.events,
    this.id,
    this.reachout,
    this.title,
    this.type,
    this.userid,
    this.duration,
  });

  factory CJL1Model.fromMap(var map) {
    return CJL1Model(
      created: map['created'].toDate(),
      date: map['date'],
      events: map['events'].map<MREvent>((e) => MREvent.fromMap(e)).toList(),
      id: map['id'],
      reachout: ReachOutModel.fromMap(map['reach_out']),
      title: map['title'],
      type: map['type'],
      userid: map['userid'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    if (events == null) {
      map['events'] = <MREvent>[];
    } else {
      map['events'] = events?.map((e) => e.toMap()).toList();
    }
    map['id'] = id ?? '';
    if (reachout == null) {
      map['reach_out'] = ReachOutModel().toMap();
    } else {
      map['reach_out'] = reachout?.toMap();
    }
    map['title'] = title ?? '';
    map['type'] = type ?? 1;
    map['userid'] = userid ?? '';
    map['duration']= duration ??0;
    return map;
  }
}

class CJL2Model {
  String? id, userid, title, date;
  DateTime? created;
  int? type, duration;
  ReachOutModel? reachout;
  List<MREvent>? relationships;
  List<CommunityEvent>? community;

  CJL2Model({
    this.community,
    this.created,
    this.date,
    this.id,
    this.reachout,
    this.relationships,
    this.title,
    this.type,
    this.userid,
    this.duration,
  });

  factory CJL2Model.fromMap(var map) {
    return CJL2Model(
      community: map['community']
          .map<CommunityEvent>((e) => CommunityEvent.fromMap(e))
          .toList(),
      created: map['created'].toDate(),
      date: map['date'],
      id: map['id'],
      reachout: ReachOutModel.fromMap(map['reach_out']),
      relationships:
          map['relationships'].map<MREvent>((e) => MREvent.fromMap(e)).toList(),
      title: map['title'],
      type: map['type'],
      userid: map['userid'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    if (community == null) {
      map['community'] = <CommunityEvent>[];
    } else {
      map['community'] = community?.map((e) => e.toMap()).toList();
    }
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    map['id'] = id ?? '';
    if (reachout == null) {
      map['reach_out'] = ReachOutModel().toMap();
    } else {
      map['reach_out'] = reachout?.toMap();
    }
    if (relationships == null) {
      map['relationships'] = <MREvent>[];
    } else {
      map['relationships'] = relationships?.map((e) => e.toMap()).toList();
    }
    map['title'] = title ?? '';
    map['type'] = type ?? 2;
    map['userid'] = userid ?? '';
    map['duration']= duration ?? 0;
    return map;
  }
}

/// Relationships
/// 3: Meaningful Relationship
/// 4: Community

class MRModel {
  DateTime? created;
  String? id, userid, title, date;
  int? type, duration;
  List<MREvent>? events;

  MRModel({
    this.created,
    this.date,
    this.events,
    this.id,
    this.title,
    this.type,
    this.userid,
    this.duration,
  });

  factory MRModel.fromMap(var map) {
    return MRModel(
      created: map['created'].toDate(),
      date: map['date'],
      events: map['events'].map<MREvent>((e) => MREvent.fromMap(e)).toList(),
      id: map['id'],
      title: map['title'],
      type: map['type'],
      userid: map['userid'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    if (events == null) {
      map['events'] = <MREvent>[];
    } else {
      map['events'] = events?.map((e) => e.toMap()).toList();
    }
    map['id'] = id ?? '';
    map['title'] = title ?? '';
    map['type'] = type ?? 3;
    map['userid'] = userid ?? '';
    map['duration']= duration ??0;
    return map;
  }
}

class MREvent {
  String? name, pos, activity, time, date, canDo;
  bool? biMonthly, showup;
  List<bool>? days;

  MREvent({
    this.activity,
    this.biMonthly,
    this.canDo,
    this.date,
    this.days,
    this.name,
    this.pos,
    this.showup,
    this.time,
  });

  factory MREvent.fromMap(var map) {
    return MREvent(
      activity: map['activity'],
      biMonthly: map['biMonthly'],
      canDo: map['can_do'],
      date: map['date'],
      days: map['days'].cast<bool>().toList(),
      name: map['name'],
      pos: map['pos'],
      showup: map['showup'],
      time: map['time'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['activity'] = activity ?? '';
    map['biMonthly'] = biMonthly ?? false;
    map['can_do'] = canDo ?? '';
    map['date'] = date ?? '';
    if (days == null) {
      map['days'] = <bool>[false, false, false, false, false, false, false];
    } else {
      map['days'] = days?.cast<bool>().toList();
    }
    map['name'] = name ?? '';
    map['pos'] = pos ?? '';
    map['showup'] = showup ?? false;
    map['time'] = time ?? '';
    return map;
  }
}

class CommunityModel {
  String? id, userid, title, date;
  int? type, duration;
  DateTime? created;
  List<CommunityEvent>? events;

  CommunityModel({
    this.created,
    this.date,
    this.events,
    this.id,
    this.title,
    this.type,
    this.userid,
   this.duration,
  });

  factory CommunityModel.fromMap(var map) {
    return CommunityModel(
      created: map['created'].toDate(),
      date: map['date'],
      events: map['events']
          .map<CommunityEvent>((e) => CommunityEvent.fromMap(e))
          .toList(),
      id: map['id'],
      title: map['title'],
      type: map['type'],
      userid: map['userid'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    if (events == null) {
      map['events'] = <CommunityEvent>[];
    } else {
      map['events'] = events?.map((e) => e.toMap()).toList();
    }
    map['id'] = id ?? '';
    map['title'] = title ?? '';
    map['type'] = type ?? 4;
    map['userid'] = userid ?? '';
    map['duration']= duration ?? 0;
    return map;
  }
}

class CommunityEvent {
  String? name, pos, time, activity, link, description, date;
  bool? monthly, biMonthly, showup;
  List<bool>? days;

  CommunityEvent({
    this.date,
    this.activity,
    this.biMonthly,
    this.days,
    this.description,
    this.link,
    this.monthly,
    this.name,
    this.pos,
    this.time,
    this.showup,
  });

  factory CommunityEvent.fromMap(var map) {
    return CommunityEvent(
      activity: map['activity'],
      biMonthly: map['bi_monthly'],
      days: map['days'].cast<bool>().toList(),
      description: map['description'],
      link: map['link'],
      monthly: map['monthly'],
      name: map['name'],
      pos: map['pos'],
      time: map['time'],
      showup: map['showup'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['activity'] = activity ?? '';
    map['bi_monthly'] = biMonthly ?? false;
    if (days == null) {
      map['days'] = <bool>[false, false, false, false, false, false, false];
    } else {
      map['days'] = days!.cast<bool>().toList();
    }
    map['description'] = description ?? '';
    map['link'] = link ?? '';
    map['monthly'] = monthly ?? false;
    map['name'] = name ?? '';
    map['pos'] = pos ?? '';
    map['time'] = time ?? '';
    map['showup'] = showup ?? false;
    map['date'] = date ?? '';
    return map;
  }
}
