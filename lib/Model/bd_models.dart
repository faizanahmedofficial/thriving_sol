import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Model/visualization_model.dart';

/// 0: Nudges
/// 1: Habit
/// 2: Ideal Time Use
/// 3: Tactical Review
/// 4: Pomodoro Timer
///

class PomodoroModel {
  String? id, userid;
  int? type, pomodoro, totalduration, totalRest, duration;
  DateTime? created;

  PomodoroModel({
    this.created,
    this.id,
    this.pomodoro,
    this.totalRest,
    this.totalduration,
    this.type,
    this.userid,
    this.duration,
  });

  factory PomodoroModel.fromMap(var map) {
    return PomodoroModel(
      created: map['created'].toDate(),
      id: map['id'],
      pomodoro: map['pomodoro'],
      totalRest: map['rest'],
      totalduration: map['duration'],
      type: map['type'],
      userid: map['userid'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['created'] = created ?? DateTime.now();
    map['id'] = id ?? '';
    map['pomodoro'] = pomodoro ?? 0;
    map['rest'] = totalRest ?? 0;
    map['duration'] = totalduration ?? 0;
    map['type'] = type ?? 4;
    map['userid'] = userid ?? '';
    map['duration']= duration ?? 0;
    return map;
  }
}

class TacticalReviewModel {
  String? id,
      userid,
      name,
      // productiveTime,
      quadrantAnalysis,
      gap,
      categoriesSpendLess,
      categoreisSpendMore,
      didntDo,
      surpriseYou,
      idealTime,
      startdate,
      endDate;
  int? type, spentHours, actionsCompleted, duration;
  DateTime? created;

  TacticalReviewModel({
    this.actionsCompleted,
    this.categoreisSpendMore,
    this.categoriesSpendLess,
    this.created,
    this.didntDo,
    this.gap,
    this.id,
    this.idealTime,
    this.name,
    // this.productiveTime,
    this.quadrantAnalysis,
    this.spentHours,
    this.surpriseYou,
    this.type,
    this.userid,
    this.startdate,
    this.endDate,
    this.duration,
  });

  factory TacticalReviewModel.fromMap(var map) {
    return TacticalReviewModel(
      actionsCompleted: map['actions completed'],
      categoreisSpendMore: map['categories to spend more time'],
      categoriesSpendLess: map['categories to spend less time'],
      created: map['created'].toDate(),
      startdate: map['start_date'],
      didntDo: map['did not do'],
      gap: map['gap'],
      id: map['id'],
      idealTime: map['ideal_time'],
      name: map['name'],
      // productiveTime: map['productive_time'],
      quadrantAnalysis: map['quadrant analysis'],
      spentHours: map['hours spent'],
      surpriseYou: map['surprise you'],
      type: map['type'],
      userid: map['userid'],
      endDate: map['end_date'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['actions completed'] = actionsCompleted ?? 0;
    map['categories to spend more time'] = categoreisSpendMore ?? '';
    map['categories to spend less time'] = categoriesSpendLess ?? '';
    map['created'] = created ?? DateTime.now();
    map['start_date'] = startdate ?? formateDate(DateTime.now());
    map['did not do'] = didntDo ?? '';
    map['gap'] = gap ?? '';
    map['id'] = id ?? '';
    map['ideal_time'] = idealTime ?? '';
    map['name'] = name ?? '';
    // map['productive_time'] = productiveTime ?? '';
    map['quadrant analysis'] = quadrantAnalysis ?? '';
    map['hours spent'] = spentHours ?? 0;
    map['surprise you'] = surpriseYou ?? '';
    map['type'] = type ?? 3;
    map['userid'] = userid ?? '';
    map['end_date'] = endDate ?? formateDate(DateTime.now());
    map['duration']= duration ?? 0;
    return map;
  }
}

class IdealTimeModel {
  String? id, userid, name, date;
  int? type, duration;
  DateTime? created;
  List<IdealCategory>? categories;

  IdealTimeModel({
    this.categories,
    this.created,
    this.date,
    this.id,
    this.name,
    this.type,
    this.userid,
     this.duration
  });

  factory IdealTimeModel.fromMap(var map) {
    return IdealTimeModel(
      categories: map['categories']
          .map<IdealCategory>((e) => IdealCategory.fromMap(e))
          .toList(),
      created: map['created'].toDate(),
      date: map['date'],
      id: map['id'],
      name: map['name'],
      type: map['type'],
      userid: map['userid'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    if (categories == null) {
      map['categories'] = <IdealCategory>[];
    } else {
      map['categories'] = categories?.map((e) => e.toMap()).toList();
    }
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    map['id'] = id ?? '';
    map['name'] = name ?? '';
    map['type'] = type ?? 2;
    map['userid'] = userid ?? '';
    map['duration']= duration ?? 0;
    return map;
  }
}

class IdealCategory {
  String? category;
  double? percentage;

  IdealCategory({this.category, this.percentage});

  factory IdealCategory.fromMap(var map) {
    return IdealCategory(
      category: map['category'],
      percentage: map['percentage'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['category'] = category ?? '';
    map['percentage'] = percentage ?? 0.0;
    return map;
  }
}

class NudgeModel {
  String? id, userid, setups, cueWritein, chainWritein, rewardWritein;
  int? type, routine, cue, setup, reward, chain, alarm, duration;
  DateTime? created;

  NudgeModel({
    this.chain,
    this.created,
    this.cue,
    this.id,
    this.reward,
    this.routine,
    this.setup,
    this.type,
    this.userid,
    this.setups,
    this.alarm,
    this.cueWritein,
    this.chainWritein,
    this.rewardWritein,
   this.duration,
  });

  factory NudgeModel.fromMap(var map) {
    return NudgeModel(
      chain: map['chain'],
      created: map['created'].toDate(),
      cue: map['cue'],
      id: map['id'],
      reward: map['reward'],
      routine: map['routine'],
      setup: map['setup'],
      type: map['type'],
      userid: map['userid'],
      setups: map['setups'],
      alarm: map['alarm'],
      cueWritein: map['cue_writein'],
      chainWritein: map['chain_writein'],
      rewardWritein: map['reward_writein'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['chain'] = chain ?? 0;
    map['created'] = created ?? DateTime.now();
    map['cue'] = cue ?? 0;
    map['id'] = id ?? '';
    map['reward'] = reward ?? 0;
    map['routine'] = routine ?? 0;
    map['setup'] = setup ?? 0;
    map['type'] = type ?? 0;
    map['userid'] = userid ?? '';
    map['setups'] = setups ?? '';
    map['alarm']= alarm ?? 0;
    map['cue_writein']= cueWritein ?? '';
    map['chain_writein'] = chainWritein ?? '';
    map['reward_writein']= rewardWritein ?? '';
    map['duration']= duration ?? 0;
    return map;
  }
}

class HabitModel {
  String? id, userid, name, date, desiredActivity, audio;
  GetMotivated? motivated;
  MakeRealistic? realistic;
  List<bool>? days;
  bool? habitToCalendar;
  MakeObvious? obvious;
  MakeEasier? easier;
  MakeEnjoyable? enjoyable;
  String? script;
  CheckModel? checks;
  DateTime? created;
  int? type, duration;

  HabitModel({
    this.checks,
    this.created,
    this.date,
    this.days,
    this.desiredActivity,
    this.easier,
    this.enjoyable,
    this.habitToCalendar,
    this.id,
    this.motivated,
    this.name,
    this.obvious,
    this.realistic,
    this.script,
    this.type,
    this.userid,
    this.audio,
    this.duration,
  });

  factory HabitModel.fromMap(var map) {
    return HabitModel(
      checks: CheckModel.fromMap(map['checks']),
      created: map['created'].toDate(),
      date: map['date'],
      days: map['days'].cast<bool>().toList(),
      desiredActivity: map['desired_activity'],
      easier: MakeEasier.fromMap(map['easier']),
      enjoyable: MakeEnjoyable.fromMap(map['enjoyable']),
      habitToCalendar: map['to_calendar'],
      id: map['id'],
      motivated: GetMotivated.fromMap(map['motivated']),
      name: map['name'],
      obvious: MakeObvious.fromMap(map['obvious']),
      realistic: MakeRealistic.fromMap(map['realistic']),
      script: map['script'],
      type: map['type'],
      userid: map['userid'],
      audio: map['audio'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    if (checks == null) {
      map['checks'] = CheckModel().toMap();
    } else {
      map['checks'] = checks?.toMap();
    }
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    if (days == null) {
      map['days'] = <bool>[false, false, false, false, false, false, false];
    } else {
      map['days'] = days?.cast<bool>().toList();
    }
    map['desired_activity'] = desiredActivity ?? '';
    if (easier == null) {
      map['easier'] = MakeEasier().toMap();
    } else {
      map['easier'] = easier?.toMap();
    }
    if (enjoyable == null) {
      map['enjoyable'] = MakeEnjoyable().toMap();
    } else {
      map['enjoyable'] = enjoyable?.toMap();
    }
    map['to_calendar'] = habitToCalendar ?? false;
    map['id'] = id ?? '';
    if (motivated == null) {
      map['motivated'] = GetMotivated().toMap();
    } else {
      map['motivated'] = motivated?.toMap();
    }
    map['name'] = name ?? '';
    if (obvious == null) {
      map['obvious'] = MakeObvious().toMap();
    } else {
      map['obvious'] = obvious?.toMap();
    }
    if (realistic == null) {
      map['realistic'] = MakeRealistic().toMap();
    } else {
      map['realistic'] = realistic?.toMap();
    }
    map['script'] = script ?? '';
    map['type'] = type ?? 1;
    map['userid'] = userid ?? '';
    map['audio']= audio ?? '';
    map['duration']= duration ?? 0;
    return map;
  }
}

class MakeEnjoyable {
  String? shortTerm, celebration, accountability;

  MakeEnjoyable({this.accountability, this.celebration, this.shortTerm});

  factory MakeEnjoyable.fromMap(var map) {
    return MakeEnjoyable(
      accountability: map['accountability'],
      celebration: map['celebration'],
      shortTerm: map['short_term'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['accountability'] = accountability ?? '';
    map['celebration'] = celebration ?? '';
    map['short_term'] = shortTerm ?? '';
    return map;
  }
}

class MakeEasier {
  String? simplification, defaultOption, babyStep, contingency;

  MakeEasier({
    this.babyStep,
    this.contingency,
    this.defaultOption,
    this.simplification,
  });

  factory MakeEasier.fromMap(var map) {
    return MakeEasier(
      babyStep: map['baby_step'],
      contingency: map['contingency_plan'],
      defaultOption: map['default_option'],
      simplification: map['simplification'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['baby_step'] = babyStep ?? '';
    map['contingency_plan'] = contingency ?? '';
    map['default_option'] = defaultOption ?? '';
    map['simplification'] = simplification ?? '';
    return map;
  }
}

class MakeObvious {
  String? environment, visualCue, sensorycue;
  int? alarm;

  MakeObvious({
    this.alarm,
    this.environment,
    this.sensorycue,
    this.visualCue,
  });

  factory MakeObvious.fromMap(var map) {
    return MakeObvious(
      alarm: map['alarm'],
      environment: map['environment'],
      sensorycue: map['sensory_cue'],
      visualCue: map['visual_cue'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['alarm'] = alarm ?? 0;
    map['environment'] = environment ?? '';
    map['sensory_cue'] = sensorycue ?? '';
    map['visual_cue'] = visualCue ?? '';
    return map;
  }
}

class MakeRealistic {
  String? chain, startTime, duration;
  int? seconds;

  MakeRealistic({this.chain, this.duration, this.seconds, this.startTime});

  factory MakeRealistic.fromMap(var map) {
    return MakeRealistic(
      chain: map['chain'],
      duration: map['duration'],
      seconds: map['seconds'],
      startTime: map['start_time'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['chain'] = chain ?? '';
    map['duration'] = duration ?? '';
    map['seconds'] = seconds ?? 0;
    map['start_time'] = startTime ?? '';
    return map;
  }
}

class GetMotivated {
  String? goal, value, deepestWhy;

  GetMotivated({this.deepestWhy, this.goal, this.value});

  factory GetMotivated.fromMap(var map) {
    return GetMotivated(
      deepestWhy: map['deepest_why'],
      goal: map['goal'],
      value: map['value'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['deepest_why'] = deepestWhy ?? '';
    map['goal'] = goal ?? '';
    map['value'] = value ?? '';
    return map;
  }
}
