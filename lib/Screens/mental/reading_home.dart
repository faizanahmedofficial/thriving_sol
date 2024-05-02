// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/app_modal.dart';
import 'package:schedular_project/Model/app_user.dart';
import 'package:schedular_project/Screens/reading_library.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_button.dart';
import 'package:schedular_project/Widgets/custom_snackbar.dart';
import 'package:schedular_project/Widgets/drop_down_button.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/stop_watch.dart';
import 'package:schedular_project/Widgets/text_widget.dart';
import 'package:schedular_project/Widgets/widgets.dart';

import '../../Controller/play_routine_controller.dart';
import '../../Widgets/dialogs.dart';

class ReadingController extends GetxController {
  Rx<ReadingModel> readings = ReadingModel(
    intro: UserReadings(),
    breathing: UserReadings(),
    mindfulness: UserReadings(),
    visualization: UserReadings(),
    reading: UserReadings(),
    movement: UserReadings(),
    cold: UserReadings(),
    eating: UserReadings(),
    sexual: UserReadings(),
    productivity: UserReadings(),
    bd: UserReadings(),
    goals: UserReadings(),
    connection: UserReadings(),
    gratitude: UserReadings(),
    diet: UserReadings(),
    er: UserReadings(),
  ).obs;
  RxInt type = 0.obs;

  UserReadings _userReadings(int type) {
    switch (type) {
      case 0:
        return readings.value.intro ?? UserReadings();
      case 1:
        return readings.value.breathing ?? UserReadings();
      case 2:
        return readings.value.visualization ?? UserReadings();
      case 3:
        return readings.value.mindfulness ?? UserReadings();
      case 4:
        return readings.value.er ?? UserReadings();
      case 5:
        return readings.value.connection ?? UserReadings();
      case 6:
        return readings.value.gratitude ?? UserReadings();
      case 7:
        return readings.value.goals ?? UserReadings();
      case 8:
        return readings.value.productivity ?? UserReadings();
      case 9:
        return readings.value.bd ?? UserReadings();
      case 10:
        return readings.value.movement ?? UserReadings();
      case 11:
        return readings.value.eating ?? UserReadings();
      case 12:
        return readings.value.cold ?? UserReadings();
      case 13:
        return readings.value.reading ?? UserReadings();
      case 14:
        return readings.value.sexual ?? UserReadings();
      default:
        return UserReadings();
    }
  }

  Future fetchReadings() async {
    await userReadings(Get.find<AuthServices>().userid).get().then((value) {
      readings.value = ReadingModel.fromMap(value.data());
    });
  }

  late Timer timer;
  @override
  void onInit() async {
    await fetchReadings();
    if (routine) {
      DateTime start = DateTime.now();
      timer = Timer(
        Duration(seconds: Get.find<PlayRoutineController>().duration.value),
        () {
          Get.log('completed');
          infoDialog(start);
        },
      );
    }
    super.onInit();
  }

  VoidCallback? onPlay() {
    try {
      if (readings.value.intro!.value == type.value &&
              readings.value.intro!.element == 3 ||
          readings.value.breathing!.value == type.value &&
              readings.value.breathing!.element == 15 ||
          readings.value.visualization!.value == type.value &&
              readings.value.visualization!.element == 34 ||
          readings.value.mindfulness!.value == type.value &&
              readings.value.mindfulness!.element == 57 ||
          readings.value.er!.value == type.value &&
              readings.value.er!.element == 93 ||
          readings.value.connection!.value == type.value &&
              readings.value.connection!.element == 99 ||
          readings.value.gratitude!.value == type.value &&
              readings.value.gratitude!.element == 64 ||
          readings.value.goals!.value == type.value &&
              readings.value.goals!.element == 114 ||
          readings.value.bd!.value == type.value &&
              readings.value.bd!.element == 132 ||
          readings.value.movement!.value == type.value &&
              readings.value.movement!.element == 153 ||
          readings.value.diet!.value == type.value &&
              readings.value.diet!.element == 144 ||
          readings.value.cold!.value == type.value &&
              readings.value.cold!.element == 138 ||
          readings.value.reading!.value == type.value &&
              readings.value.reading!.element == 142) {
        return () =>
            type.value != 14 ? type.value = type.value + 1 : type.value = 0;
      } else {
        return currentlyReading(type.value)[currentlyReading(type.value)
                .indexWhere((element) =>
                    element.value == _userReadings(type.value).element)]
            .ontap;
      }
    } catch (e) {
      return () {};
    }
  }

  bool routine = Get.arguments[0];

  @override
  void onClose() {
    if (routine) timer.cancel();
    // Get.find<PlayRoutineController>().completeElement();
    super.onClose();
  }
}

class ReadingHome extends StatefulWidget {
  const ReadingHome({Key? key}) : super(key: key);

  @override
  State<ReadingHome> createState() => _ReadingHomeState();
}

class _ReadingHomeState extends State<ReadingHome> {
  final ReadingController _controller = Get.put(ReadingController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
          child: Column(
            children: [
              Row(
                children: [
                  horizontalSpace(width: 85),
                  const TextWidget(
                    text: 'Next reading in..',
                    weight: FontWeight.bold,
                  ),
                ],
              ).marginZero,
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: _controller.onPlay(),
                    icon: const Icon(Icons.play_arrow),
                    iconSize: 70,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomDropDownStruct(
                        child: DropdownButton(
                          value: _controller.type.value,
                          onChanged: (val) {
                            _controller.type.value = val;
                          },
                          items: readingList
                              .map((e) => DropdownMenuItem(
                                    value: e.value,
                                    child: TextWidget(
                                      text: e.title,
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.note_outlined),
                          SizedBox(
                            width: width * 0.6,
                            child: TextWidget(
                              text: currentlyReading(_controller.type.value)[
                                      currentlyReading(_controller.type.value)
                                          .indexWhere((element) =>
                                              element.value ==
                                              _controller
                                                  ._userReadings(
                                                      _controller.type.value)
                                                  .element)]
                                  .title,
                              weight: FontWeight.bold,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ).marginOnly(bottom: 35),
              _controller.readings.value.intro!.value == _controller.type.value &&
                          _controller.readings.value.intro!.element == 3 ||
                      _controller.readings.value.breathing!.value == _controller.type.value &&
                          _controller.readings.value.breathing!.element == 15 ||
                      _controller.readings.value.visualization!.value ==
                              _controller.type.value &&
                          _controller.readings.value.visualization!.element ==
                              34 ||
                      _controller.readings.value.mindfulness!.value ==
                              _controller.type.value &&
                          _controller.readings.value.mindfulness!.element ==
                              57 ||
                      _controller.readings.value.er!.value == _controller.type.value &&
                          _controller.readings.value.er!.element == 93 ||
                      _controller.readings.value.connection!.value == _controller.type.value &&
                          _controller.readings.value.connection!.element ==
                              99 ||
                      _controller.readings.value.gratitude!.value == _controller.type.value &&
                          _controller.readings.value.gratitude!.element == 64 ||
                      _controller.readings.value.goals!.value == _controller.type.value &&
                          _controller.readings.value.goals!.element == 114 ||
                      _controller.readings.value.bd!.value == _controller.type.value &&
                          _controller.readings.value.bd!.element == 132 ||
                      _controller.readings.value.movement!.value == _controller.type.value &&
                          _controller.readings.value.movement!.element == 153 ||
                      _controller.readings.value.diet!.value == _controller.type.value &&
                          _controller.readings.value.diet!.element == 144 ||
                      _controller.readings.value.cold!.value == _controller.type.value &&
                          _controller.readings.value.cold!.element == 138 ||
                      _controller.readings.value.reading!.value == _controller.type.value &&
                          _controller.readings.value.reading!.element == 142
                  ? TextWidget(
                      text:
                          readingList[readingListIndex(_controller.type.value)]
                              .description,
                      fontStyle: FontStyle.italic,
                    )
                  : Container(),
              verticalSpace(height: 50),
              AppButton(
                title: 'Course Library',
                description:
                    'Browse the complete library to learn material and unlock practices that will improve your capacity to thrive mentally, physically, and financially. ',
                onTap: () => Get.to(() => const CourseLibraryScreen()),
              ).marginOnly(bottom: 50, left: 25, right: 25),
              AppButton(
                title: 'Free Reading',
                description:
                    'Read something that is not contained in the Course Library. This can be any _controller.type of reading you do for pleasure or to expand your knowledge.',
                onTap: () => Get.to(() => const FreeReadingScreen()),
              ).marginOnly(bottom: 50, left: 25, right: 25),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseLibraryScreen extends StatelessWidget {
  const CourseLibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
          bottom: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: TextWidget(
                text: 'Course Library',
                weight: FontWeight.bold,
                alignment: Alignment.center,
                textAlign: TextAlign.center,
                size: 18,
              ),
            ).marginOnly(bottom: 50),
            CustomContainer(
              margin: const EdgeInsets.only(bottom: 20),
              child: InkWell(
                child: expansionTile(title: 'Intro', intro: true),
                onTap: () => Get.to(
                  () => CustomReadingLibrary(
                    title: 'Intro',
                    list: introList
                        .where((element) => element.type == 1)
                        .toList(),
                    color: Colors.white,
                    userReadings:
                        Get.find<ReadingController>()._userReadings(0),
                  ),
                ),
              ),
            ),
            titles('Mental'),
            CustomContainer(
              // cheight: 110,
              margin: const EdgeInsets.only(bottom: 20),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: mentalList.take(3).length,
                separatorBuilder: (context, index) =>
                    const Divider(color: Colors.black, height: 0.3),
                itemBuilder: (context, index) {
                  AppModel model = mentalList[index];
                  return InkWell(
                    child:
                        expansionTile(title: model.title, color: model.color),
                    onTap: () => Get.to(
                      () => CustomReadingLibrary(
                        title: model.title,
                        list: model.list!
                            .cast<AppModel>()
                            .toList()
                            .where((element) => element.type == 1)
                            .toList(),
                        color: model.color,
                        userReadings: Get.find<ReadingController>()
                            ._userReadings(model.type!),
                      ),
                    ),
                  );
                },
              ),
            ),
            titles('Emotional'),
            CustomContainer(
              // cheight: 110,
              margin: const EdgeInsets.only(bottom: 20),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: emotionalList.length,
                separatorBuilder: (context, index) =>
                    const Divider(color: Colors.black, height: 0.3),
                itemBuilder: (context, index) {
                  AppModel model = emotionalList[index];
                  return InkWell(
                    child: expansionTile(
                        color: Color(model.intColor!), title: model.title),
                    onTap: () => Get.to(
                      () => CustomReadingLibrary(
                        title: model.title,
                        list: model.list!
                            .cast<AppModel>()
                            .toList()
                            .where((element) => element.type == 1)
                            .toList(),
                        color: Color(model.intColor!),
                        userReadings: Get.find<ReadingController>()
                            ._userReadings(model.type!),
                      ),
                    ),
                  );
                },
              ),
            ),
            titles('Purpose'),
            CustomContainer(
              // cheight: 110,
              margin: const EdgeInsets.only(bottom: 20),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: purposeList.length,
                separatorBuilder: (context, index) =>
                    const Divider(color: Colors.black, height: 0.3),
                itemBuilder: (context, index) {
                  AppModel model = purposeList[index];
                  return InkWell(
                    child: expansionTile(
                      color: Color(model.intColor!),
                      title: model.title,
                    ),
                    onTap: () => Get.to(
                      () => CustomReadingLibrary(
                        title: model.title,
                        list: model.list!
                            .cast<AppModel>()
                            .toList()
                            .where((element) => element.type == 1)
                            .toList(),
                        color: Color(model.intColor!),
                        userReadings: Get.find<ReadingController>()
                            ._userReadings(model.type!),
                      ),
                    ),
                  );
                },
              ),
            ),
            titles('Physical'),
            CustomContainer(
              // cheight: 110,
              margin: const EdgeInsets.only(bottom: 20),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: physicalList.length,
                separatorBuilder: (context, index) =>
                    const Divider(color: Colors.black, height: 0.3),
                itemBuilder: (context, index) {
                  AppModel model = physicalList[index];
                  return InkWell(
                    child: expansionTile(
                      color: Color(model.intColor!),
                      title: model.title,
                    ),
                    onTap: () => Get.to(
                      () => CustomReadingLibrary(
                        title: model.title,
                        list: model.list!
                            .cast<AppModel>()
                            .toList()
                            .where((element) => element.type == 1)
                            .toList(),
                        color: Color(model.intColor!),
                        userReadings: Get.find<ReadingController>()
                            ._userReadings(model.type!),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget expansionTile({
    required String title,
    Widget? titleIcon,
    Color? color,
    List<Widget>? children,
    bool intro = false,
  }) {
    return Container(
      color: color,
      padding: const EdgeInsets.only(top: 10, bottom: 10),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.keyboard_arrow_right),
          intro
              ? const Icon(Icons.description_outlined).marginOnly(right: 5)
              : const SizedBox.shrink(),
          intro ? TextWidget(text: title) : elementTitle(title),
        ],
      ),
      // ),
    );
  }
}

class FreeReadingScreen extends StatefulWidget {
  const FreeReadingScreen({Key? key}) : super(key: key);

  @override
  State<FreeReadingScreen> createState() => _FreeReadingScreenState();
}

class _FreeReadingScreenState extends State<FreeReadingScreen>
    with TickerProviderStateMixin {
  final Stopwatch stopwatch = Stopwatch();
  late AnimationController controller;
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  final Rx<FreeReading> _reading = FreeReading(
    id: generateId(),
  ).obs;

  Future addFreeReading() async {
    loadingDialog(context);
    await freeReadings(Get.find<AuthServices>().userid)
        .doc(_reading.value.id)
        .set(_reading.value.toMap());
    stopwatch.reset();
    Get.back();
    customSnackbar(
      title: 'Recorded Successfully!',
      message: 'Reading has been recorded successfully.',
      position: SnackPosition.BOTTOM,
    );
  }

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    super.initState();
  }

  final RxBool first = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 10,
        ),
        child: Column(
          children: [
            const TextWidget(
              text: 'Free Reading (Practice)',
              weight: FontWeight.bold,
              alignment: Alignment.center,
              textAlign: TextAlign.center,
              size: 18,
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'Read something, anything, to expand your mind and your horizons. This is for reading that is outside of the Thriving Shortcut learning modules.',
              alignment: Alignment.center,
              textAlign: TextAlign.center,
              fontStyle: FontStyle.italic,
            ).marginOnly(left: 20, right: 20, bottom: 30),
            SizedBox(
              height: height * 0.3,
              child: CustomStopwatch(
                text: 'Read',
                stopwatch: stopwatch,
                controller: controller,
              ),
            ).marginOnly(bottom: 50),
            Row(
              children: [
                const Icon(Icons.volume_up_rounded),
                SizedBox(
                  width: width * 0.73,
                  child: Slider(
                    value: 0.45,
                    onChanged: (val) {},
                    inactiveColor: Colors.grey.withOpacity(0.5),
                  ),
                ),
              ],
            ).marginOnly(left: 15, right: 15),
            CustomElevatedButton(
              text: stopwatch.isRunning ? 'Pause' : 'Read Now!',
              onPressed: () {
                setState(() {
                  if (!stopwatch.isRunning) {
                    if (!first.value) {
                      start = DateTime.now();
                      _reading.value.start = start;
                      first.value = !first.value;
                    }
                    stopwatch.start();
                    print(_reading.value.start);
                  } else if (stopwatch.isRunning) {
                    stopwatch.stop();
                  }
                });
              },
            ).marginOnly(bottom: 40, left: 15, right: 15),
            CustomElevatedButton(
              text: 'Finished',
              onPressed: () async {
                setState(() {
                  if (stopwatch.isRunning) {
                    stopwatch.stop();
                    end = DateTime.now();
                    _reading.value.seconds = end.difference(start).inSeconds;
                  }
                });
                await addFreeReading();
              },
            ).marginOnly(left: 25, right: 25)
          ],
        ),
      ),
    );
  }
}
