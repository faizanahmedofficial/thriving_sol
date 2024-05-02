/// 0: Cold
/// 1: Trainers
///

class ColdExercises {
  String? id, name;
  int? type, option;
  List<Elevels>? level;

  ColdExercises({
    this.id,
    this.level,
    this.name,
    this.type,
    this.option,
  });

  factory ColdExercises.fromMap(var map) {
    return ColdExercises(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      option: map['option'],
      level: map['levels'].map<Elevels>((e) => Elevels.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap(var map) {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    map['name'] = name ?? '';
    map['type'] = type ?? 0;
    map['option'] = option ?? 0;
    if (level == null) {
      map['levels'] = <Elevels>[];
    } else {
      map['levels'] = level?.map((e) => e.toMap()).toList();
    }
    return map;
  }
}

class Elevels {
  String? id, name;
  int? level;
  List<Exercises>? exercises;

  Elevels({this.exercises, this.id, this.level, this.name});

  factory Elevels.fromMap(var map) {
    return Elevels(
      id: map['id'],
      level: map['level'],
      name: map['name'],
      exercises:
          map['exercises'].map<Exercises>((e) => Exercises.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    map['level'] = level ?? 0;
    map['name'] = name ?? '';
    if (exercises == null) {
      map['exercises'] = <Exercises>[];
    } else {
      map['exercises'] = exercises?.map((e) => e.toMap()).toList();
    }
    return map;
  }
}

class Exercises {
  String? id;
  int? index, time;

  Exercises({this.id, this.index, this.time});

  factory Exercises.fromMap(var map) {
    return Exercises(
      id: map['id'],
      index: map['index'],
      time: map['time'],
    );
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    map['index'] = index ?? 0;
    map['time'] = time ?? 0;
    return map;
  }
}

class TrainersModel {
  String? id;
  int? type;
  List<TLevels>? levels;

  TrainersModel({this.id, this.levels, this.type});

  factory TrainersModel.fromMap(var map) {
    return TrainersModel(
      id: map['id'],
      type: map['type'],
      levels: map['levels'].map<TLevels>((e) => TLevels.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    map['type'] = type ?? 1;
    if (levels == null) {
      map['levels'] = <TLevels>[];
    } else {
      map['levels'] = levels?.map((e) => e.toMap()).toList();
    }
    return map;
  }
}

class TLevels {
  int? level;
  List<TExercises>? exercises;

  TLevels({this.level, this.exercises});

  factory TLevels.fromMap(var map) {
    return TLevels(
      level: map['level'],
      exercises: map['exercises']
          .map<TExercises>((e) => TExercises.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['level'] = level ?? 1;
    if (exercises == null) {
      map['exercises'] = <TExercises>[];
    } else {
      map['exercises'] = exercises?.map((e) => e.toMap()).toList();
    }
    return map;
  }
}

class TExercises {
  int? exercise;
  List<ETSets>? sets;

  TExercises({this.exercise, this.sets});

  factory TExercises.fromMap(var map) {
    return TExercises(
      exercise: map['exercise'],
      sets: map['sets'].map<ETSets>((e) => ETSets.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['exercise'] = exercise ?? 1;
    if (sets == null) {
      map['sets'] = <ETSets>[];
    } else {
      map['sets'] = sets?.map((e) => e.toMap()).toList();
    }
    return map;
  }
}

class ETSets {
  int? eset, exercise, rest;

  ETSets({this.eset, this.exercise, this.rest});

  factory ETSets.fromMap(var map) {
    return ETSets(
      eset: map['set'],
      exercise: map['exercise'],
      rest: map['rest'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['set'] = eset ?? 1;
    map['exercise'] = exercise ?? 0;
    map['rest'] = rest ?? 0;
    return map;
  }
}
