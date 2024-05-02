import 'package:schedular_project/Functions/functions.dart';

/// 0: Food Journal Level 1
/// 1: Easy Shopping List Level 1

class FoodJournalModel {
  String? id, userid, name, date, notes;
  int? type, duration;
  DateTime? created;
  List<FoodModel>? foods;
  HealthyEatingModel? healthy;

  FoodJournalModel({
    this.created,
    this.date,
    this.foods,
    this.healthy,
    this.id,
    this.name,
    this.type,
    this.userid,
    this.notes,
   this.duration,
  });

  factory FoodJournalModel.fromMap(var map) {
    return FoodJournalModel(
      created: map['created'].toDate(),
      date: map['date'],
      foods: map['foods'].map<FoodModel>((e) => FoodModel.fromMap(e)).toList(),
      healthy: HealthyEatingModel.fromMap(map['healthy_eating']),
      id: map['id'],
      name: map['name'],
      type: map['type'],
      userid: map['userid'],
      notes: map['notes'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['created'] = created ?? DateTime.now();
    if (foods == null) {
      map['foods'] = <FoodModel>[];
    } else {
      map['foods'] = foods?.map((e) => e.toMap()).toList();
    }
    if (healthy == null) {
      map['healthy_eating'] = HealthyEatingModel().toMap();
    } else {
      map['healthy_eating'] = healthy?.toMap();
    }
    map['id'] = id ?? '';
    map['name'] = name ?? '';
    map['type'] = type ?? 0;
    map['userid'] = userid ?? '';
    map['date'] = date ?? formateDate(DateTime.now());
    map['notes']= notes ?? '';
    map['duration']= duration?? 0;
    return map;
  }
}

class FoodModel {
  String? food;
  int? type, index;
  double? portion;

  FoodModel({
    this.food,
    this.portion,
    this.type,
    this.index,
  });

  factory FoodModel.fromMap(var map) {
    return FoodModel(
      food: map['food'],
      portion: map['portion'].toDouble(),
      type: map['type'],
      index: map['index'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['food'] = food ?? '';
    map['portion'] = portion ?? 0.0;
    map['type'] = type ?? 0;
    map['index'] = index ?? 0;
    return map;
  }
}

class HealthyEatingModel {
  double? water, portion, slow, eatUntil, fasting;
  WeightModel? weight;

  HealthyEatingModel({
    this.eatUntil,
    this.portion,
    this.slow,
    this.water,
    this.weight,
    this.fasting,
  });

  factory HealthyEatingModel.fromMap(var map) {
    return HealthyEatingModel(
      eatUntil: map['Eat until 80% full then stop'].toDouble(),
      portion: map['Measure portion size by hand'].toDouble(),
      slow: map['Eat slowly and mindfully savor each bite'].toDouble(),
      water: map['Drink 1 gallon of water'].toDouble(),
      weight: WeightModel.fromMap(map['Weigh yourself']),
      fasting: map['Intermittent Fasting'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['Eat until 80% full then stop'] = eatUntil ?? 0.0;
    map['Measure portion size by hand'] = portion ?? 0.0;
    map['Eat slowly and mindfully savor each bite'] = slow ?? 0.0;
    map['Drink 1 gallon of water'] = water ?? 0.0;
    if (weight == null) {
      map['Weigh yourself'] = WeightModel().toMap();
    } else {
      map['Weigh yourself'] = weight?.toMap();
    }
    map['Intermittent Fasting'] = fasting ?? 0.0;
    return map;
  }
}

class WeightModel {
  double? weight;
  int? unit;

  WeightModel({this.unit, this.weight});

  factory WeightModel.fromMap(var map) {
    return WeightModel(
      weight: map['weight'].toDouble(),
      unit: map['unit'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['weight'] = weight ?? 0.0;
    map['unit'] = unit ?? 0;
    return map;
  }
}

class ShoppingListModel {
  String? id, userid, name, date, operation, progressing, goingForward;
  int? type, progressingValue, duration;
  DateTime? created;
  List<String>? proteins, vegetables, complexCarbs, healthyFats;
  WeightModel? weight, changeWeight;

  ShoppingListModel({
    this.changeWeight,
    this.complexCarbs,
    this.created,
    this.date,
    this.goingForward,
    this.healthyFats,
    this.id,
    this.name,
    this.operation,
    this.progressing,
    this.progressingValue,
    this.proteins,
    this.type,
    this.userid,
    this.vegetables,
    this.weight,
    this.duration,
  });

  factory ShoppingListModel.fromMap(var map) {
    return ShoppingListModel(
      changeWeight: WeightModel.fromMap(map['change_weight']),
      complexCarbs: map['complex_carbs'].cast<String>().toList(),
      created: map['created'].toDate(),
      date: map['date'],
      goingForward: map['going_forward'],
      healthyFats: map['healthy_fats'].cast<String>().toList(),
      id: map['id'],
      name: map['name'],
      operation: map['operation'],
      progressing: map['progressing'],
      progressingValue: map['progressing_value'],
      proteins: map['proteins'].cast<String>().toList(),
      type: map['type'],
      userid: map['userid'],
      vegetables: map['vegetables'].cast<String>().toList(),
      weight: WeightModel.fromMap(map['weight']),
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    if (changeWeight == null) {
      map['change_weight'] = WeightModel().toMap();
    } else {
      map['change_weight'] = changeWeight?.toMap();
    }
    if (complexCarbs == null) {
      map['complex_carbs'] = <String>[];
    } else {
      map['complex_carbs'] = complexCarbs?.cast<String>().toList();
    }
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    map['going_forward'] = goingForward ?? '';
    if (healthyFats == null) {
      map['healthy_fats'] = <String>[];
    } else {
      map['healthy_fats'] = healthyFats?.cast<String>().toList();
    }
    map['id'] = id ?? '';
    map['name'] = name ?? '';
    map['operation'] = operation ?? '+';
    map['progressing'] = progressing ?? '';
    map['progressing_value'] = progressingValue ?? 0;
    if (proteins == null) {
      map['proteins'] = <String>[];
    } else {
      map['proteins'] = proteins?.cast<String>().toList();
    }
    map['type'] = type ?? 1;
    map['userid'] = userid ?? '';
    if (vegetables == null) {
      map['vegetables'] = <String>[];
    } else {
      map['vegetables'] = vegetables?.cast<String>().toList();
    }
    if (weight == null) {
      map['weight'] = WeightModel().toMap();
    } else {
      map['weight'] = weight?.toMap();
    }
    map['duration']= duration ?? 0;
    return map;
  }
}
