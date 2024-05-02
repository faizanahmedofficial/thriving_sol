import '../Functions/functions.dart';

/// 0: Baby gratitude journal
/// 1: Gratitude Journal level 1
/// 2: Gratitude Letter

class BabyGratitudeModel {
  String? id, userid, title, journal, date;
  DateTime? created;
  int? type, duration;

  BabyGratitudeModel(
      {this.created,
      this.id,
      this.journal,
      this.title,
      this.type,
      this.userid,
      this.duration,
      this.date});

  factory BabyGratitudeModel.fromMap(var map) {
    return BabyGratitudeModel(
      created: map['created'].toDate(),
      id: map['id'],
      journal: map['journal'],
      title: map['title'],
      userid: map['userid'],
      type: map['type'],
      duration: map['duration'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['created'] = created ?? DateTime.now();
    map['id'] = id ?? '';
    map['journal'] = journal ?? '';
    map['title'] = title ?? '';
    map['userid'] = userid ?? '';
    map['type'] = type ?? 0;
    map['duration'] = duration ?? 0;
    map['date'] = date ?? formateDate(DateTime.now());
    return map;
  }
}

class GratitudeModel {
  String? id,
      userid,
      title,
      thankful,
      grateful,
      laugh,
      proud,
      necessities,
      sights,
      circumstances,
      doneRecently,
      luckyHappend,
      comfortable,
      positive,
      challenges,
      failure,
      negative,
      things,
      date;
  int? type, duration;
  DateTime? created;

  GratitudeModel({
    this.challenges,
    this.circumstances,
    this.comfortable,
    this.doneRecently,
    this.failure,
    this.grateful,
    this.id,
    this.laugh,
    this.luckyHappend,
    this.necessities,
    this.negative,
    this.positive,
    this.proud,
    this.sights,
    this.thankful,
    this.things,
    this.title,
    this.userid,
    this.created,
    this.type,
    date,
    this.duration,
  });

  factory GratitudeModel.fromMap(var map) {
    return GratitudeModel(
      challenges: map['Which challenges have helped me grow'],
      circumstances: map['What circumstances am I grateful for'],
      comfortable: map[
          'What things do I have that make me or my loved ones more comfortable'],
      doneRecently: map['What have I done recently that I enjoyed'],
      failure: map['How was failure helped me'],
      grateful: map['Who am I grateful to have in my life'],
      id: map['id'],
      laugh: map['What has made me laugh or smile recently'],
      luckyHappend: map['Has anything lucky happened to me'],
      necessities: map['What necessities am I grateful to have'],
      negative: map['How can I reframe a negative into a positive?'],
      positive: map[
          'What troubles have I had that made possible something positive in my life'],
      proud: map['What has made me proud recently'],
      sights: map[
          'What beautiful sights sounds tastes and feelings have I expeirenced'],
      thankful: map['I feel thankful for'],
      things: map[
          'What things do I have that people in other places or time periods lack'],
      title: map['title'],
      userid: map['userid'],
      type: map['type'],
      created: map['created'].toDate(),
      duration: map['duration'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['Which challenges have helped me grow'] = challenges ?? '';
    map['What circumstances am I grateful for'] = circumstances ?? '';
    map['What things do I have that make me or my loved ones more comfortable'] =
        comfortable ?? '';
    map['What have I done recently that I enjoyed'] = doneRecently ?? '';
    map['How was failure helped me'] = failure ?? '';
    map['Who am I grateful to have in my life'] = grateful ?? '';
    map['id'] = id ?? '';
    map['What has made me laugh or smile recently'] = laugh ?? '';
    map['Has anything lucky happened to me'] = luckyHappend ?? '';
    map['What necessities am I grateful to have'] = necessities ?? '';
    map['How can I reframe a negative into a positive?'] = negative ?? '';
    map['What troubles have I had that made possible something positive in my life'] =
        positive ?? '';
    map['What has made me proud recently'] = proud ?? '';
    map['What beautiful sights sounds tastes and feelings have I expeirenced'] =
        sights ?? '';
    map['I feel thankful for'] = thankful ?? '';
    map['What things do I have that people in other places or time periods lack'] =
        things ?? '';
    map['title'] = title ?? '';
    map['userid'] = userid ?? '';
    map['type'] = type ?? 1;
    map['created'] = created ?? DateTime.now();
    map['date'] = date ?? formateDate(DateTime.now());
    return map;
  }
}

class LetterModel {
  int? type, duration;
  DateTime? created;
  String? id, userid, title, who, gift, thankful, letter, delivery, date;
  bool? delivered;

  LetterModel({
    this.created,
    this.delivered,
    this.delivery,
    this.gift,
    this.id,
    this.letter,
    this.thankful,
    this.title,
    this.type,
    this.userid,
    this.who,
    this.date,
    this.duration,
  });

  factory LetterModel.fromMap(var map) {
    return LetterModel(
      created: map['created'].toDate(),
      delivered: map['delivered'],
      delivery: map['How will you deliver the letter to its recipient'],
      gift: map['What gift will you include with this letter'],
      id: map['id'],
      letter: map['gratitude letter'],
      thankful: map['Why are you thankful to this person'],
      title: map['title'],
      type: map['type'],
      userid: map['userid'],
      who: map['Who will this letter of gratitude be addressed to'],
      date: map['date'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['created'] = created ?? DateTime.now();
    map['delivered'] = delivered ?? false;
    map['How will you deliver the letter to its recipient'] = delivery ?? '';
    map['What gift will you include with this letter'] = gift ?? '';
    map['id'] = id ?? '';
    map['gratitude letter'] = letter ?? '';
    map['Why are you thankful to this person'] = thankful ?? '';
    map['title'] = title ?? '';
    map['type'] = type ?? 2;
    map['userid'] = userid ?? '';
    map['Who will this letter of gratitude be addressed to'] = who ?? '';
    map['date'] = date ?? formateDate(DateTime.now());
    map['duration'] = duration ?? 0;
    return map;
  }
}
