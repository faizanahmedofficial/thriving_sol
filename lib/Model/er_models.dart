import 'package:schedular_project/Functions/functions.dart';

/// Exercises
/// 0: Baby Reframing; 1: behavioral activation; 2: resolve the situation
/// 3: ABC Root Analysis, 4: fact chacking your toughts (test)
/// 5: Fact Checking Your Thoughts, 6: identifying cognitive distortions
/// 7: refreming cognitive distortions & negative thoughts
class BfModel {
  String? id, userid, title, expectation, reframed, date;
  int? expBelief, reframedBelief, type, duration;
  DateTime? created;

  BfModel({
    this.created,
    this.date,
    this.expBelief,
    this.expectation,
    this.id,
    this.reframed,
    this.reframedBelief,
    this.title,
    this.userid,
    this.type,
    this.duration,
  });

  factory BfModel.fromMap(var map) {
    return BfModel(
      id: map['id'],
      created: map['created'].toDate(),
      date: map['date'],
      expBelief: map['expected'],
      expectation: map['expectation'],
      reframed: map['reframe'],
      reframedBelief: map['reframed'],
      title: map['title'],
      userid: map['userid'],
      type: map['type'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    map['expected'] = expBelief ?? 0;
    map['expectation'] = expectation ?? '';
    map['reframe'] = reframed ?? '';
    map['reframed'] = reframedBelief ?? 0;
    map['title'] = title ?? '';
    map['userid'] = userid ?? '';
    map['type'] = type ?? 0;
    map['duration']= duration ?? 0;
    return map;
  }
}

class BAModel {
  String? id, userid, title, date;
  int? type, duration;
  List<BAEvents>? events;
  DateTime? created;

  BAModel({
    this.id,
    this.userid,
    this.title,
    this.created,
    this.date,
    this.events,
    this.type,
    this.duration,
  });

  factory BAModel.fromMap(var map) {
    return BAModel(
      id: map['id'],
      userid: map['userid'],
      title: map['title'],
      date: map['date'],
      created: map['created'].toDate(),
      type: map['type'],
      events: map['events'].map<BAEvents>((e) => BAEvents.fromMap(e)).toList(),
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['userid'] = userid;
    map['created'] = created ?? DateTime.now();
    map['type'] = type ?? 1;
    map['title'] = title ?? '';
    map['date'] = date ?? formateDate(DateTime.now());
    if (events == null) {
      map['events'] = [BAEvents().toMap()];
    } else {
      map['events'] = events?.map((e) => e.toMap()).toList();
    }
    map['duration']= duration ?? 0;
    return map;
  }
}

class BAEvents {
  String? description, start, end;
  bool? completed;
  int? index;

  BAEvents({
    this.description,
    this.start,
    this.end,
    this.completed,
    this.index,
  });

  factory BAEvents.fromMap(var map) {
    return BAEvents(
      description: map['description'],
      start: map['start'],
      end: map['end'],
      index: map['index'],
      completed: map['completed'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['description'] = description ?? '';
    map['start'] = start ?? '00:00';
    map['end'] = end ?? '00:00';
    map['index'] = index ?? 0;
    map['completed'] = completed ?? false;
    return map;
  }
}

class ResolutionModel {
  String? id, userid, title, date, solution, fiveYears, advice, alternative;
  int? type, duration;
  DateTime? created;

  ResolutionModel({
    this.advice,
    this.alternative,
    this.created,
    this.date,
    this.fiveYears,
    this.id,
    this.solution,
    this.title,
    this.type,
    this.userid,
    this.duration,
  });

  factory ResolutionModel.fromMap(var map) {
    return ResolutionModel(
      advice: map['advice'],
      alternative: map['alternative'],
      created: map['created'].toDate(),
      date: map['date'],
      fiveYears: map['five_years'],
      id: map['id'],
      solution: map['solution'],
      title: map['title'],
      type: map['type'],
      userid: map['userid'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['advice'] = advice ?? '';
    map['alternative'] = alternative ?? '';
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    map['five_years'] = fiveYears ?? '';
    map['id'] = id ?? '';
    map['solution'] = solution ?? '';
    map['title'] = title ?? '';
    map['type'] = type ?? 2;
    map['userid'] = userid ?? '';
    map['duration']= duration ?? 0;
    return map;
  }
}

class RAModel {
  String? id, userid, date, time, cdate, title;
  bool? precedent;
  DateTime? created;
  List<String>? persons, places, actions, triggers, behaviors, consequences;
  int? type, duration;

  RAModel({
    this.id,
    this.actions,
    this.behaviors,
    this.cdate,
    this.consequences,
    this.created,
    this.date,
    this.persons,
    this.places,
    this.precedent,
    this.time,
    this.triggers,
    this.title,
    this.userid,
    this.type,
    this.duration,
  });

  factory RAModel.fromMap(var map) {
    return RAModel(
      id: map['id'],
      actions: map['actions'].cast<String>(),
      behaviors: map['behaviors'].cast<String>(),
      cdate: map['cdate'],
      consequences: map['consequences'].cast<String>(),
      created: map['created'].toDate(),
      date: map['date'],
      persons: map['persons'].cast<String>(),
      places: map['places'].cast<String>(),
      precedent: map['precedent'],
      time: map['time'],
      triggers: map['triggers'].cast<String>(),
      userid: map['userid'],
      title: map['title'],
      type: map['type'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    if (actions == null) {
      map['actions'] = <String>[];
    } else {
      map['actions'] = actions?.toList();
    }
    if (behaviors == null) {
      map['behaviors'] = <String>[];
    } else {
      map['behaviors'] = behaviors?.toList();
    }
    map['cdate'] = cdate ?? formateDate(DateTime.now());
    if (consequences == null) {
      map['consequences'] = <String>[];
    } else {
      map['consequences'] = consequences?.toList();
    }
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    if (persons == null) {
      map['persons'] = <String>[];
    } else {
      map['persons'] = persons?.toList();
    }
    if (places == null) {
      map['places'] = <String>[];
    } else {
      map['places'] = places?.toList();
    }
    map['precedent'] = precedent ?? false;
    map['time'] = time ?? '00:00';
    if (triggers == null) {
      map['triggers'] = <String>[];
    } else {
      map['triggers'] = triggers?.toList();
    }
    map['userid'] = userid ?? '';
    map['title'] = title ?? '';
    map['type'] = type ?? 3;
    map['duration']= duration ?? 0;
    return map;
  }
}

class FCTestModel {
  String? id, userid, date, title;
  int? type, score, duration;
  double? percentage;
  DateTime? created;
  ThoughtModel? thoughts;

  FCTestModel({
    this.created,
    this.date,
    this.id,
    this.percentage,
    this.score,
    this.thoughts,
    this.title,
    this.type,
    this.userid,
    this.duration,
  });

  factory FCTestModel.fromMap(var map) {
    return FCTestModel(
      created: map['created'].toDate(),
      date: map['date'],
      id: map['id'],
      percentage: map['percentage'],
      score: map['score'],
      thoughts: ThoughtModel.fromMap(map['thoughts']),
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
    map['id'] = id;
    map['percentage'] = percentage ?? 0;
    map['score'] = score ?? 0;
    if (thoughts == null) {
      map['thoughts'] = ThoughtModel().toMap();
    } else {
      map['thoughts'] = thoughts?.toMap();
    }
    map['title'] = title;
    map['type'] = type ?? 4;
    map['userid'] = userid;
    map['duration']= duration ??0;
    return map;
  }
}

class ThoughtModel {
  bool? idiot,
      ugly,
      fired,
      hatesMe,
      noFriends,
      horrible,
      badperson,
      weak,
      overweight,
      noEverLove,
      noFriendForever,
      alwaysingle,
      single,
      noJob,
      loser,
      notSuccessful,
      inDebt,
      noSports,
      sportsHighSchool,
      obese,
      failure,
      neverDonethat,
      cantDo,
      neverTrained,
      greedy,
      lazy,
      yelledAt,
      hitMe,
      forehead;
  ThoughtModel({
    this.alwaysingle,
    this.badperson,
    this.cantDo,
    this.failure,
    this.fired,
    this.forehead,
    this.greedy,
    this.hatesMe,
    this.hitMe,
    this.horrible,
    this.idiot,
    this.inDebt,
    this.lazy,
    this.loser,
    this.neverDonethat,
    this.neverTrained,
    this.noEverLove,
    this.noFriendForever,
    this.noFriends,
    this.noJob,
    this.noSports,
    this.notSuccessful,
    this.obese,
    this.overweight,
    this.single,
    this.sportsHighSchool,
    this.ugly,
    this.weak,
    this.yelledAt,
  });

  factory ThoughtModel.fromMap(var map) {
    return ThoughtModel(
      idiot: map['Im an idiot'],
      ugly: map['I am ugly.'],
      fired: map['I was fired from my job.'],
      hatesMe: map['Everybody hates me.'],
      noFriends: map['I dont have any friends.'],
      horrible: map['This will be horrible.'],
      badperson: map['Im a bad person.'],
      weak: map['Im weak.'],
      overweight: map['Im overweight.'],
      noEverLove: map['No one could ever love me.'],
      noFriendForever: map['I will have no friends forever.'],
      alwaysingle: map['I will always be single.'],
      single: map['I am single.'],
      noJob: map['I have no job.'],
      loser: map['Im a loser.'],
      notSuccessful: map['Im not successful.'],
      inDebt: map['Im in debt.'],
      noSports: map['Im no good at sports.'],
      sportsHighSchool: map['I didnt play sports in high school.'],
      obese: map['Im obese.'],
      failure: map['Im a failure.'],
      neverDonethat: map['I should have never done that.'],
      cantDo: map['I cant do that.'],
      neverTrained: map['Ive never been trained to do that.'],
      greedy: map['Im greedy.'],
      lazy: map['Im lazy'],
      yelledAt: map['She yelled at me'],
      hitMe: map['she hit me'],
      forehead: map['My forehead is too big.'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['Im an idiot'] = idiot ?? false;
    map['I am ugly.'] = ugly ?? false;
    map['I was fired from my job.'] = fired ?? false; // false;
    map['Everybody hates me.'] = hatesMe ?? false;
    map['I dont have any friends.'] = noFriends ?? false; // false;
    map['This will be horrible.'] = horrible ?? false;
    map['Im a bad person.'] = badperson ?? false;
    map['Im weak.'] = weak ?? false;
    map['Im overweight.'] = overweight ?? false; // false;
    map['No one could ever love me.'] = noEverLove ?? false;
    map['I will have no friends forever.'] = noFriendForever ?? false;
    map['I will always be single.'] = alwaysingle ?? false;
    map['I am single.'] = single ?? false; // false
    map['I have no job.'] = noJob ?? false; // false
    map['Im a loser.'] = loser ?? false;
    map['Im not successful.'] = notSuccessful ?? false;
    map['Im in debt.'] = inDebt ?? false; //false
    map['Im no good at sports.'] = noSports ?? false;
    map['I didnt play sports in high school.'] =
        sportsHighSchool ?? false; //false
    map['Im obese.'] = obese ?? false;
    map['Im a failure.'] = failure ?? false;
    map['I should have never done that.'] = neverDonethat ?? false;
    map['I cant do that.'] = cantDo ?? false;
    map['Ive never been trained to do that.'] = neverTrained ?? false;
    map['Im greedy.'] = greedy ?? false;
    map['Im lazy'] = lazy ?? false;
    map['She yelled at me'] = yelledAt ?? false;
    map['she hit me'] = hitMe ?? false;
    map['My forehead is too big.'] = forehead ?? false;
    return map;
  }
}

class FcyModel {
  String? id, userid, title, date;
  int? type, duration;
  DateTime? created;
  List<FCEvent>? thoughts;

  FcyModel({
    this.created,
    this.date,
    this.id,
    this.thoughts,
    this.title,
    this.type,
    this.userid,
    this.duration,
  });

  factory FcyModel.fromMap(var map) {
    return FcyModel(
      created: map['created'].toDate(),
      date: map['date'],
      id: map['id'],
      thoughts:
          map['thoughts'].map<FCEvent>((e) => FCEvent.fromMap(e)).toList(),
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
    map['id'] = id;
    if (thoughts == null) {
      map['thoughts'] = [FCEvent().toMap()];
    } else {
      map['thoughts'] = thoughts?.map((e) => e.toMap()).toList();
    }
    map['title'] = title ?? '';
    map['type'] = type ?? 5;
    map['userid'] = userid;
    map['duration']= duration ?? 0;
    return map;
  }
}

class FCEvent {
  String? thought;
  int? option, belief;

  FCEvent({this.belief, this.thought, this.option});

  factory FCEvent.fromMap(var map) {
    return FCEvent(
      thought: map['thought'],
      belief: map['belief'],
      option: map['option'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['thought'] = thought ?? '';
    map['belief'] = belief ?? 0;
    map['option'] = option ?? 0;
    return map;
  }
}

class CDModel {
  String? id, userid, date, title;
  int? type, duration;
  CDEvent? event;
  DateTime? created;

  CDModel({
    this.created,
    this.date,
    this.event,
    this.id,
    this.title,
    this.type,
    this.userid,
    this.duration,
  });

  factory CDModel.fromMap(var map) {
    return CDModel(
      created: map['created'].toDate(),
      date: map['date'],
      event: CDEvent.fromMap(map['event']),
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
    if (event == null) {
      map['event'] = CDEvent().toMap();
    } else {
      map['event'] = event?.toMap();
    }
    map['id'] = id;
    map['title'] = title ?? '';
    map['type'] = type ?? 6;
    map['userid'] = userid;
    map['duration']= duration ?? 0;
    return map;
  }
}

class CDEvent {
  int? beingRight,
      mentalFiltering,
      personalization,
      shouldStatements,
      mindReading,
      fortuneTelling,
      magnification,
      emotionalReasoning,
      globalLabeling,
      fallacyOfChange,
      overgeneralization,
      blackThinking,
      jumpingConclusions,
      mindRead,
      fallacyofFairness,
      heavenReward,
      controlFallacy,
      blaming;

  CDEvent({
    this.beingRight,
    this.blackThinking,
    this.blaming,
    this.controlFallacy,
    this.emotionalReasoning,
    this.fallacyOfChange,
    this.fallacyofFairness,
    this.fortuneTelling,
    this.globalLabeling,
    this.heavenReward,
    this.jumpingConclusions,
    this.magnification,
    this.mentalFiltering,
    this.mindRead,
    this.mindReading,
    this.overgeneralization,
    this.personalization,
    this.shouldStatements,
  });

  factory CDEvent.fromMap(var map) {
    return CDEvent(
      beingRight: map['Always being right'],
      mentalFiltering: map['Mental filtering '],
      personalization: map['Personalization'],
      shouldStatements: map['Should statements'],
      mindRead: map['Mind reading'],
      fortuneTelling: map['Fortune Telling '],
      magnification: map['Magnification and minimization '],
      emotionalReasoning: map['Emotional reasoning'],
      globalLabeling: map['Global labeling '],
      fallacyOfChange: map['Fallacy of Change'],
      overgeneralization: map['Overgeneralization '],
      blackThinking: map['Black and white thinking '],
      jumpingConclusions: map['Jumping to conclusions '],
      mindReading: map['Mind reading two'],
      fallacyofFairness: map['Fallacy of fairness'],
      heavenReward: map['Heaven\'s Reward'],
      controlFallacy: map['Control Fallacy '],
      blaming: map['Blaming '],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['Always being right'] = beingRight ?? 0;
    map['Mental filtering '] = mentalFiltering ?? 0;
    map['Personalization'] = personalization ?? 0;
    map['Should statements'] = shouldStatements ?? 0;
    map['Mind reading'] = mindRead ?? 0;
    map['Fortune Telling '] = fortuneTelling ?? 0;
    map['Magnification and minimization '] = magnification ?? 0;
    map['Emotional reasoning'] = emotionalReasoning ?? 0;
    map['Global labeling '] = globalLabeling ?? 0;
    map['Fallacy of Change'] = fallacyOfChange ?? 0;
    map['Overgeneralization '] = overgeneralization ?? 0;
    map['Black and white thinking '] = blackThinking ?? 0;
    map['Jumping to conclusions '] = jumpingConclusions ?? 0;
    map['Mind reading two'] = mindReading ?? 0;
    map['Fallacy of fairness'] = fallacyofFairness ?? 0;
    map['Heaven\'s Reward'] = heavenReward ?? 0;
    map['Control Fallacy '] = controlFallacy ?? 0;
    map['Blaming '] = blaming ?? 0;
    return map;
  }
}

class ReframingModel {
  String? id, userid, title, date;
  int? type, duration;
  DateTime? created;
  List<ReframingEvent>? thoughts;

  ReframingModel({
    this.id,
    this.userid,
    this.title,
    this.date,
    this.type,
    this.created,
    this.thoughts,
    this.duration,
  });

  factory ReframingModel.fromMap(var map) {
    return ReframingModel(
      id: map['id'],
      userid: map['userid'],
      title: map['title'],
      date: map['date'],
      type: map['type'],
      created: map['created'].toDate(),
      thoughts: map['thoughts']
          .map<ReframingEvent>((e) => ReframingEvent.fromMap(e))
          .toList(),
          duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['userid'] = userid;
    map['title'] = title ?? '';
    map['date'] = date ?? formateDate(DateTime.now());
    map['type'] = type ?? 7;
    map['created'] = created ?? DateTime.now();
    if (thoughts == null) {
      map['thoughts'] = [ReframingEvent().toMap()];
    } else {
      map['thoughts'] = thoughts?.map((e) => e.toMap()).toList();
    }
    map['duration']= duration ?? 0;
    return map;
  }
}

class ReframingEvent {
  String? thought, reframed, evidence, evidencAgainst;
  int? option, distortion, actualBelief, reframedBelief;

  ReframingEvent({
    this.distortion,
    this.actualBelief,
    this.evidencAgainst,
    this.evidence,
    this.option,
    this.reframed,
    this.reframedBelief,
    this.thought,
  });

  factory ReframingEvent.fromMap(var map) {
    return ReframingEvent(
      distortion: map['distortion'],
      actualBelief: map['actual_belief'],
      evidencAgainst: map['evidence_against'],
      evidence: map['evidence'],
      option: map['option'],
      reframed: map['reframed_thought'],
      reframedBelief: map['reframed_belief'],
      thought: map['thought'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['distortion'] = distortion ?? 0;
    map['actual_belief'] = actualBelief ?? 0;
    map['evidence_against'] = evidencAgainst ?? '';
    map['evidence'] = evidence ?? '';
    map['option'] = option ?? 0;
    map['reframed_thought'] = reframed ?? '';
    map['reframed_belief'] = reframedBelief ?? 0;
    map['thought'] = thought ?? '';
    return map;
  }
}

/// Journals
/// 8: Onserve - Short form, 9: observe = full form
/// 10: Emotional Check-In Short form,
/// 11: Emotional Check-In Full Version
/// 12: Emotional Analysis - Short Form
/// 13: Emotional Analysis - Full Version
/// 14: Emotional & Thought Check In - Short Form
/// 15: Emotional & Thought Check in - Full Version
/// 16: Emotional & Thought Analysis - Short Form
/// 17: Emotional & Thought Analysis - Full Version

class ETSfModel {
  DateTime? created;
  String? id, userid, title, date, resolution;
  int? type, stress, duration;
  EmotionalChecks? checks;
  RAModel? rootAnalysis;
  List<EmotionsModel>? emotions;
  List<ReframingEvent>? thoughts;

  ETSfModel({
    this.checks,
    this.created,
    this.date,
    this.emotions,
    this.id,
    this.resolution,
    this.rootAnalysis,
    this.stress,
    this.thoughts,
    this.title,
    required this.type,
    this.userid,
    this.duration,
  });

  factory ETSfModel.fromMap(var map) {
    return ETSfModel(
      checks: EmotionalChecks.fromMap(map['checks']),
      created: map['created'].toDate(),
      date: map['date'],
      emotions: map['emotions']
          .map<EmotionsModel>((e) => EmotionsModel.fromMap(e))
          .toList(),
      id: map['id'],
      resolution: map['resolution'],
      rootAnalysis: RAModel.fromMap(map['root_analysis']),
      stress: map['stress'],
      thoughts: map['thoughts']
          .map<ReframingEvent>((e) => ReframingEvent.fromMap(e))
          .toList(),
      title: map['title'],
      type: map['type'],
      userid: map['userid'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    if (checks == null) {
      map['checks'] = EmotionalChecks().toMap();
    } else {
      map['checks'] = checks?.toMap();
    }
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    if (emotions == null) {
      map['emotions'] = <EmotionsModel>[];
    } else {
      map['emotions'] = emotions?.map((e) => e.toMap()).toList();
    }
    map['id'] = id ?? '';
    map['resolution'] = resolution ?? '';
    if (rootAnalysis == null) {
      map['root_analysis'] = RAModel().toMap();
    } else {
      map['root_analysis'] = rootAnalysis?.toMap();
    }
    map['stress'] = stress ?? 0;
    if (thoughts == null) {
      map['thoughts'] = <ReframingEvent>[];
    } else {
      map['thoughts'] = thoughts?.map((e) => e.toMap()).toList();
    }
    map['title'] = title ?? '';
    map['type'] = type ?? 14; // 14: ET Check-in, 16: ET Analysis
    map['userid'] = userid ?? '';
    map['duration']= duration ?? 0;
    return map;
  }
}

class EAModel {
  DateTime? created;
  String? id, userid, title, date;
  int? type, stress, duration;
  RAModel? rootAnalysis;
  List<EmotionsModel>? emotions;
  List<ReframingEvent>? thoughts;
  ResolutionModel? resolution;

  EAModel({
    this.created,
    this.date,
    this.emotions,
    this.id,
    this.resolution,
    this.stress,
    this.thoughts,
    this.title,
    required this.type,
    this.userid,
    this.rootAnalysis,
    this.duration,
  });

  factory EAModel.fromMap(var map) {
    return EAModel(
      created: map['created'].toDate(),
      date: map['date'],
      emotions: map['emotions']
          .map<EmotionsModel>((e) => EmotionsModel.fromMap(e))
          .toList(),
      id: map['id'],
      resolution: ResolutionModel.fromMap(map['resolution']),
      stress: map['stress'],
      thoughts: map['thoughts']
          .map<ReframingEvent>((e) => ReframingEvent.fromMap(e))
          .toList(),
      title: map['title'],
      type: map['type'],
      userid: map['userid'],
      rootAnalysis: RAModel.fromMap(map['root_analysis']),
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    if (emotions == null) {
      map['emotions'] = <EmotionsModel>[];
    } else {
      map['emotions'] = emotions?.map((e) => e.toMap()).toList();
    }
    map['id'] = id ?? '';
    if (resolution == null) {
      map['resolution'] = ResolutionModel().toMap();
    } else {
      map['resolution'] = resolution?.toMap();
    }
    map['stress'] = stress ?? 0;
    if (thoughts == null) {
      map['thoughts'] = <ReframingEvent>[];
    } else {
      map['thoughts'] = thoughts?.map((e) => e.toMap()).toList();
    }
    map['title'] = title ?? '';
    map['type'] = type ?? 13; // 13: Emotional Analysis, 15: Emotional & Thought Check-in, 17: ET Analysis
    map['userid'] = userid ?? '';
    if (rootAnalysis == null) {
      map['root_analysis'] = RAModel().toMap();
    } else {
      map['root_analysis'] = rootAnalysis?.toMap();
    }
    map['duration']= duration ?? 0;
    return map;
  }
}

class EASfModel {
  DateTime? created;
  String? id, userid, title, date, resolution;
  int? type, stress, duration;
  EmotionalChecks? checks;
  RAModel? rootAnalysis;
  List<EmotionsModel>? emotions;
  List<EThoughtModel>? thoughts;

  EASfModel({
    this.checks,
    this.created,
    this.date,
    this.emotions,
    this.id,
    this.resolution,
    this.rootAnalysis,
    this.stress,
    this.thoughts,
    this.title,
    this.type,
    this.userid,
    this.duration,
  });

  factory EASfModel.fromMap(var map) {
    return EASfModel(
      checks: EmotionalChecks.fromMap(map['checks']),
      created: map['created'].toDate(),
      date: map['date'],
      emotions: map['emotions']
          .map<EmotionsModel>((e) => EmotionsModel.fromMap(e))
          .toList(),
      id: map['id'],
      resolution: map['resolution'],
      rootAnalysis: RAModel.fromMap(map['root_analysis']),
      stress: map['stress'],
      thoughts: map['thoughts']
          .map<EThoughtModel>((e) => EThoughtModel.fromMap(e))
          .toList(),
      title: map['title'],
      type: map['type'],
      userid: map['userid'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    if (checks == null) {
      map['checks'] = EmotionalChecks().toMap();
    } else {
      map['checks'] = checks?.toMap();
    }
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    if (emotions == null) {
      map['emotions'] = <EmotionsModel>[];
    } else {
      map['emotions'] = emotions?.map((e) => e.toMap()).toList();
    }
    map['id'] = id ?? '';
    map['resolution'] = resolution ?? '';
    if (rootAnalysis == null) {
      map['root_analysis'] = RAModel().toMap();
    } else {
      map['root_analysis'] = rootAnalysis?.toMap();
    }
    map['stress'] = stress ?? 0;
    if (thoughts == null) {
      map['thoughts'] = <EThoughtModel>[];
    } else {
      map['thoughts'] = thoughts?.map((e) => e.toMap()).toList();
    }
    map['title'] = title ?? '';
    map['type'] = type ?? 12;
    map['userid'] = userid ?? '';
    map['duration']= duration ?? 0;
    return map;
  }
}

class ECIModel {
  String? id, userid, title, date;
  int? type, stress, duration;
  List<EmotionsModel>? emotions;
  List<ReframingEvent>? thoughts;
  ResolutionModel? resolution;
  DateTime? created;

  ECIModel({
    this.created,
    this.date,
    this.emotions,
    this.id,
    this.resolution,
    this.stress,
    this.thoughts,
    this.title,
    this.type,
    this.userid,
    this.duration,
  });

  factory ECIModel.fromMap(var map) {
    return ECIModel(
      created: map['created'].toDate(),
      date: map['date'],
      emotions: map['emotions']
          .map<EmotionsModel>((e) => EmotionsModel.fromMap(e))
          .toList(),
      id: map['id'],
      resolution: ResolutionModel.fromMap(map['resolution']),
      stress: map['stress'],
      thoughts: map['thoughts']
          .map<ReframingEvent>((e) => ReframingEvent.fromMap(e))
          .toList(),
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
    if (emotions == null) {
      map['emotions'] = <EmotionsModel>[];
    } else {
      map['emotions'] = emotions?.map((e) => e.toMap()).toList();
    }
    map['id'] = id ?? '';
    if (resolution == null) {
      map['resolution'] = ResolutionModel().toMap();
    } else {
      map['resolution'] = resolution?.toMap();
    }
    map['stress'] = stress ?? 0;
    if (thoughts == null) {
      map['thoughts'] = <ReframingEvent>[];
    } else {
      map['thoughts'] = thoughts?.map((e) => e.toMap()).toList();
    }
    map['title'] = title ?? '';
    map['type'] = type ?? 11;
    map['userid'] = userid ?? '';
    map['duration']= duration ?? 0;
    return map;
  }
}

class ObserveSfModel {
  String? id, userid, title, date;
  bool? relaxation, confident, observeYourself, yourLevel;
  int? type, observe, duration;
  DateTime? created;

  ObserveSfModel({
    this.confident,
    this.created,
    this.date,
    this.id,
    this.observe,
    this.observeYourself,
    this.relaxation,
    this.title,
    this.type,
    this.userid,
    this.yourLevel,
    this.duration,
  });

  factory ObserveSfModel.fromMap(var map) {
    return ObserveSfModel(
      confident: map['Induce a confident state'],
      created: map['created'].toDate(),
      date: map['date'],
      id: map['id'],
      observe: map['observe'],
      observeYourself: map['Impartially observe yourself'],
      relaxation: map['Induce a relaxation response'],
      title: map['title'],
      type: map['type'],
      userid: map['userid'],
      yourLevel: map['find your level'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['Induce a confident state'] = confident ?? false;
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    map['id'] = id;
    map['observe'] = observe ?? 9;
    map['Impartially observe yourself'] = observeYourself ?? false;
    map['Induce a relaxation response'] = relaxation ?? false;
    map['title'] = title ?? '';
    map['type'] = type ?? 8;
    map['userid'] = userid;
    map['find your level'] = yourLevel ?? false;
    map['duration']= duration ?? 0;
    return map;
  }
}

class ObserveModel {
  String? id, userid, title, date;
  int? type, stress, duration;
  DateTime? created;

  ObserveModel({
    this.id,
    this.created,
    this.date,
    this.stress,
    this.title,
    this.type,
    this.userid,
    this.duration,
  });

  factory ObserveModel.fromMap(var map) {
    return ObserveModel(
      id: map['id'],
      created: map['created'].toDate(),
      date: map['date'],
      stress: map['stress'],
      title: map['title'],
      type: map['type'],
      userid: map['userid'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    map['stress'] = stress ?? 9;
    map['title'] = title ?? '';
    map['type'] = type ?? 9;
    map['userid'] = userid;
    map['duration']= duration ?? 0;
    return map;
  }
}

class EmotionalSfModel {
  String? id, userid, title, date, resolution;
  DateTime? created;
  int? type, stress, duration;
  EmotionalChecks? check;
  List<EmotionsModel>? emotions;
  List<EThoughtModel>? thoughts;

  EmotionalSfModel({
    this.check,
    this.created,
    this.date,
    this.emotions,
    this.id,
    this.resolution,
    this.stress,
    this.thoughts,
    this.title,
    this.type,
    this.userid,
    this.duration,
  });

  factory EmotionalSfModel.fromMap(var map) {
    return EmotionalSfModel(
      check: EmotionalChecks.fromMap(map['checks']),
      created: map['created'].toDate(),
      date: map['date'],
      emotions: map['emotions']
          .map<EmotionsModel>((e) => EmotionsModel.fromMap(e))
          .toList(),
      id: map['id'],
      resolution: map['resolution'],
      stress: map['stress'],
      thoughts: map['thoughts']
          .map<EThoughtModel>((e) => EThoughtModel.fromMap(e))
          .toList(),
      title: map['title'],
      type: map['type'],
      userid: map['userid'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    if (check == null) {
      map['checks'] = EmotionalChecks().toMap();
    } else {
      map['checks'] = check?.toMap();
    }
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    if (emotions == null) {
      map['emotions'] = <EmotionsModel>[];
    } else {
      map['emotions'] = emotions?.map((e) => e.toMap()).toList();
    }
    map['id'] = id;
    map['resolution'] = resolution ?? '';
    map['stress'] = stress ?? 0;
    if (thoughts == null) {
      map['thoughts'] = <EThoughtModel>[];
    } else {
      map['thoughts'] = thoughts?.map((e) => e.toMap()).toList();
    }
    map['title'] = title ?? '';
    map['type'] = type ?? 10;
    map['userid'] = userid;
    map['duration']= duration ?? 0;
    return map;
  }
}

class EThoughtModel {
  String? thought, reframed;
  int? actualBelief, reframedBelief;

  EThoughtModel({
    this.actualBelief,
    this.reframed,
    this.reframedBelief,
    this.thought,
  });

  factory EThoughtModel.fromMap(var map) {
    return EThoughtModel(
      actualBelief: map['actual_belief'],
      reframed: map['reframed'],
      reframedBelief: map['reframed_belief'],
      thought: map['thought'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['actual_belief'] = actualBelief ?? 0;
    map['reframed'] = reframed ?? '';
    map['reframed_belief'] = reframedBelief ?? 0;
    map['thought'] = thought;
    return map;
  }
}

class EmotionsModel {
  String? emotion;
  int? strength;

  EmotionsModel({this.emotion, this.strength});

  factory EmotionsModel.fromMap(var map) {
    return EmotionsModel(
      emotion: map['emotion'],
      strength: map['strength'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['emotion'] = emotion ?? '';
    map['strength'] = strength ?? 0;
    return map;
  }
}

class EmotionalChecks {
  bool? relaxation, confident, observeYourself, yourlevel;

  EmotionalChecks({
    this.confident,
    this.observeYourself,
    this.relaxation,
    this.yourlevel,
  });

  factory EmotionalChecks.fromMap(var map) {
    return EmotionalChecks(
      confident: map['Induce a confident state'],
      observeYourself: map['Impartially observe yourself'],
      relaxation: map['Induce a relaxation response'],
      yourlevel: map['find your level'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['Induce a confident state'] = confident ?? false;
    map['Impartially observe yourself'] = observeYourself ?? false;
    map['Induce a relaxation response'] = relaxation ?? false;
    map['find your level'] = yourlevel ?? false;
    return map;
  }
}
