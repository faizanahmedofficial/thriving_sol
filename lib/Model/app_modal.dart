import 'package:flutter/cupertino.dart';

class AppModel {
  String title, description;
  String? link, docid, path;
  int? value,
      intColor,
      type,
      duration,
      rest,
      preReading,
      prePractice,
      connectedPractice,
      connectedReading, ideal, actual;
  VoidCallback? ontap;
  Color? color;
  List? list;
  bool? check;
  double? percentage;

  AppModel(
    this.title,
    this.description, {
    this.ontap,
    this.value,
    this.intColor,
    this.type,
    this.color,
    this.link,
    this.docid,
    this.duration,
    this.rest,
    this.path,
    this.connectedReading,
    this.preReading,
    this.connectedPractice,
    this.prePractice,
    this.list,
    this.ideal,this.actual,this.check,this.percentage,
  });
}

class DaysModel {
  String title;
  bool value;

  DaysModel(this.title, this.value);
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

class AzureModel {
  String? subscriptionkey, region;
  bool? logs;

  AzureModel({this.logs, this.region, this.subscriptionkey});

  factory AzureModel.fromMap(var map) {
    return AzureModel(
      logs: map['withLogs'],
      subscriptionkey: map['subscriptionkey'],
      region: map['region'],
    );
  }
}

class MRSetupModel {
  String? routine;
  List<MRSExercises>? exercises;
  int? value, type;

  MRSetupModel({this.routine, this.exercises, this.value, this.type});
}

class MRSExercises {
  String? name;
  int? time, value, type;

  MRSExercises({this.name, this.time, this.value, this.type});
}
