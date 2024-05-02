// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Functions/date_picker.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Screens/custom_bottom.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/checkboxes.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/drop_down_button.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';

import '../../../Common/journal_top.dart';
import '../../../Constants/constants.dart';
import '../../../Model/action_model.dart';
import '../../../Model/app_modal.dart';
import '../../../Model/app_user.dart';
import '../../../Model/bd_models.dart';
import '../../../Services/auth_services.dart';
import '../../../Widgets/app_bar.dart';
import '../../../Widgets/loading_dialog.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../../Widgets/text_widget.dart';
import '../Readings/bd_reading.dart';
import '../bd_home.dart';

class TacticalReviewScreen extends StatefulWidget {
  const TacticalReviewScreen({Key? key}) : super(key: key);

  @override
  State<TacticalReviewScreen> createState() => _TacticalReviewScreenState();
}

class _TacticalReviewScreenState extends State<TacticalReviewScreen> {
  TextEditingController name = TextEditingController(
    text: 'TacticalReview ${formatTitelDate(DateTime.now())}',
  );
  RxString start = ''.obs;
  RxString end = ''.obs;
  RxInt sort = 0.obs;

  Future<DateTime> pickDate(String date) async {
    return await customDatePicker(
      context,
      initialDate: date == '' ? DateTime.now() : dateFromString(date),
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    );
  }

  RxBool list = true.obs;
  RxBool quadrant = true.obs;
  RxBool ideal = true.obs;

  TextEditingController quadrantAnalysis = TextEditingController();

  TextEditingController gap = TextEditingController();
  TextEditingController categoriesless = TextEditingController();
  TextEditingController categoriesMore = TextEditingController();

  TextEditingController didnt = TextEditingController();
  TextEditingController surprise = TextEditingController();
  TextEditingController realistic = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: customAppbar(
            leading: backButton(
              () => index.value == 0 ? Get.back() : previousIndex(),
            ),
            implyLeading: true,
          ),
          bottomNavigationBar: BottomButtons(
            button1: index.value != 5 ? 'Continue' : 'Done',
            button2: 'Save',
            onPressed1: index.value != 5
                ? () => updateIndex()
                : () async => edit ? await updateReview() : await addReview(),
            onPressed2: () async => await addReview(true),
            onPressed3: () => index.value != 0 ? previousIndex() : Get.back(),
          ),
          body: SingleChildScrollView(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Column(
              children: [
                ExerciseTitle(
                  title: 'Tactical Review (Practice)',
                  onPressed: () => Get.to(() => const TacticalReviewReading()),
                ),
                JournalTop(
                  controller: name,
                  add: () => clearData(),
                  save: () async =>
                      edit ? await updateReview(true) : await addReview(true),
                  drive: () => Get.off(() => const PreviousReviews()),
                ).marginOnly(bottom: 5),
                index.value == 0
                    ? page1()
                    : index.value == 1
                        ? page2()
                        : index.value == 2
                            ? page3()
                            : index.value == 3
                                ? page4()
                                : index.value == 4
                                    ? page5()
                                    : index.value == 5
                                        ? page6()
                                        : Container(),
              ],
            ),
          ),
        );
      },
    );
  }

  clearData() {
    index.value = 0;
    start.value = '';
    end.value = '';
    sort.value = 0;
    list.value = true;
    quadrant.value = true;
    ideal.value = true;
    quadrantAnalysis.clear();
    gap.clear();
    categoriesMore.clear();
    categoriesless.clear();
    didnt.clear();
    surprise.clear();
    realistic.clear();
    _review.value = TacticalReviewModel(
      id: generateId(),
      userid: Get.find<AuthServices>().userid,
    );
    filteredaction0.clear();
    filteredaction1.clear();
    filteredaction2.clear();
    filteredaction3.clear();
    duplicatedTime = <String>['', ''].obs;
    clearActions();
    setState(() {});
  }

  Widget page6() {
    return Column(
      children: [
        const TextWidget(
          text: 'Conclusion',
          weight: FontWeight.bold,
          size: 16,
          alignment: Alignment.center,
        ).marginOnly(top: 10),
        const TextWidget(
          text:
              'Is there anything you didn\'t do because you knew you\'d have to track it? Why?',
          textAlign: TextAlign.justify,
          size: 16,
        ).marginOnly(bottom: 10, top: 10),
        TextFormField(
          controller: didnt,
          maxLines: 7,
          decoration: inputDecoration(),
        ).marginOnly(bottom: 15),
        const TextWidget(
          text: 'How did this analysis surprise you?',
          textAlign: TextAlign.justify,
          size: 16,
        ).marginOnly(bottom: 10, top: 10),
        TextFormField(
          controller: surprise,
          maxLines: 7,
          decoration: inputDecoration(),
        ).marginOnly(bottom: 15),
        const TextWidget(
          text:
              'Was your ideal time use realistic and attainable? How can you make it more attainable and realistic without sacrificing your most important goals and priorities?',
          textAlign: TextAlign.justify,
          size: 16,
        ).marginOnly(bottom: 10, top: 10),
        TextFormField(
          controller: realistic,
          maxLines: 7,
          decoration: inputDecoration(),
        ).marginOnly(bottom: 15),
      ],
    ).marginOnly(left: 10, right: 10);
  }

  Widget page5() {
    return Column(
      children: [
        const TextWidget(
          text:
              'Is there a gap in actual vs. ideal time use? How can you close this gap? ',
          textAlign: TextAlign.justify,
          size: 16,
        ).marginOnly(bottom: 10, top: 10),
        TextFormField(
          controller: gap,
          maxLines: 7,
          decoration: inputDecoration(),
        ).marginOnly(bottom: 15),
        const TextWidget(
          text:
              'What categories would you like to spend less time in? How will you alter your environment or priorities to change your time use? ',
          textAlign: TextAlign.justify,
          size: 16,
        ).marginOnly(bottom: 10, top: 10),
        TextFormField(
          controller: categoriesless,
          maxLines: 7,
          decoration: inputDecoration(),
        ).marginOnly(bottom: 15),
        const TextWidget(
          text:
              'What categories would you like to spend more time in? How will you alter your environment or priorities to change your time use? ',
          textAlign: TextAlign.justify,
          size: 16,
        ).marginOnly(bottom: 10, top: 10),
        TextFormField(
          controller: categoriesMore,
          maxLines: 7,
          decoration: inputDecoration(),
        ).marginOnly(bottom: 15),
      ],
    ).marginOnly(left: 10, right: 10);
  }

  List<AppModel> get actualTimeUse =>
      idealTimeList.where((p0) => p0.actual != 0).toList();
  List<AppModel> get idealTimeUse =>
      idealTimeList.where((p0) => p0.ideal != 0).toList();
  List<AppModel> get idealtimelist =>
      idealTimeList.where((p0) => p0.value != -1).toList();

  List<Color> colors = const <Color>[
    Color(0xffADE256),
    Color(0xffE2CF56),
    Color(0xffE38955),
    Color(0xffE25667),
    Color(0xffE256AD),
    Color(0xffCF56E3),
    Color(0xff8B56E2),
    Color(0xff5868E3),
    Color(0xff57AEE3),
    Color(0xff57E2CF),
    Color(0xff56E289),
    Color(0xff68E357),
  ];
  Widget page4() {
    return Column(
      children: [
        CustomCheckBox(
          value: ideal.value,
          onChanged: (val) => ideal.value = val,
          title: 'Actual Vs. Ideal Time Use by Category',
          width: width,
          titleWeight: FontWeight.bold,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width * 0.45,
              child: Column(
                children: [
                  const TextWidget(
                    text: 'Actual Time Use',
                    weight: FontWeight.bold,
                  ).marginOnly(bottom: 10),
                  Column(
                    children: List.generate(
                      actualTimeUse.length,
                      (index) {
                        final _actual = actualTimeUse[index];
                        return qADetail(
                          _actual.actual == 0
                              ? '0'
                              : secondsToHours(_actual.actual!)
                                  .toStringAsFixed(2),
                          calculatePercentage(_actual.actual!, totalTime.value)
                              .toString(),
                          _actual.title.capitalize!,
                          width * 0.23,
                        );
                      },
                    ),
                  ),
                  // qADetail(
                  //   unclassifiedCategory.value == 0
                  //       ? '0'
                  //       : secondsToHours(unclassifiedCategory.value)
                  //           .toStringAsFixed(2),
                  //   calculatePercentage(
                  //           unclassifiedCategory.value, totalTime.value)
                  //       .toString(),
                  //   'Unclassified',
                  //   width * 0.23,
                  // ),
                ],
              ),
            ),

            /// ideal time
            SizedBox(
              width: width * 0.45,
              child: Column(
                children: [
                  const TextWidget(
                    text: 'Ideal Time Use',
                    weight: FontWeight.bold,
                  ).marginOnly(bottom: 10),
                  Column(
                    children: List.generate(
                      recentidealTimeList.length,
                      (index) {
                        final _actual = recentidealTimeList[index];
                        return _actual.value == -1
                            ? Container()
                            : qADetail(
                                _actual.percentage == 0
                                    ? '0'
                                    : percent(_actual.percentage ?? 0),
                                percent(_actual.percentage ?? 0),
                                _actual.title.capitalize!,
                                width * 0.23,
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).marginOnly(bottom: 30),

        /// actual time user chart
        const TextWidget(
          text: 'Actual Time Use',
          alignment: Alignment.center,
          weight: FontWeight.bold,
          size: 20,
        ),
        Container(
          height: height * 0.3,
          margin: const EdgeInsets.only(top: 15, bottom: 30),
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 0,
              sections: List.generate(
                (actualTimeUse.length),
                (index) {
                  // if (actualTimeUse.length == index) {
                  //   return PieChartSectionData(
                  //     showTitle: true,
                  //     radius: 100,
                  //     value: unclassifiedCategory.value / totalTime.value,
                  //     color: const Color(0xffFFFB95),
                  //     title: secondsToHours(unclassifiedCategory.value)
                  //         .toStringAsFixed(2),
                  //     titlePositionPercentageOffset: 1.2,
                  //   );
                  // } else {
                  final _actual = actualTimeUse[index];
                  return PieChartSectionData(
                    radius: 100,
                    showTitle: true,
                    value: _actual.actual! / totalTime.value,
                    color: index > colors.length - 1
                        ? colors[index - (colors.length - 1)]
                        : colors[index],
                    title: secondsToHours(_actual.actual!).toStringAsFixed(2),
                    titlePositionPercentageOffset: 1.2,
                  );
                  // }
                },
              ),
            ),
          ),
        ),
        SizedBox(
          height: height * 0.2,
          child: GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 3.0,
            ),
            children: List.generate(
              actualTimeUse.length,
              (index) {
                // if (actualTimeUse.length == index) {
                //   return quadrantIndicator(
                //     const Color(0xffFFFB95),
                //     'Unclassified',
                //   );
                // } else {
                final _actual = actualTimeUse[index];
                return quadrantIndicator(
                  index > colors.length - 1
                      ? colors[index - (colors.length - 1)]
                      : colors[index],
                  _actual.title,
                );
                // }
              },
            ),
          ),
        ),

        /// ideal time user chart
        const TextWidget(
          text: 'Ideal Time Use',
          alignment: Alignment.center,
          weight: FontWeight.bold,
          size: 20,
        ).marginOnly(top: 30),
        Container(
          height: height * 0.3,
          margin: const EdgeInsets.only(top: 15, bottom: 30),
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 0,
              sections: List.generate(
                recentidealTimeList.length,
                (index) {
                  final _actual = recentidealTimeList[index];
                  return PieChartSectionData(
                    radius: 100,
                    showTitle: true,
                    value: _actual.percentage,
                    color: index > colors.length - 1
                        ? colors[index - (colors.length - 1)]
                        : colors[index],
                    title: percent(_actual.percentage ?? 0),
                    titlePositionPercentageOffset: 1.2,
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(
          height: height * 0.2,
          child: GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 3.0,
            ),
            children: List.generate(
              recentidealTimeList.length,
              (index) {
                final _actual = recentidealTimeList[index];
                return _actual.value == -1
                    ? Container()
                    : quadrantIndicator(
                        index > colors.length - 1
                            ? colors[index - (colors.length - 1)]
                            : colors[index],
                        _actual.title,
                      );
              },
            ),
          ),
        ),
      ],
    );
  }

  String percent(double value) {
    String received = value.toStringAsFixed(2);
    final separated = received.split('.');
    if (separated[1] == '00') {
      return separated.first;
    } else {
      return received;
    }
  }

  Widget page3() {
    return Column(
      children: [
        const TextWidget(
          text:
              'What does the quadrant analysis tell you about how you are spending your time? Are you spending too much time on distractions in quadrant 4? Are you getting stuck doing quadrant 3 busy work/chores that could be delegated? Are you not planning far enough ahead in your important work and getting overwhelmed by quadrant 1 work? Or are you spending time on important work in quadrant 2 that will pay off handsomely in the future? How will you alter your schedule to stay in quadrant 2',
          size: 16,
          textAlign: TextAlign.justify,
        ).marginOnly(bottom: 17, top: 10),
        TextFormField(
          maxLines: 22,
          controller: quadrantAnalysis,
          textInputAction: TextInputAction.newline,
          decoration: inputDecoration(),
        ),
      ],
    ).marginOnly(left: 10, right: 10);
  }

  Widget page2() {
    return Column(
      children: [
        CustomCheckBox(
          value: quadrant.value,
          onChanged: (val) => quadrant.value = val,
          title: 'Quadrant Analysis',
          width: width,
          titleWeight: FontWeight.bold,
        ),
        qADetail(
          urgency1.value == 0
              ? '0'
              : secondsToHours(urgency1.value).toStringAsFixed(2).toString(),
          calculatePercentage(urgency1.value, totalTime.value).toString(),
          '1: Urgent and important',
        ),
        qADetail(
          urgency2.value == 0
              ? '0'
              : secondsToHours(urgency2.value).toStringAsFixed(2),
          calculatePercentage(urgency2.value, totalTime.value).toString(),
          '2: Not urgent but important',
        ),
        qADetail(
          urgency3.value == 0
              ? '0'
              : secondsToHours(urgency3.value).toStringAsFixed(0),
          calculatePercentage(urgency3.value, totalTime.value).toString(),
          '3: Urgent but not important',
        ),
        qADetail(
          urgency4.value == 0
              ? '0'
              : secondsToHours(urgency4.value).toStringAsFixed(2),
          calculatePercentage(urgency4.value, totalTime.value).toString(),
          '4: Not urgent and not important',
        ),
        qADetail(
          unclassified.value == 0
              ? '0'
              : secondsToHours(unclassified.value).toStringAsFixed(2),
          calculatePercentage(unclassified.value, totalTime.value).toString(),
          'Unclassified',
        ),
        verticalSpace(height: height * 0.02),
        AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 0,
              sections: [
                PieChartSectionData(
                  radius: 130,
                  showTitle: true,
                  value: urgency1.value / totalTime.value,
                  color: const Color(0xff00ACFF),
                  title: secondsToHours(urgency1.value).toStringAsFixed(2),
                  titlePositionPercentageOffset: 1.2,
                  // titlePositionPercentageOffset: 10,
                ),
                PieChartSectionData(
                  radius: 130,
                  showTitle: true,
                  value: urgency2.value / totalTime.value,
                  color: const Color(0xff25FAFF),
                  title: secondsToHours(urgency2.value).toStringAsFixed(2),
                  titlePositionPercentageOffset: 1.2,
                  // titlePositionPercentageOffset: 10,
                ),
                PieChartSectionData(
                  radius: 130,
                  showTitle: true,
                  value: urgency3.value / totalTime.value,
                  color: const Color(0xff3FFFE3),
                  title: secondsToHours(urgency3.value).toStringAsFixed(2),
                  titlePositionPercentageOffset: 1.2,
                  // titlePositionPercentageOffset: 10,
                ),
                PieChartSectionData(
                  radius: 130,
                  showTitle: true,
                  value: urgency4.value / totalTime.value,
                  color: const Color(0xff04F997),
                  title: secondsToHours(urgency4.value).toStringAsFixed(2),
                  titlePositionPercentageOffset: 1.2,
                  // titlePositionPercentageOffset: 10,
                ),
                PieChartSectionData(
                  showTitle: true,
                  radius: 130,
                  value: unclassified.value / totalTime.value,
                  color: const Color(0xffACFF93),
                  title: secondsToHours(unclassified.value).toStringAsFixed(2),
                  titlePositionPercentageOffset: 1.2,
                  // titlePositionPercentageOffset: 10,
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            quadrantIndicator(const Color(0xff00ACFF), 'Quadrant 1'),
            quadrantIndicator(const Color(0xff25FAFF), 'Quadrant 2'),
            quadrantIndicator(const Color(0xff3FFFE3), 'Quadrant 3'),
          ],
        ).marginOnly(bottom: 10),
        Row(
          children: [
            quadrantIndicator(const Color(0xff04F997), 'Quadrant 4'),
            quadrantIndicator(const Color(0xffACFF93), 'Quadrant 5'),
          ],
        ),
      ],
    );
  }

  Widget quadrantIndicator(Color color, String title) {
    return Center(
      child: Row(
        children: [
          Container(
            width: 25,
            height: 15,
            color: color,
            margin: const EdgeInsets.only(right: 10),
          ),
          SizedBox(
            width: width * 0.152,
            child: TextWidget(
                text: title, alignment: Alignment.centerLeft, maxline: 2),
          ),
        ],
      ).marginOnly(right: 20),
    );
  }

  Widget qADetail(String hours, String percentage, String title,
      [double? _width]) {
    return Row(
      children: [
        SizedBox(
          width: _width ?? width * 0.3,
          child: TextWidget(
            text: '$hours hrs ($percentage%)',
            maxline: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(child: TextWidget(text: title)),
      ],
    ).marginOnly(bottom: 5);
  }

  Widget page1() {
    return Column(
      children: [
        const TextWidget(
          text: 'Choose a Period in the past to Review',
          alignment: Alignment.center,
          textAlign: TextAlign.center,
          fontStyle: FontStyle.italic,
        ).marginOnly(bottom: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidget(text: 'Date Range of '),
            DateWidget(
              date: start.value == '' ? 'MM/DD/YY' : start.value,
              ontap: () async =>
                  start.value = formateDate(await pickDate(start.value)),
            ),
            const TextWidget(text: ' - '),
            DateWidget(
              date: end.value == '' ? 'MM/DD/YY' : end.value,
              ontap: () async {
                end.value = formateDate(await pickDate(end.value));
                getFilteredValues();
                setState(() {});
              },
            ),
          ],
        ).marginOnly(bottom: 15),
        overallStatsWidget(
          'Most Productive Time',
          duplicatedTime[0] == '' ? 'HH-MM' : duplicatedTime[0],
        ),
        overallStatsWidget(
          'Total Time Spent Recording Actions',
          getDurationString(totalTime
              .value), // '${secondsToHours(totalTime.value).toStringAsFixed(0)} hours',
        ),
        overallStatsWidget(
          'Total Number of Actions Completed',
          '${totalCompleted.value}',
        ),
        CustomCheckBox(
          value: list.value,
          onChanged: (val) => list.value = val,
          title: 'List of Actions Taken',
          titleWeight: FontWeight.bold,
          width: width,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const TextWidget(text: 'Sort by: ').marginOnly(right: 5),
                CustomDropDownStruct(
                  child: DropdownButton(
                    value: sort.value,
                    onChanged: (val) {
                      sort.value = val;
                      applySort();
                    },
                    items: sortbyList
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.value,
                            child: TextWidget(
                              text: e.title,
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
            // const TextWidget(text: 'Completed?'),
          ],
        ).marginOnly(bottom: 10),
        if (list.value)
          Column(
            children: [
              for (int i = 0; i < events.length; i++)
                eventsWidget(events[i].type ?? 0, events[i]),
            ],
          ),
      ],
    );
  }

  Widget eventsWidget(int type, AEventModel event) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          type == 2 || type == 3
              ? CustomDropDownStruct(
                  child: DropdownButton(
                    value: event.urgency,
                    onChanged: null,
                    items: urgencyList
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.value,
                            child: TextWidget(
                              text: e.description,
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ).marginOnly(right: 5)
              : const SizedBox(width: 50).marginOnly(right: 5),
          SizedBox(
            width: width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(text: event.description!.capitalizeFirst!),
                if (type != 0)
                  TextWidget(
                    text: idealTimeList[
                            idealTimeType(event.category!, event.catid!)]
                        .title,
                  ),
              ],
            ),
          ).marginOnly(right: 5),
          SizedBox(
            width: width * 0.35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(text: event.actual!.date!),
                TextWidget(text: getDurationString(event.actual!.duration!)),
              ],
            ),
          ).marginOnly(right: 5),
          // Checkbox(value: event.completed, onChanged: (val) {}),
        ],
      ).marginOnly(bottom: 10),
    );
  }

  Widget overallStatsWidget(String title, String value) {
    return Row(
      children: [
        Container(
          width: width * 0.3,
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(3),
          ),
          child: TextWidget(text: value, alignment: Alignment.center),
        ),
        TextWidget(text: title),
      ],
    ).marginOnly(bottom: 10);
  }

  RxInt index = 0.obs;
  updateIndex() => index.value = index.value + 1;
  previousIndex() => index.value = index.value - 1;

  final bool edit = Get.arguments[0];
  final Rx<TacticalReviewModel> _review = TacticalReviewModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  DateTime initial = DateTime.now();
  setData(DateTime _end) {
    _review.value.name = name.text;
    _review.value.startdate = start.value;
    _review.value.endDate = end.value;
    _review.value.spentHours = secondsToHours(totalTime.value).toInt();
    _review.value.actionsCompleted = totalCompleted.value;
    _review.value.quadrantAnalysis = quadrantAnalysis.text;
    _review.value.gap = gap.text;
    _review.value.categoreisSpendMore = categoriesMore.text;
    _review.value.categoriesSpendLess = categoriesless.text;
    _review.value.didntDo = didnt.text;
    _review.value.idealTime = realistic.text;
    _review.value.surpriseYou = surprise.text;
    final diff = _end.difference(initial).inSeconds;
    if (edit) {
      _review.value.duration = _review.value.duration! + diff;
    } else {
      _review.value.duration = diff;
    }
  }

  fetchData() {
    _review.value = Get.arguments[1] as TacticalReviewModel;
    name.text = _review.value.name!;
    start.value = _review.value.startdate!;
    end.value = _review.value.endDate!;
    totalTime.value = _review.value.spentHours!;
    totalCompleted.value = _review.value.actionsCompleted!;
    quadrantAnalysis.text = _review.value.quadrantAnalysis!;
    gap.text = _review.value.gap!;
    categoriesMore.text = _review.value.categoreisSpendMore!;
    categoriesless.text = _review.value.categoriesSpendLess!;
    didnt.text = _review.value.didntDo!;
    realistic.text = _review.value.idealTime!;
    surprise.text = _review.value.surpriseYou!;
    getFilteredValues();
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == bd);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: name.text,
        count: 1,
        duration: end.difference(initial).inSeconds,
        id: _review.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addReview([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    loadingDialog(context);
    final end = DateTime.now();
    setData(end);
    if (edit) _review.value.id = generateId();
    await bdRef.doc(_review.value.id).set(_review.value.toMap());
    await addAccomplishment(end);
    Get.back();
    if (!fromsave) {
      if (Get.find<BdController>().history.value.value == 133) {
        Get.find<BdController>()
            .updateHistory(end.difference(initial).inSeconds);
      }
      Get.back();
    }
    customToast(message: 'Review added successfully');
  }

  Future updateReview([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    loadingDialog(context);
    final end = DateTime.now();
    setData(end);
    await bdRef.doc(_review.value.id).update(_review.value.toMap());
    Get.back();
    if (!fromsave) Get.back();
    customToast(message: 'Updated successfully');
  }

  RxList<AppModel> idealTimeList = <AppModel>[
    AppModel('Unclassified', '', value: -1, type: 0, ideal: 0, actual: 0)
  ].obs;
  RxList<AppModel> recentidealTimeList = <AppModel>[].obs;

  RxInt idealIndex = 0.obs;
  int idealTimeIndex(int value) =>
      idealTimeList.indexWhere((element) => element.type == value);
  int idealTimeType(int value, String id) => idealTimeList.indexWhere(
      (element) => element.description == id && element.value == value);

  Future fetchIdealTime() async {
    await bdRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 2)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (int i = 0; i < value.docs.length; i++) {
          var doc = IdealTimeModel.fromMap(value.docs[i]);
          for (int j = 0; j < doc.categories!.length; j++) {
            final category = doc.categories![j];
            if (category.category != '') {
              idealIndex.value = idealIndex.value + 1;
              idealTimeList.add(
                AppModel(
                  category.category!.capitalize!,
                  doc.id!,
                  value: j,
                  type: idealIndex.value,
                  ideal: 0,
                  actual: 0,
                  percentage: (category.percentage ?? 0.0),
                ),
              );
            }
          }
        }
        print(idealTimeList);
        setState(() {});
      }
    });
    setState(() {});
  }

  RxInt recentidealIndex = 0.obs;
  Future fetchRecentIdealTime() async {
    await bdRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 2)
        .orderBy('created', descending: true)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (int i = 0; i < value.docs.length; i++) {
          var doc = IdealTimeModel.fromMap(value.docs[i]);
          for (int j = 0; j < doc.categories!.length; j++) {
            final category = doc.categories![j];
            if (category.category != '') {
              recentidealIndex.value = idealIndex.value + 1;
              recentidealTimeList.add(
                AppModel(
                  category.category!.capitalize!,
                  doc.id!,
                  value: j,
                  type: idealIndex.value,
                  ideal: 0,
                  actual: 0,
                  percentage: (category.percentage ?? 0.0),
                ),
              );
            }
          }
        }
        print(recentidealTimeList);
        setState(() {});
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    setState(() {
      getActionJournals();
      fetchIdealTime();
      fetchRecentIdealTime();
    });
    super.initState();
  }

  Future getActionJournals() async {
    await actionRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .orderBy('date')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          if (doc['type'] == 0) {
            action0.add(AJL0Model.fromMap(doc));
          } else if (doc['type'] == 1) {
            action1.add(AJL1Model.fromMap(doc));
          } else if (doc['type'] == 2) {
            action2.add(AJL2Model.fromMap(doc));
          } else if (doc['type'] == 3) {
            action3.add(AJL3Model.fromMap(doc));
          }
        }
      }
    }).whenComplete(() {
      if (edit) fetchData();
    });
  }

  RxList<AJL0Model> action0 = <AJL0Model>[].obs;
  RxList<AJL1Model> action1 = <AJL1Model>[].obs;
  RxList<AJL2Model> action2 = <AJL2Model>[].obs;
  RxList<AJL3Model> action3 = <AJL3Model>[].obs;

  RxList<AJL0Model> filteredaction0 = <AJL0Model>[].obs;
  RxList<AJL1Model> filteredaction1 = <AJL1Model>[].obs;
  RxList<AJL2Model> filteredaction2 = <AJL2Model>[].obs;
  RxList<AJL3Model> filteredaction3 = <AJL3Model>[].obs;

  Future getFilteredValues() async {
    totalTime.value = 0;
    totalCompleted.value = 0;
    final _end =
        formateDate(dateFromString(end.value).add(const Duration(days: 1)));
    filteredaction0.assignAll(action0.where((p0) =>
        dateFromString(p0.date!).isAfter(dateFromString(start.value)) &&
        dateFromString(p0.date!).isBefore(dateFromString(_end))));
    print(filteredaction0);
    filteredaction1.assignAll(action1.where((p0) =>
        dateFromString(p0.date!).isAfter(dateFromString(start.value)) &&
        dateFromString(p0.date!).isBefore(dateFromString(_end))));
    print(filteredaction1);
    filteredaction2.assignAll(action2.where((p0) =>
        dateFromString(p0.date!).isAfter(dateFromString(start.value)) &&
        dateFromString(p0.date!).isBefore(dateFromString(_end))));
    print(filteredaction2);
    filteredaction3.assignAll(action3.where((p0) =>
        dateFromString(p0.date!).isAfter(dateFromString(start.value)) &&
        dateFromString(p0.date!).isBefore(dateFromString(_end))));
    print(filteredaction3);
    mostRepetativeTime();
    totalActions();
    addEvents();
    applySort();
  }

  List<AEventModel> events = <AEventModel>[];

  addEvents() {
    events.clear();
    setState(() {
      for (int i = 0; i < filteredaction0.length; i++) {
        for (int j = 0; j < filteredaction0[i].actual!.length; j++) {
          filteredaction0[i].actual![j].type = filteredaction0[i].type;
          events.add(filteredaction0[i].actual![j]);
        }
      }
      for (int i = 0; i < filteredaction1.length; i++) {
        for (int j = 0; j < filteredaction1[i].actual!.length; j++) {
          filteredaction1[i].actual![j].type = filteredaction1[i].type;
          events.add(filteredaction1[i].actual![j]);
        }
      }
      for (int i = 0; i < filteredaction2.length; i++) {
        for (int j = 0; j < filteredaction2[i].actual!.length; j++) {
          filteredaction2[i].actual![j].type = filteredaction2[i].type;
          events.add(filteredaction2[i].actual![j]);
        }
      }
      for (int i = 0; i < filteredaction3.length; i++) {
        for (int j = 0; j < filteredaction3[i].actual!.length; j++) {
          filteredaction3[i].actual![j].type = filteredaction3[i].type;
          events.add(filteredaction3[i].actual![j]);
        }
      }
    });
  }

  applySort() {
    if (sort.value == 0) {
      events.sort((a, b) => a.actual!.date!.compareTo(b.actual!.date!));
    } else if (sort.value == 1) {
      events.sort((a, b) => b.actual!.duration!.compareTo(a.actual!.duration!));
    } else if (sort.value == 2) {
      events.sort((a, b) => b.urgency!.compareTo(a.urgency!));
    } else if (sort.value == 3) {
      events.sort((a, b) => a.category!.compareTo(b.category!));
    }
    setState(() {});
  }

  RxList<String> duplicatedTime = <String>['', ''].obs;
  mostRepetativeTime() {
    List starttime = [];
    duplicatedTime = <String>['', ''].obs;
    for (var element in filteredaction0) {
      final date =
          '${element.mostEnergetic!.start!}-${element.mostEnergetic!.end!}';
      if (starttime.contains(date)) {
        print('Duplicated: $date');
        duplicatedTime[0] = date;
      } else {
        starttime.add(date);
      }
    }
    for (var element in filteredaction1) {
      final date = '${element.energetic!.start!}-${element.energetic!.end!}';
      if (starttime.contains(date)) {
        print('Duplicated: $date');
        duplicatedTime[0] = date;
      } else {
        starttime.add(date);
      }
    }
    for (var element in filteredaction2) {
      final date = '${element.energetic!.start!}-${element.energetic!.end!}';
      if (starttime.contains(date)) {
        print('Duplicated: $date');
        duplicatedTime[0] = date;
      } else {
        starttime.add(date);
      }
    }
    for (var element in filteredaction3) {
      final date = '${element.energetic!.start!}-${element.energetic!.end!}';
      if (starttime.contains(date)) {
        print('Duplicated: $date');
        duplicatedTime[0] = date;
      } else {
        starttime.add(date);
      }
    }

    if (duplicatedTime[0] == '') {
      duplicatedTime[0] = starttime[Random().nextInt(starttime.length)];
    }
  }

  clearActions() {
    totalTime.value = 0;
    totalCompleted.value = 0;
    totalEvent.value = 0;
    idealTotalTime.value = 0;

    urgency1.value = 0;
    urgency2.value = 0;
    urgency3.value - 0;
    urgency4.value = 0;
    unclassified.value = 0;

    unclassifiedCategory.value = 0;
    iunclassifiedCategory.value = 0;
  }

  RxInt totalTime = 0.obs;
  RxInt totalCompleted = 0.obs;
  totalActions() {
    clearActions();
    _updateActionsLvl0(filteredaction0);
    _updateActionsLvl1(filteredaction1);
    _updateActionsLvl2(filteredaction2);
    _updateActionsLvl3(filteredaction3);
  }

  RxInt totalEvent = 0.obs;
  RxInt idealTotalTime = 0.obs;

  RxInt urgency1 = 0.obs;
  RxInt urgency2 = 0.obs;
  RxInt urgency3 = 0.obs;
  RxInt urgency4 = 0.obs;
  RxInt unclassified = 0.obs;

  RxInt unclassifiedCategory = 0.obs;
  RxInt iunclassifiedCategory = 0.obs;

  updateTotal([int value = 1]) => totalEvent.value = totalEvent.value + value;
  updateCompleted([int value = 1]) =>
      totalCompleted.value = totalCompleted.value + value;
  updateTotalTime(int value) => totalTime.value = totalTime.value + value;
  updateItTime(int value) =>
      idealTotalTime.value = idealTotalTime.value + value;

  /// urgency
  unclassifiedUrgency([int value = 1]) =>
      unclassified.value = unclassified.value + value;
  updateUrgency1([int value = 1]) => urgency1.value = urgency1.value + value;
  updateUrgency2([int value = 1]) => urgency2.value = urgency2.value + value;
  updateUrgency3([int value = 1]) => urgency3.value = urgency3.value + value;
  updateUrgency4([int value = 1]) => urgency4.value = urgency4.value + value;

  /// categories
  updateUnclassifedCat([int value = 1]) => {
        unclassifiedCategory.value = unclassifiedCategory.value + value,
        idealTimeList[0].actual = idealTimeList[0].actual! + value,
      };
  updateUnclassifediCat([int value = 1]) =>
      iunclassifiedCategory.value = iunclassifiedCategory.value + value;
  updateideal(int category, String id, [int value = 1]) =>
      idealTimeList[idealTimeType(category, id)].ideal =
          idealTimeList[idealTimeType(category, id)].ideal! + value;
  updateActual(int category, String id, [int value = 1]) =>
      idealTimeList[idealTimeType(category, id)].actual =
          idealTimeList[idealTimeType(category, id)].actual! + value;

  _updateActionsLvl0(List<AJL0Model> list) {
    for (var action in list) {
      updateTotal(action.actual!.length);

      for (int i = 0; i < action.actual!.length; i++) {
        final _event = action.actual![i];
        if (_event.completed!) updateCompleted();
        updateTotalTime(_event.actual!.duration!);
        updateItTime(_event.actual!.duration!);
        unclassifiedUrgency(_event.actual!.duration!);
        updateUnclassifedCat(_event.actual!.duration!);
        updateUnclassifediCat(_event.actual!.duration!);
      }
    }
    print('Total Events: ${totalEvent.value}');
    print('Total Ideal Time: ${idealTotalTime.value}');
    print('Total TIme: ${totalTime.value}');
    print('Unclassified: ${unclassified.value}');
  }

  _updateActionsLvl1(List<AJL1Model> list) {
    for (var action in list) {
      updateTotal(action.actual!.length);
      for (int i = 0; i < action.actual!.length; i++) {
        final _event = action.actual![i];
        if (_event.completed!) updateCompleted();
        updateideal(_event.category!, _event.catid!, _event.actual!.duration!);
        updateActual(_event.category!, _event.catid!, _event.actual!.duration!);
        updateTotalTime(_event.actual!.duration!);
        updateItTime(_event.actual!.duration!);
        unclassifiedUrgency(_event.actual!.duration!);
      }
    }
    print('Unclassified: ${unclassifiedCategory.value}');
    print('Unclassified: ${iunclassifiedCategory.value}');
  }

  updateUrgencies(int urgency, int duration) {
    switch (urgency) {
      case 0:
        updateUrgency1(duration);
        break;
      case 1:
        updateUrgency2(duration);
        break;
      case 2:
        updateUrgency3(duration);
        break;
      case 3:
        updateUrgency4(duration);
        break;
    }
  }

  _updateActionsLvl2(List<AJL2Model> list) {
    for (var action in list) {
      updateTotal(action.actual!.length);
      // for (int i = 0; i < action.events!.length; i++) {
      //   final _event = action.events![i];
      //   if (_event.completed!) updateCompleted();
      //   updateItTime(_event.scheduled!.duration!);
      //   updateideal(
      //       _event.category!, _event.catid!, _event.scheduled!.duration!);
      // }

      for (int i = 0; i < action.actual!.length; i++) {
        final _event = action.actual![i];
        // try {
        //   if (_event.description != action.events![i].description) {
        //     updateTotal();
        //     if (_event.completed!) updateCompleted();
        //     updateTotalTime(_event.actual!.duration!);
        //     updateItTime(_event.actual!.duration!);
        //     updateideal(
        //         _event.category!, _event.catid!, _event.actual!.duration!);
        //     updateActual(
        //         _event.category!, _event.catid!, _event.actual!.duration!);
        //     updateUrgencies(_event.urgency!, _event.actual!.duration!);
        //   } else {
        //     updateActual(
        //         _event.category!, _event.catid!, _event.actual!.duration!);
        //     updateTotalTime(_event.actual!.duration!);
        //     updateUrgencies(_event.urgency!, _event.actual!.duration!);
        //   }
        // } catch (e) {
        //   updateTotal();
        if (_event.completed!) updateCompleted();
        updateideal(_event.category!, _event.catid!, _event.actual!.duration!);
        updateActual(_event.category!, _event.catid!, _event.actual!.duration!);
        updateTotalTime(_event.actual!.duration!);
        updateItTime(_event.actual!.duration!);
        updateUrgencies(_event.urgency!, _event.actual!.duration!);
        // }
      }
    }
    print('Total Events: ${totalEvent.value}');
    print('Total Ideal Time: ${idealTotalTime.value}');
    print('Total TIme: ${totalTime.value}');
    print('Unclassified: ${unclassified.value}');
  }

  _updateActionsLvl3(List<AJL3Model> list) {
    for (var action in list) {
      updateTotal(action.actual!.length);
      // for (int i = 0; i < action.events!.length; i++) {
      //   final _event = action.events![i];
      //   if (_event.completed!) updateCompleted();
      //   updateItTime(_event.scheduled!.duration!);
      //   updateideal(
      //       _event.category!, _event.catid!, _event.scheduled!.duration!);
      // }

      for (int i = 0; i < action.actual!.length; i++) {
        final _event = action.actual![i];
        // try {
        //   if (_event.description != action.events![i].description) {
        //     updateTotal();
        //     if (_event.completed!) updateCompleted();
        //     updateTotalTime(_event.actual!.duration!);
        //     updateItTime(_event.actual!.duration!);
        //     updateideal(
        //         _event.category!, _event.catid!, _event.actual!.duration!);
        //     updateActual(
        //         _event.category!, _event.catid!, _event.actual!.duration!);
        //     updateUrgencies(_event.urgency!, _event.actual!.duration!);
        //   } else {
        //     updateActual(
        //         _event.category!, _event.catid!, _event.actual!.duration!);
        //     updateTotalTime(_event.actual!.duration!);
        //     updateUrgencies(_event.urgency!, _event.actual!.duration!);
        //   }
        // } catch (e) {
        //   updateTotal();
        if (_event.completed!) updateCompleted();
        updateideal(_event.category!, _event.catid!, _event.actual!.duration!);
        updateActual(_event.category!, _event.catid!, _event.actual!.duration!);
        updateTotalTime(_event.actual!.duration!);
        updateItTime(_event.actual!.duration!);
        updateUrgencies(_event.urgency!, _event.actual!.duration!);
        // }
      }
    }
    print('Total Events: ${totalEvent.value}');
    print('Total Ideal Time: ${idealTotalTime.value}');
    print('Total TIme: ${totalTime.value}');
    print('Unclassified: ${unclassified.value}');
  }
}

class PreviousReviews extends StatelessWidget {
  const PreviousReviews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Tactical Reviews',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: bdRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 3)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data.docs.isEmpty) {
            return CircularLoadingWidget(
              height: height,
              onCompleteText: 'Nothing to show...',
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              final TacticalReviewModel model =
                  TacticalReviewModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const TacticalReviewScreen(),
                      arguments: [true, model]),
                  title: TextWidget(
                    text: model.name!,
                    weight: FontWeight.bold,
                    size: 15,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
