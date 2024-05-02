// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Controller/user_controller.dart';
import 'package:schedular_project/Model/app_modal.dart';
import 'package:schedular_project/Model/app_user.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/checkboxes.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/drop_down_button.dart';
import 'package:schedular_project/Widgets/text_widget.dart';
import 'package:cell_calendar/cell_calendar.dart';

import '../Functions/date_picker.dart';
import '../Functions/functions.dart';
import '../Widgets/custom_button.dart';
import 'custom_bottom.dart';

class AccomplishmentScreen extends StatelessWidget {
  const AccomplishmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            headline('Accomplishments').marginOnly(bottom: 30),
            Column(
              children: [
                AppButton(
                  onTap: () => Get.to(() => const CompletedExercises()),
                  title: 'Completed Exercises',
                  description:
                      'View all your completed exercises by date and category',
                ).marginOnly(bottom: 30),
                AppButton(
                  onTap: () => Get.to(() => const StatsScreen()),
                  title: 'Stats & Streak',
                  description:
                      'See which days you completed your routines and habits, how much time you spent doing it, and more.',
                ).marginOnly(bottom: 30),
              ],
            ).marginOnly(left: 25, right: 25),
          ],
        ),
      ),
    );
  }
}

class CompletedExercises extends StatefulWidget {
  const CompletedExercises({Key? key}) : super(key: key);

  @override
  State<CompletedExercises> createState() => _CompletedExercisesState();
}

class _CompletedExercisesState extends State<CompletedExercises> {
  RxBool filter = false.obs;
  RxInt sort = 0.obs;

  RxString start = ''.obs;
  RxString end = ''.obs;

  Future<DateTime> pickDate(String date) async {
    return await customDatePicker(
      context,
      initialDate: date == '' ? DateTime.now() : dateFromString(date),
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    );
  }

  @override
  void initState() {
    Get.find<UserController>()
        .fetchAccomplishments(Get.find<AuthServices>().userid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Column(
            children: [
              titles('Completed Exercises', alignment: Alignment.center)
                  .marginOnly(bottom: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomCheckBox(
                    value: filter.value,
                    onChanged: (val) => filter.value = val,
                    title: 'Filter',
                  ),
                  Row(
                    children: [
                      const TextWidget(text: 'Sort by:').marginOnly(right: 5),
                      CustomDropDownStruct(
                        child: DropdownButton(
                          value: sort.value,
                          onChanged: (val) {
                            setState(() {
                              sort.value = val;
                              sortData();
                            });
                          },
                          items: accomplistmentSortList
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e.value,
                                  child: SizedBox(
                                    width: width * 0.28,
                                    child: TextWidget(
                                      text: e.title,
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (filter.value)
                SizedBox(
                  height: height * 0.4,
                  child: GridView.builder(
                    shrinkWrap: false,
                    itemCount: categoryList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2.0,
                    ),
                    itemBuilder: (context, index) {
                      final AppModel category = categoryList[index];
                      return CustomCheckBox(
                        value: category.check,
                        onChanged: (val) {
                          setState(() {
                            category.check = val;
                            applyfilter();
                          });
                        },
                        title: category.title,
                        width: 100,
                        textAlignment: Alignment.centerLeft,
                      );
                    },
                  ).marginOnly(bottom: 10),
                ),
              Row(
                children: [
                  DateWidget(
                    size: 18,
                    weight: FontWeight.bold,
                    date: start.value == '' ? 'MM/DD/YY' : start.value,
                    ontap: () async {
                      await pickDate(start.value).then((value) {
                        if (end.value != '' &&
                            value.isAfter(dateFromString(end.value))) {
                          customToast(
                            message:
                                'Start date can\'t be a date after the end date',
                          );
                        } else {
                          start.value = formateDate(value);
                          selectData();
                        }
                        setState(() {});
                      });
                      setState(() {});
                      // start.value = formateDate(await pickDate(start.value));
                    },
                  ),
                  const TextWidget(text: ' - '),
                  DateWidget(
                    size: 18,
                    weight: FontWeight.bold,
                    date: end.value == '' ? 'MM/DD/YY' : end.value,
                    ontap: () async {
                      await pickDate(end.value).then((value) {
                        if (value.isBefore(dateFromString(start.value))) {
                          customToast(
                            message:
                                'End date should be greater than start date',
                          );
                        } else {
                          end.value = formateDate(value);
                          selectData();
                        }
                        setState(() {});
                      });
                      setState(() {});
                    },
                  ),
                ],
              ).marginOnly(bottom: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.2,
                    child: const TextWidget(text: 'Exercise', size: 16),
                  ),
                  SizedBox(
                    width: width * 0.2,
                    child: const TextWidget(text: 'Category', size: 16),
                  ),
                  const TextWidget(text: 'Date', size: 16),
                  const TextWidget(text: 'Duration', size: 16),
                ],
              ).marginOnly(bottom: 15),
              if (sortedRoutines.isNotEmpty)
                Column(
                  children: [
                    for (int i = 0; i < sortedRoutines.length; i++)
                      accomplishmentWidget(i),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  RxList<ARoutines> routines = <ARoutines>[].obs;
  RxList<ARoutines> sortedRoutines = <ARoutines>[].obs;
  Widget accomplishmentWidget(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: width * 0.25,
          child: TextWidget(text: sortedRoutines[index].name ?? ''),
        ),
        SizedBox(
          width: width * 0.25,
          child: TextWidget(
            text: sortedRoutines[index].categoryName ?? '',
            maxline: 2,
          ),
        ),
        SizedBox(child: TextWidget(text: sortedRoutines[index].date ?? '')),
        TextWidget(
          text: getDurationString(sortedRoutines[index].duration ?? 0),
        ),
      ],
    ).marginOnly(bottom: 10);
  }

  sortData() {
    sortedRoutines.clear();
    switch (sort.value) {
      case 0:
        {
          sortedRoutines.assignAll(routines);
          sortedRoutines.sort((a, b) => a.date!.compareTo(b.date!));
          break;
        }
      case 1:
        {
          sortedRoutines.assignAll(routines);
          sortedRoutines.sort((a, b) => a.name!.compareTo(b.name!));
          break;
        }
      case 2:
        {
          sortedRoutines.assignAll(routines);
          sortedRoutines
              .sort((a, b) => a.categoryName!.compareTo(b.categoryName!));
          break;
        }
      case 3:
        {
          sortedRoutines.assignAll(routines);
          sortedRoutines.sort((a, b) => a.duration!.compareTo(b.duration!));
          break;
        }
      default:
        sortedRoutines.assignAll(routines);
    }
  }

  selectData() {
    routines.clear();
    setState(() {
      for (int i = 0;
          i < Get.find<AuthServices>().accomplishments.length;
          i++) {
        final accomplish = Get.find<AuthServices>().accomplishments[i];
        for (int j = 0; j < accomplish.routines!.length; j++) {
          final _routine = accomplish.routines![j];
          if (dateFromString(_routine.date!).isAfter(dateFromString(start.value)
                  .subtract(const Duration(days: 1))) &&
              dateFromString(_routine.date!).isBefore(
                  dateFromString(end.value).add(const Duration(days: 1)))) {
            routines.add(
              ARoutines(
                name: _routine.name,
                id: _routine.id,
                date: _routine.date,
                count: _routine.count,
                duration: _routine.duration,
                categoryName:
                    categoryList[categoryIndex(accomplish.category!)].title,
                category: accomplish.category,
              ),
            );
          }
        }
      }
      print(routines.length);
      sortData();
    });
  }

  applyfilter() {
    setState(() {
      final list = routines;
      routines = <ARoutines>[].obs;
      for (int i = 0; i < categoryList.length; i++) {
        if (categoryList[i].check!) {
          final catlist =
              list.where((p0) => p0.category == categoryList[i].value).toList();
          for (int j = 0; j < catlist.length; j++) {
            final _routine = catlist[j];
            routines.add(
              ARoutines(
                name: _routine.name,
                id: _routine.id,
                date: _routine.date,
                count: _routine.count,
                duration: _routine.duration,
                categoryName:
                    categoryList[categoryIndex(categoryList[i].value!)].title,
                category: categoryList[i].value!,
              ),
            );
          }
        }
      }
      sortData();
      print('after sort');
      routines.assignAll(list);
      print(routines.length);
    });
  }

  @override
  void dispose() {
    setState(() {
      for (int i = 0; i < categoryList.length; i++) {
        if (categoryList[i].check!) {
          categoryList[i].check = false;
        }
      }
    });
    super.dispose();
  }
}

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  Rx<DateTime> start = DateTime(0).obs;
  Rx<DateTime> end = DateTime(0).obs;

  Future<DateTime> pickDate(DateTime date) async {
    return await customDatePicker(
      context,
      initialDate: date == DateTime(0) ? DateTime.now() : date,
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    );
  }

  RxInt category = (0).obs;

  Rx<DateTime> current = DateTime.now().obs;

  Rx<AccomplishmentModel> routine = AccomplishmentModel().obs;

  initialRoutine() {
    setState(() {
      print(Get.find<AuthServices>().accomplishments);
      routine.value = Get.find<AuthServices>()
          .accomplishments
          .where((element) => element.category == category.value)
          .first;
    });
  }

  @override
  void initState() {
    setState(() {
      Get.find<UserController>()
          .fetchAccomplishments(Get.find<AuthServices>().userid)
          .then((value) {
        initialRoutine();
      });
    });

    super.initState();
  }

  final CellCalendarPageController controller = CellCalendarPageController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: 10,
          ),
          child: Column(
            children: [
              titles('Stats', alignment: Alignment.center)
                  .marginOnly(bottom: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DateWidget(
                    size: 18,
                    // weight: FontWeight.bold,
                    date: start.value == DateTime(0)
                        ? 'MM/DD/YY'
                        : formateDate(start.value),
                    ontap: () async 
                       { await pickDate(start.value).then((value) {
                        if (end.value != DateTime(0) && value.isAfter(end.value)) {
                          customToast(
                            message:
                                'Start date should be before than end date',
                          );
                        } else {
                          start.value = value;
                          selectDatainDuration();
                          setState(() {});
                        }
                      });

                      setState(() {});
                        // start.value = (await pickDate(start.value));
                        },
                  ),
                  const TextWidget(text: ' - '),
                  DateWidget(
                    size: 18,
                    // weight: FontWeight.bold,
                    date: end.value == DateTime(0)
                        ? 'MM/DD/YY'
                        : formateDate(end.value),
                    ontap: () async {
                      await pickDate(end.value).then((value) {
                        if (value.isBefore(start.value)) {
                          customToast(
                            message:
                                'End date should be greater than start date',
                          );
                        } else {
                          end.value = value;
                          selectDatainDuration();
                          setState(() {});
                        }
                      });

                      setState(() {});
                    },
                  ),
                ],
              ).marginOnly(bottom: 20),
              const Divider(),
              SizedBox(
                height: height * 0.15,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 10,
                    horizontalMargin: 2,
                    showBottomBorder: true,
                    columns: [
                      dataColumn('', 'Category'),
                      columnSeparator(),
                      dataColumn('Longest Streak', 'Longest Streak'),
                      columnSeparator(),
                      dataColumn('Total Practices', 'Total Practices'),
                      columnSeparator(),
                      dataColumn('Total', 'Total'),
                      columnSeparator(),
                      dataColumn(
                        'Most Advanced Practices Unlocked',
                        'Most advanced practices unlocked',
                      ),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(
                            CustomDropDownStruct(
                              child: DropdownButton<int>(
                                value: category.value,
                                items: categoryList
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.value,
                                        child: SizedBox(
                                          width: width * 0.25,
                                          child: TextWidget(
                                            text: e.title,
                                            alignment: Alignment.centerLeft,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    category.value = val!;
                                    initialRoutine();
                                    selectCategoryEvents();
                                  });
                                },
                              ),
                            ),
                          ),
                          rowSeparator(),
                          dataCell((routine.value.max ?? '').toString()),
                          rowSeparator(),
                          dataCell(((routine.value.routines ?? []).length)
                              .toString()),
                          rowSeparator(),
                          dataCell((routine.value.total ?? '').toString()),
                          rowSeparator(),
                          dataCell(routine.value.advanced ?? ''),
                        ],
                      ),
                    ],
                  ),
                ),
              ).marginOnly(bottom: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      current.value =
                          current.value.subtract(const Duration(days: 30));
                      controller.animateToDate(
                        current.value,
                        duration: const Duration(milliseconds: 2),
                        curve: Curves.bounceIn,
                      );
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  titles(
                    DateFormat('MMMM yyyy').format(current.value),
                    alignment: Alignment.center,
                  ),
                  IconButton(
                    onPressed: () {
                      current.value =
                          current.value.add(const Duration(days: 30));
                      controller.animateToDate(
                        current.value,
                        duration: const Duration(milliseconds: 2),
                        curve: Curves.bounceIn,
                      );
                    },
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
              ).marginOnly(bottom: 20),
              SizedBox(
                height: height * 0.6,
                child: CellCalendar(
                  events: categoryEvents,
                  cellCalendarPageController: controller,
                  monthYearLabelBuilder: (date) => Container(),
                  daysOfTheWeekBuilder: (days) {
                    final labels = ["S", "M", "T", "W", "T", "F", "S"];
                    return TextWidget(
                      text: labels[days],
                      alignment: Alignment.center,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataColumn dataColumn(String text, String tooltip) => DataColumn(
        tooltip: tooltip,
        label: TextWidget(
          text: text,
          size: 16,
          maxline: 2,
          alignment: Alignment.centerLeft,
        ),
      );

  DataColumn columnSeparator() => const DataColumn(label: VerticalDivider());

  DataCell rowSeparator() => const DataCell(VerticalDivider());

  DataCell dataCell(String text) => DataCell(
        TextWidget(text: text, alignment: Alignment.centerLeft),
      );

  RxList<CalendarEvent> events = <CalendarEvent>[].obs;
  RxList<CalendarEvent> categoryEvents = <CalendarEvent>[].obs;

  ///
  selectDatainDuration() {
    setState(() {
      for (int i = 0;
          i < Get.find<AuthServices>().accomplishments.length;
          i++) {
        final accomplish = Get.find<AuthServices>().accomplishments[i];
        for (int j = 0; j < accomplish.routines!.length; j++) {
          final routine = accomplish.routines![j];
          if (dateFromString(routine.date!).isBefore(end.value) &&
              dateFromString(routine.date!).isAfter(start.value)) {
            events.add(
              CalendarEvent(
                eventName: 'X',
                eventDate: dateFromString(routine.date ?? ''),
                eventID: accomplish.category.toString(),
              ),
            );
          }
        }
      }
      selectCategoryEvents();
    });
  }

  selectCategoryEvents() {
    categoryEvents.assignAll(
        events.where((p0) => p0.eventID == category.value.toString()));
  }
}
