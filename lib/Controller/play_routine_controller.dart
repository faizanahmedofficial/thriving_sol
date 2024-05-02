// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Controller/user_controller.dart';
import 'package:schedular_project/Screens/main_screen.dart';

import '../Global/firebase_collections.dart';
import '../Model/app_user.dart';
import '../Model/routine_model.dart';
import '../Screens/Emotional/connection_home.dart';
import '../Screens/Emotional/er_home.dart';
import '../Screens/Emotional/gratitude_home.dart';
import '../Screens/Physical/cold_home.dart';
import '../Screens/Physical/diet_home.dart';
import '../Screens/Physical/movement_home.dart';
import '../Screens/Physical/sexual_home.dart';
import '../Screens/Purpose/bd_home.dart';
import '../Screens/Purpose/goals_home.dart';
import '../Screens/mental/breathing_home.dart';
import '../Screens/mental/mindfulness_home.dart';
import '../Screens/mental/reading_home.dart';
import '../Screens/mental/visualization_home.dart';
import '../Services/auth_services.dart';

class PlayRoutineController extends GetxController {
  RxInt category = 0.obs;
  RxInt routineindex = 0.obs;
  RxInt elementIndex = 0.obs;
  RxInt nextIndex = 0.obs;
  RxInt nextCategory = 0.obs;
  Rx<DateTime> start = DateTime.now().obs;
  Rx<DateTime> end = DateTime.now().obs;
  RxInt duration = 0.obs;
  RxString today = ''.obs;

  Rx<RoutineModel> routine = RoutineModel().obs;

  setData(int _category, int _routineindex, int _elementindex, int _nextIndex,
      int _nextcat, DateTime _start, int _duration, String date) {
    category.value = _category;
    routineindex.value = _routineindex;
    elementIndex.value = _elementindex;
    nextIndex.value = _nextIndex;
    nextCategory.value = _nextcat;
    start.value = _start;
    duration.value = _duration;
    today.value = date;
  }

  completeElement(int _duration,{bool current = false}) async {
    updateStats(_duration);
    if (Get.find<AuthServices>().settings.autoContinue == 0) {
      if (elementIndex.value ==
          routine.value.routines![routineindex.value].elements!.length - 1) {
        if (routineindex.value != routine.value.routines!.length - 1) {
          Get.offAll(() => const MainScreen());
          // final _new = routine.value.routines![routineindex.value + 1];
          // if (_new.elements!.isNotEmpty) {
          //   playCategories(
          //     _new.elements![0].category!,
          //     routineindex.value + 1,
          //     0,
          //     1,
          //     _new.elements![1].category!,
          //     routine.value,
          //     _new.seconds!,
          //     current,
          //     today.value
          //   );
          // } else {
          //   final _next = routine.value.routines![routineindex.value + 2];
          //   playCategories(
          //     _next.elements![0].category!,
          //     routineindex.value + 2,
          //     0,
          //     1,
          //     _next.elements![1].category!,
          //     routine.value,
          //     _next.seconds!,
          //     current,
          //     today.value,
          //   );
          // }
        } else {
          if (!current) Get.offAll(() => const MainScreen());
        }
      } else {
        print('next element');
        playCategories(
          nextCategory.value,
          routineindex.value,
          nextIndex.value,
          nextIndex.value + 1,
          nextIndex.value ==
                  routine.value.routines![routineindex.value].elements!.length -
                      1
              ? 0
              : routine.value.routines![routineindex.value]
                  .elements![nextIndex.value + 1].category!,
          routine.value,
          nextIndex.value ==
                  routine.value.routines![routineindex.value].elements!.length -
                      1
              ? 0
              : routine.value.routines![routineindex.value]
                  .elements![nextIndex.value + 1].seconds!,
          current,
          today.value,
        );
      }
    } else {
      if (!current) Get.back();
    }
    print('completed');
  }

  updateStats(int _duration) {
    Get.log('updating stats');
    updateToday(routineindex.value, elementIndex.value);
    updateAccomplishment(routine.value.routines![routineindex.value], _duration);
  }

  updateAccomplishment(Routines _routine, int _duration) {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.category == category.value);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: _routine.name,
        count: 1,
        date: today.value,
        duration: _duration,
        id: routine.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
    userAccomplishments(Get.find<AuthServices>().userid)
        .where('name', isEqualTo: _routine.name)
        .where('parentid', isEqualTo: routine.value.id)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          userAccomplishments(Get.find<AuthServices>().userid)
              .doc(doc.id)
              .update({
            'time': FieldValue.increment(_routine.seconds ?? 0),
            'current': FieldValue.increment(1),
            'longest': FieldValue.increment(1),
            'total': FieldValue.increment(1),
          });
        }
      } else if (value.docs.isEmpty) {
        userAccomplishments(Get.find<AuthServices>().userid).doc().set({
          'name': _routine.name,
          'parentid': routine.value.id,
          'time': _routine.seconds,
          'current': 1,
          'longest': 1,
          'total': 1,
          'advanced': '',
        });
      }
    });
  }

  updateToday(int index, int eindex) async {
    await todayRoutines(Get.find<AuthServices>().userid)
        .where('date', isEqualTo: today.value)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        TodayRoutines _today = TodayRoutines.fromMap(value.docs[0]);
        final _troutines = _today.routines!
            .where((element) => element.routineid == routine.value.id);
        if (_troutines.isNotEmpty) {
          TRModel _routine = _troutines.first;
          final _currents =
              _routine.indexes!.where((element) => element.index == index);
          if (_currents.isNotEmpty) {
            TREModel _current = _currents.first;
            _current.elements!.add(eindex);
          } else {
            _routine.indexes!.add(TREModel(index: index, elements: []));
          }
        } else {
          _today.routines!.add(
            TRModel(
              routineid: routine.value.id,
              indexes: [
                TREModel(index: index, elements: [eindex])
              ],
            ),
          );
        }
        // Get.find<UserController>()
        //     .todaysList
        //     .where((p0) => p0.date == formateDate(DateTime.now()))
        //     .toList()
        //     .first = _today;
        todayRoutines(Get.find<AuthServices>().userid)
            .doc(value.docs[0].id)
            .update(_today.toMap());
      } else {
        TodayRoutines _today = TodayRoutines(
          date: today.value,
          routines: [
            TRModel(
              routineid: routine.value.id,
              indexes: [
                TREModel(index: index, elements: [eindex])
              ],
            )
          ],
        );
        Get.find<UserController>().todaysList.add(_today);
        todayRoutines(Get.find<AuthServices>().userid)
            .doc()
            .set(_today.toMap());
      }
    });
    await Get.find<UserController>()
        .fetchTodays(Get.find<AuthServices>().userid);
    print('updated');
  }
}

playCategories(
    int category,
    int routineindex,
    int elementindex,
    int nextindex,
    int nextcat,
    RoutineModel routine,
    int duration,
    bool current,
    String date) {
  final arguments = [true];
  Get.find<PlayRoutineController>().routine.value = routine;
  Get.find<PlayRoutineController>().setData(
    category,
    routineindex,
    elementindex,
    nextindex,
    nextcat,
    DateTime.now(),
    duration,
    date,
  );
  switch (category) {
    case 0:
      if (!current) Get.to(() => BreathingHomeScreen(), arguments: arguments);
      break;
    case 1:
      if (!current) Get.to(() => VisualizationHome(), arguments: arguments);
      break;
    case 2:
      if (!current) Get.to(() => MindfulnesScreen(), arguments: arguments);
      break;
    case 3:
      if (!current) Get.to(() => ErHome(), arguments: arguments);
      break;
    case 4:
      if (!current) Get.to(() => ConnectionHome(), arguments: arguments);
      break;
    case 5:
      if (!current) Get.to(() => GratitudeHome(), arguments: arguments);
      break;
    case 6:
      if (!current) Get.to(() => GoalsHome(), arguments: arguments);
      break;
    case 7:
      if (!current) Get.to(() => BdHome(), arguments: arguments);
      break;
    case 8:
      if (!current) Get.to(() => MovementHome(), arguments: arguments);
      break;
    case 9:
      if (!current) Get.to(() => DietHome(), arguments: arguments);
      break;
    case 10:
      if (!current) Get.to(() => ColdHome(), arguments: arguments);
      break;
    case 11:
      if (!current) Get.to(() => SexualHome(), arguments: arguments);
      break;
    case 12:
      if (!current) Get.to(() => const ReadingHome(), arguments: arguments);
      break;
  }
}
