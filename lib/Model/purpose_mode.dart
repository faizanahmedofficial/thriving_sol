import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Model/bd_models.dart';

/// 0: Purpose Journal Level 0
/// 1: Purpose journal Level 1
/// 2: Purpose Journal Level 2
/// 3: Purpose Journal Level 3
/// 4: values, authentic & aspiration
/// 5: Goals Setting and Deepest why's
/// 6: Roadmap
/// 7: Periodic Review
///

class PeriodicReviewModel {
  String? id, userid, name;
  int? type, duration;
  DateTime? created;
  ReviewTime? reviewtime;
  ValuesModel? value;
  ReflectionModel? reflection;
  GoalsModel? goal;
  RoadmapModel? roadmap;
  GoalReflectionModel? goalsReflection;
  HabitsReflection? habitsReflection;
  NextPeriod? nextPeriod;

  PeriodicReviewModel({
    this.created,
    this.reviewtime,
    this.goal,
    this.goalsReflection,
    this.habitsReflection,
    this.id,
    this.name,
    this.nextPeriod,
    this.reflection,
    this.roadmap,
    this.type,
    this.userid,
    this.value,
    this.duration,
  });

  factory PeriodicReviewModel.fromMap(var map) {
    return PeriodicReviewModel(
      created: map['created'].toDate(),
      reviewtime: ReviewTime.fromMap(map['review_time']),
      goal: GoalsModel.fromMap(map['goal']),
      goalsReflection: GoalReflectionModel.fromMap(map['goal_reflection']),
      habitsReflection: HabitsReflection.fromMap(map['habit_reflection']),
      id: map['id'],
      name: map['name'],
      nextPeriod: NextPeriod.fromMap(map['next_period']),
      reflection: ReflectionModel.fromMap(map['reflection']),
      roadmap: RoadmapModel.fromMap(map['roadmap']),
      type: map['type'],
      userid: map['userid'],
      value: ValuesModel.fromMap(map['value']),
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['created'] = created ?? DateTime.now();
    if (reviewtime == null) {
      map['review_time'] = ReviewTime().toMap();
    } else {
      map['review_time'] = reviewtime?.toMap();
    }
    if (goal == null) {
      map['goal'] = GoalsModel().toMap();
    } else {
      map['goal'] = goal?.toMap();
    }
    if (goalsReflection == null) {
      map['goal_reflection'] = GoalReflectionModel().toMap();
    } else {
      map['goal_reflection'] = goalsReflection?.toMap();
    }
    if (habitsReflection == null) {
      map['habit_reflection'] = HabitsReflection().toMap();
    } else {
      map['habit_reflection'] = habitsReflection?.toMap();
    }
    map['id'] = id ?? '';
    map['name'] = name ?? '';
    if (nextPeriod == null) {
      map['next_period'] = NextPeriod().toMap();
    } else {
      map['next_period'] = nextPeriod?.toMap();
    }
    if (reflection == null) {
      map['reflection'] = ReflectionModel().toMap();
    } else {
      map['reflection'] = reflection?.toMap();
    }
    if (roadmap == null) {
      map['roadmap'] = RoadmapModel().toMap();
    } else {
      map['roadmap'] = roadmap?.toMap();
    }
    map['type'] = type ?? 7;
    map['userid'] = userid ?? '';
    if (value == null) {
      map['value'] = ValuesModel().toMap();
    } else {
      map['value'] = value?.toMap();
    }
    map['duration']= duration ?? 0;
    return map;
  }
}

class NextPeriod {
  String? quarter, challenge, energy, review;
  String? date;
  PHabitDuration? duration;

  NextPeriod({
    this.challenge,
    this.date,
    this.duration,
    this.energy,
    this.quarter,
    this.review,
  });

  factory NextPeriod.fromMap(var map) {
    return NextPeriod(
      challenge: map[
          'What are your biggest system challenges and how can you overcome them'],
      date: map['date'],
      duration: PHabitDuration.fromMap(map['duration']),
      energy: map['Which are acting as a drag on your energy'],
      quarter: map['What can you do this quarter'],
      review: map['review your calendar'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['What are your biggest system challenges and how can you overcome them'] =
        challenge ?? '';
    map['date'] =
        date ?? formateDate(DateTime.now().add(const Duration(days: 14)));
    if (duration == null) {
      map['duration'] = PHabitDuration().toMap();
    } else {
      map['duration'] = duration?.toMap();
    }
    map['Which are acting as a drag on your energy'] = energy ?? '';
    map['What can you do this quarter'] = quarter ?? '';
    map['review your calendar'] = review ?? '';
    return map;
  }
}

class HabitsReflection {
  String? name, consistent, improving, challenge;

  HabitsReflection({
    this.challenge,
    this.consistent,
    this.improving,
    this.name,
  });

  factory HabitsReflection.fromMap(var map) {
    return HabitsReflection(
      challenge: map[
          'What are your biggest challenges to completing this habit and what is your plan to overcome them'],
      consistent: map['Are you staying consistent'],
      improving: map['Am I improving'],
      name: map['habit_name'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['What are your biggest challenges to completing this habit and what is your plan to overcome them'] =
        challenge;
    map['Are you staying consistent'] = consistent;
    map['Am I improving'] = improving;
    map['habit_name'] = name;
    return map;
  }
}

class GoalReflectionModel {
  String? metDeadline,
      realisticMilestones,
      efficiency,
      resources,
      biggestChallenge;

  GoalReflectionModel({
    this.biggestChallenge,
    this.efficiency,
    this.metDeadline,
    this.realisticMilestones,
    this.resources,
  });

  factory GoalReflectionModel.fromMap(var map) {
    return GoalReflectionModel(
      biggestChallenge:
          map['What are your biggest challenges and how can you overcome them'],
      efficiency: map[
          'How could you work towards your goal ten times more efficiently'],
      metDeadline:
          map['Have you met your deadlines in your goals and milestones'],
      realisticMilestones: map[
          'Do you have realistic milestones planned out for the next period'],
      resources: map[
          'How can you use the resources you have at hand right now to get the job done and complete your goal'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['What are your biggest challenges and how can you overcome them'] =
        biggestChallenge ?? '';
    map['How could you work towards your goal ten times more efficiently'] =
        efficiency ?? '';
    map['Have you met your deadlines in your goals and milestones'] =
        metDeadline ?? '';
    map['Do you have realistic milestones planned out for the next period'] =
        realisticMilestones ?? '';
    map['How can you use the resources you have at hand right now to get the job done and complete your goal'] =
        resources ?? '';
    return map;
  }
}

class ReflectionModel {
  String? authenticityScore, environment, stoppingYou;

  ReflectionModel({
    this.authenticityScore,
    this.environment,
    this.stoppingYou,
  });

  factory ReflectionModel.fromMap(var map) {
    return ReflectionModel(
      authenticityScore:
          map['Why do you think you have this authenticity score'],
      environment: map['How can you design your environment'],
      stoppingYou:
          map['What is stopping you from living up to your value fully'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};

    map['Why do you think you have this authenticity score'] =
        authenticityScore ?? '';
    map['How can you design your environment'] = environment ?? '';
    map['What is stopping you from living up to your value fully'] =
        stoppingYou ?? '';
    return map;
  }
}

class ReviewTime {
  String? start, end;

  ReviewTime({this.end, this.start});

  factory ReviewTime.fromMap(var map) {
    return ReviewTime(
      end: map['end'],
      start: map['start'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['end'] = end ?? formateDate(DateTime.now());
    map['start'] = start ?? formateDate(DateTime.now());
    return map;
  }
}

class PJL3Model {
  String? id, userid, name, date, nextConcreteAction, prepare;
  int? type,duration;
  DateTime? created;
  ValuesModel? value;
  GoalsModel? goal;
  SystemHabit? systemHabit;
  RoadmapModel? roadmap;
  bool? complete;

  PJL3Model({
    this.complete,
    this.created,
    this.date,
    this.goal,
    this.id,
    this.name,
    this.nextConcreteAction,
    this.prepare,
    this.roadmap,
    this.systemHabit,
    this.type,
    this.userid,
    this.value,
  this.duration,
  });

  factory PJL3Model.fromMap(var map) {
    return PJL3Model(
      complete: map['complete'],
      created: map['created'].toDate(),
      date: map['date'],
      goal: GoalsModel.fromMap(map['goal']),
      id: map['id'],
      name: map['name'],
      nextConcreteAction: map['next_concrete_action'],
      prepare: map['prepare'],
      roadmap: RoadmapModel.fromMap(map['roadmap']),
      systemHabit: SystemHabit.fromMap(map['system_habit']),
      type: map['type'],
      userid: map['userid'],
      value: ValuesModel.fromMap(map['value']),
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['complete'] = complete ?? false;
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    if (goal == null) {
      map['goal'] = GoalsModel().toMap();
    } else {
      map['goal'] = goal?.toMap();
    }
    map['id'] = id ?? '';
    map['name'] = name ?? '';
    map['next_concrete_action'] = nextConcreteAction ?? '';
    map['prepare'] = prepare ?? '';
    if (roadmap == null) {
      map['roadmap'] = RoadmapModel().toMap();
    } else {
      map['roadmap'] = roadmap?.toMap();
    }
    if (systemHabit == null) {
      map['system_habit'] = SystemHabit().toMap();
    } else {
      map['system_habit'] = systemHabit?.toMap();
    }
    map['type'] = type ?? 3;
    map['userid'] = userid ?? '';
    if (value == null) {
      map['value'] = ValuesModel().toMap();
    } else {
      map['value'] = value?.toMap();
    }
    map['duration']= duration ?? 0;
    return map;
  }
}

class RoadmapGoal {
  String? goalid;
  List<String>? habits;

  RoadmapGoal({this.goalid, this.habits});

  factory RoadmapGoal.fromMap(var map) {
    return RoadmapGoal(
      goalid: map['goal_id'],
      habits: map['habits'].cast<String>().toList(),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['goal_id'] = goalid ?? '';
    if (habits == null) {
      map['habits'] = <String>[];
    } else {
      map['habits'] = habits?.toList();
    }
    return map;
  }
}

class RoadmapModel {
  String? id, userid, name;
  int? type, duration;
  DateTime? created;
  List<MilestoneModel>? milestone;
  SystemHabit? habit;
  RoadmapGoal? goal;

  RoadmapModel({
    this.milestone,
    this.created,
    this.id,
    this.name,
    this.type,
    this.userid,
    this.habit,
    this.goal,
    this.duration,
  });

  factory RoadmapModel.fromMap(var map) {
    return RoadmapModel(
      milestone: map['milestones']
          .map<MilestoneModel>((e) => MilestoneModel.fromMap(e))
          .toList(),
      created: map['created'].toDate(),
      id: map['id'],
      name: map['name'],
      type: map['type'],
      userid: map['userid'],
      habit: SystemHabit.fromMap(map['system_habit']),
      goal: RoadmapGoal.fromMap(map['goal']),
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    if (milestone == null) {
      map['milestones'] = <MilestoneModel>[];
    } else {
      map['milestones'] = milestone?.map((e) => e.toMap()).toList();
    }
    map['created'] = created ?? DateTime.now();
    map['id'] = id ?? '';
    map['type'] = type ?? 6;
    map['userid'] = userid ?? '';
    if (habit == null) {
      map['system_habit'] = SystemHabit().toMap();
    } else {
      map['system_habit'] = habit?.toMap();
    }
    if (goal == null) {
      map['goal'] = RoadmapGoal().toMap();
    } else {
      map['goal'] = goal?.toMap();
    }
    map['name'] = name ?? '';
    map['duration']= duration ?? 0;
    return map;
  }
}

class MilestoneModel {
  String? milestone, completion, measureCompletion;
  bool? complete;
  List<String>? habits;

  MilestoneModel({
    this.complete,
    this.measureCompletion,
    this.milestone,
    this.habits,
    this.completion,
  });

  factory MilestoneModel.fromMap(var map) {
    return MilestoneModel(
      complete: map['complete'],
      measureCompletion: map['measure completion'].toString(),
      milestone: map['milestone'],
      habits: map['habits'].cast<String>().toList(),
      completion: map['completion'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['complete'] = complete ?? false;
    map['measure completion'] = measureCompletion ?? '';
    map['milestone'] = milestone ?? '';
    if (habits == null) {
      map['habits'] = <String>[];
    } else {
      map['habits'] = habits?.cast<String>().toList();
    }
    map['completion'] = completion ?? formateDate(DateTime.now());
    return map;
  }
}

class SystemHabit {
  String? name;
  bool? complete;
  PHabitDuration? duration;
  List<bool>? days;
  NudgeModel? nudge;

  SystemHabit({
    this.name,
    this.complete,
    this.days,
    this.duration,
    this.nudge,
  });

  factory SystemHabit.fromMap(var map) {
    return SystemHabit(
      name: map['name'],
      complete: map['complete'],
      days: map['days'].cast<bool>().toList(),
      duration: PHabitDuration.fromMap(map['duration']),
      nudge: NudgeModel.fromMap(map['nudge']),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name ?? '';
    map['complete'] = complete ?? false;
    if (days == null) {
      map['days'] = <bool>[false, false, false, false, false, false, false];
    } else {
      map['days'] = days?.cast<bool>().toList();
    }
    if (duration == null) {
      map['duration'] = PHabitDuration().toMap();
    } else {
      map['duration'] = duration?.toMap();
    }
    if (nudge == null) {
      map['nudge'] = NudgeModel().toMap();
    } else {
      map['nudge'] = nudge?.toMap();
    }
    return map;
  }
}

class PHabitDuration {
  String? start, end, duration;
  int? seconds;

  PHabitDuration({
    this.seconds,
    this.start,
    this.duration,
    this.end,
  });

  factory PHabitDuration.fromMap(var map) {
    return PHabitDuration(
      seconds: map['seconds'],
      start: map['start'],
      duration: map['duration'],
      end: map['end'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['seconds'] = seconds ?? 0;
    map['start'] = start ?? '';
    map['end'] = end ?? '';
    map['duration'] = duration ?? '';
    return map;
  }
}

class PJL2Model {
  String? id, userid, name, date, nextConcreteAction, prepare;
  int? type, duration;
  DateTime? created;
  ValuesModel? value;
  GoalsModel? goal;
  bool? complete;

  PJL2Model({
    this.complete,
    this.created,
    this.date,
    this.goal,
    this.id,
    this.name,
    this.nextConcreteAction,
    this.prepare,
    this.type,
    this.userid,
    this.value,
    this.duration,
  });

  factory PJL2Model.fromMap(var map) {
    return PJL2Model(
      complete: map['complete'],
      created: map['created'].toDate(),
      date: map['date'],
      goal: GoalsModel.fromMap(map['goal']),
      id: map['id'],
      name: map['name'],
      nextConcreteAction: map['next_concrete_action'],
      prepare: map['prepare'],
      type: map['type'],
      userid: map['userid'],
      value: ValuesModel.fromMap(map['value']),
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['complete'] = complete ?? false;
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    if (goal == null) {
      map['goal'] = GoalsModel().toMap();
    } else {
      map['goal'] = goal?.toMap();
    }
    map['id'] = id ?? '';
    map['name'] = name ?? '';
    map['next_concrete_action'] = nextConcreteAction ?? '';
    map['prepare'] = prepare ?? '';
    map['type'] = type ?? 2;
    map['userid'] = userid ?? '';
    if (value == null) {
      map['value'] = ValuesModel().toMap();
    } else {
      map['value'] = value?.toMap();
    }
    map['duration']= duration;
    return map;
  }
}

class GoalsModel {
  String? id, userid, name;
  String? goal, complete, deepestWhys, freeWrite, valueid, measureNumerically, importance;
  int?  type, duration;
  DateTime? created;
  List<String>? aboveAnswerImportant;

  GoalsModel({
    this.complete,
    this.deepestWhys,
    this.freeWrite,
    this.goal,
    this.measureNumerically,
    this.aboveAnswerImportant,
    this.created,
    this.id,
    this.importance,
    this.name,
    this.type,
    this.userid,
    this.valueid,
    this.duration,
  });

  factory GoalsModel.fromMap(var map) {
    return GoalsModel(
      complete: map['When will I complete this goal'],
      deepestWhys: map['What is my deepest why for completing this goal'],
      freeWrite: map['free write'],
      goal: map['goal'],
      measureNumerically: map['How can I measure completion numerically'],
      aboveAnswerImportant: map['Why is the above answer important to me']
          .cast<String>()
          .toList(),
      created: map['created'].toDate(),
      id: map['id'],
      importance: map['Why is this goal important to me'],
      name: map['name'],
      type: map['type'],
      userid: map['userid'],
      valueid: map['valueid'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['When will I complete this goal'] = complete ?? '';
    map['What is my deepest why for completing this goal'] = deepestWhys ?? '';
    map['free write'] = freeWrite ?? '';
    map['goal'] = goal ?? '';
    map['How can I measure completion numerically'] = measureNumerically ?? '';
    if (aboveAnswerImportant == null) {
      map['Why is the above answer important to me'] = <String>[
        '',
        '',
        '',
        '',
        ''
      ];
    } else {
      map['Why is the above answer important to me'] =
          aboveAnswerImportant?.cast<String>().toList();
    }
    map['created'] = created ?? DateTime.now();
    map['id'] = id ?? '';
    map['Why is this goal important to me'] = importance ?? '';
    map['name'] = name ?? '';
    map['type'] = type ?? 5;
    map['userid'] = userid ?? '';
    map['valueid'] = valueid ?? '';
    map['duration']= duration ?? 0;
    return map;
  }
}

class PJL1Model {
  String? id, userid, name, date, prephow, script;
  int? type, duration;
  DateTime? created;
  PJ1Value? value;
  bool? completed;

  PJL1Model({
    this.created,
    this.date,
    this.id,
    this.name,
    this.script,
    this.type,
    this.userid,
    this.value,
    this.duration,
  });

  factory PJL1Model.fromMap(var map) {
    return PJL1Model(
      created: map['created'].toDate(),
      date: map['date'],
      id: map['id'],
      name: map['name'],
      script: map['script'],
      type: map['type'],
      userid: map['userid'],
      value: PJ1Value.fromMap(map['value']),
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    map['id'] = id ?? '';
    map['name'] = name ?? '';
    map['script'] = script ?? '';
    map['type'] = type ?? 1;
    map['userid'] = userid ?? '';
    if (value == null) {
      map['value'] = PJ1Value().toMap();
    } else {
      map['value'] = value?.toMap();
    }
    map['duration']= duration ?? 0;
    return map;
  }
}

class PJ1Value {
  ValuesModel? value;
  bool? completed;
  String? prephow, journalid;

  PJ1Value({this.completed, this.prephow, this.value, this.journalid});

  factory PJ1Value.fromMap(var map) {
    return PJ1Value(
      completed: map['completed'],
      prephow: map['prephow'],
      value: ValuesModel.fromMap(map['value']),
      journalid: map['journalid'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['completed'] = completed ?? false;
    map['prephow'] = prephow ?? '';
    if (value == null) {
      map['value'] = ValuesModel().toMap();
    } else {
      map['value'] = value?.toMap();
    }
    map['journalid']= journalid ?? '';
    return map;
  }
}

class ValuesModel {
  String? id, userid, name;
  String? value, actionTaken;
  int? type, duration;
  DateTime? created;
  double? authenticity, importance;

  ValuesModel({
    this.actionTaken,
    this.authenticity,
    this.value,
    this.created,
    this.id,
    this.importance,
    this.name,
    this.type,
    this.userid,
    this.duration,
  });

  factory ValuesModel.fromMap(var map) {
    return ValuesModel(
      actionTaken: map['actions_taken'],
      authenticity: map['authnticity'].toDouble(),
      value: map['value'],
      created: map['created'].toDate(),
      id: map['id'],
      importance: map['importance'].toDouble(),
      type: map['type'],
      userid: map['userid'],
      name: map['name'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['actions_taken'] = actionTaken ?? '';
    map['authnticity'] = authenticity ?? 0;
    map['value'] = value ?? '';
    map['created'] = created ?? DateTime.now();
    map['id'] = id ?? '';
    map['importance'] = importance ?? 0;
    map['type'] = type ?? 4;
    map['userid'] = userid ?? '';
    map['name'] = name ?? '';
    map['duration']= duration ?? 0;
    return map;
  }
}

class PJL0Model {
  String? id, userid, name, date, goals;
  int? type, duration;
  DateTime? created;

  PJL0Model({
    this.created,
    this.date,
    this.goals,
    this.id,
    this.name,
    this.type,
    this.userid,
    this.duration,
  });

  factory PJL0Model.fromMap(var map) {
    return PJL0Model(
      created: map['created'].toDate(),
      date: map['date'],
      goals: map['goals'],
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
    map['goals'] = goals ?? '';
    map['id'] = id ?? '';
    map['name'] = name ?? '';
    map['type'] = type ?? 0;
    map['userid'] = userid ?? '';
    map['duration']= duration ?? 0;
    return map;
  }
}
