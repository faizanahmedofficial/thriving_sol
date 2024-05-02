class ScriptModel {
  String? id, userid, topic, goal, steps, detail, type, title, link;
  int? option, duration;
  DateTime? created;
  CheckModel? checks;

  ScriptModel({
    this.id,
    this.detail,
    this.goal,
    this.steps,
    this.topic,
    this.type,
    this.userid,
    this.option,
    this.created,
    this.title,
    this.link,
    this.checks,
   this.duration,
  });

  factory ScriptModel.fromMap(var map) {
    return ScriptModel(
      id: map['id'],
      detail: map['detail'],
      goal: map['goal'],
      steps: map['steps'],
      topic: map['topic'],
      type: map['type'],
      userid: map['userid'],
      option: map['option'],
      created: map['created'].toDate(),
      title: map['title'],
      link: map['link'],
      checks: CheckModel.fromMap(map['checks']),
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['userid'] = userid;
    map['topic'] = topic ?? '';
    map['type'] = type ?? '';
    map['option'] = option ?? 0;
    map['goal'] = goal ?? '';
    map['steps'] = steps ?? '';
    map['detail'] = detail ?? '';
    map['created'] = created ?? DateTime.now();
    map['title'] = title ?? "";
    map['link'] = link ?? '';
    if (checks == null) {
      map['checks'] = CheckModel().toMap();
    } else {
      map['checks'] = checks!.toMap();
    }
map['duration']= duration ?? 0;
    return map;
  }
}

class CheckModel {
  bool? sight,
      hearing,
      touch,
      music,
      taste,
      smell,
      vperspective,
      viewAngle,
      emotional;

  CheckModel({
    this.emotional,
    this.hearing,
    this.music,
    this.sight,
    this.smell,
    this.taste,
    this.touch,
    this.viewAngle,
    this.vperspective,
  });

  factory CheckModel.fromMap(var map) {
    return CheckModel(
      sight: map['sight'],
      hearing: map['hearing'],
      touch: map['touch'],
      music: map['music'],
      taste: map['taste'],
      smell: map['smell'],
      viewAngle: map['angle'],
      vperspective: map['perspective'],
      emotional: map['emotional'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['sight'] = sight ?? false;
    map['hearing'] = hearing ?? false;
    map['touch'] = touch ?? false;
    map['music'] = music ?? false;
    map['taste'] = taste ?? false;
    map['smell'] = smell ?? false;
    map['angle'] = viewAngle ?? false;
    map['perspective'] = vperspective ?? false;
    map['emotional'] = emotional ?? false;
    return map;
  }
}

class SensesModel {
  bool? sight, hearing, touch, music, taste, smell;

  SensesModel({
    this.hearing,
    this.music,
    this.sight,
    this.smell,
    this.taste,
    this.touch,
  });

  factory SensesModel.fromMap(var map) {
    return SensesModel(
      sight: map['sight'],
      hearing: map['hearing'],
      touch: map['touch'],
      music: map['music'],
      taste: map['taste'],
      smell: map['smell'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['sight'] = sight ?? false;
    map['hearing'] = hearing ?? false;
    map['touch'] = touch ?? false;
    map['music'] = music ?? false;
    map['taste'] = taste ?? false;
    map['smell'] = smell ?? false;
    return map;
  }
}

class LsrtModel {
  String? id, userid, title, emotions, vAngle, mentalImage, script, audio;
  LsrtScript? vscript;
  int? vividness, ease, controllability, duration;
  SensesModel? senses;
  bool? first, third;
  CheckModel? layer;
  DateTime? created;

  LsrtModel({
    this.audio,
    this.controllability,
    this.ease,
    this.emotions,
    this.first,
    this.id,
    this.layer,
    this.mentalImage,
    this.script,
    this.senses,
    this.third,
    this.userid,
    this.vAngle,
    this.vividness,
    this.vscript,
    this.created,
    this.title,
    this.duration,
  });

  factory LsrtModel.fromMap(var map) {
    return LsrtModel(
      audio: map['audio'],
      controllability: map['controllability'],
      ease: map['ease'],
      emotions: map['emotions'],
      first: map['first'],
      id: map['id'],
      layer: CheckModel.fromMap(map['layer']),
      mentalImage: map['mentalimage'],
      script: map['script'],
      senses: SensesModel.fromMap(map['senses']),
      third: map['third'],
      userid: map['userid'],
      vAngle: map['viewing_angle'],
      vividness: map['vividness'],
      vscript: LsrtScript.fromMap(map['visualscript']),
      created: map['created'].toDate(),
      title: map['title'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['audio'] = audio ?? '';
    map['controllability'] = controllability ?? 1;
    map['ease'] = ease ?? 1;
    map['emotions'] = emotions ?? '';
    map['first'] = first ?? false;
    map['id'] = id;
    if (layer == null) {
      map['layer'] = CheckModel().toMap();
    } else {
      map['layer'] = layer?.toMap();
    }
    map['mentalimage'] = mentalImage ?? '';
    map['script'] = script ?? '';
    if (senses == null) {
      map['senses'] = SensesModel().toMap();
    } else {
      map['senses'] = senses?.toMap();
    }
    map['third'] = third ?? false;
    map['userid'] = userid;
    map['viewing_angle'] = vAngle ?? '';
    map['vividness'] = vividness ?? false;
    if (vscript == null) {
      map['visualscript'] = LsrtScript().toMap();
    } else {
      map['visualscript'] = vscript?.toMap();
    }
    map['created'] = created ?? DateTime.now();
    map['title'] = title ?? '';
    map['duration']= duration ?? 0;
    return map;
  }
}

class LsrtScript {
  String? id, detail, link, topic;
  int? value;

  LsrtScript({
    this.detail,
    this.id,
    this.value,
    this.link,
    this.topic,
  });

  factory LsrtScript.fromMap(var map) {
    return LsrtScript(
      id: map['id'],
      detail: map['detail'],
      value: map['value'],
      link: map['link'],
      topic: map['topic'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    map['detail'] = detail ?? '';
    map['link'] = link ?? '';
    map['value'] = value ?? 0;
    map['topic']= topic ?? '';
    return map;
  }
}
