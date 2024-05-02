///0: guided cold
///1: freestyle cold

class GuidedColdModel {
  String? id, userid;
  int? type, option, level, exercise, seconds, duration;
  DateTime? created;

  GuidedColdModel({
    this.created,
   this.duration,
    this.exercise,
    this.id,
    this.level,
    this.option,
    this.seconds,
    this.type,
    this.userid,

  });

  factory GuidedColdModel.fromMap(var map) {
    return GuidedColdModel(
      created: map['created'].toDate(),
      duration: map['duration'],
      exercise: map['exercise'],
      id: map['id'],
      level: map['level'],
      option: map['option'],
      seconds: map['seconds'],
      type: map['type'],
      userid: map['userid'],
     
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['created'] = created ?? DateTime.now();
    map['duration'] = duration ?? 0;
    map['exercise'] = exercise ?? 0;
    map['id'] = id ?? '';
    map['level'] = level ?? 0;
    map['option'] = option ?? 0;
    map['seconds'] = seconds ?? 0;
    map['type'] = type ?? 0;
    map['userid'] = userid ?? '';

    return map;
  }
}

class FreestyleModel {
  String? id, userid;
  int? type, option, seconds, duration;
  DateTime? created;

  FreestyleModel({
    this.created,
   this.duration,
    this.id,
    this.option,
    this.seconds,
    this.type,
    this.userid,
    
  });

  factory FreestyleModel.fromMap(var map) {
    return FreestyleModel(
      created: map['created'].toDate(),
      duration: map['duration'],
      id: map['id'],
      option: map['option'],
      seconds: map['seconds'],
      type: map['type'],
      userid: map['userid'],
      
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['created'] = created ?? DateTime.now();
    map['duration'] = duration ?? 0;
    map['id'] = id ?? '';
    map['option'] = option ?? 0;
    map['seconds'] = seconds ?? 0;
    map['type'] = type ?? 1;
    map['userid'] = userid ?? '';
   
    return map;
  }
}
