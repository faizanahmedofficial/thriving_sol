// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Model/exercise_models.dart';
import 'package:schedular_project/Screens/Discover/discover_element_page.dart';
import 'package:schedular_project/Screens/Emotional/Exercises/abc_root_analysis.dart';
import 'package:schedular_project/Screens/Emotional/Exercises/baby_reframing.dart';
import 'package:schedular_project/Screens/Emotional/Exercises/resolution.dart';
import 'package:schedular_project/Screens/Emotional/Relationships/community.dart';
import 'package:schedular_project/Screens/Emotional/connection_home.dart';
import 'package:schedular_project/Screens/Emotional/gratitude_home.dart';
import 'package:schedular_project/Screens/Emotional/journals/baby_gratitude_journal.dart';
import 'package:schedular_project/Screens/Emotional/journals/connection_journal_lvl_0.dart';
import 'package:schedular_project/Screens/Emotional/journals/observe_full_version.dart';
import 'package:schedular_project/Screens/Emotional/journals/observe_sf.dart';
import 'package:schedular_project/Screens/Emotional/journals/thought_checkin.dart';
import 'package:schedular_project/Screens/Physical/Journals/easy_shopping_list_lvl1.dart';
import 'package:schedular_project/Screens/Physical/Journals/food_journal_lvl_1.dart';
import 'package:schedular_project/Screens/Physical/Journals/free_style_cold.dart';
import 'package:schedular_project/Screens/Physical/Journals/pc_journal_level_1.dart';
import 'package:schedular_project/Screens/Physical/cold_home.dart';
import 'package:schedular_project/Screens/Physical/diet_home.dart';
import 'package:schedular_project/Screens/Physical/movement_home.dart';
import 'package:schedular_project/Screens/Physical/sexual_home.dart';
import 'package:schedular_project/Screens/Purpose/bd_home.dart';
import 'package:schedular_project/Screens/Purpose/exercises/habits_builder.dart';
import 'package:schedular_project/Screens/Purpose/exercises/ideal_time.dart';
import 'package:schedular_project/Screens/Purpose/goals_home.dart';
import 'package:schedular_project/Screens/Routines/manual_routines.dart';
import 'package:schedular_project/Screens/Routines/personalized_routines.dart';
import 'package:schedular_project/Screens/Emotional/er_home.dart';
import 'package:schedular_project/Screens/Routines/routine_screen.dart';
import 'package:schedular_project/Screens/intro_home.dart';
import 'package:schedular_project/Screens/mental/breathing_home.dart';
import 'package:schedular_project/Screens/mental/mindfulness_home.dart';
import 'package:schedular_project/Screens/mental/reading_home.dart';
import 'package:schedular_project/Screens/mental/visualization_home.dart';

import '../Model/app_modal.dart';
import '../Screens/Emotional/Exercises/behavioral_activation.dart';
import '../Screens/Emotional/Exercises/congnitive_distortions.dart';
import '../Screens/Emotional/Exercises/fact_checking.dart';
import '../Screens/Emotional/Exercises/fact_checking_your_thoughts.dart';
import '../Screens/Emotional/Exercises/reframing.dart';
import '../Screens/Emotional/Relationships/meaningful_connection.dart';
import '../Screens/Emotional/gratitude_letter.dart';
import '../Screens/Emotional/journals/connection_journal_lvl1.dart';
import '../Screens/Emotional/journals/connection_journal_lvl2.dart';
import '../Screens/Emotional/journals/emotional_analysis.dart';
import '../Screens/Emotional/journals/emotional_analysis_sf.dart';
import '../Screens/Emotional/journals/emotional_check_in.dart';
import '../Screens/Emotional/journals/emotional_checkin_sf.dart';
import '../Screens/Emotional/journals/gratitude_journal_lvl1.dart';
import '../Screens/Emotional/journals/thought_analysis.dart';
import '../Screens/Emotional/journals/thought_analysis_sf.dart';
import '../Screens/Emotional/journals/thought_checkin_sf.dart';
import '../Screens/Physical/Journals/guided_cold.dart';
import '../Screens/Physical/Journals/pc_journal_level_0.dart';
import '../Screens/Physical/movement_assessment.dart';
import '../Screens/Purpose/Readings/bd_reading.dart';
import '../Screens/Purpose/exercises/nudges_screen.dart';
import '../Screens/Purpose/exercises/pomodoro_screen.dart';
import '../Screens/Purpose/journals/action_journal_level3.dart';
import '../Screens/Purpose/journals/action_journal_lvl0.dart';
import '../Screens/Purpose/journals/action_journal_lvl1.dart';
import '../Screens/Purpose/journals/action_journal_lvl2.dart';
import '../Screens/Purpose/journals/tactical_review.dart';
import '../Screens/mental/lsrt.dart';
import '../Screens/mental/v101_create_script.dart';
import '../Screens/readings.dart';
import '../app_icons.dart';

String currentTime = DateFormat('MM/dd/yy').format(DateTime.now());
var width = Get.width;
var height = Get.height;

String factkey = 'answerkey';
String breathing = 'breathing';
String visualization = 'visualization';
String mindfulness = 'mindfulness';
String reading = 'reading';
String er = 'er';
String connection = 'connection';
String gratitude = 'gratitude';
String movement = 'movement';
String diet = 'diet';
String cold = 'cold';
String sexual = 'sexual';
String goals = 'goals';
String bd = 'bd';
String intro = 'intro';

List<AppModel> docids = [
  AppModel('Intro', intro, value: 0),
  AppModel('Breathing', breathing, value: 1),
  AppModel('Behavioral Design & Productivity', bd, value: 2),
  AppModel('Cold', cold, value: 3),
  AppModel('Connection', connection, value: 4),
  AppModel('Diet', diet, value: 5),
  AppModel('Emotional Regulation', er, value: 6),
  AppModel('Goals & Values', goals, value: 7),
  AppModel('Gratitude', gratitude, value: 8),
  AppModel('Mindfulness', mindfulness, value: 9),
  AppModel('Movement', movement, value: 10),
  AppModel('Reading', reading, value: 11),
  AppModel('Sexual', sexual, value: 12),
  AppModel('Visualization', visualization, value: 13),
];

const String listeningpath = 'assets/listening/';
const String audiopath = 'assets/audio/';

const String arail = 'Arial';

RxList<AppModel> discoverList = <AppModel>[
  AppModel(
    'Intro',
    'Learn the concepts and basics to thrive.',
    ontap: () => Get.to(() => IntroHome(), arguments: [false]),
  ),
  AppModel(
    'Mental',
    'How can I steel my mind to stress, instantly get in a state of focus & flow, increase my enjoyment of everything, and get better at anything while lying on the couch.',
    ontap: () => Get.to(
      () => DiscoverElementScreen(),
      arguments: ['Mental', mentalList],
    ),
  ),
  AppModel(
    'Emotional',
    'How can I change my thought & behavior patterns to maximize the long term happiness & mental health of myself and those I care about most?',
    ontap: () => Get.to(
      () => DiscoverElementScreen(),
      arguments: ['Emotional', emotionalList],
    ),
  ),
  AppModel(
    'Physical',
    'How can I can achieve my ideal body composition, increase my lifespan, and maximize my quality of life?',
    ontap: () => Get.to(
      () => DiscoverElementScreen(),
      arguments: ['Physical', physicalList],
    ),
  ),
  AppModel(
    'Purpose',
    'How can I live my ideal lifestyle on my own terms and reach my definition of succes quickly, without using willpower?',
    ontap: () => Get.to(
      () => DiscoverElementScreen(),
      arguments: ['Purpose', purposeList],
    ),
  ),
].obs;

List<AppModel> routineOptions = <AppModel>[
  AppModel(
    'Personalized Thriving Shortcut',
    'Answer a few questions then watch as a routine is automatically created to fit your schedule designed to help you thrive in the areas of your life that are most important to you.  (30 seconds) ',
    ontap: () => Get.to(() => const PersonalizedRoutines()),
  ),
  AppModel(
    'Manual Thriving Shortcut',
    'Create your Thriving Shortcut manually by adding individual habits in the order you please. (Advanced) ',
    ontap: () => Get.to(() => const ManualRoutines()),
  ),
];

List<AppModel> timeList = <AppModel>[
  AppModel('5 minutes', '', value: 5, duration: 300),
  AppModel('10 minutes', '', value: 10, duration: 600),
  AppModel('15 minutes', '', value: 15, duration: 900),
  AppModel('20 minutes', '', value: 20, duration: 1200),
  AppModel('25 minutes', '', value: 25, duration: 1500),
  AppModel('30 minutes', '', value: 30, duration: 1800),
  AppModel('35 minutes', '', value: 35, duration: 2100),
  AppModel('40 minutes', '', value: 40, duration: 2400),
  AppModel('45 minutes', '', value: 45, duration: 2700),
  AppModel('50 minutes', '', value: 50, duration: 3000),
  AppModel('55 minutes', '', value: 55, duration: 3300),
  AppModel('60 minutes', '', value: 60, duration: 3600),
  AppModel('65 minutes', '', value: 65, duration: 3900),
  AppModel('70 minutes', '', value: 70, duration: 4200),
  AppModel('75 minutes', '', value: 75, duration: 4500),
  AppModel('80 minutes', '', value: 80, duration: 4800),
  AppModel('85 minutes', '', value: 85, duration: 5100),
  AppModel('90 minutes', '', value: 90, duration: 5400),
  AppModel('95 minutes', '', value: 95, duration: 5700),
  AppModel('100 minutes', '', value: 100, duration: 6000),
  AppModel('105 minutes', '', value: 105, duration: 6300),
  AppModel('110 minutes', '', value: 110, duration: 6600),
  AppModel('115 minutes', '', value: 115, duration: 6900),
  AppModel('120 minutes', '', value: 120, duration: 7200),
  AppModel('Time is no object (Any amount of time)', '', value: 0, duration: 0),
];

List<AppModel> categoryList = <AppModel>[
  AppModel(
    'Breathing',
    'Breathe correctly to control your body\'s natural relaxation and happiness responses.',
    value: 0,
    ontap: () => Get.to(() => BreathingHomeScreen(), arguments: [false]),
    check: false,
  ),
  AppModel(
    'Visualization',
    'Imagine. Mentally rehearse skills, situations, trauma, or nearly anything to simulate a real event and prime your mind to respond better and faster in real life.',
    value: 1,
    ontap: () => Get.to(() => VisualizationHome(), arguments: [false]),
    check: false,
  ),
  AppModel(
    'Mindfulness',
    'Train your brain to naturally enter a state of focus and enjoyment that spills into every aspect of your life.',
    value: 2,
    ontap: () => Get.to(() => MindfulnesScreen(), arguments: [false]),
    check: false,
  ),
  AppModel(
    'Emotional Regulation',
    'Learn to control and understand your emotions, thoughts, & behaviors.',
    value: 3,
    ontap: () => Get.to(() => ErHome(), arguments: [false]),
    check: false,
  ),
  AppModel(
    'Connection',
    'Hang out. Give support to others and/ or draw on support from others.',
    value: 4,
    ontap: () => Get.to(() => ConnectionHome(), arguments: [false]),
    check: false,
  ),
  AppModel(
    'Gratitude',
    'Make appreciation your default mode to draw more joy, thanks, meaning and happiness from each moment.',
    value: 5,
    ontap: () => Get.to(() => GratitudeHome(), arguments: [false]),
    check: false,
  ),
  AppModel(
    'Goals & Values',
    'Find and pursue your purpose daily. Live your life exactly how you want to.',
    value: 6,
    ontap: () => Get.to(() => GoalsHome(), arguments: [false]),
    check: false,
  ),
  AppModel(
    'Productivity & Behavioral Design',
    'Work smarter to have more time for the people and things you love. Design your life so the most natural choice is the best choice.',
    value: 7,
    ontap: () => Get.to(() => BdHome(), arguments: [false]),
    check: false,
  ),
  AppModel(
    'Movement',
    'Move your body for general health, strength, weight loss, mobility, and much more in the time you have with or without a gym.',
    value: 8,
    ontap: () => Get.to(() => MovementHome(), arguments: [false]),
    check: false,
  ),
  AppModel(
    'Eating/Diet',
    'Learn simple habits to make getting to and maintaining a healthy weight natural and normal for you.',
    value: 9,
    ontap: () => Get.to(() => DietHome(), arguments: [false]),
    check: false,
  ),
  AppModel(
    'Cold',
    'Gain instant focus, energy, happiness, and resilience to stress while improving skin, hair, and circulation.',
    value: 10,
    ontap: () => Get.to(() => ColdHome(), arguments: [false]),
    check: false,
  ),
  AppModel(
    'Sexual',
    'Exercise the "secret" muscles that make it better, longer, more frequent, & more satisfying.',
    value: 11,
    ontap: () => Get.to(() => SexualHome(), arguments: [false]),
    check: false,
  ),
  AppModel(
    'Learning/Reading',
    'Learn a new skill. Advance your current skills. Push your brain.',
    value: 12,
    ontap: () => Get.to(() => const ReadingHome(), arguments: [false]),
    check: false,
  ),
];

/// 0: green arrow, 1: red arrow (down)
List<AppModel> breathingBenefitList = <AppModel>[
  AppModel(AppIcons.cognitiveAbility, 'Cognitive ability (smarts)', type: 0),
  AppModel(AppIcons.controlEmotionalState, 'Control of emotions', type: 0),
  AppModel(AppIcons.decisionMaking, 'Decision making', type: 0),
  AppModel(AppIcons.disease, 'Immunity', type: 0),
  AppModel(AppIcons.focus, 'Focus', type: 0),
  AppModel(AppIcons.longevity, 'Longevity', type: 0),
  AppModel(AppIcons.lungHealth, 'Lung Health', type: 0),
  AppModel(AppIcons.sexualHealth, 'Sexual Health', type: 0),
  AppModel(AppIcons.wellbeing, 'Well being', type: 0),
  AppModel(AppIcons.anger, 'Anger', type: 1),
  AppModel(AppIcons.anxiety, 'Anxiety', type: 1),
  AppModel(AppIcons.stress, 'Stress', type: 1),
  AppModel(AppIcons.depression, 'Depression', type: 1),
  AppModel(AppIcons.painAches, 'Aches & pain', type: 1),
  AppModel(AppIcons.facialDeformities, 'Facial deformalities', type: 1),
  AppModel(AppIcons.ptsd, 'PTSD', type: 1),
];

List<AppModel> visualizationBenefitList = <AppModel>[
  AppModel(AppIcons.atheleticAbility, 'Skill level at anything', type: 0),
  AppModel(AppIcons.goalAttainment, 'Goal Attainment', type: 0),
  AppModel(AppIcons.reactionTime, 'Reaction Time', type: 0),
  AppModel(AppIcons.strength, 'Strength', type: 0),
  AppModel(AppIcons.endurance, 'Endurance', type: 0),
  AppModel(AppIcons.stress, 'Stress', type: 1),
  AppModel(AppIcons.depression, 'Depression', type: 1),
  AppModel(AppIcons.anxiety, 'Anxiety', type: 1),
  AppModel(AppIcons.painAches, 'Aches & Pain', type: 1),
  AppModel(AppIcons.ptsd, 'PTSD', type: 1),
];

List<AppModel> mindfulnessBenefitList = <AppModel>[
  AppModel(AppIcons.money, 'Money', type: 0),
  AppModel(AppIcons.relationships, 'Relationships', type: 0),
  AppModel(AppIcons.longevity, 'Longevity', type: 0),
  AppModel(AppIcons.cognitiveAbility, 'Congivtie ability (smarts)', type: 0),
  AppModel(AppIcons.focus, 'Focus', type: 0),
  AppModel(AppIcons.controlEmotionalState, 'Control of Emotions', type: 0),
  AppModel(AppIcons.decisionMaking, 'Decision Making', type: 0),
  AppModel(AppIcons.cardiovascularHealth, 'Cardio-vascular health', type: 0),
  AppModel(AppIcons.wellbeing, 'Well being', type: 0),
  AppModel(AppIcons.lungHealth, 'Lung Health', type: 0),
  AppModel(AppIcons.goalAttainment, 'Goal Attainment', type: 0),
  AppModel(AppIcons.mindfulness, 'Enjoyment of life', type: 0),
  AppModel(AppIcons.anxiety, 'Anxiety', type: 1),
  AppModel(AppIcons.stress, 'Stress', type: 1),
  AppModel(AppIcons.depression, 'Depression', type: 1),
  AppModel(AppIcons.painAches, 'Aches & Pain', type: 1),
  AppModel(AppIcons.loneliness, 'Loneliness', type: 1),
];

List<AppModel> erBenefitList = <AppModel>[
  AppModel(AppIcons.controlEmotionalState, 'Control of Emotion', type: 0),
  AppModel(AppIcons.decisionMaking, 'Decision Making', type: 0),
  AppModel(AppIcons.relationships, 'Relationships', type: 0),
  AppModel(AppIcons.wellbeing, 'Well being', type: 0),
  AppModel(AppIcons.healthyBehaviors, 'Weight loss', type: 0),
  AppModel(AppIcons.sleep, 'Sleep', type: 0),
  AppModel(AppIcons.anger, 'Anger', type: 1),
  AppModel(AppIcons.anxiety, 'Anxiety', type: 1),
  AppModel(AppIcons.stress, 'Stress', type: 1),
  AppModel(AppIcons.depression, 'Depression', type: 1),
  AppModel(AppIcons.painAches, 'Aches & Pain', type: 1),
  AppModel(AppIcons.ptsd, 'PTSD', type: 1),
  AppModel(AppIcons.badHabitsAddition, 'Bad Habits/ Addition', type: 1),
  AppModel(AppIcons.jail, 'Jail', type: 1),
];

List<AppModel> connectionBenefitList = <AppModel>[
  AppModel(AppIcons.money, 'Money', type: 0),
  AppModel(AppIcons.relationships, 'Relationships', type: 0),
  AppModel(AppIcons.longevity, 'Longevity', type: 0),
  AppModel(AppIcons.cognitiveAbility, 'Cognitive Ability (smarts)', type: 0),
  AppModel(AppIcons.cardiovascularHealth, 'Cardi-vascular Health', type: 0),
  AppModel(AppIcons.wellbeing, 'Well being', type: 0),
  AppModel(AppIcons.happiness, 'Happiness', type: 0),
  AppModel(AppIcons.disease, 'Immunity', type: 0),
  AppModel(AppIcons.death, 'Death from All Causes', type: 1),
  AppModel(AppIcons.anxiety, 'Anxiety', type: 1),
  AppModel(AppIcons.stress, 'Stress', type: 1),
  AppModel(AppIcons.depression, 'Depression', type: 1),
  AppModel(AppIcons.loneliness, 'Loneliness', type: 1),
];

List<AppModel> gratitudeBenefitList = <AppModel>[
  AppModel(AppIcons.wellbeing, 'Well being', type: 0),
  AppModel(AppIcons.happiness, 'Happiness', type: 0),
  AppModel(AppIcons.relationships, 'Relationships', type: 0),
  AppModel(AppIcons.sleep, 'Sleep', type: 0),
  AppModel(AppIcons.cardiovascularHealth, 'Cardi-vascular Health', type: 0),
  AppModel(AppIcons.disease, 'Immunity', type: 0),
  AppModel(AppIcons.painAches, 'Aches & Pain', type: 1),
  AppModel(AppIcons.anxiety, 'Anxiety', type: 1),
  AppModel(AppIcons.stress, 'Stress', type: 1),
  AppModel(AppIcons.depression, 'Depression', type: 1),
  AppModel(AppIcons.anger, 'Anger', type: 1),
];

List<AppModel> goalBenefitList = <AppModel>[
  AppModel(AppIcons.money, 'Money', type: 0),
  AppModel(AppIcons.happiness, 'Happiness', type: 0),
  AppModel(AppIcons.longevity, 'Longevity', type: 0),
  AppModel(AppIcons.cardiovascularHealth, 'Cardi-vascular Health', type: 0),
  AppModel(AppIcons.goalAttainment, 'Goal Attainment', type: 0),
  AppModel(AppIcons.wellbeing, 'Well being', type: 0),
  AppModel(AppIcons.procrastination, 'Procrastination', type: 1),
  AppModel(AppIcons.anxiety, 'Anxiety', type: 1),
  AppModel(AppIcons.stress, 'Stress', type: 1),
  AppModel(AppIcons.depression, 'Depression', type: 1),
  AppModel(AppIcons.death, 'Death', type: 1),
  AppModel(AppIcons.painAches, 'Aches & pain', type: 1),
];

List<AppModel> bdBenefitList = <AppModel>[
  AppModel(AppIcons.goalAttainment, 'Goal Attainment', type: 0),
  AppModel(AppIcons.healthyBehaviors, 'Healthy Habits', type: 0),
  AppModel(AppIcons.procrastination, 'Procrastination', type: 1),
  AppModel(AppIcons.badHabitsAddition, 'Bad Habits/ Addiction', type: 1),
];

List<AppModel> movementBenefitList = <AppModel>[
  AppModel(AppIcons.longevity, 'Longevity', type: 0),
  AppModel(AppIcons.cognitiveAbility, 'Cognitive Ability (smarts)', type: 0),
  AppModel(AppIcons.strength, 'Strength', type: 0),
  AppModel(AppIcons.healthyBehaviors, 'Weight loss', type: 0),
  AppModel(AppIcons.wellbeing, 'Well being', type: 0),
  AppModel(AppIcons.lungHealth, 'Lung Health', type: 0),
  AppModel(AppIcons.happiness, 'Happiness', type: 0),
  AppModel(AppIcons.disease, 'Immunity', type: 0),
  AppModel(AppIcons.cardiovascularHealth, 'Cardi-vascular Health', type: 0),
  AppModel(AppIcons.endurance, 'Endurance', type: 0),
  AppModel(AppIcons.sleep, 'Sleep', type: 0),
  AppModel(AppIcons.sexualHealth, 'Sexual health', type: 0),
  AppModel(AppIcons.stress, 'Stress', type: 1),
  AppModel(AppIcons.depression, 'Depression', type: 1),
  AppModel(AppIcons.painAches, 'Aches & pain', type: 1),
];

List<AppModel> eatingBenefitList = <AppModel>[
  AppModel(AppIcons.longevity, 'Longevity', type: 0),
  AppModel(AppIcons.healthyBehaviors, 'Weight loss', type: 0),
  AppModel(AppIcons.happiness, 'Happiness', type: 0),
  AppModel(AppIcons.disease, 'Immunity', type: 0),
  AppModel(AppIcons.wellbeing, 'Well being', type: 0),
  AppModel(AppIcons.cardiovascularHealth, 'Cardi-vascular Health', type: 0),
];

List<AppModel> coldBenefitList = <AppModel>[
  AppModel(AppIcons.resilience, 'Resilience to Stress', type: 0),
  AppModel(AppIcons.happiness, 'Happiness', type: 0),
  AppModel(AppIcons.energy, 'Energy', type: 0),
  AppModel(AppIcons.healthyBehaviors, 'Weight loss', type: 0),
  AppModel(AppIcons.disease, 'Immunity', type: 0),
  AppModel(AppIcons.cardiovascularHealth, 'Cardi-vascular Health', type: 0),
  AppModel(AppIcons.skinhair, 'Skin & Hair Health', type: 0),
  AppModel(AppIcons.focus, 'Focus', type: 0),
  AppModel(AppIcons.stress, 'Stress', type: 1),
  AppModel(AppIcons.depression, 'Depression', type: 1),
  AppModel(AppIcons.painAches, 'Aches & pain', type: 1),
];

List<AppModel> sexualBenefitList = <AppModel>[
  AppModel(AppIcons.sexualHealth, 'Sexual Health', type: 0),
  // AppModel(AppIcons.happiness, 'Feel more pleasure', type: 0),
  // AppModel(AppIcons.strength, 'Give more pleasure', type: 0),
  AppModel(AppIcons.energy, 'Energy', type: 0),
  // AppModel(AppIcons.wellbeing, 'Longer & more powerful orgasms', type: 0),
  // AppModel(AppIcons.sexualHealth, 'Constipation', type: 1),
  // AppModel(AppIcons.stress, 'Incontinence', type: 1),
];

List<AppModel> learningBenefitList = <AppModel>[
  AppModel(AppIcons.money, 'Money', type: 0),
  AppModel(AppIcons.longevity, 'Longevity', type: 0),
  AppModel(AppIcons.cognitiveAbility, 'Cognitive Ability (smarts)', type: 0),
  AppModel(AppIcons.happiness, 'Happiness', type: 0),
  AppModel(AppIcons.wellbeing, 'Well being', type: 0),
];

List<AppModel> selectBenefits(int value) {
  switch (value) {
    case 0:
      return breathingBenefitList;
    case 1:
      return visualizationBenefitList;
    case 2:
      return mindfulnessBenefitList;
    case 3:
      return erBenefitList;
    case 4:
      return connectionBenefitList;
    case 5:
      return gratitudeBenefitList;
    case 6:
      return goalBenefitList;
    case 7:
      return bdBenefitList;
    case 8:
      return movementBenefitList;
    case 9:
      return eatingBenefitList;
    case 10:
      return coldBenefitList;
    case 11:
      return sexualBenefitList;
    case 12:
      return learningBenefitList;
    default:
      return <AppModel>[];
  }
}

List<DaysModel> dayLists = <DaysModel>[
  DaysModel('M', true),
  DaysModel('T', true),
  DaysModel('W', true),
  DaysModel('Th', true),
  DaysModel('F', true),
  DaysModel('Sa', true),
  DaysModel('Su', true),
];

List<AppModel> goalsList = <AppModel>[
  AppModel(
    'Total wellness',
    'Optimize your happiness as well as your physical, mental, and financial health.',
    value: 0,
  ),
  AppModel('Happiness & wellbeing', 'Be happier and more content.', value: 1),
  AppModel('Physical Health', 'Live longer. Feel and look better. ', value: 2),
  AppModel(
    'Mental Health',
    'Master negative emotions, have better relationships, and control your actions.',
    value: 3,
  ),
  AppModel(
    'Financial health & goals',
    'Find and live your purpose, on your terms. Attain your definition of success.',
    value: 4,
  ),
];

List<String> dayNames = <String>['M', 'T', 'W', 'Th', 'F', 'Sa', 'Su'];

List<AppModel> cueList = <AppModel>[
  AppModel('Change your phone\'s wallpaper', '', value: 0),
  AppModel('Put a sticky notes with reminder', '', value: 1),
  AppModel('Draw & put a poster reminer', '', value: 2),
  AppModel('Write in...', '', value: 3),
  AppModel('Change your password to something', '', value: 4),
  AppModel('Use the smell og coffee to remind you', '', value: 5),
  AppModel('Light a candle or essential oil before', '', value: 6),
  AppModel('Have a friend give you reminder of', '', value: 7),
  AppModel('Place an odd or bright colored object', '', value: 8),
  AppModel('Set an Alarm', '', value: 9),
];

List<AppModel> chainList = <AppModel>[
  AppModel('Write in...', '', value: 0),
  AppModel('After you wake up', '', value: 1),
  AppModel('After you brush your teeth/shower', '', value: 2),
  AppModel('After breakfast', '', value: 3),
  AppModel('After you start your commute', '', value: 4),
  AppModel('After you feed your pet', '', value: 5),
  AppModel('After you take your first break', '', value: 6),
  AppModel('After lunch', '', value: 7),
  AppModel('After your first coffee of the day', '', value: 8),
  AppModel('After dinner', '', value: 9),
  AppModel('After a certain TV show/other type', '', value: 10),
  AppModel('An hour before bed', '', value: 11),
  AppModel('When you arrive home', '', value: 12),
  AppModel('After you read your child a book', '', value: 13),
  AppModel('When you finish your homework', '', value: 14),
];

List<AppModel> rewardList = <AppModel>[
  AppModel('Eat something you like', '', value: 0),
  AppModel('Take a deep breath and smile', '', value: 1),
  AppModel('Drink something you like', '', value: 2),
  AppModel('Smile brightly and fully', '', value: 3),
  AppModel('Take a moment to play or do ', '', value: 4),
  AppModel('Watch a show', '', value: 5),
  AppModel('Check your social media', '', value: 6),
  AppModel('Take a nap', '', value: 7),
  AppModel('Write in...', '', value: 8),
  AppModel('Hug or kiss a loved one', '', value: 9),
  AppModel('Give someone (or yourself) a high', '', value: 10),
  AppModel('Say "Thank you" to yourself', '', value: 11),
  AppModel('Take time for a hobby', '', value: 12),
  AppModel('Take a walk (probably in nature)', '', value: 13),
  AppModel('Stretch', '', value: 14),
  AppModel('Take a bath', '', value: 15),
];

List<AppModel> mentalList = <AppModel>[
  AppModel(
    'Breathing',
    'Breathe correctly to control your body\'s natural relaxation and happiness responses.',
    ontap: () => Get.to(() => BreathingHomeScreen(), arguments: [false]),
    intColor: 0xffD6E9FF,
    value: 0,
    color: const Color(0xffD6E9FF),
    list: breathingList.where((element) => element.type == 1).toList(),
    type: 1,
  ),
  AppModel(
    'Visualization',
    'Imagine. Mentally rehearse skills, situations, trauma, or nearly anything to simulate a real event and prime your mind to respond better and faster in real life.',
    ontap: () => Get.to(() => VisualizationHome(), arguments: [false]),
    intColor: 0xffD6E1EE,
    value: 1,
    color: const Color(0xffD6E1EE),
    list: visualizationList.where((element) => element.type == 1).toList(),
    type: 2,
  ),
  AppModel(
    'Mindfulness',
    'Train your brain to naturally enter a state of focus and enjoyment that spills into every aspect of your life.',
    ontap: () => Get.to(() => MindfulnesScreen(), arguments: [false]),
    intColor: 0xffD6D9DB,
    value: 2,
    color: const Color(0xffD6D9DB),
    list: mindfulnessList.where((element) => element.type == 1).toList(),
    type: 3,
  ),
  AppModel(
    'Reading',
    'Learn a new skill. Advance your current skills. Push your brain.',
    ontap: () => Get.to(() => const ReadingHome(), arguments: [false]),
    value: 3,
    type: 13,
  ),
];

List<AppModel> emotionalList = <AppModel>[
  AppModel(
    'Emotional Regulation (ER)',
    'Learn to control and understand your emotions, thoughts, & behaviors.',
    ontap: () => Get.to(() => ErHome(), arguments: [false]),
    intColor: 0xffC2FEC5,
    value: 0,
    list: erList.where((element) => element.type == 1).toList(),
    type: 4,
  ),
  AppModel(
    'Connection',
    'Be human. Give support to others and/ or draw on support from others.',
    ontap: () => Get.to(() => ConnectionHome(), arguments: [false]),
    intColor: 0xffABEBAF,
    value: 1,
    list: connectionList.where((element) => element.type == 1).toList(),
    type: 5,
  ),
  AppModel(
    'Gratitude',
    'Make appreciation your default mode to draw more joy, thanks, meaning, and happiness from every moment of your life.',
    ontap: () => Get.to(() => GratitudeHome(), arguments: [false]),
    intColor: 0xffB3D8B5,
    value: 2,
    list: gratitudeList.where((element) => element.type == 1).toList(),
    type: 6,
  ),
];

List<AppModel> physicalList = <AppModel>[
  AppModel(
    'Movement',
    'Move your body to increase overall health, strength, body fat loss, and mobility in the time you have with or without a gym.',
    ontap: () => Get.to(() => MovementHome(), arguments: [false]),
    intColor: 0xffFFC7C7,
    value: 0,
    list: movementList.where((element) => element.type == 1).toList(),
    type: 10,
  ),
  AppModel(
    'Diet',
    'Learn simple habits to make getting to and maintaining your ideal healthy weight natural and normal for you.',
    ontap: () => Get.to(() => DietHome(), arguments: [false]),
    intColor: 0xffE9B6B6,
    value: 1,
    list: dietList.where((element) => element.type == 1).toList(),
    type: 11,
  ),
  AppModel(
    'Cold',
    'Gain instant focus, energy, happiness, and resilience to stress while improving skin, hair, and circulation.',
    ontap: () => Get.to(() => ColdHome(), arguments: [false]),
    intColor: 0xffD5BDBD,
    value: 2,
    list: coldList.where((element) => element.type == 1).toList(),
    type: 12,
  ),
  AppModel(
    'Sexual',
    'Exercise the “secret” muscles that make it better, longer, more frequent, & more satisfying.',
    intColor: 0xffC2B8B8,
    ontap: () => Get.to(() => SexualHome(), arguments: [false]),
    value: 3,
    list: sexualList.where((element) => element.type == 1).toList(),
    type: 14,
  ),
];

List<AppModel> purposeList = <AppModel>[
  AppModel(
    'Goals & Values',
    'Find and pursue your purpose daily. Live your life exactly how you want to.',
    ontap: () => Get.to(() => GoalsHome(), arguments: [false]),
    value: 0,
    intColor: 0xffFFFAB2,
    list: valueGoalList.where((element) => element.type == 1).toList(),
    type: 7,
  ),
  AppModel(
    'Planning & Behavioral Design',
    'Work smarter to have more time for the people and things you love. Design your life so the most natural choice is the best choice.',
    ontap: () => Get.to(() => BdHome(), arguments: [false]),
    value: 1,
    intColor: 0xffEEEAB4,
    list: bdList.where((element) => element.type == 1).toList(),
    type: 9,
  ),
];

/// 0: practice, 1: reading, 2: audio

List<AppModel> introList = <AppModel>[
  AppModel(
    'I100- What and Why? (Reading)',
    '',
    value: 0,
    type: 1,
    ontap: () => Get.to(
      () => ReadingScreen(
        title: 'I100- What and Why?',
        link:
            'https://docs.google.com/document/d/1BAHPkAE7yCOQ6G1bi-ug-wCOL3UQLuc9',
        linked: () {},
        function: () => {
          Get.find<IntroController>().updateHistory(),
          Get.log('closed'),
        },
      ),
    ),
  ),
  AppModel(
    'I101- Principles (Reading)',
    '',
    value: 1,
    type: 1,
    preReading: 0,
    // ontap: () => Get.to(() => const PrinciplesReading()),
    ontap: () => Get.to(
      () => ReadingScreen(
        title: 'I101- Principles',
        link:
            'https://docs.google.com/document/d/1qSPeCrVK-6LFvht0DstdCQ6dwOUJsURl/',
        linked: () {},
        function: () => {
          Get.find<IntroController>().updateHistory(),
          Get.log('closed'),
        },
      ),
    ),
  ),
  AppModel(
    'I102- How to use this program (Reading)',
    '',
    value: 2,
    preReading: 0,
    connectedPractice: 4,
    type: 1,
    ontap: () => Get.to(
      () => ReadingScreen(
        title: 'I102- How to use this program',
        link:
            'https://docs.google.com/document/d/1rQQdH-LmQkUjcUIgswSjgmOPdTHzuVpa/',
        linked: () => Get.to(() => const AppRoutines()),
        function: () => {
          Get.find<IntroController>().updateHistory(),
          Get.log('closed'),
        },
      ),
    ),
    // ontap: () => Get.to(() => const HowToUseReading()),
  ),
  AppModel(
    'BD101- Behavioral Design Journal- Habits & Designing path to least resistance (Reading)',
    '',
    value: 3,
    preReading: 1,
    type: 1,
    ontap: () => Get.to(() => const BD101Reading()),
    // ontap: () => Get.to(
    //   () => ReadingScreen(
    //     title: 'BD101- Behavioral Design Journal- Habits & Designing path to least resistance',
    //     link:
    //         'https://docs.google.com/document/d/1qSPeCrVK-6LFvht0DstdCQ6dwOUJsURl/',
    //     linked: () {},
    //     function: () => {
    //       Get.find<IntroController>().updateHistory(end.difference(initial).inSeconds),
    //       Get.log('closed'),
    //     },
    //   ),
    // ),
  ),
  AppModel(
    'Routine Creator (Practice)',
    '',
    value: 4,
    connectedReading: 2,
    type: 0,
    ontap: () => Get.to(() => const AppRoutines()),
  ),
];

List<AppModel> readingList = <AppModel>[
  AppModel(
    'Intro',
    '* You\'ve completed all readings on this topic or need to complete an exercise to advance. Consider changing your learning focus. *',
    value: 0,
  ),
  AppModel(
    'Breathing',
    '* You\'ve completed all readings on this topic or need to complete an exercise to advance. Consider changing your learning focus. *',
    value: 1,
  ),
  AppModel(
    'Visualization',
    '* You\'ve completed all readings on this topic or need to complete an exercise to advance. Consider changing your learning focus. *',
    value: 2,
  ),
  AppModel(
    'Mindfulness',
    '* You\'ve completed all readings on this topic or need to complete an exercise to advance. Consider changing your learning focus. *',
    value: 3,
  ),
  AppModel(
    'Emotional Regulation',
    '* You\'ve completed all readings on this topic or need to complete an exercise to advance. Consider changing your learning focus. *',
    value: 4,
  ),
  AppModel(
    'Connection',
    '* You\'ve completed all readings on this topic or need to complete an exercise to advance. Consider changing your learning focus. *',
    value: 5,
  ),
  AppModel(
    'Gratitude',
    '* You\'ve completed all readings on this topic or need to complete an exercise to advance. Consider changing your learning focus. *',
    value: 6,
  ),
  AppModel(
    'Goals & Values',
    '* You\'ve completed all readings on this topic or need to complete an exercise to advance. Consider changing your learning focus. *',
    value: 7,
  ),
  // AppModel(
  //   'Productivity',
  //   '* You\'ve completed all readings on this topic or need to complete an exercise to advance. Consider changing your learning focus. *',
  //   value: 8,
  // ),
  AppModel(
    'Behavioral Design',
    '* You\'ve completed all readings on this topic or need to complete an exercise to advance. Consider changing your learning focus. *',
    value: 9,
  ),
  AppModel(
    'Movement',
    '* You\'ve completed all readings on this topic or need to complete an exercise to advance. Consider changing your learning focus. *',
    value: 10,
  ),
  AppModel(
    'Eating',
    '* You\'ve completed all readings on this topic or need to complete an exercise to advance. Consider changing your learning focus. *',
    value: 11,
  ),
  AppModel(
    'Cold',
    '* You\'ve completed all readings on this topic or need to complete an exercise to advance. Consider changing your learning focus. *',
    value: 12,
  ),
  // AppModel(
  //   'Reading',
  //   '* You\'ve completed all readings on this topic or need to complete an exercise to advance. Consider changing your learning focus. *',
  //   value: 13,
  // ),
  AppModel(
    'Sexual',
    '* You\'ve completed all readings on this topic or need to complete an exercise to advance. Consider changing your learning focus. *',
    value: 14,
  ),
];

List<AppModel> readings = <AppModel>[
  AppModel('Course Reading (Breathing)', '', value: 65),
  AppModel('Course Reading (Visualization)', '', value: 66),
  AppModel('Course Reading (Mindfulness)', '', value: 67),
  AppModel('Course Reading (Therapy)', '', value: 68),
  AppModel('Course Reading (Connection)', '', value: 69),
  AppModel('Course Reading (Gratitude)', '', value: 70),
  AppModel('Course Reading (Goals & Values)', '', value: 71),
  AppModel('Course Reading (Planning & Behavioral Design)', '', value: 72),
  AppModel('Course Reading (Movement)', '', value: 73),
  AppModel('Course Reading (Diet)', '', value: 74),
  AppModel('Course Reading (Cold)', '', value: 75),
  AppModel('Course Reading (PC)', '', value: 76),
  AppModel('Course Library', '', value: 77),
  AppModel('Free Reading', '', value: 78),
];

List<AppModel> currentlyReading(int category) {
  switch (category) {
    case 0:
      return introList.where((element) => element.type == 1).toList();
    case 1:
      return breathingList.where((element) => element.type == 1).toList();
    case 2:
      return visualizationList.where((element) => element.type == 1).toList();
    case 3:
      return mindfulnessList.where((element) => element.type == 1).toList();
    case 4:
      return erList.where((element) => element.type == 1).toList();
    case 5:
      return connectionList.where((element) => element.type == 1).toList();
    case 6:
      return gratitudeList.where((element) => element.type == 1).toList();
    case 7:
      return valueGoalList.where((element) => element.type == 1).toList();
    case 8:
      return <AppModel>[];
    case 9:
      return bdList.where((element) => element.type == 1).toList();
    case 10:
      return movementList.where((element) => element.type == 1).toList();
    case 11:
      return dietList.where((element) => element.type == 1).toList();
    case 12:
      return coldList.where((element) => element.type == 1).toList();
    // case 13:
    //   return readings;
    case 14:
      return sexualList.where((element) => element.type == 1).toList();
    default:
      return <AppModel>[];
  }
}

///
List<AppModel> breathingList = <AppModel>[
  //2: audio, 0:practic, 1:reading
  AppModel(
    'One Breath (0:32) Guided Audio',
    '${audiopath}One Breath (0_32).mp3',
    value: 5,
    type: 2,
    connectedReading: 7,
    ontap: () {},
  ),
  AppModel(
    'One Breath (1:13) Guided Audio',
    '${audiopath}One Breath (1_13).mp3',
    value: 6,
    type: 2,
    connectedReading: 7,
  ),
  // AppModel('Free Breathing (Practice)', '', value: 7, type: 0),
  AppModel(
    'B Intro- Unlock the Anti-Stress Pathway and Build a Base to Exploring Your Inner World (Intro)',
    '',
    value: 7,
    type: 1,
    connectedPractice: 5,
    // ontap: () => Get.to(() => const BIntroReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title:
              'B Intro- Unlock the Anti-Stress Pathway and Build a Base to Exploring Your Inner World',
          link:
              'https://docs.google.com/document/d/1qw78rEKZDog52DV5Vblx-cdjaJCAfUmY',
          linked: () {
            Get.to(
              () => GuidedBreathingScreen(
                fromExercise: true,
                entity: breathingList[breathingListIndex(5)],
                connectedReading: () => Get.back(),
                onfinished: () => Get.back(),
              ),
            );
          },
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<BreathingController>().history.value.value == 7) {
              Get.find<BreathingController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
          },
        ),
      );
    },
  ),
  AppModel(
    'B100- Just Breath (Reading)',
    '',
    value: 8,
    type: 1,
    preReading: 7,
    connectedPractice: 9,
    // ontap: () => Get.to(() => const B100Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'B100- Just Breath',
          link:
              'https://docs.google.com/document/d/1IV1Wbp0KY0wMF99JXYmpS75NB84tMllJ/',
          linked: () => Get.to(
            () => GuidedBreathingScreen(
              fromExercise: true,
              entity: breathingList[breathingListIndex(9)],
              onfinished: () => Get.back(),
              connectedReading: () => Get.back(),
            ),
          ),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<BreathingController>().history.value.value == 8) {
              Get.find<BreathingController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
          },
        ),
      );
    },
  ),
  AppModel(
    'Deep Breathing: Technique (2:42) Guided Audio',
    '${audiopath}Deep Breathing- Technique (2_42).mp3',
    value: 9,
    type: 2,
    preReading: 8,
    connectedReading: 8,
  ),
  AppModel(
    'Deep Breathing: Relax (2:42) Guided Audio',
    '${audiopath}Deep Breathing- Relax (2_42).mp3',
    value: 10,
    type: 2,
    preReading: 8,
    connectedReading: 8,
  ),
  AppModel(
    'B101- 3 Stage Breathing (Reading)',
    '',
    value: 11,
    type: 1,
    prePractice: 9, // 3 times deep breathing
    connectedPractice: 12, // 3 stage breathing
    // ontap: () => Get.to(() => const B101Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      Get.to(
        () => ReadingScreen(
          title: 'B101- 3 Stage Breathing',
          link:
              'https://docs.google.com/document/d/1K3ms2VevzA9pduRSE0awRWRKnYEnmbHV/',
          linked: () => Get.to(
            () => GuidedBreathingScreen(
              fromExercise: true,
              entity: breathingList[breathingListIndex(12)],
              onfinished: () => Get.back(),
              connectedReading: () => Get.back(),
            ),
          ),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<BreathingController>().history.value.value == 11) {
              Get.find<BreathingController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    '3 Stage Breathing (0:41) Guided Audio',
    '${audiopath}3-Stage Breathing (1_00).mp3',
    value: 12,
    type: 2,
    preReading: 11,
    connectedReading: 11,
  ),
  AppModel(
    '3 Stage Breathing (2:18) Guided Audio',
    '${audiopath}3-Stage Breathing (2_37).mp3',
    value: 13,
    type: 2,
    preReading: 11,
    connectedReading: 11,
  ),
  AppModel(
    '3 Stage Breathing (10:02) Guided Audio',
    '${audiopath}3-Stage Breathing (10_26).mp3',
    value: 14,
    type: 2,
    preReading: 11,
    connectedReading: 11,
  ),
  AppModel('B102- Secret Ingredient (Reading)', '',
      value: 15,
      type: 1,
      prePractice: 12, // 3 times 3 stage breathing
      connectedPractice: 16, // harmonic breathing
      // ontap: () => Get.to(() => const B102Reading()),
      ontap: () {
    DateTime initial = DateTime.now();
    print(initial);
    Get.to(
      () => ReadingScreen(
        title: 'B102- Secret Ingredient',
        link:
            'https://docs.google.com/document/d/1HHWUuIsn32c1zGFq73iBpGMctWeEerX-/',
        linked: () => Get.to(
          () => GuidedBreathingScreen(
            fromExercise: true,
            entity: breathingList[breathingListIndex(16)],
            onfinished: () {},
            connectedReading: () => Get.back(),
          ),
        ),
        function: () {
          DateTime end = DateTime.now();
          if (Get.find<BreathingController>().history.value.value == 15) {
            Get.find<BreathingController>()
                .updateHistory(end.difference(initial).inSeconds);
          }
          Get.log('closed');
        },
      ),
    );
  }),
  AppModel(
    'Harmonic Breathing (1:00) Guided Audio',
    '${audiopath}Harmonic Breathing (1_03).mp3',
    value: 16,
    type: 2,
    preReading: 15,
  ),
  AppModel(
    'Harmonic Breathing (2:51) Guided Audio',
    '${audiopath}Harmonic Breathing (2_56).mp3',
    value: 17,
    type: 2,
    preReading: 15,
  ),
  AppModel(
    'Harmonic Breathing (9:17) Guided Audio',
    '${audiopath}Harmonic Breathing (9_38).mp3',
    value: 18,
    type: 2,
    preReading: 15,
  ),
];

List<AppModel> freeBreathingList = <AppModel>[
  AppModel('Deep breathing', '${listeningpath}babystep.mp3', value: 0),
  AppModel('3 stage breathing', '${listeningpath}3stagebreathing.mp3',
      value: 1),
  AppModel('Vibration breathing', '${listeningpath}3statebreathing_humming.mp3',
      value: 2),
  AppModel('Other', '${listeningpath}babystep.mp3', value: 3),
];

List<AppModel> mindfulnessList = <AppModel>[
  //0:audio, 1:practice, 2:reading
  AppModel(
    'M Intro- Increase enjoyment from EVERYTHING you do! (Reading)',
    '',
    value: 35,
    type: 1,
    // ontap: () => Get.to(() => const MIntroReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'M Intro- Increase enjoyment from EVERYTHING you do!',
          link:
              'https://docs.google.com/document/d/1Fu5OWVIZdh0og6zbL009HTpi6M_U_3Vv/',
          linked: () {},
          function: () {
            if (Get.find<MindfulnessController>().history.value.value == 35) {
              DateTime end = DateTime.now();
              debugPrint('disposing');
              Get.find<MindfulnessController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Baby Breath Awareness (0:33) Guided Audio',
    '${audiopath}Baby Breath Awareness (0_33).mp3',
    value: 36,
    type: 2,
  ),
  AppModel(
    'M100- Mindfulness Defined (Reading)',
    '',
    value: 37,
    type: 1,
    preReading: 35,
    // ontap: () => Get.to(() => const MindfulnessDefinedReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'M100- Mindfulness Defined',
          link:
              'https://docs.google.com/document/d/1I_KshM2psZgWtkPtzTgSS2oYkz_8Siru/',
          linked: () {},
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<MindfulnessController>().history.value.value == 37) {
              debugPrint('disposing');
              Get.find<MindfulnessController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'M101- Breath Awareness (Reading)',
    '',
    value: 38,
    type: 1,
    preReading: 37,
    connectedPractice: 39, // breath awarness
    // ontap: () => Get.to(() => const BreathAwarenessReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'M101- Breath Awareness',
          link:
              'https://docs.google.com/document/d/1nq3njNLEtiPkXas3RtQUMaJZEOWcLYtC/',
          linked: () {
            Get.to(
              () => GuidedMinfulnessScreen(
                fromExercise: true,
                entity: mindfulnessList[mindfulnessListIndex(39)],
                connectedReading: () => Get.back(),
                onfinished: () => Get.back(),
              ),
            );
          },
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<MindfulnessController>().history.value.value == 38) {
              debugPrint('disposing');
              Get.find<MindfulnessController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Breath Awareness (1:22) Guided Audio',
    '${audiopath}Breath Awareness (1_26).mp3',
    value: 39,
    type: 2,
    preReading: 38,
    connectedReading: 38,
  ),
  AppModel(
    'M102- Smiling Awareness (Reading)',
    '',
    value: 40,
    type: 1,
    prePractice: 39, // 3 times breath awareness
    connectedPractice: 41, // smiling awareness
    // ontap: () => Get.to(() => const SmileAwarenessReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'M102- Smiling Awareness!',
          link:
              'https://docs.google.com/document/d/1BcFvuTHErGqqWeTD9iOIh2hF7_AClPgI/',
          linked: () {
            Get.to(
              () => GuidedMinfulnessScreen(
                fromExercise: true,
                entity: mindfulnessList[mindfulnessListIndex(41)],
                connectedReading: () => Get.back(),
                onfinished: () => Get.back(),
              ),
            );
          },
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<MindfulnessController>().history.value.value == 40) {
              debugPrint('disposing');
              Get.find<MindfulnessController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Smiling Awareness (1:47) Guided Audio',
    '${audiopath}Smiling Awareness (1_47).mp3',
    value: 41,
    type: 2,
    preReading: 40,
    connectedReading: 40,
  ),
  AppModel(
    'M103- Sensory Awarenss (Reading)',
    '',
    value: 42,
    type: 1,
    prePractice: 41, // 1 time smiling awareness
    // ontap: () => Get.to(() => const SensoryAwarenessReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'M103- Sensory Awareness!',
          link:
              'https://docs.google.com/document/d/1Q4zLEfCuO8y86llSiv27GPeaAXGQ7-os/',
          linked: () {},
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<MindfulnessController>().history.value.value == 42) {
              debugPrint('disposing');
              Get.find<MindfulnessController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'M103a- Sight Awarenss (Reading)',
    '',
    value: 43,
    type: 1,
    preReading: 42,
    connectedPractice: 44, // sight awareness
    // ontap: () => Get.to(() => const SightAwarenessReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'M103a- Sight Awareness',
          link:
              'https://docs.google.com/document/d/1j1Isvw0f6bS5j3epwzeklTvPgWHfh5tv/',
          linked: () {
            Get.to(
              () => GuidedMinfulnessScreen(
                fromExercise: true,
                entity: mindfulnessList[mindfulnessListIndex(44)],
                connectedReading: () => Get.back(),
                onfinished: () => Get.back(),
              ),
            );
          },
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<MindfulnessController>().history.value.value == 43) {
              debugPrint('disposing');
              Get.find<MindfulnessController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Sight Awareness (2:05) Guided Audio',
    '${audiopath}Sight Awareness (2_06).mp3',
    value: 44,
    type: 2,
    preReading: 43,
    connectedReading: 43,
  ),
  AppModel(
    'M103b- Sound Awareness (Reading)',
    '',
    value: 45,
    type: 1,
    preReading: 42,
    connectedPractice: 46, // sound awareness
    // ontap: () => Get.to(() => const SoundAwarenessReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'M103b- Sound Awareness',
          link:
              'https://docs.google.com/document/d/17waIUmRJbcE87p0FzHx0sZhgQkuc95dD/',
          linked: () {
            Get.to(
              () => GuidedMinfulnessScreen(
                fromExercise: true,
                entity: mindfulnessList[mindfulnessListIndex(46)],
                connectedReading: () => Get.back(),
                onfinished: () => Get.back(),
              ),
            );
          },
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<MindfulnessController>().history.value.value == 45) {
              debugPrint('disposing');
              Get.find<MindfulnessController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Sound Awareness (2:28) Guided Audio',
    '${audiopath}Sound Awareness (2_28).mp3',
    value: 46,
    type: 2,
    preReading: 45,
    connectedReading: 45,
  ),
  AppModel(
    'M103c- Smell Awareness (Reading)',
    '',
    value: 47,
    type: 1,
    preReading: 42,
    connectedPractice: 48, // smell awareness
    // ontap: () => Get.to(() => const SmellAwareness()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'M103c- Smell Awareness',
          link:
              'https://docs.google.com/document/d/1-ouPyYUZ5fbQc7rxK8OHOgGbLXHd75oT/',
          linked: () {
            Get.to(
              () => GuidedMinfulnessScreen(
                fromExercise: true,
                entity: mindfulnessList[mindfulnessListIndex(48)],
                connectedReading: () => Get.back(),
                onfinished: () => Get.back(),
              ),
            );
          },
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<MindfulnessController>().history.value.value == 47) {
              debugPrint('disposing');
              Get.find<MindfulnessController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Smell Awareness (2:21) Guided Audio',
    'assets/audio1.mp3',
    value: 48,
    type: 2,
    preReading: 47,
    connectedReading: 47,
  ),
  AppModel(
    'M103d- Touch Awareness (Reading)',
    '',
    value: 49,
    type: 1,
    preReading: 42, connectedPractice: 50, // touch awareness
    // ontap: () => Get.to(() => const TouchAwarenessReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'M103d- Touch Awareness',
          link:
              'https://docs.google.com/document/d/1hz5O1wZ0jq5_Zqxv9qFwramNixup2cHe/',
          linked: () {
            Get.to(
              () => GuidedMinfulnessScreen(
                fromExercise: true,
                entity: mindfulnessList[mindfulnessListIndex(50)],
                connectedReading: () => Get.back(),
                onfinished: () => Get.back(),
              ),
            );
          },
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<MindfulnessController>().history.value.value == 49) {
              debugPrint('disposing');
              Get.find<MindfulnessController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Touch Awareness (2:54) Guided Audio',
    '${audiopath}Touch Awareness (3_01).mp3',
    value: 50,
    type: 2,
    preReading: 49,
    connectedReading: 49,
  ),
  AppModel(
    'M103e- Taste Awareness (Reading)',
    '',
    value: 51,
    type: 1,
    preReading: 42, connectedPractice: 52, // taste awareness
    // ontap: () => Get.to(() => const TasteAwarenessReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'M103e- Taste Awareness',
          link:
              'https://docs.google.com/document/d/1xH5KCddx0uwKiLUl1QqrMr2MFQQp6Uei/',
          linked: () {
            Get.to(
              () => GuidedMinfulnessScreen(
                fromExercise: true,
                entity: mindfulnessList[mindfulnessListIndex(52)],
                connectedReading: () => Get.back(),
                onfinished: () => Get.back(),
              ),
            );
          },
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<MindfulnessController>().history.value.value == 51) {
              debugPrint('disposing');
              Get.find<MindfulnessController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Taste Awareness (3:11) Guided Audio',
    '${audiopath}Taste Awareness (3_19).mp3',
    value: 52,
    type: 2,
    preReading: 51,
    connectedReading: 51,
  ),
  AppModel(
    'M103f- Kinesthetic Awareness (Reading)',
    '',
    value: 53,
    type: 1,
    preReading: 42,
    connectedPractice: 54, // kinesthetic awareness
    // ontap: () => Get.to(() => const KinestheticAwarenessReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'M103f- Kinesthetic Awareness',
          link:
              'https://docs.google.com/document/d/1KsgqONXoaJJXTrJjC5NVhI8aNh_KYpln/',
          linked: () {
            Get.to(
              () => GuidedMinfulnessScreen(
                fromExercise: true,
                entity: mindfulnessList[mindfulnessListIndex(54)],
                connectedReading: () => Get.back(),
                onfinished: () => Get.back(),
              ),
            );
          },
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<MindfulnessController>().history.value.value == 53) {
              debugPrint('disposing');
              Get.find<MindfulnessController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Kinesthetic Awareness (2:11) Guided Audio',
    'assets/audio2.mp3',
    value: 54,
    type: 2,
    preReading: 53,
    connectedReading: 53,
  ),
  AppModel(
    'M104- Body Scans (Reading)',
    '',
    value: 55,
    type: 1,
    prePractice: 54, // 1 time sight awareness,
    connectedPractice: 55, // body scans
    // ontap: () => Get.to(() => const BodyScanReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'M104- Body Scans',
          link:
              'https://docs.google.com/document/d/12-_h0kCWz9bs02DuNSVt6I4BTyKgUQYz/',
          linked: () {
            Get.to(
              () => GuidedMinfulnessScreen(
                fromExercise: true,
                entity: mindfulnessList[mindfulnessListIndex(56)],
                connectedReading: () => Get.back(),
                onfinished: () => Get.back(),
              ),
            );
          },
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<MindfulnessController>().history.value.value == 55) {
              debugPrint('disposing');
              Get.find<MindfulnessController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Body Scans (3:44) Guided Audio',
    '${audiopath}Body Scan (3_53).mp3',
    value: 56,
    type: 2,
    preReading: 55,
    connectedReading: 55,
  ),
  AppModel(
    'M105- Open Monitoring (Reading)',
    '',
    value: 57,
    type: 1,
    prePractice: 56, // 3 times body scans
    connectedPractice: 58, // open monitoring
    // ontap: () => Get.to(() => const OpenMonitoringReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'M105- Open Monitoring',
          link:
              'https://docs.google.com/document/d/1yWvIM1d9hXIPFtgK2nN3hKi5Yg5bZlxW/',
          linked: () {
            Get.to(
              () => GuidedMinfulnessScreen(
                fromExercise: true,
                entity: mindfulnessList[mindfulnessListIndex(58)],
                connectedReading: () => Get.back(),
                onfinished: () => Get.back(),
              ),
            );
          },
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<MindfulnessController>().history.value.value == 57) {
              debugPrint('disposing');
              Get.find<MindfulnessController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Open Monitoring (1:52) Guided Audio',
    '${audiopath}Open Monitoring (1_52).mp3',
    value: 58,
    type: 2,
    preReading: 57,
    connectedReading: 57,
  ),
  // AppModel('Free Mindfulness Practice', '', value: 58, type: 0),
  // AppModel(
  //   'Meal Mindfulness (0:24) Guided Audio',
  //   '${listeningpath}mindfulmeals.mp3',
  //   value: 59,
  //   type: 2,
  // ),
];

List<AppModel> freeMindfulList = <AppModel>[
  AppModel('Meals/Drinks (Taste)', '${listeningpath}mindfulmeals.mp3',
      value: 0),
  AppModel('Breath', '${listeningpath}3statebreathing_humming.mp3', value: 1),
  AppModel('Touch', '${listeningpath}3statebreathing_humming.mp3', value: 2),
  AppModel('Sight', '${listeningpath}3statebreathing_humming.mp3', value: 3),
  AppModel('Sound', '${listeningpath}3statebreathing_humming.mp3', value: 4),
  AppModel('Body Scan', '${listeningpath}3statebreathing_humming.mp3',
      value: 5),
  AppModel('Open Monitoring', '${listeningpath}3statebreathing_humming.mp3',
      value: 6),
  AppModel('Other', '${listeningpath}3statebreathing_humming.mp3', value: 7),
];

List<AppModel> visualizationList = <AppModel>[
  //2:audio, 0:practice, 1:reading, 3: custom
  AppModel(
    'V Intro- Einstein\'s secret weapon. Increase your skill at anything while laying on the couch (Reading) ',
    '',
    value: 19,
    type: 1,
    connectedPractice: 24, // progressive muscle relaxation
    // ontap: () => Get.to(() => const VIntroReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title:
              'V Intro- Einstein\'s secret weapon. Increase your skill at anything while laying on the couch',
          link:
              'https://docs.google.com/document/d/1PrJXZZ7DK3Jl6zgzLm73m_c-BSkhPcLp/',
          linked: () {
            Get.to(
              () => GuidedVisualization(
                fromExercise: true,
                entity: visualizationList[visualizationIndex(24)],
                connectedReading: () => Get.back(),
                onfinished: () => Get.back(),
              ),
            );
          },
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<VisualizationController>().history.value.value == 19) {
              debugPrint('disposing');
              Get.find<VisualizationController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'V100- What is Visualization? (Reading)',
    '',
    value: 20,
    type: 1,
    prePractice: 19,
    connectedPractice: 23, // drink water - baby steps-habits,
    // ontap: () => Get.to(() => const WhatIsVisualizationReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'V100- What is Visualization? ',
          link:
              'https://docs.google.com/document/d/1mWPm4jf9I0IF-4G9rPEX_icsxB74Ap17/',
          linked: () {
            Get.to(
              () => GuidedVisualization(
                fromExercise: true,
                entity: visualizationList[visualizationIndex(23)],
                connectedReading: () => Get.back(),
                onfinished: () => Get.back(),
              ),
            );
          },
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<VisualizationController>().history.value.value == 20) {
              debugPrint('disposing');
              Get.find<VisualizationController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Guided Visualization for Improving Visualization Skill - Fruit',
    '',
    value: 21,
    type: 1,
    preReading: 20,
    connectedPractice: 22, // fruit visualization improvement exercise
    // ontap: () => Get.to(() => const GuidedVisualizationFruitReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'Guided Visualization for Improving Physical Strength -Fruit',
          link:
              'https://docs.google.com/document/d/1YMyAu6mW6tEnp7RQBodgPMk7t3FVcBVp/',
          linked: () {
            Get.to(
              () => GuidedVisualization(
                fromExercise: true,
                entity: visualizationList[visualizationIndex(22)],
                connectedReading: () => Get.back(),
                onfinished: () => Get.back(),
              ),
            );
          },
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<VisualizationController>().history.value.value == 21) {
              debugPrint('disposing');
              Get.find<VisualizationController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Fruit (Visualization Improvement Exercise) (Audio)',
    '${audiopath}Improve Visualization Skill (3_05).mp3',
    value: 22,
    type: 2,
    preReading: 20,
    connectedReading: 21,
    link: '${audiopath}Improve Visualization Skill (3_05).mp3',
  ),
  AppModel(
    'Drink Water (1:00) Guided Audio',
    '${audiopath}Drinking Water (1_00).mp3',
    value: 23,
    type: 2,
    preReading: 20,
    connectedReading: 20,
    link: '${audiopath}Drinking Water (1_00).mp3',
  ),
  AppModel(
    'Progressive Muscle Relaxation (5:59) Guided Audio ',
    '${audiopath}Progressive Full Body Relaxation (6_15).mp3',
    value: 24,
    type: 2,
    preReading: 20,
    connectedReading: 20,
    link: '${audiopath}Progressive Full Body Relaxation (6_15).mp3',
  ),
  AppModel(
    'V101- Creating your script (Reading)',
    '',
    value: 25,
    type: 1,
    prePractice: 22, // 1 time Fruit Visualization Improvement
    connectedPractice: 28, // Creating your script
    // ontap: () => Get.to(() => const CreateYourScriptReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'V101- Creating your script',
          link:
              'https://docs.google.com/document/d/1MENpf_8xxQ6UWtGBlon8uNkJ6sKxMAZW/',
          linked: () => Get.to(
            () => const V101CreateScript(),
            arguments: [false],
          ),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<VisualizationController>().history.value.value == 25) {
              debugPrint('disposing');
              Get.find<VisualizationController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Guided Visualization for Improving Physical Strength - Workout (Reading)',
    '',
    value: 26,
    type: 1,
    preReading: 25,
    connectedPractice: 27, // workout improvement audio
    // ontap: () => Get.to(() => const GuidedVisualizationReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title:
              'Guided Visualization for Improving Physical Strength - Workout',
          link:
              'https://docs.google.com/document/d/1bE9_jphBA1WgvoufwVHOuFYaENqxAxiB/',
          linked: () {
            Get.to(
              () => GuidedVisualization(
                fromExercise: true,
                entity: visualizationList[visualizationIndex(27)],
                connectedReading: () => Get.back(),
                onfinished: () => Get.back(),
              ),
            );
          },
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<VisualizationController>().history.value.value == 26) {
              debugPrint('disposing');
              Get.find<VisualizationController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Improve Physical Strength (1:00) Guided Audio',
    '${audiopath}Improve Physical Strength (1_00).mp3',
    value: 27,
    type: 2,
    preReading: 25,
    connectedReading: 26,
    link: '${audiopath}Improve Physical Strength (1_00).mp3',
  ),
  AppModel(
    'Creating your script (Practice)',
    '',
    value: 28,
    type: 0,
    preReading: 25,
    connectedReading: 25,
    ontap: () => Get.to(() => const V101CreateScript(), arguments: [false]),
  ),
  AppModel(
    'V102- Visualization Improvement (Reading)',
    '',
    value: 29,
    type: 1,
    prePractice: 28, // 1 time create your script
    connectedPractice: 31, // LSRT
    // ontap: () => Get.to(() => const VisualizationImprovementsReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'V102- Visualization Improvement',
          link:
              'https://docs.google.com/document/d/1AoM3znyfd1XxxlLYnNBnijNHHmpAfWBr/',
          linked: () => Get.to(() => const LSRT(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<VisualizationController>().history.value.value == 29) {
              debugPrint('disposing');
              Get.find<VisualizationController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  // AppModel('Improve Visualization Skill (2:58) Guided Audio',
  //     '${listeningpath}babystep.mp3',
  //     value: 30, type: 2),
  AppModel(
    'LSRT (Practice)',
    '',
    value: 31,
    type: 0,
    preReading: 29,
    connectedReading: 29,
    ontap: () => Get.to(() => const LSRT(), arguments: [false]),
  ),
  AppModel(
    'V103- Habits (Reading)',
    '',
    value: 32,
    type: 1,
    prePractice: 31, // 1 time LSRT
    connectedPractice: 0, // habits under create script
    // ontap: () => Get.to(() => const HabitsReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'V103- Habits',
          link:
              'https://docs.google.com/document/d/1D-fr4A0I-k1NTaLHoI3jxM0u0fWqeaO_/',
          linked: () =>
              Get.to(() => const V101CreateScript(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<VisualizationController>().history.value.value == 32) {
              debugPrint('disposing');
              Get.find<VisualizationController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'V104- Ideal Life (Reading)',
    '',
    value: 33,
    type: 1,
    prePractice: 28, // 1 time habit
    connectedPractice: 0, // ideal life under create script
    // ontap: () => Get.to(() => const IdealLifeReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'V104- Ideal Life',
          link:
              'https://docs.google.com/document/d/1GoFWulL7M5cAqhs3wOlhfgjFjhnmUIYM/',
          linked: () =>
              Get.to(() => const V101CreateScript(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<VisualizationController>().history.value.value == 33) {
              debugPrint('disposing');
              Get.find<VisualizationController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'V105- Ideal Day (Reading)',
    '',
    value: 34,
    type: 1,
    prePractice: 28, // 1 time ideal life
    connectedPractice: 0, // ideal day under create script
    // ontap: () => Get.to(() => const IdealDayReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'V105- Ideal Day',
          link:
              'https://docs.google.com/document/d/1fLMuR9oUQNRGO7duaSDttqCgBRZtAvwg/',
          linked: () =>
              Get.to(() => const V101CreateScript(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<VisualizationController>().history.value.value == 34) {
              debugPrint('disposing');
              Get.find<VisualizationController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  // AppModel('Custom (Links to Guided Visualization)', '', value: 34, type: 3),
];

List<AppModel> scriptOption = <AppModel>[
  AppModel('None', '', value: 0),
  AppModel('Task or Sport', '', value: 1),
  AppModel('Ideal Life', '', value: 2),
  AppModel('Ideal Day', '', value: 3),
  AppModel('Forming Habits', '', value: 4),
  AppModel('Emotional Reprogramming', '', value: 5),
];

List<int> radioList = <int>[1, 2, 3, 4, 5];

List<AppModel> erList = <AppModel>[
  //66
  /// 0: practice, 1: reading
  AppModel(
    'ER Intro- Generational Curses and Their Cure',
    '',
    type: 1,
    value: 67,
    connectedPractice: 71, // ERJL0 - Observe
    // ontap: () => Get.to(() => const ERIntro()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'ER Intro- Generational Curses and Their Cure',
          link:
              'https://docs.google.com/document/d/1sQBau2cQ--qGDobCDCx_RchOCSS0SzpZ/',
          linked: () => Get.to(() => const ObserveSF(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<ErController>().history.value.value == 67) {
              debugPrint('disposing');
              Get.find<ErController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'ER100- A Brief Introduction to CBT (Reading)',
    '',
    type: 1,
    value: 68,
    connectedPractice: 70, // baby reframing
    // ontap: () => Get.to(() => const ER100Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'ER100- A Brief Introduction to CBT',
          link:
              'https://docs.google.com/document/d/1HoVvGqqLHWLH-ATn-DoS4MXO_2ZlY9jD/',
          linked: () => Get.to(() => BabyReframing(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<ErController>().history.value.value == 68) {
              debugPrint('disposing');
              Get.find<ErController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Behavioral Activation (Practice)',
    '',
    type: 0,
    value: 69,
    connectedReading: 68,
    ontap: () => Get.to(() => const BAScreen(), arguments: [false]),
  ),
  AppModel(
    'Baby Reframing (Practice)',
    '',
    type: 0,
    value: 70,
    ontap: () => Get.to(() => BabyReframing(), arguments: [false]),
  ),
  AppModel(
    'ER Journal Level 0- Observe (Practice)',
    '',
    type: 0,
    value: 71,
    connectedReading: 73,
    ontap: () => Get.to(() => const ObserveFullForm(), arguments: [false]),
  ),
  AppModel(
    'ER Journal Level 0- Observe (short form) (Practice)',
    '',
    type: 0,
    value: 72,
    connectedReading: 73,
    ontap: () => Get.to(() => const ObserveSF(), arguments: [false]),
  ),
  AppModel(
    'ER101- Emotional Check-In and Limiting Damage (Reading)',
    '',
    type: 1,
    value: 73,
    preReading: 67,
    connectedPractice: 76, // ERJL 1
    // ontap: () => Get.to(() => const ER101Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'ER101- Emotional Check-In and Limiting Damage',
          link:
              'https://docs.google.com/document/d/1ZkupifvNrMxLfJuCZKrVewEwx269xGHs/',
          linked: () =>
              Get.to(() => const EmotionalCheckIn(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<ErController>().history.value.value == 73) {
              debugPrint('disposing');
              Get.find<ErController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'ER101a- Resolve the Situation (Reading)',
    '',
    type: 1,
    value: 74,
    preReading: 73,
    connectedPractice: 75, // resolve the situation
    // ontap: () => Get.to(() => const ER101aReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'ER101a- Resolve the Situation',
          link:
              'https://docs.google.com/document/d/10h8qjNmn61kP5pmyokNPtfJ2ahrBFvhZ/',
          linked: () => Get.to(() => const Resolution(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<ErController>().history.value.value == 74) {
              debugPrint('disposing');
              Get.find<ErController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Resolve the Situation (Practice)',
    '',
    type: 0,
    value: 75,
    preReading: 73,
    connectedReading: 74,
    ontap: () => Get.to(() => const Resolution(), arguments: [false]),
  ),
  AppModel(
    'ER Journal Level 1- Emotional Check-In (Practice)',
    '',
    type: 0,
    value: 76,
    preReading: 73,
    connectedReading: 73,
    ontap: () => Get.to(() => const EmotionalCheckIn(), arguments: [false]),
  ),
  AppModel(
    'ER Journal Level 1- Emotional Check-In (short form) (Practice)',
    '',
    type: 0,
    value: 77,
    preReading: 73,
    connectedReading: 73,
    ontap: () => Get.to(() => const EmotionalCheckInSf(), arguments: [false]),
  ),
  AppModel(
    'ER102- ABC Root Analysis (Reading)',
    '',
    type: 1,
    value: 78,
    prePractice: 76, // 3 times EJL1
    connectedPractice: 79, // abc root analysis
    // ontap: () => Get.to(() => const ER102Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'ER102- ABC Root Analysis',
          link:
              'https://docs.google.com/document/d/1j5pNiZwiJKJWq2swS0UOJZJUzy-5-qFz/',
          linked: () =>
              Get.to(() => const AbcRootAnalysis(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<ErController>().history.value.value == 78) {
              debugPrint('disposing');
              Get.find<ErController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'ABC Root Analysis',
    '',
    type: 0,
    value: 79,
    preReading: 78,
    connectedReading: 78, //
    ontap: () => Get.to(() => const AbcRootAnalysis(), arguments: [false]),
  ),
  AppModel(
    'ER Journal Level 2- Emotional Analysis (short form)',
    '',
    type: 0,
    value: 80,
    prePractice: 79, // 1 time abc root analysis,
    connectedReading: 78,
    ontap: () => Get.to(() => const EmotionalAnalysisSf(), arguments: [false]),
  ),
  AppModel(
    'ER Journal Level 2- Emotional Analysis (Practice)',
    '',
    type: 0,
    value: 81,
    prePractice: 79, // 1 time abc root analysis
    connectedReading: 78,
    ontap: () => Get.to(() => const EmotionalAnalysis(), arguments: [false]),
  ),
  AppModel(
    'ER103- Are Your Thoughts Facts? (Reading)',
    '',
    type: 1,
    value: 82,
    prePractice: 81, // 1 time ERJL2
    connectedPractice: 83,
    // ontap: () => Get.to(() => const ER103Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'ER103- Are Your Thoughts Facts?',
          link:
              'https://docs.google.com/document/d/1mGyuMG_od8-VuCPXLx8npGrFYc37G5gy/',
          linked: () => Get.to(() => const FactChecking(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<ErController>().history.value.value == 82) {
              debugPrint('disposing');
              Get.find<ErController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Fact Checking Thoughts (Test)',
    '',
    type: 0,
    value: 83,
    preReading: 82,
    connectedReading: 82,
    ontap: () => Get.to(() => const FactChecking(), arguments: [false]),
  ),
  AppModel(
    'Fact Checking Your Thoughts (Practice)',
    '',
    type: 0,
    value: 84,
    prePractice: 83,
    connectedReading: 82,
    ontap: () =>
        Get.to(() => const FactCheckingYourThoughts(), arguments: [false]),
  ),
  AppModel(
    'ER Journal Level 3- Thought Check (Practice)',
    '',
    type: 0,
    value: 85,
    prePractice: 83,
    connectedReading: 82,
    ontap: () => Get.to(() => const ThoughtCheckIn(), arguments: [false]),
  ),
  AppModel(
    'ER Journal Level 3- Thought Check Short Form',
    '',
    type: 0,
    value: 86,
    prePractice: 83,
    connectedReading: 82,
    ontap: () => Get.to(() => const ThoughtCheckinSf(), arguments: [false]),
  ),
  AppModel(
    'ER104- Cognitive Distortions (Reading)',
    '',
    type: 1,
    value: 87,
    prePractice: 86, // 3 times ERJL3
    connectedPractice: 87,
    // ontap: () => Get.to(() => const ER104Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'ER104- Cognitive Distortion',
          link:
              'https://docs.google.com/document/d/1tN5NgA8DM7RN92B2FOTcrftjrf1nkUKs/',
          linked: () =>
              Get.to(() => const CognitiveDistortion(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<ErController>().history.value.value == 87) {
              debugPrint('disposing');
              Get.find<ErController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Identifying Cognitive Distortions in Yourself (Test)',
    '',
    type: 0,
    value: 88,
    preReading: 87,
    connectedReading: 87,
    ontap: () => Get.to(() => const CognitiveDistortion(), arguments: [false]),
  ),
  AppModel(
    'ER105- Reframing Cognitive Distortions and Negative Thoughts (Reading)',
    '',
    type: 1,
    value: 89,
    prePractice: 88, // 1 time conginitive distoritions
    connectedPractice: 90,
    // ontap: () => Get.to(() => const ER105Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'ER105- Reframing Cognitive Distortions and Negative Thoughts',
          link:
              'https://docs.google.com/document/d/1h2vTz0qNkkKZpIQueQg5ee-KyVPmidXs/',
          linked: () => Get.to(() => const Reframing(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<ErController>().history.value.value == 89) {
              debugPrint('disposing');
              Get.find<ErController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'ER105- Reframing Cognitive Distortions and Negative Thoughts ',
    '',
    type: 0,
    value: 90,
    preReading: 89,
    connectedReading: 89,
    ontap: () => Get.to(() => const Reframing(), arguments: [false]),
  ),
  AppModel(
    'ER Journal Level 4- Thought Analysis (Practice)',
    '',
    type: 0,
    value: 91,
    prePractice: 90, // 3 times reframing CD
    connectedReading: 89,
    ontap: () => Get.to(() => const ThoughtAnalysis(), arguments: [false]),
  ),
  AppModel(
    'ER Journal Level 4- Thought Analysis Short Form (Practice)',
    '',
    type: 0,
    value: 92,
    prePractice: 90, // 3 times reframing CD
    connectedReading: 89,
    ontap: () => Get.to(() => const ThoughtAnalysisSf(), arguments: [false]),
  ),
  AppModel(
    'ER106- Take Action (Reading)',
    '',
    type: 1,
    value: 93,
    prePractice: 91, // 1 time ERJL4
    // ontap: () => Get.to(() => const ER106Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'ER106- Take Action',
          link:
              'https://docs.google.com/document/d/1BxYnA5SWB994IYSoEyQ35SmD6innQui-/',
          linked: () =>
              Get.to(() => const EmotionalCheckIn(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<ErController>().history.value.value == 93) {
              debugPrint('disposing');
              Get.find<ErController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
];

List<AppModel> beliefList = <AppModel>[
  AppModel('1', ' (Little belief with heavy doubt)', value: 0),
  AppModel('2', '', value: 1),
  AppModel('3', '', value: 2),
  AppModel('4', '', value: 3),
  AppModel('5', '', value: 4),
  AppModel('6', '', value: 5),
  AppModel('7', '', value: 6),
  AppModel('8', '', value: 7),
  AppModel('9', '', value: 8),
  AppModel('10', ' (Unwavering belief)', value: 9),
];

List<AppModel> optionList = <AppModel>[
  AppModel('Fact', '', value: 0),
  AppModel('Opinion', '', value: 1),
];

List<AppModel> frequencyList = <AppModel>[
  AppModel('Frequently', '', value: 0),
  AppModel('Sometimes', '', value: 1),
  AppModel('Never', '', value: 2),
];

List<AppModel> distortionList = <AppModel>[
  AppModel('Always being right', '', value: 0),
  AppModel('Mental filtering', '', value: 1),
  AppModel('Should statements', '', value: 2),
  AppModel('Personalization', '', value: 3),
  AppModel('Mind Reading', '', value: 4),
  AppModel('Fortune telling', '', value: 5),
  AppModel('Magnification and minimization', '', value: 6),
  AppModel('Emotional reasoning', '', value: 7),
  AppModel('Jumping to conclusions', '', value: 8),
  AppModel('Global labeling', '', value: 9),
  AppModel('Black & white thinking', '', value: 10),
  AppModel('Fallacy of fairness', '', value: 11),
  AppModel('Overgeneralization', '', value: 12),
  AppModel('Fallacy of change', '', value: 13),
  AppModel('Heaven\'s reward', '', value: 14),
  AppModel('Control fallacy', '', value: 15),
  AppModel('Blaming', '', value: 16),
];

List<AppModel> observeList = <AppModel>[
  AppModel('1 (Feeling wonderful)', '', value: 0),
  AppModel('2', '', value: 1),
  AppModel('3', '', value: 2),
  AppModel('4', '', value: 3),
  AppModel('5', '', value: 4),
  AppModel('6', '', value: 5),
  AppModel('7', '', value: 6),
  AppModel('8', '', value: 7),
  AppModel('9', '', value: 8),
  AppModel('10 (Feeling very stressed out/ overwhelmed)', '', value: 9),
];

List<AppModel> emotionList = <AppModel>[
  AppModel('1 (Barely feel the emotion at all)', '', value: 0),
  AppModel('2', '', value: 1),
  AppModel('3', '', value: 2),
  AppModel('4', '', value: 3),
  AppModel('5', '', value: 4),
  AppModel('6', '', value: 5),
  AppModel('7', '', value: 6),
  AppModel('8', '', value: 7),
  AppModel('9', '', value: 8),
  AppModel('10 (Feeling the emotion very strongly)', ' ', value: 9),
];

List<AppModel> connectionList = <AppModel>[
  //94
  ///0: practice, 1: reading
  AppModel(
    'Connection Intro- Double Your Risk of Early Death by Not Reading This',
    '',
    value: 94,
    type: 1,
    connectedPractice: 95, // CJL0
    // ontap: () => Get.to(() => const ConnectionIntro()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title:
              'Connection Intro- Double Your Risk of Early Death by Not Reading This',
          link:
              'https://docs.google.com/document/d/1scvS_eFJzCwbWoKUkSKGlFtYodhVLn0A/',
          linked: () => Get.to(
            () => const ConnectionJournalLvl0(),
            arguments: [false],
          ),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<ConnectionController>().history.value.value == 94) {
              debugPrint('disposing');
              Get.find<ConnectionController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Connection Journal Level 0- Simply Reach out',
    '',
    value: 95,
    type: 0,
    connectedReading: 94,
    ontap: () =>
        Get.to(() => const ConnectionJournalLvl0(), arguments: [false]),
  ),
  AppModel(
    'C101- Building Meaningful Relationship (Reading)',
    '',
    value: 96,
    type: 1,
    preReading: 94,
    prePractice: 95, // 1 time CJL0
    connectedPractice: 97, // Meaningful relationships/connections
    // ontap: () => Get.to(() => const BuildMeaningfulConnection()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'C101- Building Meaningful Relationship',
          link:
              'https://docs.google.com/document/d/1cFCoktCffSynkSe4UVPe3ALGEPg05uVc/',
          linked: () => Get.to(
            () => const MeaningfulConnection(),
            arguments: [false],
          ),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<ConnectionController>().history.value.value == 96) {
              debugPrint('disposing');
              Get.find<ConnectionController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Meaningful Connections (Practice)',
    '',
    value: 97,
    type: 0,
    preReading: 96,
    connectedReading: 96,
    ontap: () => Get.to(() => const MeaningfulConnection(), arguments: [false]),
  ),
  AppModel(
    'Connection Journal Level 1- Deepen (Practice)',
    '',
    value: 98,
    type: 0,
    prePractice: 97, // 1 time MR
    connectedReading: 96,
    ontap: () =>
        Get.to(() => const ConnectionJournalLvl1(), arguments: [false]),
  ),
  AppModel(
    'C102- Building, Fun, Wealth, and Relationship (Reading)',
    '',
    value: 99,
    type: 1,
    prePractice: 98, // 3 times CJL1
    connectedPractice: 100, // Community
    // ontap: () => Get.to(() => const C102Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'C102- Building, Fun, Wealth, and Relationship',
          link:
              'https://docs.google.com/document/d/1-JSXX4KLABegk8fl-D92TYWM5vKXg-sM/',
          linked: () => Get.to(() => const Community(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<ConnectionController>().history.value.value == 99) {
              debugPrint('disposing');
              Get.find<ConnectionController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Community (Practice)',
    '',
    value: 100,
    type: 0,
    prePractice: 99,
    connectedReading: 99,
    ontap: () => Get.to(() => const Community(), arguments: [false]),
  ),
  AppModel(
    'Connection Journal Level 2- Expand & Deepen',
    '',
    value: 101,
    type: 0,
    prePractice: 100, // 1 time community,
    connectedReading: 99,
    ontap: () =>
        Get.to(() => const ConnectionJournalLvl2(), arguments: [false]),
  ),
];

List<AppModel> gratitudeList = <AppModel>[
  //60
  /// 0: practice, 1: reading
  AppModel(
    'G Intro- Say 2 words and be happier, healthier, and more likeable',
    '',
    value: 60,
    type: 1,
    connectedPractice: 61,
    // ontap: () => Get.to(() => const GIntroReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title:
              'G Intro- Say 2 words and be happier, healthier, and more likeable',
          link:
              'https://docs.google.com/document/d/1prPUmKmlyNpyEz1ISyYVUemwNHK425Qp/',
          linked: () => Get.to(
            () => const BabyGratitudeJournal(),
            arguments: [false],
          ),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<GratitudeController>().history.value.value == 60) {
              debugPrint('disposing');
              Get.find<GratitudeController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Baby Gratitude Journal (Practice)',
    '',
    value: 61,
    type: 0,
    connectedReading: 60,
    ontap: () => Get.to(() => const BabyGratitudeJournal(), arguments: [false]),
  ),
  AppModel(
    'G101- Gratitude Journal (Reading)',
    '',
    value: 62,
    type: 1,
    preReading: 60,
    connectedPractice: 63, // gratitude journal
    // ontap: () => Get.to(() => const G101Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'G101- Gratitude Journal',
          link:
              'https://docs.google.com/document/d/1_GmNRM8xmINp0ml_gB_l9pg2-UlmNEyo/',
          linked: () => Get.to(
            () => const GratitudeJournal1(),
            arguments: [false],
          ),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<GratitudeController>().history.value.value == 62) {
              debugPrint('disposing');
              Get.find<GratitudeController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Gratitude Journal (Practice)',
    '',
    value: 63,
    type: 0,
    preReading: 62,
    connectedReading: 62,
    ontap: () => Get.to(() => const GratitudeJournal1(), arguments: [false]),
  ),
  AppModel(
    'G102- Gratitude Letter (Reading)',
    '',
    value: 64,
    type: 1,
    prePractice: 63, // 3 times gratitude journal
    connectedPractice: 65, // gratitude letter
    // ontap: () => Get.to(() => const GratitudeLetterReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'G102- Gratitude Letter',
          link:
              'https://docs.google.com/document/d/1yI_qm45vOOLx4MW8mGd877Qd2tsLFRBJ/',
          linked: () => Get.to(
            () => const GratitudeLetter(),
            arguments: [false],
          ),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<GratitudeController>().history.value.value == 64) {
              debugPrint('disposing');
              Get.find<GratitudeController>()
                  .updateHistory(end.difference(initial).inSeconds);
              debugPrint('disposed');
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Gratitude Letter (Practice)',
    '',
    value: 65,
    type: 0,
    preReading: 64,
    connectedReading: 64,
    ontap: () => Get.to(() => const GratitudeLetter(), arguments: [false]),
  ),
];

List<AppModel> movementList = <AppModel>[
  // 0: practice,1: reading
  AppModel(
    'Principles of Physical Fitness (Reading)',
    '',
    value: 148,
    type: 1,
    // ontap: () => Get.to(() => const PrincipleofPhysicalFitness()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'Principles of Physical Fitness',
          link:
              'https://docs.google.com/document/d/148VHyAoRuKZ1NxPUVbMdu74YgHOpNNnh/',
          linked: () {},
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<MovementController>().history.value.value == 148) {
              Get.find<MovementController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    '30 second routine creator (Practice)',
    '',
    value: 149,
    type: 0,
    ontap: () => Get.to(() => const MovementAssessment(), arguments: [false]),
  ),
  AppModel(
    'Movement Journal (Reading)',
    '',
    value: 150,
    type: 1,
    prePractice: 149,
    connectedPractice: 151,
    // ontap: () => Get.to(() => const MovementJournalReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'Movement Journal',
          link:
              'https://docs.google.com/document/d/1GuQQW1eHmqkoxk7fRQXIaQn5sKALzJAe/',
          linked: () =>
              Get.to(() => const MovementJournal(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<MovementController>().history.value.value == 150) {
              Get.find<MovementController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Movement Journal (Practice)',
    '',
    value: 151,
    type: 0,
    prePractice: 149,
    connectedReading: 150,
    ontap: () => Get.to(() => const MovementJournal(), arguments: [false]),
  ),
  AppModel(
    'Exercise Library (Reading)',
    '',
    value: 152,
    type: 1,
    preReading: 148,
    // ontap: () => Get.to(() => const ExerciseLibraryREading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'Exercise Library',
          link:
              'https://docs.google.com/document/d/1DM9UZT3hnEA8dBQW8ISyL1MoAO7ZQlhx/',
          linked: () {},
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<MovementController>().history.value.value == 152) {
              Get.find<MovementController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'The four types of physical fitness and how to enhance them (Reading)',
    '',
    value: 153,
    type: 1,
    preReading: 148,
    // ontap: () => Get.to(() => const TypesofPhysicalReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'The four types of physical fitness and how to enhance them',
          link:
              'https://docs.google.com/document/d/1VQdzSXJSCEGooEpvdIqnHb7apx2WovSo/',
          linked: () {},
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<MovementController>().history.value.value == 153) {
              Get.find<MovementController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
];

List<AppModel> calisthenicsType = <AppModel>[
  AppModel('Overall Health', '', value: 0),
  AppModel('Strength', '', value: 1),
  AppModel('Cardio', '', value: 2),
  AppModel('Mobility', '', value: 3),
  AppModel('Custom', '', value: 4),
];

List<AppModel> weightTraings = <AppModel>[
  AppModel('Bodyweight', '', value: 0),
  AppModel('Free weights (Gym Required)', '', value: 1),
  AppModel('Weight machines (Gym Required)', '', value: 2),
];

List<AppModel> intervalTraings = <AppModel>[
  AppModel('HITT (Hight Intensity)', '', value: 0),
  AppModel('Continuous (Medium Intensity)', '', value: 1),
  AppModel('Active Recovery (Low Intensity)', '', value: 2),
];

List<AppModel> dedicatedTimeList = <AppModel>[
  AppModel('Snack (4-10 mins)', '', value: 0, duration: 600),
  AppModel('Quick (10-15 mins)', '', value: 1, duration: 900),
  AppModel('Short (20-30 mins)', '', value: 2, duration: 1800),
  AppModel('Medium (30-45 mins)', '', value: 4, duration: 2700),
  AppModel('Extra (45-60 mins)', '', value: 5, duration: 3600),
  AppModel('Extra+ (~85 mins)', '', value: 6, duration: 5100),
];

List<AppModel> workoutDurationList = <AppModel>[
  // AppModel('Duration', '', value: 0),
  AppModel('secs (seconds)', '', value: 1),
  AppModel('lb\'s (pounds)', '', value: 2),
  AppModel('kg\'s (kilograms)', '', value: 3),
  AppModel('mins (minutes)', '', value: 4),
  // AppModel('Short (20-30 mins)', '', value: 5),
];

List<AppModel> workoutRepsList = <AppModel>[
  AppModel('Reps (repetitions)', '', value: 0),
  AppModel('Miles', '', value: 1),
  AppModel('km\'s (kilometers)', '', value: 2),
  AppModel('Yards', '', value: 3),
  AppModel('Meters', '', value: 4),
];

List<AppModel> restList = <AppModel>[
  AppModel('Rest', '', value: 0),
  AppModel('secs (seconds)', '', value: 1),
];

List<AppModel> movementGoals = <AppModel>[
  AppModel('Improve Overall Health', '', value: 0),
  AppModel('Increase Strength/ Muscle', '', value: 1),
  AppModel('Get Leaner', '', value: 2),
  AppModel('Enhance Cardiovascular Health', 'Cardio', value: 3),
  AppModel('Improve Flexibility/ Mobility', '', value: 4),
];

List<AppModel> resistanceTraining = <AppModel>[
  AppModel('Bodyweight', '', value: 0),
  AppModel('Free weights', '', value: 1),
  AppModel('Weight machines', '', value: 2),
  AppModel('Don\'t know/ No preference', '', value: 3),
];

List<AppModel> cardioTrainingList = <AppModel>[
  AppModel(
    'Shorter workouts at full intensity such as sprinting (HIIT)',
    '',
    value: 0,
  ),
  AppModel(
    'Longer workouts at a medium to low intensity such as jogging (Continuous)',
    '',
    value: 1,
  ),
  AppModel('Don\'t know/ No preference', '', value: 2),
];

List<AppModel> exerciseDaysList = <AppModel>[
  AppModel('1', '', value: 0),
  AppModel('2', '', value: 1),
  AppModel('3', '', value: 2),
  AppModel('4', '', value: 3),
  AppModel('5', '', value: 4),
  AppModel('6', '', value: 5),
  AppModel('7', '', value: 6),
];

List<AppModel> posList = <AppModel>[
  AppModel('1 (Postivity Score)', '1'),
  AppModel('2', '2'),
  AppModel('3', '3'),
  AppModel('4', '4'),
  AppModel('5', '5'),
  AppModel('6', '6'),
  AppModel('7', '7'),
  AppModel('8', '8'),
  AppModel('9', '9'),
  AppModel('10', '10'),
];

List<AppModel> goalscoreList = <AppModel>[
  AppModel('1 (Linked Value & Goal Achievement Score)', '1', value: 1),
  AppModel('2', '2', value: 2),
  AppModel('3', '3', value: 3),
  AppModel('4', '4', value: 4),
  AppModel('5', '5', value: 5),
  AppModel('6', '6', value: 6),
  AppModel('7', '7', value: 7),
  AppModel('8', '8', value: 8),
  AppModel('9', '9', value: 9),
  AppModel('10', '10', value: 10),
];

List<AppModel> coldList = <AppModel>[
  ///0: practice, 1: reading
  AppModel(
    'Cold - Supercharge your Immune System, Resilience to Stress, and Energy (Intro)',
    '',
    value: 134,
    type: 1,
    // ontap: () => Get.to(() => const ColdSuperchargeReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title:
              'Cold - Supercharge your Immune System, Resilience to Stress, and Energy',
          link:
              'https://docs.google.com/document/d/1AkeIS_IbXonuXs4gBdH009GyB1sqHasc/',
          linked: () {},
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<ColdController>().history.value.value == 134) {
              Get.find<ColdController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Freestyle Cold (Practice)',
    '',
    value: 135,
    type: 0,
    ontap: () => Get.to(() => const FreeStyleScreen(), arguments: [false]),
  ),
  AppModel(
    'Guided Cold (Practice)',
    '',
    value: 136,
    type: 0,
    preReading: 134,
    ontap: () => Get.to(() => const GuidedColdScreen(), arguments: [false]),
  ),
  AppModel(
    'C101- Beginner Tips (Reading)',
    '',
    value: 137,
    type: 1,
    preReading: 134,
    // ontap: () => Get.to(() => const BeginnerTips()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'C101- Beginner Tips ',
          link:
              'https://docs.google.com/document/d/1Vjz_UW7cfl90SE7NVS_jNbddBBJiy3S6/',
          linked: () {},
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<ColdController>().history.value.value == 137) {
              Get.find<ColdController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'C102- Advanced Tips (Reading)',
    '',
    value: 138,
    type: 1,
    preReading: 137,
    // ontap: () => Get.to(() => const AdvanceTips()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'C102- Advanced Tips (Reading)',
          link:
              'https://docs.google.com/document/d/1GqgPMg1hPmp6MKoO3AjGN5l0-OtEmO6Y/',
          linked: () {},
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<ColdController>().history.value.value == 138) {
              Get.find<ColdController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
];

List<AppModel> sexualList = <AppModel>[
  ///0: practice, 1: reading
  AppModel(
    'PC99- Why and What? (Reading)',
    '',
    value: 139,
    type: 1,
    // ontap: () => Get.to(() => const PC99Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'PC99- Why and What?',
          link:
              'https://docs.google.com/document/d/1IZLDgamPSi1r5sqMh1wz9CcmlZydKBeX/',
          linked: () {},
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<SexualController>().history.value.value == 139) {
              Get.find<SexualController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'PC Journal Level 0 (Practice)',
    '',
    value: 140,
    type: 0,
    ontap: () => Get.to(() => const PCJournalLvl0(), arguments: [false]),
  ),
  AppModel(
    'PC Journal Level 1 (Practice)',
    '',
    value: 141,
    type: 0,
    preReading: 139,
    prePractice: 140, // 1 time PCJL0
    ontap: () => Get.to(() => const PCJournalLvl1(), arguments: [false]),
  ),
  AppModel(
    'PC100- Intermediate PC Training (Reading)',
    '',
    value: 142,
    type: 1,
    prePractice: 141, // 10 times PCJL1
    // ontap: () => Get.to(() => const PC100Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'PC100- Intermediate PC Training',
          link:
              'https://docs.google.com/document/d/12n8Vz-IVKg5CUpnllcK0eWUjwrco54iK/',
          linked: () {},
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<SexualController>().history.value.value == 142) {
              Get.find<SexualController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
];

List<AppModel> dietList = <AppModel>[
  ///0: practice, 1: reading
  AppModel(
    'Eating Made Simple (Reading)',
    '',
    value: 143,
    type: 1,
    // ontap: () => Get.to(() => const EatingMadeSimpleReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'Eating Made Simple',
          link:
              'https://docs.google.com/document/d/1EBcsIItER6LcAf5qUb6eTo2ZtgSqkAx4/',
          linked: () {},
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<DietController>().history.value.value == 143) {
              Get.find<DietController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Hand Portion Guide (Reading)',
    '',
    value: 144,
    type: 1,
    preReading: 143,
    // ontap: () => Get.to(() => const HandPortionGuideReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'Hand Portion Guide',
          link:
              'https://docs.google.com/document/d/1h4sHSzdMNkD0xTMux4uyo9dMlXhIvqY8/',
          linked: () {},
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<DietController>().history.value.value == 144) {
              Get.find<DietController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Food Journal 1- Simple Eating (Practice)',
    '',
    value: 145,
    type: 0,
    preReading: 144,
    ontap: () => Get.to(() => const FJLvl1(), arguments: [false]),
  ),
  AppModel(
    'Easy Shopping List Level 1 (Practice)',
    '',
    value: 146,
    type: 0,
    preReading: 144,
    ontap: () => Get.to(() => const EasyShoppingList1(), arguments: [false]),
  ),
  // AppModel('Psycho CICO (Reading)', '', value: 147, type: 1),
];

List<AppModel> valueGoalList = <AppModel>[
  //102
  ///0: practice, 1: reading
  AppModel(
    'Go Intro- Purpose = Happiness (Intro)',
    '',
    value: 102,
    type: 1,
    // ontap: () => Get.to(() => const GoIntroReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'Go Intro- Purpose = Happiness',
          link:
              'https://docs.google.com/document/d/1e9uH6lsYKREMfRwsZkzOOpRPtThZJ-vb/',
          linked: () {},
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<GoalsController>().history.value.value == 102) {
              Get.find<GoalsController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Purpose Journal (Reading)',
    '',
    value: 103,
    type: 1,
    connectedPractice: 104,
    // ontap: () => Get.to(() => const PurposeJournalReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'Purpose Journal',
          link:
              'https://docs.google.com/document/d/1d58xMAbmYJwsVbx615GTcs_fEaUL00Ft/',
          linked: () => Get.to(() => const PJL0Screen(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<GoalsController>().history.value.value == 103) {
              Get.find<GoalsController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
          },
        ),
      );
    },
  ),
  AppModel(
    'Purpose Journal Level 0- Explore (Practice)',
    '',
    value: 104,
    type: 0,
    connectedReading: 103, // P98, goals journal reading
    ontap: () => Get.to(() => const PJL0Screen(), arguments: [false]),
  ),
  AppModel(
    'Go 99- Values: Authentic & Aspirational (Reading)',
    '',
    value: 105,
    type: 1,
    connectedPractice: 106,
    // ontap: () => Get.to(() => const Go99Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'Go 99- Values: Authentic & Aspirational',
          link:
              'https://docs.google.com/document/d/12e5cPi3zDsC7O9FJXTdEpCI7ahdtAor2/',
          linked: () => Get.to(() => const ValueScreen(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<GoalsController>().history.value.value == 105) {
              Get.find<GoalsController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Values: Authentic & Aspirational (Practice)',
    '',
    value: 106,
    type: 0,
    preReading: 105,
    connectedReading: 105,
    ontap: () => Get.to(() => const ValueScreen(), arguments: [false]),
  ),
  AppModel(
    'Purpose Journal Level 1- Values (Practice)',
    '',
    value: 107,
    type: 0,
    prePractice: 106, // 1 times Values: Authentic & Aspirational
    connectedReading: 105,
    ontap: () => Get.to(() => const PJL1Screen(), arguments: [false]),
  ),
  AppModel(
    'Go100- Goals Setting and Your Deepest Why\'s (Reading)',
    '',
    value: 108,
    type: 1,
    prePractice: 107, // 1 times PJL1
    connectedPractice: 109, // Goals setting and deepest why
    // ontap: () => Get.to(() => const Go100Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'Go100- Goals Setting and Your Deepest Why\'s ',
          link:
              'https://docs.google.com/document/d/1XBRFh4ahttXdWvy4i6COPqGVtM_mJ8fl/',
          linked: () =>
              Get.to(() => const GoalsSettingScreen(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<GoalsController>().history.value.value == 108) {
              Get.find<GoalsController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Goals Setting and Your Deepest Why\'s (Practice)',
    '',
    value: 109,
    type: 0,
    preReading: 108,
    connectedReading: 108,
    ontap: () => Get.to(() => const GoalsSettingScreen(), arguments: [false]),
  ),
  AppModel(
    'Purpose Journal Level 2- Values, Goals & Deepest Why\'s (Practice)',
    '',
    value: 110,
    type: 0,
    prePractice: 109, // 1 times GSYDW
    connectedReading: 108,
    ontap: () => Get.to(() => const PJL2Screen(), arguments: [false]),
  ),
  AppModel(
    'G0101- Creating a Roadmap & System (Reading)',
    '',
    value: 111,
    type: 1,
    prePractice: 110, // 1 times PJL2
    // ontap: () => Get.to(() => const Go101Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'G0101- Creating a Roadmap & System',
          link:
              'https://docs.google.com/document/d/1qGvSLsdFlhnNaS441cac0YpD2p9rxGEx/',
          linked: () => Get.to(() => const RoadmapScreen(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<GoalsController>().history.value.value == 111) {
              Get.find<GoalsController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Creating a Roadmap & System (Practice)',
    '',
    value: 112,
    type: 0,
    preReading: 111,
    ontap: () => Get.to(() => const RoadmapScreen(), arguments: [false]),
  ),
  AppModel(
    'Purpose Journal Level 3 (Practice)',
    '',
    value: 113,
    type: 0,
    prePractice: 112,
    ontap: () => Get.to(() => const PJL3Screen(), arguments: [false]),
  ),
  AppModel(
    'Go102- Periodic Review (Reading)', '', value: 114, type: 1,
    prePractice: 113, // 1 time PJL3
    // ontap: () => Get.to(() => const G102Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'Go102- Periodic Review ',
          link:
              'https://docs.google.com/document/d/1cusMB7xRJaIbxvW2TlnMgcPaGz9Yivuk/',
          linked: () =>
              Get.to(() => const PeriodicReviewScreen(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<GoalsController>().history.value.value == 114) {
              Get.find<GoalsController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Periodic Review (Practice)',
    '',
    value: 115,
    type: 0,
    preReading: 114,
    prePractice: 113, // 1 time PJL3
    ontap: () => Get.to(() => const PeriodicReviewScreen(), arguments: [false]),
  ),
];

List<AppModel> bdList = <AppModel>[
  ///0: practice, 1: reading
  AppModel(
    'BD101- Habits & Behavioral Design (Reading)',
    '',
    value: 116,
    type: 1,
    connectedPractice: 117,
    // ontap: () => Get.to(() => const Bd101Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'BD101- Habits & Behavioral Design',
          link:
              'https://docs.google.com/document/d/1WKopjoxtn5Bc8KueOEPt0C4xQ02T3zAm/',
          linked: () => Get.to(() => const NudgesScreen(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<BdController>().history.value.value == 116) {
              Get.find<BdController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'BD101a- Nudges (Practice)',
    '',
    value: 117,
    type: 0,
    preReading: 116,
    connectedReading: 116,
    ontap: () => Get.to(() => const NudgesScreen(), arguments: [false]),
  ),
  AppModel(
    'BD101- Habits Builder (Practice)',
    '',
    value: 118,
    type: 0,
    preReading: 116,
    connectedReading: 116,
    ontap: () => Get.to(() => const HabitsBuilder(), arguments: [false]),
  ),
  AppModel(
    'P Intro- Get EVERYTHING done with ZERO',
    '',
    value: 119,
    type: 1,
    // ontap: () => Get.to(() => const PIntroReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'P Intro- Get EVERYTHING done with ZERO',
          link:
              'https://docs.google.com/document/d/1oLnerl0WvTZkT5-LWY4aUXxanirMYQoB/',
          linked: () {},
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<BdController>().history.value.value == 119) {
              Get.find<BdController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'P98- Action Journal (Reading)',
    '',
    value: 120,
    type: 1,
    preReading: 119,
    // ontap: () => Get.to(() => const P98Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'P98- Action Journal',
          link:
              'https://docs.google.com/document/d/10ZPT49HqKUW3A5ziXPA3dr-MoyrqufHC/',
          linked: () {},
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<BdController>().history.value.value == 120) {
              Get.find<BdController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'P99- Brutally Honest (Reading)',
    '',
    value: 121,
    type: 1,
    preReading: 120,
    // ontap: () => Get.to(() => const P99Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'P99- Brutally Honest',
          link:
              'https://docs.google.com/document/d/1SCJaZHqgJIs5CsFwSNDsLEb0E6a46fcV/',
          linked: () =>
              Get.to(() => const ActionJournalLvl0(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<BdController>().history.value.value == 121) {
              Get.find<BdController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Action Journal Level 0- Honest Accounting (Practice)',
    '',
    value: 122,
    type: 0,
    connectedReading: 121,
    ontap: () => Get.to(() => const ActionJournalLvl0(), arguments: [false]),
  ),
  AppModel(
    'Ideal Time Use (Reading)',
    '',
    value: 123,
    type: 1,
    preReading: 121,
    connectedPractice: 124, // Ideal Time Use
    // ontap: () => Get.to(() => const IdealTImeUseReading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'Ideal Time Use',
          link:
              'https://docs.google.com/document/d/1zzGpY1ejo4qzuTphvlhnowj_Kgj7J34t/',
          linked: () =>
              Get.to(() => const IdealTimeScreen(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<BdController>().history.value.value == 123) {
              Get.find<BdController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Ideal Time Use (Practice)',
    '',
    value: 124,
    type: 0,
    preReading: 123,
    connectedReading: 123,
    ontap: () => Get.to(() => const IdealTimeScreen(), arguments: [false]),
  ),
  AppModel(
    'Action Journal Level 1- Tactical Accounting (Practice)',
    '',
    value: 125,
    type: 0,
    prePractice: 124,
    connectedReading: 123,
    ontap: () => Get.to(() => const ActionJournalLvl1(), arguments: [false]),
  ),
  AppModel(
    'P100- Simple TO-DO List (Reading)',
    '',
    value: 126,
    type: 1,
    prePractice: 125,
    ontap: () => Get.to(() => const P100Reading()),
    // ontap: () => Get.to(
    //   () => ReadingScreen(
    //     title:'P100- Simple TO-DO List',
    //     link:
    //         'https://docs.google.com/document/d/1qSPeCrVK-6LFvht0DstdCQ6dwOUJsURl/',
    //     linked:               () =>
    //               Get.to(() => const ActionJournalLvl2(), arguments: [false]),
    //     function: () => {
    //       if (Get.find<BdController>().history.value.value == 126)
    //         {
    //           Get.find<BdController>().updateHistory(end.difference(initial).inSeconds),
    //         },
    //       Get.log('closed'),
    //     },
    //   ),
    // ),
  ),
  AppModel(
    'Action Journal Level 2- Tactical Priorities (Practice)',
    '',
    value: 127,
    type: 0,
    preReading: 126,
    connectedReading: 126,
    ontap: () => Get.to(() => const ActionJournalLvl2(), arguments: [false]),
  ),
  AppModel(
    'P100A- Timeboxing & Time Blocking: Elon Musk\'s Best Friend (Reading)',
    '',
    value: 128,
    type: 1,
    ontap: () => Get.to(() => const P100AReading()),
    // ontap: () => Get.to(
    //   () => ReadingScreen(
    //     title: 'I101- Principles',
    //     link:
    //         'https://docs.google.com/document/d/1qSPeCrVK-6LFvht0DstdCQ6dwOUJsURl/',
    //     linked: () {},
    //     function: () => {
    //       if (Get.find<BdController>().history.value.value == 128) {
    // Get.find<BdController>().updateHistory(end.difference(initial).inSeconds),
    // },
    //       Get.log('closed'),
    //     },
    //   ),
    // ),
  ),
  AppModel(
    'P101- Pomodoro Taking breaks and deep workouts (Reading)',
    '',
    value: 129,
    type: 1,
    prePractice: 127, // AJL2
    // ontap: () => Get.to(() => const P101Reading()),
    ontap: () {
      DateTime initial = DateTime.now();
      print(initial);
      Get.to(
        () => ReadingScreen(
          title: 'P101- Pomodoro Taking breaks and deep workouts',
          link:
              'https://docs.google.com/document/d/1v7Iiq_AHEihJBewr-fP_U_GY7N7hd0Rk/',
          linked: () =>
              Get.to(() => const PomodoroScreen(), arguments: [false]),
          function: () {
            DateTime end = DateTime.now();
            if (Get.find<BdController>().history.value.value == 129) {
              Get.find<BdController>()
                  .updateHistory(end.difference(initial).inSeconds);
            }
            Get.log('closed');
          },
        ),
      );
    },
  ),
  AppModel(
    'Pomodoro Timer (Practice)',
    '',
    value: 130,
    type: 0,
    preReading: 129,
    connectedReading: 129,
    ontap: () => Get.to(() => const PomodoroScreen(), arguments: [false]),
  ),
  AppModel(
    'Action Journal Level 3- Tactical Precision (Practice)',
    '',
    value: 131,
    type: 0,
    preReading: 129,
    connectedReading: 129,
    ontap: () => Get.to(() => const ActionJournalLvl3(), arguments: [false]),
  ),
  AppModel(
    'Tactical Review (Reading)',
    '',
    value: 132,
    type: 1,
    ontap: () => Get.to(() => const TacticalReviewReading()),
    // ontap: () => Get.to(
    //   () => ReadingScreen(
    //     title: 'Tactical Review',
    //     link:
    //         'https://docs.google.com/document/d/1qSPeCrVK-6LFvht0DstdCQ6dwOUJsURl/',
    //     linked: () =>
    //         Get.to(() => const TacticalReviewScreen(), arguments: [false]),
    //     function: () => {
    //       if (Get.find<BdController>().history.value.value == 132)
    //         {
    //           Get.find<BdController>().updateHistory(end.difference(initial).inSeconds),
    //         },
    //       Get.log('closed'),
    //     },
    //   ),
    // ),
  ),
  AppModel(
    'Tactical Review (Practice)',
    '',
    value: 133,
    type: 0,
    ontap: () => Get.to(() => const TacticalReviewScreen(), arguments: [false]),
  ),
];

List<AppModel> guidedColdOptions = <AppModel>[
  AppModel('Cold Shower', '', value: 0),
  AppModel('Cold Bath', '', value: 1),
];

List<AppModel> freeColdOptions = <AppModel>[
  AppModel('Cold Shower', '', value: 0),
  AppModel('Cold Bath', '', value: 1),
  AppModel('Cold Facial', '', value: 2),
  AppModel('Cold Air', '', value: 3),
  AppModel('Hand/ Foot Bath', '', value: 4),
  AppModel('Other', '', value: 5),
];

List<AppModel> foodPortionList = <AppModel>[
  AppModel('Fist', '', value: 0),
  AppModel('Cupped Palm', '', value: 1),
  AppModel('Thumb', '', value: 3),
  AppModel('Pointer Finger', '', value: 4),
];

List<AppModel> weighUnitList = <AppModel>[
  AppModel('lb', '', value: 0),
  AppModel('kg', '', value: 1),
];

List<AppModel> progressingList = <AppModel>[
  AppModel('Weigh yourself', '', value: 0),
  AppModel('Drink 1 gallon of water a day', '', value: 1),
  AppModel('Measure portion size with your hand', '', value: 2),
  AppModel('Eat slowly & mindfully', '', value: 3),
  AppModel('Stop eating when you are 80% full', '', value: 4),
];

List<AppModel> increaseChanceList = <AppModel>[
  AppModel('Find your deepest motivation (Open goals and deepest)', '',
      value: 0),
  AppModel('Bypass willpower (Go to habit builder worksheet)', '', value: 1),
  AppModel('Gain knowledge by reviewing Hand Size Cheatsheet', '', value: 2),
  AppModel('Be more mindful (Go to mindfulness section)', '', value: 3),
  AppModel('Eliminate mental blocks by analyzing your thoughts', '', value: 4),
];

List<ColdExercises> coldexercises = <ColdExercises>[
  ColdExercises(
    id: generateId(),
    name: 'Cold Shower',
    option: 0,
    type: 0,
    level: [
      Elevels(
        level: 1,
        name: '1',
        exercises: [
          Exercises(index: 1, time: 15),
          Exercises(index: 2, time: 19),
          Exercises(index: 3, time: 23),
          Exercises(index: 4, time: 27),
          Exercises(index: 5, time: 31),
        ],
      ),
      Elevels(
        level: 2,
        name: '2 ',
        exercises: [
          Exercises(index: 1, time: 35),
          Exercises(index: 2, time: 39),
          Exercises(index: 3, time: 43),
          Exercises(index: 4, time: 47),
          Exercises(index: 5, time: 51),
        ],
      ),
      Elevels(
        level: 3,
        name: '3',
        exercises: [
          Exercises(index: 1, time: 55),
          Exercises(index: 2, time: 59),
          Exercises(index: 3, time: 63),
          Exercises(index: 4, time: 67),
          Exercises(index: 5, time: 71),
        ],
      ),
      Elevels(
        level: 4,
        name: '4',
        exercises: [
          Exercises(index: 1, time: 75),
          Exercises(index: 2, time: 79),
          Exercises(index: 3, time: 83),
          Exercises(index: 4, time: 87),
          Exercises(index: 5, time: 91),
        ],
      ),
      Elevels(
        level: 5,
        name: '5',
        exercises: [
          Exercises(index: 1, time: 95),
          Exercises(index: 2, time: 90),
          Exercises(index: 3, time: 103),
          Exercises(index: 4, time: 107),
          Exercises(index: 5, time: 111),
        ],
      ),
      Elevels(
        level: 6,
        name: '6',
        exercises: [
          Exercises(index: 1, time: 115),
          Exercises(index: 2, time: 119),
          Exercises(index: 3, time: 123),
          Exercises(index: 4, time: 127),
          Exercises(index: 5, time: 131),
        ],
      ),
      Elevels(
        level: 7,
        name: '7',
        exercises: [
          Exercises(index: 1, time: 135),
          Exercises(index: 2, time: 139),
          Exercises(index: 3, time: 143),
          Exercises(index: 4, time: 147),
          Exercises(index: 5, time: 151),
        ],
      ),
      Elevels(
        level: 8,
        name: '8',
        exercises: [
          Exercises(index: 1, time: 155),
          Exercises(index: 2, time: 159),
          Exercises(index: 3, time: 163),
          Exercises(index: 4, time: 167),
          Exercises(index: 5, time: 171),
        ],
      ),
      Elevels(
        level: 9,
        name: '9',
        exercises: [
          Exercises(index: 1, time: 175),
          Exercises(index: 2, time: 179),
          Exercises(index: 3, time: 183),
          Exercises(index: 4, time: 187),
          Exercises(index: 5, time: 191),
        ],
      ),
      Elevels(
        level: 10,
        name: '10',
        exercises: [
          Exercises(index: 1, time: 195),
          Exercises(index: 2, time: 199),
          Exercises(index: 3, time: 203),
          Exercises(index: 4, time: 207),
          Exercises(index: 5, time: 211),
        ],
      ),
      Elevels(
        level: 11,
        name: '11',
        exercises: [
          Exercises(index: 1, time: 215),
          Exercises(index: 2, time: 219),
          Exercises(index: 3, time: 223),
          Exercises(index: 4, time: 227),
          Exercises(index: 5, time: 231),
        ],
      ),
      Elevels(
        level: 12,
        name: '12',
        exercises: [
          Exercises(index: 1, time: 235),
          Exercises(index: 2, time: 239),
          Exercises(index: 3, time: 243),
          Exercises(index: 4, time: 247),
          Exercises(index: 5, time: 251),
        ],
      ),
      Elevels(
        level: 13,
        name: '13',
        exercises: [
          Exercises(index: 1, time: 255),
          Exercises(index: 2, time: 259),
          Exercises(index: 3, time: 263),
          Exercises(index: 4, time: 267),
          Exercises(index: 5, time: 271),
        ],
      ),
      Elevels(
        level: 14,
        name: '14',
        exercises: [
          Exercises(index: 1, time: 275),
          Exercises(index: 2, time: 279),
          Exercises(index: 3, time: 283),
          Exercises(index: 4, time: 287),
          Exercises(index: 5, time: 291),
        ],
      ),
      Elevels(
        level: 15,
        name: '15',
        exercises: [
          Exercises(index: 1, time: 295),
          Exercises(index: 2, time: 299),
          Exercises(index: 3, time: 303),
          Exercises(index: 4, time: 307),
          Exercises(index: 5, time: 311),
        ],
      ),
      Elevels(
        level: 16,
        name: '16',
        exercises: [
          Exercises(index: 1, time: 315),
          Exercises(index: 2, time: 319),
          Exercises(index: 3, time: 323),
          Exercises(index: 4, time: 327),
          Exercises(index: 5, time: 331),
        ],
      ),
      Elevels(
        level: 17,
        name: '17',
        exercises: [
          Exercises(index: 1, time: 335),
          Exercises(index: 2, time: 339),
          Exercises(index: 3, time: 343),
          Exercises(index: 4, time: 347),
          Exercises(index: 5, time: 351),
        ],
      ),
      Elevels(
        level: 18,
        name: '18',
        exercises: [
          Exercises(index: 1, time: 355),
          Exercises(index: 2, time: 359),
          Exercises(index: 3, time: 363),
          Exercises(index: 4, time: 367),
          Exercises(index: 5, time: 371),
        ],
      ),
      Elevels(
        level: 19,
        name: '19',
        exercises: [
          Exercises(index: 1, time: 375),
          Exercises(index: 2, time: 379),
          Exercises(index: 3, time: 383),
          Exercises(index: 4, time: 387),
          Exercises(index: 5, time: 391),
        ],
      ),
      Elevels(
        level: 20,
        name: '20',
        exercises: [
          Exercises(index: 1, time: 395),
          Exercises(index: 2, time: 399),
          Exercises(index: 3, time: 403),
          Exercises(index: 4, time: 407),
          Exercises(index: 5, time: 411),
        ],
      ),
      Elevels(
        level: 21,
        name: '21',
        exercises: [
          Exercises(index: 1, time: 415),
          Exercises(index: 2, time: 419),
          Exercises(index: 3, time: 423),
          Exercises(index: 4, time: 427),
          Exercises(index: 5, time: 431),
        ],
      ),
      Elevels(
        level: 22,
        name: '22',
        exercises: [
          Exercises(index: 1, time: 435),
          Exercises(index: 2, time: 439),
          Exercises(index: 3, time: 443),
          Exercises(index: 4, time: 447),
          Exercises(index: 5, time: 451),
        ],
      ),
      Elevels(
        level: 23,
        name: '23',
        exercises: [
          Exercises(index: 1, time: 455),
          Exercises(index: 2, time: 459),
          Exercises(index: 3, time: 463),
          Exercises(index: 4, time: 467),
          Exercises(index: 5, time: 471),
        ],
      ),
      Elevels(
        level: 24,
        name: '24',
        exercises: [
          Exercises(index: 1, time: 475),
          Exercises(index: 2, time: 479),
          Exercises(index: 3, time: 483),
          Exercises(index: 4, time: 487),
          Exercises(index: 5, time: 491),
        ],
      ),
      Elevels(
        level: 25,
        name: '25',
        exercises: [
          Exercises(index: 1, time: 495),
          Exercises(index: 2, time: 499),
          Exercises(index: 3, time: 503),
          Exercises(index: 4, time: 507),
          Exercises(index: 5, time: 511),
        ],
      ),
      Elevels(
        level: 26,
        name: '26',
        exercises: [
          Exercises(index: 1, time: 515),
          Exercises(index: 2, time: 519),
          Exercises(index: 3, time: 523),
          Exercises(index: 4, time: 527),
          Exercises(index: 5, time: 531),
        ],
      ),
      Elevels(
        level: 27,
        name: '27',
        exercises: [
          Exercises(index: 1, time: 535),
          Exercises(index: 2, time: 539),
          Exercises(index: 3, time: 543),
          Exercises(index: 4, time: 547),
          Exercises(index: 5, time: 551),
        ],
      ),
      Elevels(
        level: 28,
        name: '28',
        exercises: [
          Exercises(index: 1, time: 555),
          Exercises(index: 2, time: 559),
          Exercises(index: 3, time: 563),
          Exercises(index: 4, time: 567),
          Exercises(index: 5, time: 571),
        ],
      ),
      Elevels(
        level: 29,
        name: '29',
        exercises: [
          Exercises(index: 1, time: 575),
          Exercises(index: 2, time: 579),
          Exercises(index: 3, time: 583),
          Exercises(index: 4, time: 587),
          Exercises(index: 5, time: 591),
        ],
      ),
      Elevels(
        level: 30,
        name: '30',
        exercises: [
          Exercises(index: 1, time: 595),
          Exercises(index: 2, time: 599),
          Exercises(index: 3, time: 603),
          Exercises(index: 4, time: 607),
          Exercises(index: 5, time: 611),
        ],
      ),
    ],
  ),
  ColdExercises(
    id: generateId(),
    name: 'Cold Bath',
    option: 1,
    type: 0,
    level: [
      Elevels(
        level: 1,
        name: '1',
        exercises: [
          Exercises(index: 1, time: 60),
          Exercises(index: 2, time: 66),
          Exercises(index: 3, time: 72),
          Exercises(index: 4, time: 78),
          Exercises(index: 5, time: 84),
        ],
      ),
      Elevels(
        level: 2,
        name: '2 ',
        exercises: [
          Exercises(index: 1, time: 90),
          Exercises(index: 2, time: 96),
          Exercises(index: 3, time: 102),
          Exercises(index: 4, time: 108),
          Exercises(index: 5, time: 114),
        ],
      ),
      Elevels(
        level: 3,
        name: '3',
        exercises: [
          Exercises(index: 1, time: 120),
          Exercises(index: 2, time: 126),
          Exercises(index: 3, time: 132),
          Exercises(index: 4, time: 138),
          Exercises(index: 5, time: 144),
        ],
      ),
      Elevels(
        level: 4,
        name: '4',
        exercises: [
          Exercises(index: 1, time: 150),
          Exercises(index: 2, time: 156),
          Exercises(index: 3, time: 162),
          Exercises(index: 4, time: 168),
          Exercises(index: 5, time: 174),
        ],
      ),
      Elevels(
        level: 5,
        name: '5',
        exercises: [
          Exercises(index: 1, time: 180),
          Exercises(index: 2, time: 186),
          Exercises(index: 3, time: 192),
          Exercises(index: 4, time: 198),
          Exercises(index: 5, time: 204),
        ],
      ),
      Elevels(
        level: 6,
        name: '6',
        exercises: [
          Exercises(index: 1, time: 210),
          Exercises(index: 2, time: 216),
          Exercises(index: 3, time: 222),
          Exercises(index: 4, time: 228),
          Exercises(index: 5, time: 234),
        ],
      ),
      Elevels(
        level: 7,
        name: '7',
        exercises: [
          Exercises(index: 1, time: 240),
          Exercises(index: 2, time: 246),
          Exercises(index: 3, time: 252),
          Exercises(index: 4, time: 258),
          Exercises(index: 5, time: 264),
        ],
      ),
      Elevels(
        level: 8,
        name: '8',
        exercises: [
          Exercises(index: 1, time: 272),
          Exercises(index: 2, time: 278),
          Exercises(index: 3, time: 284),
          Exercises(index: 4, time: 290),
          Exercises(index: 5, time: 296),
        ],
      ),
      Elevels(
        level: 9,
        name: '9',
        exercises: [
          Exercises(index: 1, time: 302),
          Exercises(index: 2, time: 308),
          Exercises(index: 3, time: 314),
          Exercises(index: 4, time: 320),
          Exercises(index: 5, time: 326),
        ],
      ),
      Elevels(
        level: 10,
        name: '10',
        exercises: [
          Exercises(index: 1, time: 332),
          Exercises(index: 2, time: 338),
          Exercises(index: 3, time: 342),
          Exercises(index: 4, time: 350),
          Exercises(index: 5, time: 356),
        ],
      ),
      Elevels(
        level: 11,
        name: '11',
        exercises: [
          Exercises(index: 1, time: 362),
          Exercises(index: 2, time: 368),
          Exercises(index: 3, time: 374),
          Exercises(index: 4, time: 389),
          Exercises(index: 5, time: 386),
        ],
      ),
      Elevels(
        level: 12,
        name: '12',
        exercises: [
          Exercises(index: 1, time: 392),
          Exercises(index: 2, time: 398),
          Exercises(index: 3, time: 404),
          Exercises(index: 4, time: 410),
          Exercises(index: 5, time: 416),
        ],
      ),
      Elevels(
        level: 13,
        name: '13',
        exercises: [
          Exercises(index: 1, time: 422),
          Exercises(index: 2, time: 428),
          Exercises(index: 3, time: 434),
          Exercises(index: 4, time: 440),
          Exercises(index: 5, time: 446),
        ],
      ),
      Elevels(
        level: 14,
        name: '14',
        exercises: [
          Exercises(index: 1, time: 452),
          Exercises(index: 2, time: 458),
          Exercises(index: 3, time: 464),
          Exercises(index: 4, time: 470),
          Exercises(index: 5, time: 472),
        ],
      ),
      Elevels(
        level: 15,
        name: '15',
        exercises: [
          Exercises(index: 1, time: 478),
          Exercises(index: 2, time: 484),
          Exercises(index: 3, time: 490),
          Exercises(index: 4, time: 496),
          Exercises(index: 5, time: 502),
        ],
      ),
      Elevels(
        level: 16,
        name: '16',
        exercises: [
          Exercises(index: 1, time: 508),
          Exercises(index: 2, time: 514),
          Exercises(index: 3, time: 520),
          Exercises(index: 4, time: 526),
          Exercises(index: 5, time: 532),
        ],
      ),
      Elevels(
        level: 17,
        name: '17',
        exercises: [
          Exercises(index: 1, time: 538),
          Exercises(index: 2, time: 544),
          Exercises(index: 3, time: 550),
          Exercises(index: 4, time: 556),
          Exercises(index: 5, time: 562),
        ],
      ),
      Elevels(
        level: 18,
        name: '18',
        exercises: [
          Exercises(index: 1, time: 568),
          Exercises(index: 2, time: 574),
          Exercises(index: 3, time: 580),
          Exercises(index: 4, time: 586),
          Exercises(index: 5, time: 592),
        ],
      ),
      Elevels(
        level: 19,
        name: '19',
        exercises: [
          Exercises(index: 1, time: 598),
          Exercises(index: 2, time: 604),
          Exercises(index: 3, time: 610),
          Exercises(index: 4, time: 616),
          Exercises(index: 5, time: 622),
        ],
      ),
      Elevels(
        level: 20,
        name: '20',
        exercises: [
          Exercises(index: 1, time: 628),
          Exercises(index: 2, time: 634),
          Exercises(index: 3, time: 640),
          Exercises(index: 4, time: 646),
          Exercises(index: 5, time: 652),
        ],
      ),
      Elevels(
        level: 21,
        name: '21',
        exercises: [
          Exercises(index: 1, time: 658),
          Exercises(index: 2, time: 664),
          Exercises(index: 3, time: 670),
          Exercises(index: 4, time: 676),
          Exercises(index: 5, time: 682),
        ],
      ),
      Elevels(
        level: 22,
        name: '22',
        exercises: [
          Exercises(index: 1, time: 688),
          Exercises(index: 2, time: 694),
          Exercises(index: 3, time: 700),
          Exercises(index: 4, time: 706),
          Exercises(index: 5, time: 712),
        ],
      ),
      Elevels(
        level: 23,
        name: '23',
        exercises: [
          Exercises(index: 1, time: 718),
          Exercises(index: 2, time: 724),
          Exercises(index: 3, time: 730),
          Exercises(index: 4, time: 736),
          Exercises(index: 5, time: 742),
        ],
      ),
      Elevels(
        level: 24,
        name: '24',
        exercises: [
          Exercises(index: 1, time: 748),
          Exercises(index: 2, time: 754),
          Exercises(index: 3, time: 760),
          Exercises(index: 4, time: 766),
          Exercises(index: 5, time: 772),
        ],
      ),
      Elevels(
        level: 25,
        name: '25',
        exercises: [
          Exercises(index: 1, time: 778),
          Exercises(index: 2, time: 784),
          Exercises(index: 3, time: 790),
          Exercises(index: 4, time: 796),
          Exercises(index: 5, time: 802),
        ],
      ),
      Elevels(
        level: 26,
        name: '26',
        exercises: [
          Exercises(index: 1, time: 808),
          Exercises(index: 2, time: 814),
          Exercises(index: 3, time: 820),
          Exercises(index: 4, time: 826),
          Exercises(index: 5, time: 832),
        ],
      ),
      Elevels(
        level: 27,
        name: '27',
        exercises: [
          Exercises(index: 1, time: 838),
          Exercises(index: 2, time: 844),
          Exercises(index: 3, time: 850),
          Exercises(index: 4, time: 856),
          Exercises(index: 5, time: 862),
        ],
      ),
      Elevels(
        level: 28,
        name: '28',
        exercises: [
          Exercises(index: 1, time: 868),
          Exercises(index: 2, time: 874),
          Exercises(index: 3, time: 890),
          Exercises(index: 4, time: 896),
          Exercises(index: 5, time: 902),
        ],
      ),
      Elevels(
        level: 29,
        name: '29',
        exercises: [
          Exercises(index: 1, time: 908),
          Exercises(index: 2, time: 914),
          Exercises(index: 3, time: 920),
          Exercises(index: 4, time: 926),
          Exercises(index: 5, time: 932),
        ],
      ),
      Elevels(
        level: 30,
        name: '30',
        exercises: [
          Exercises(index: 1, time: 938),
          Exercises(index: 2, time: 944),
          Exercises(index: 3, time: 950),
          Exercises(index: 4, time: 956),
          Exercises(index: 5, time: 962),
        ],
      ),
    ],
  ),
];

List<TrainersModel> trainerList = <TrainersModel>[
  TrainersModel(
    id: generateId(),
    type: 1,
    levels: <TLevels>[
      TLevels(
        level: 1,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 4),
              ETSets(eset: 2, exercise: 3, rest: 4),
              ETSets(eset: 3, exercise: 3, rest: 4),
              ETSets(eset: 4, exercise: 3, rest: 4),
              ETSets(eset: 5, exercise: 3, rest: 4),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 4),
              ETSets(eset: 2, exercise: 3, rest: 4),
              ETSets(eset: 3, exercise: 3, rest: 4),
              ETSets(eset: 4, exercise: 3, rest: 4),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 4),
              ETSets(eset: 2, exercise: 3, rest: 4),
              ETSets(eset: 3, exercise: 3, rest: 4),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 4),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 4),
              ETSets(eset: 2, exercise: 3, rest: 4),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 3, rest: 4),
              ETSets(eset: 7, exercise: 3, rest: 4),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 4),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 3, rest: 4),
              ETSets(eset: 6, exercise: 3, rest: 4),
              ETSets(eset: 7, exercise: 3, rest: 4),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 3, rest: 4),
              ETSets(eset: 5, exercise: 3, rest: 4),
              ETSets(eset: 6, exercise: 3, rest: 4),
              ETSets(eset: 7, exercise: 3, rest: 4),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 4),
              ETSets(eset: 2, exercise: 3, rest: 4),
              ETSets(eset: 3, exercise: 3, rest: 4),
              ETSets(eset: 4, exercise: 3, rest: 4),
              ETSets(eset: 5, exercise: 3, rest: 4),
              ETSets(eset: 6, exercise: 3, rest: 4),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 2,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 3),
              ETSets(eset: 2, exercise: 3, rest: 3),
              ETSets(eset: 3, exercise: 3, rest: 4),
              ETSets(eset: 4, exercise: 3, rest: 4),
              ETSets(eset: 5, exercise: 3, rest: 4),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 3),
              ETSets(eset: 2, exercise: 3, rest: 3),
              ETSets(eset: 3, exercise: 3, rest: 4),
              ETSets(eset: 4, exercise: 3, rest: 4),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 3),
              ETSets(eset: 2, exercise: 3, rest: 3),
              ETSets(eset: 3, exercise: 3, rest: 4),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 4),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 3),
              ETSets(eset: 2, exercise: 3, rest: 3),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 3, rest: 4),
              ETSets(eset: 7, exercise: 3, rest: 4),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 3),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 3, rest: 4),
              ETSets(eset: 6, exercise: 3, rest: 4),
              ETSets(eset: 7, exercise: 3, rest: 4),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 3, rest: 4),
              ETSets(eset: 5, exercise: 3, rest: 4),
              ETSets(eset: 6, exercise: 3, rest: 4),
              ETSets(eset: 7, exercise: 3, rest: 4),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 3),
              ETSets(eset: 2, exercise: 3, rest: 3),
              ETSets(eset: 3, exercise: 3, rest: 4),
              ETSets(eset: 4, exercise: 3, rest: 3),
              ETSets(eset: 5, exercise: 3, rest: 4),
              ETSets(eset: 6, exercise: 3, rest: 4),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 3,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 3),
              ETSets(eset: 2, exercise: 3, rest: 3),
              ETSets(eset: 3, exercise: 3, rest: 3),
              ETSets(eset: 4, exercise: 3, rest: 3),
              ETSets(eset: 5, exercise: 3, rest: 4),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 3),
              ETSets(eset: 2, exercise: 3, rest: 3),
              ETSets(eset: 3, exercise: 3, rest: 3),
              ETSets(eset: 4, exercise: 3, rest: 3),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 3),
              ETSets(eset: 2, exercise: 3, rest: 3),
              ETSets(eset: 3, exercise: 3, rest: 3),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 4),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 3),
              ETSets(eset: 2, exercise: 3, rest: 3),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 3, rest: 4),
              ETSets(eset: 7, exercise: 3, rest: 4),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 3),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 3, rest: 4),
              ETSets(eset: 6, exercise: 3, rest: 4),
              ETSets(eset: 7, exercise: 3, rest: 4),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 3, rest: 3),
              ETSets(eset: 5, exercise: 3, rest: 4),
              ETSets(eset: 6, exercise: 3, rest: 4),
              ETSets(eset: 7, exercise: 3, rest: 4),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 3),
              ETSets(eset: 2, exercise: 3, rest: 3),
              ETSets(eset: 3, exercise: 3, rest: 3),
              ETSets(eset: 4, exercise: 3, rest: 3),
              ETSets(eset: 5, exercise: 3, rest: 4),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 4,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 3),
              ETSets(eset: 2, exercise: 3, rest: 3),
              ETSets(eset: 3, exercise: 3, rest: 3),
              ETSets(eset: 4, exercise: 3, rest: 3),
              ETSets(eset: 5, exercise: 3, rest: 3),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 3),
              ETSets(eset: 2, exercise: 3, rest: 3),
              ETSets(eset: 3, exercise: 3, rest: 3),
              ETSets(eset: 4, exercise: 3, rest: 3),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 3),
              ETSets(eset: 2, exercise: 3, rest: 3),
              ETSets(eset: 3, exercise: 3, rest: 3),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 4),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 3),
              ETSets(eset: 2, exercise: 3, rest: 3),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 3, rest: 4),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 3),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 3, rest: 3),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 3, rest: 3),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 3, rest: 3),
              ETSets(eset: 5, exercise: 3, rest: 3),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 3, rest: 3),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 3, rest: 3),
              ETSets(eset: 2, exercise: 3, rest: 3),
              ETSets(eset: 3, exercise: 3, rest: 3),
              ETSets(eset: 4, exercise: 3, rest: 3),
              ETSets(eset: 5, exercise: 3, rest: 3),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 5,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 4),
              ETSets(eset: 2, exercise: 4, rest: 4),
              ETSets(eset: 3, exercise: 4, rest: 4),
              ETSets(eset: 4, exercise: 4, rest: 4),
              ETSets(eset: 5, exercise: 4, rest: 4),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 4),
              ETSets(eset: 2, exercise: 4, rest: 4),
              ETSets(eset: 3, exercise: 4, rest: 4),
              ETSets(eset: 4, exercise: 4, rest: 4),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 4),
              ETSets(eset: 2, exercise: 4, rest: 4),
              ETSets(eset: 3, exercise: 4, rest: 4),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 4),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 4),
              ETSets(eset: 2, exercise: 4, rest: 4),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 4, rest: 4),
              ETSets(eset: 7, exercise: 4, rest: 4),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 4),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 4, rest: 4),
              ETSets(eset: 6, exercise: 4, rest: 4),
              ETSets(eset: 7, exercise: 4, rest: 4),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 4, rest: 4),
              ETSets(eset: 5, exercise: 4, rest: 4),
              ETSets(eset: 6, exercise: 4, rest: 4),
              ETSets(eset: 7, exercise: 4, rest: 4),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 4),
              ETSets(eset: 2, exercise: 4, rest: 4),
              ETSets(eset: 3, exercise: 4, rest: 4),
              ETSets(eset: 4, exercise: 4, rest: 4),
              ETSets(eset: 5, exercise: 4, rest: 4),
              ETSets(eset: 6, exercise: 4, rest: 4),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 6,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 3),
              ETSets(eset: 2, exercise: 4, rest: 3),
              ETSets(eset: 3, exercise: 4, rest: 4),
              ETSets(eset: 4, exercise: 4, rest: 4),
              ETSets(eset: 5, exercise: 4, rest: 4),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 3),
              ETSets(eset: 2, exercise: 4, rest: 3),
              ETSets(eset: 3, exercise: 4, rest: 4),
              ETSets(eset: 4, exercise: 4, rest: 4),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 4),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 3),
              ETSets(eset: 2, exercise: 4, rest: 3),
              ETSets(eset: 3, exercise: 4, rest: 4),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 4),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 3),
              ETSets(eset: 2, exercise: 4, rest: 3),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 4, rest: 4),
              ETSets(eset: 7, exercise: 4, rest: 4),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 3),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 4, rest: 4),
              ETSets(eset: 6, exercise: 4, rest: 4),
              ETSets(eset: 7, exercise: 4, rest: 4),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 4, rest: 4),
              ETSets(eset: 5, exercise: 4, rest: 4),
              ETSets(eset: 6, exercise: 4, rest: 4),
              ETSets(eset: 7, exercise: 4, rest: 4),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 3),
              ETSets(eset: 2, exercise: 4, rest: 3),
              ETSets(eset: 3, exercise: 4, rest: 4),
              ETSets(eset: 4, exercise: 4, rest: 4),
              ETSets(eset: 5, exercise: 4, rest: 4),
              ETSets(eset: 6, exercise: 4, rest: 4),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 7,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 3),
              ETSets(eset: 2, exercise: 4, rest: 3),
              ETSets(eset: 3, exercise: 4, rest: 3),
              ETSets(eset: 4, exercise: 4, rest: 3),
              ETSets(eset: 5, exercise: 4, rest: 4),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 3),
              ETSets(eset: 2, exercise: 4, rest: 3),
              ETSets(eset: 3, exercise: 4, rest: 3),
              ETSets(eset: 4, exercise: 4, rest: 3),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 3),
              ETSets(eset: 2, exercise: 4, rest: 3),
              ETSets(eset: 3, exercise: 4, rest: 3),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 4),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 3),
              ETSets(eset: 2, exercise: 4, rest: 3),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 4, rest: 4),
              ETSets(eset: 7, exercise: 4, rest: 4),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 3),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 4, rest: 4),
              ETSets(eset: 6, exercise: 4, rest: 4),
              ETSets(eset: 7, exercise: 4, rest: 4),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 4, rest: 3),
              ETSets(eset: 5, exercise: 4, rest: 4),
              ETSets(eset: 6, exercise: 4, rest: 4),
              ETSets(eset: 7, exercise: 4, rest: 4),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 3),
              ETSets(eset: 2, exercise: 4, rest: 3),
              ETSets(eset: 3, exercise: 4, rest: 3),
              ETSets(eset: 4, exercise: 4, rest: 3),
              ETSets(eset: 5, exercise: 4, rest: 3),
              ETSets(eset: 6, exercise: 4, rest: 4),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 8,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 3),
              ETSets(eset: 2, exercise: 4, rest: 3),
              ETSets(eset: 3, exercise: 4, rest: 3),
              ETSets(eset: 4, exercise: 4, rest: 3),
              ETSets(eset: 5, exercise: 4, rest: 3),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 3),
              ETSets(eset: 2, exercise: 4, rest: 3),
              ETSets(eset: 3, exercise: 4, rest: 3),
              ETSets(eset: 4, exercise: 4, rest: 3),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 3),
              ETSets(eset: 2, exercise: 4, rest: 3),
              ETSets(eset: 3, exercise: 4, rest: 3),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 4),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 3),
              ETSets(eset: 2, exercise: 4, rest: 3),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 4, rest: 3),
              ETSets(eset: 7, exercise: 4, rest: 4),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 3),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 4, rest: 3),
              ETSets(eset: 6, exercise: 4, rest: 3),
              ETSets(eset: 7, exercise: 4, rest: 3),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 4, rest: 3),
              ETSets(eset: 5, exercise: 4, rest: 3),
              ETSets(eset: 6, exercise: 4, rest: 3),
              ETSets(eset: 7, exercise: 4, rest: 3),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 4, rest: 3),
              ETSets(eset: 2, exercise: 4, rest: 3),
              ETSets(eset: 3, exercise: 4, rest: 3),
              ETSets(eset: 4, exercise: 4, rest: 3),
              ETSets(eset: 5, exercise: 4, rest: 3),
              ETSets(eset: 6, exercise: 4, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 9,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 5),
              ETSets(eset: 2, exercise: 5, rest: 5),
              ETSets(eset: 3, exercise: 5, rest: 5),
              ETSets(eset: 4, exercise: 5, rest: 5),
              ETSets(eset: 5, exercise: 5, rest: 5),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 5),
              ETSets(eset: 2, exercise: 5, rest: 5),
              ETSets(eset: 3, exercise: 5, rest: 5),
              ETSets(eset: 4, exercise: 5, rest: 5),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 5, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 5),
              ETSets(eset: 2, exercise: 5, rest: 5),
              ETSets(eset: 3, exercise: 5, rest: 5),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 5, rest: 5),
              ETSets(eset: 8, exercise: 5, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 5),
              ETSets(eset: 2, exercise: 5, rest: 5),
              ETSets(eset: 3, exercise: 5, rest: 5),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 5, rest: 5),
              ETSets(eset: 8, exercise: 5, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 5),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 5, rest: 5),
              ETSets(eset: 6, exercise: 5, rest: 5),
              ETSets(eset: 7, exercise: 5, rest: 5),
              ETSets(eset: 8, exercise: 5, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 5, rest: 5),
              ETSets(eset: 5, exercise: 5, rest: 5),
              ETSets(eset: 6, exercise: 5, rest: 5),
              ETSets(eset: 7, exercise: 5, rest: 5),
              ETSets(eset: 8, exercise: 5, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 5),
              ETSets(eset: 2, exercise: 5, rest: 5),
              ETSets(eset: 3, exercise: 5, rest: 5),
              ETSets(eset: 4, exercise: 5, rest: 5),
              ETSets(eset: 5, exercise: 5, rest: 5),
              ETSets(eset: 6, exercise: 5, rest: 5),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 10,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 4),
              ETSets(eset: 2, exercise: 5, rest: 4),
              ETSets(eset: 3, exercise: 5, rest: 5),
              ETSets(eset: 4, exercise: 5, rest: 5),
              ETSets(eset: 5, exercise: 5, rest: 5),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 4),
              ETSets(eset: 2, exercise: 5, rest: 4),
              ETSets(eset: 3, exercise: 5, rest: 5),
              ETSets(eset: 4, exercise: 5, rest: 5),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 5, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 3),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 4),
              ETSets(eset: 2, exercise: 5, rest: 4),
              ETSets(eset: 3, exercise: 5, rest: 5),
              ETSets(eset: 4, exercise: 5, rest: 5),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 5, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 4),
              ETSets(eset: 2, exercise: 5, rest: 4),
              ETSets(eset: 3, exercise: 5, rest: 5),
              ETSets(eset: 4, exercise: 5, rest: 5),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 5, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 4),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 5, rest: 5),
              ETSets(eset: 6, exercise: 5, rest: 5),
              ETSets(eset: 7, exercise: 5, rest: 5),
              ETSets(eset: 8, exercise: 5, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 5, rest: 5),
              ETSets(eset: 5, exercise: 5, rest: 5),
              ETSets(eset: 6, exercise: 5, rest: 5),
              ETSets(eset: 7, exercise: 5, rest: 5),
              ETSets(eset: 8, exercise: 5, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 4),
              ETSets(eset: 2, exercise: 5, rest: 4),
              ETSets(eset: 3, exercise: 5, rest: 5),
              ETSets(eset: 4, exercise: 5, rest: 5),
              ETSets(eset: 5, exercise: 5, rest: 5),
              ETSets(eset: 6, exercise: 5, rest: 5),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 11,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 4),
              ETSets(eset: 2, exercise: 5, rest: 4),
              ETSets(eset: 3, exercise: 5, rest: 4),
              ETSets(eset: 4, exercise: 5, rest: 4),
              ETSets(eset: 5, exercise: 5, rest: 5),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 4),
              ETSets(eset: 2, exercise: 5, rest: 4),
              ETSets(eset: 3, exercise: 5, rest: 4),
              ETSets(eset: 4, exercise: 5, rest: 4),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 5, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 4),
              ETSets(eset: 2, exercise: 5, rest: 4),
              ETSets(eset: 3, exercise: 5, rest: 4),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 5, rest: 5),
              ETSets(eset: 8, exercise: 5, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 4),
              ETSets(eset: 2, exercise: 5, rest: 4),
              ETSets(eset: 3, exercise: 5, rest: 5),
              ETSets(eset: 4, exercise: 5, rest: 5),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 5, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 4),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 5, rest: 5),
              ETSets(eset: 6, exercise: 5, rest: 5),
              ETSets(eset: 7, exercise: 5, rest: 5),
              ETSets(eset: 8, exercise: 5, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 5, rest: 4),
              ETSets(eset: 5, exercise: 5, rest: 5),
              ETSets(eset: 6, exercise: 5, rest: 5),
              ETSets(eset: 7, exercise: 5, rest: 5),
              ETSets(eset: 8, exercise: 5, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 4),
              ETSets(eset: 2, exercise: 5, rest: 4),
              ETSets(eset: 3, exercise: 5, rest: 4),
              ETSets(eset: 4, exercise: 5, rest: 4),
              ETSets(eset: 5, exercise: 5, rest: 5),
              ETSets(eset: 6, exercise: 5, rest: 5),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 12,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 4),
              ETSets(eset: 2, exercise: 5, rest: 4),
              ETSets(eset: 3, exercise: 5, rest: 4),
              ETSets(eset: 4, exercise: 5, rest: 4),
              ETSets(eset: 5, exercise: 5, rest: 4),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 4),
              ETSets(eset: 2, exercise: 5, rest: 4),
              ETSets(eset: 3, exercise: 5, rest: 4),
              ETSets(eset: 4, exercise: 5, rest: 4),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 5, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 4),
              ETSets(eset: 2, exercise: 5, rest: 4),
              ETSets(eset: 3, exercise: 5, rest: 4),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 5, rest: 5),
              ETSets(eset: 8, exercise: 5, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 4),
              ETSets(eset: 2, exercise: 5, rest: 4),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 5, rest: 4),
              ETSets(eset: 7, exercise: 5, rest: 5),
              ETSets(eset: 8, exercise: 5, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 4),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 5, rest: 4),
              ETSets(eset: 6, exercise: 5, rest: 4),
              ETSets(eset: 7, exercise: 5, rest: 4),
              ETSets(eset: 8, exercise: 5, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 5, rest: 4),
              ETSets(eset: 5, exercise: 5, rest: 4),
              ETSets(eset: 6, exercise: 5, rest: 4),
              ETSets(eset: 7, exercise: 5, rest: 4),
              ETSets(eset: 8, exercise: 5, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 5, rest: 4),
              ETSets(eset: 2, exercise: 5, rest: 4),
              ETSets(eset: 3, exercise: 5, rest: 4),
              ETSets(eset: 4, exercise: 5, rest: 4),
              ETSets(eset: 5, exercise: 5, rest: 4),
              ETSets(eset: 6, exercise: 5, rest: 4),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 13,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 5),
              ETSets(eset: 2, exercise: 6, rest: 5),
              ETSets(eset: 3, exercise: 6, rest: 5),
              ETSets(eset: 4, exercise: 6, rest: 5),
              ETSets(eset: 5, exercise: 6, rest: 5),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 5),
              ETSets(eset: 2, exercise: 6, rest: 5),
              ETSets(eset: 3, exercise: 6, rest: 5),
              ETSets(eset: 4, exercise: 6, rest: 5),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 6, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 5),
              ETSets(eset: 2, exercise: 6, rest: 5),
              ETSets(eset: 3, exercise: 6, rest: 5),
              ETSets(eset: 4, exercise: 6, rest: 5),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 6, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 5),
              ETSets(eset: 2, exercise: 6, rest: 5),
              ETSets(eset: 3, exercise: 6, rest: 5),
              ETSets(eset: 4, exercise: 6, rest: 5),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 6, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 5),
              ETSets(eset: 2, exercise: 6, rest: 5),
              ETSets(eset: 3, exercise: 6, rest: 5),
              ETSets(eset: 4, exercise: 6, rest: 5),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 6, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 1, exercise: 6, rest: 5),
              ETSets(eset: 2, exercise: 6, rest: 5),
              ETSets(eset: 3, exercise: 6, rest: 5),
              ETSets(eset: 4, exercise: 6, rest: 5),
              ETSets(eset: 8, exercise: 6, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 5),
              ETSets(eset: 2, exercise: 6, rest: 5),
              ETSets(eset: 3, exercise: 6, rest: 5),
              ETSets(eset: 4, exercise: 6, rest: 5),
              ETSets(eset: 5, exercise: 6, rest: 5),
              ETSets(eset: 6, exercise: 6, rest: 5),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 14,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 4),
              ETSets(eset: 2, exercise: 6, rest: 4),
              ETSets(eset: 3, exercise: 6, rest: 5),
              ETSets(eset: 4, exercise: 6, rest: 5),
              ETSets(eset: 5, exercise: 6, rest: 5),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 4),
              ETSets(eset: 2, exercise: 6, rest: 4),
              ETSets(eset: 3, exercise: 6, rest: 5),
              ETSets(eset: 4, exercise: 6, rest: 5),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 6, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 4),
              ETSets(eset: 2, exercise: 6, rest: 4),
              ETSets(eset: 3, exercise: 6, rest: 5),
              ETSets(eset: 4, exercise: 6, rest: 5),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 6, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 4),
              ETSets(eset: 2, exercise: 6, rest: 4),
              ETSets(eset: 3, exercise: 6, rest: 5),
              ETSets(eset: 4, exercise: 6, rest: 5),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 6, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 4),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 6, rest: 5),
              ETSets(eset: 6, exercise: 6, rest: 5),
              ETSets(eset: 7, exercise: 6, rest: 5),
              ETSets(eset: 8, exercise: 6, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 1, exercise: 6, rest: 5),
              ETSets(eset: 2, exercise: 6, rest: 5),
              ETSets(eset: 3, exercise: 6, rest: 5),
              ETSets(eset: 4, exercise: 6, rest: 5),
              ETSets(eset: 8, exercise: 6, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 4),
              ETSets(eset: 2, exercise: 6, rest: 4),
              ETSets(eset: 3, exercise: 6, rest: 5),
              ETSets(eset: 4, exercise: 6, rest: 5),
              ETSets(eset: 5, exercise: 6, rest: 5),
              ETSets(eset: 6, exercise: 6, rest: 5),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 15,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 4),
              ETSets(eset: 2, exercise: 6, rest: 4),
              ETSets(eset: 3, exercise: 6, rest: 4),
              ETSets(eset: 4, exercise: 6, rest: 4),
              ETSets(eset: 5, exercise: 6, rest: 5),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 4),
              ETSets(eset: 2, exercise: 6, rest: 4),
              ETSets(eset: 3, exercise: 6, rest: 4),
              ETSets(eset: 4, exercise: 6, rest: 4),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 6, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 4),
              ETSets(eset: 2, exercise: 6, rest: 4),
              ETSets(eset: 3, exercise: 6, rest: 4),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 6, rest: 5),
              ETSets(eset: 8, exercise: 6, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 4),
              ETSets(eset: 2, exercise: 6, rest: 4),
              ETSets(eset: 3, exercise: 6, rest: 5),
              ETSets(eset: 4, exercise: 6, rest: 5),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 6, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 4),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 6, rest: 5),
              ETSets(eset: 6, exercise: 6, rest: 5),
              ETSets(eset: 7, exercise: 6, rest: 5),
              ETSets(eset: 8, exercise: 6, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 6, rest: 4),
              ETSets(eset: 5, exercise: 6, rest: 5),
              ETSets(eset: 6, exercise: 6, rest: 5),
              ETSets(eset: 7, exercise: 6, rest: 5),
              ETSets(eset: 8, exercise: 6, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 4),
              ETSets(eset: 2, exercise: 6, rest: 4),
              ETSets(eset: 3, exercise: 6, rest: 4),
              ETSets(eset: 4, exercise: 6, rest: 4),
              ETSets(eset: 5, exercise: 6, rest: 5),
              ETSets(eset: 6, exercise: 6, rest: 5),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 16,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 4),
              ETSets(eset: 2, exercise: 6, rest: 4),
              ETSets(eset: 3, exercise: 6, rest: 4),
              ETSets(eset: 4, exercise: 6, rest: 4),
              ETSets(eset: 5, exercise: 6, rest: 4),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 4),
              ETSets(eset: 2, exercise: 6, rest: 4),
              ETSets(eset: 3, exercise: 6, rest: 4),
              ETSets(eset: 4, exercise: 6, rest: 4),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 6, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 4),
              ETSets(eset: 2, exercise: 6, rest: 4),
              ETSets(eset: 3, exercise: 6, rest: 4),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 6, rest: 5),
              ETSets(eset: 8, exercise: 6, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 4),
              ETSets(eset: 2, exercise: 6, rest: 4),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 6, rest: 4),
              ETSets(eset: 7, exercise: 6, rest: 5),
              ETSets(eset: 8, exercise: 6, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 4),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 6, rest: 4),
              ETSets(eset: 6, exercise: 6, rest: 4),
              ETSets(eset: 7, exercise: 6, rest: 4),
              ETSets(eset: 8, exercise: 6, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 6, rest: 4),
              ETSets(eset: 5, exercise: 6, rest: 4),
              ETSets(eset: 6, exercise: 6, rest: 4),
              ETSets(eset: 7, exercise: 6, rest: 4),
              ETSets(eset: 8, exercise: 6, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 6, rest: 4),
              ETSets(eset: 2, exercise: 6, rest: 4),
              ETSets(eset: 3, exercise: 6, rest: 4),
              ETSets(eset: 4, exercise: 6, rest: 4),
              ETSets(eset: 5, exercise: 6, rest: 4),
              ETSets(eset: 6, exercise: 6, rest: 4),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 17,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 7, rest: 5),
              ETSets(eset: 2, exercise: 7, rest: 5),
              ETSets(eset: 3, exercise: 7, rest: 5),
              ETSets(eset: 4, exercise: 7, rest: 5),
              ETSets(eset: 5, exercise: 7, rest: 5),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 7, rest: 5),
              ETSets(eset: 2, exercise: 7, rest: 5),
              ETSets(eset: 3, exercise: 7, rest: 5),
              ETSets(eset: 4, exercise: 7, rest: 5),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 7, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 7, rest: 5),
              ETSets(eset: 2, exercise: 7, rest: 5),
              ETSets(eset: 3, exercise: 7, rest: 5),
              ETSets(eset: 4, exercise: 7, rest: 5),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 7, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 7, rest: 5),
              ETSets(eset: 2, exercise: 7, rest: 5),
              ETSets(eset: 3, exercise: 7, rest: 5),
              ETSets(eset: 4, exercise: 7, rest: 5),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 7, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 7, rest: 5),
              ETSets(eset: 2, exercise: 7, rest: 5),
              ETSets(eset: 3, exercise: 7, rest: 5),
              ETSets(eset: 4, exercise: 7, rest: 5),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 7, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 7, rest: 5),
              ETSets(eset: 5, exercise: 7, rest: 5),
              ETSets(eset: 6, exercise: 7, rest: 5),
              ETSets(eset: 7, exercise: 7, rest: 5),
              ETSets(eset: 8, exercise: 7, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 7, rest: 5),
              ETSets(eset: 2, exercise: 7, rest: 5),
              ETSets(eset: 3, exercise: 7, rest: 5),
              ETSets(eset: 4, exercise: 7, rest: 5),
              ETSets(eset: 5, exercise: 7, rest: 5),
              ETSets(eset: 6, exercise: 7, rest: 5),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 18,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 8, rest: 6),
              ETSets(eset: 2, exercise: 8, rest: 6),
              ETSets(eset: 3, exercise: 8, rest: 6),
              ETSets(eset: 4, exercise: 8, rest: 6),
              ETSets(eset: 5, exercise: 8, rest: 6),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 8, rest: 6),
              ETSets(eset: 2, exercise: 8, rest: 6),
              ETSets(eset: 3, exercise: 8, rest: 6),
              ETSets(eset: 4, exercise: 8, rest: 6),
              ETSets(eset: 5, exercise: 3, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 8, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 8, rest: 6),
              ETSets(eset: 2, exercise: 8, rest: 6),
              ETSets(eset: 3, exercise: 8, rest: 6),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 8, rest: 6),
              ETSets(eset: 8, exercise: 8, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 8, rest: 6),
              ETSets(eset: 2, exercise: 8, rest: 6),
              ETSets(eset: 3, exercise: 8, rest: 6),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 8, rest: 6),
              ETSets(eset: 8, exercise: 8, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 8, rest: 6),
              ETSets(eset: 2, exercise: 8, rest: 6),
              ETSets(eset: 3, exercise: 8, rest: 6),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 8, rest: 6),
              ETSets(eset: 8, exercise: 8, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 8, rest: 6),
              ETSets(eset: 5, exercise: 8, rest: 6),
              ETSets(eset: 6, exercise: 8, rest: 6),
              ETSets(eset: 7, exercise: 8, rest: 6),
              ETSets(eset: 8, exercise: 8, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 8, rest: 6),
              ETSets(eset: 2, exercise: 8, rest: 6),
              ETSets(eset: 3, exercise: 8, rest: 6),
              ETSets(eset: 4, exercise: 8, rest: 6),
              ETSets(eset: 5, exercise: 8, rest: 6),
              ETSets(eset: 6, exercise: 8, rest: 6),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 19,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 8, rest: 6),
              ETSets(eset: 2, exercise: 8, rest: 6),
              ETSets(eset: 3, exercise: 8, rest: 5),
              ETSets(eset: 4, exercise: 8, rest: 5),
              ETSets(eset: 5, exercise: 8, rest: 6),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 8, rest: 6),
              ETSets(eset: 2, exercise: 8, rest: 6),
              ETSets(eset: 3, exercise: 8, rest: 5),
              ETSets(eset: 4, exercise: 8, rest: 5),
              ETSets(eset: 5, exercise: 3, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 8, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 8, rest: 6),
              ETSets(eset: 2, exercise: 8, rest: 6),
              ETSets(eset: 3, exercise: 8, rest: 5),
              ETSets(eset: 4, exercise: 8, rest: 5),
              ETSets(eset: 5, exercise: 3, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 8, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 8, rest: 6),
              ETSets(eset: 2, exercise: 8, rest: 6),
              ETSets(eset: 3, exercise: 8, rest: 6),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 8, rest: 6),
              ETSets(eset: 8, exercise: 8, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 8, rest: 6),
              ETSets(eset: 2, exercise: 8, rest: 6),
              ETSets(eset: 3, exercise: 8, rest: 6),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 8, rest: 6),
              ETSets(eset: 8, exercise: 8, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 8, rest: 5),
              ETSets(eset: 5, exercise: 8, rest: 6),
              ETSets(eset: 6, exercise: 8, rest: 6),
              ETSets(eset: 7, exercise: 8, rest: 6),
              ETSets(eset: 8, exercise: 8, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 8, rest: 6),
              ETSets(eset: 2, exercise: 8, rest: 6),
              ETSets(eset: 3, exercise: 8, rest: 6),
              ETSets(eset: 4, exercise: 8, rest: 6),
              ETSets(eset: 5, exercise: 8, rest: 5),
              ETSets(eset: 6, exercise: 8, rest: 6),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 20,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 8, rest: 6),
              ETSets(eset: 2, exercise: 8, rest: 6),
              ETSets(eset: 3, exercise: 8, rest: 5),
              ETSets(eset: 4, exercise: 8, rest: 5),
              ETSets(eset: 5, exercise: 8, rest: 5),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 8, rest: 6),
              ETSets(eset: 2, exercise: 8, rest: 6),
              ETSets(eset: 3, exercise: 8, rest: 5),
              ETSets(eset: 4, exercise: 8, rest: 5),
              ETSets(eset: 5, exercise: 3, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 8, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 8, rest: 6),
              ETSets(eset: 2, exercise: 8, rest: 6),
              ETSets(eset: 3, exercise: 8, rest: 5),
              ETSets(eset: 4, exercise: 8, rest: 5),
              ETSets(eset: 5, exercise: 3, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 8, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 8, rest: 6),
              ETSets(eset: 2, exercise: 8, rest: 6),
              ETSets(eset: 3, exercise: 8, rest: 5),
              ETSets(eset: 4, exercise: 8, rest: 5),
              ETSets(eset: 5, exercise: 3, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 8, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 8, rest: 6),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 8, rest: 5),
              ETSets(eset: 6, exercise: 8, rest: 5),
              ETSets(eset: 7, exercise: 8, rest: 5),
              ETSets(eset: 8, exercise: 8, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 8, rest: 5),
              ETSets(eset: 5, exercise: 8, rest: 5),
              ETSets(eset: 6, exercise: 8, rest: 5),
              ETSets(eset: 7, exercise: 8, rest: 5),
              ETSets(eset: 8, exercise: 8, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 8, rest: 6),
              ETSets(eset: 2, exercise: 8, rest: 6),
              ETSets(eset: 3, exercise: 8, rest: 5),
              ETSets(eset: 4, exercise: 8, rest: 5),
              ETSets(eset: 5, exercise: 8, rest: 5),
              ETSets(eset: 6, exercise: 8, rest: 5),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 21,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 9, rest: 8),
              ETSets(eset: 2, exercise: 9, rest: 8),
              ETSets(eset: 3, exercise: 9, rest: 7),
              ETSets(eset: 4, exercise: 9, rest: 7),
              ETSets(eset: 5, exercise: 9, rest: 7),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 9, rest: 8),
              ETSets(eset: 2, exercise: 9, rest: 8),
              ETSets(eset: 3, exercise: 9, rest: 7),
              ETSets(eset: 4, exercise: 9, rest: 7),
              ETSets(eset: 5, exercise: 3, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 9, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 9, rest: 8),
              ETSets(eset: 2, exercise: 9, rest: 8),
              ETSets(eset: 3, exercise: 9, rest: 7),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 9, rest: 7),
              ETSets(eset: 8, exercise: 9, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 9, rest: 8),
              ETSets(eset: 2, exercise: 9, rest: 8),
              ETSets(eset: 3, exercise: 9, rest: 7),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 9, rest: 7),
              ETSets(eset: 8, exercise: 9, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 9, rest: 8),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 9, rest: 7),
              ETSets(eset: 6, exercise: 9, rest: 7),
              ETSets(eset: 7, exercise: 9, rest: 7),
              ETSets(eset: 8, exercise: 9, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 9, rest: 7),
              ETSets(eset: 5, exercise: 9, rest: 7),
              ETSets(eset: 6, exercise: 9, rest: 7),
              ETSets(eset: 7, exercise: 9, rest: 7),
              ETSets(eset: 8, exercise: 9, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 9, rest: 8),
              ETSets(eset: 2, exercise: 9, rest: 8),
              ETSets(eset: 3, exercise: 9, rest: 7),
              ETSets(eset: 4, exercise: 9, rest: 7),
              ETSets(eset: 5, exercise: 9, rest: 7),
              ETSets(eset: 6, exercise: 9, rest: 7),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 22,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 10, rest: 10),
              ETSets(eset: 2, exercise: 10, rest: 10),
              ETSets(eset: 3, exercise: 10, rest: 9),
              ETSets(eset: 4, exercise: 10, rest: 9),
              ETSets(eset: 5, exercise: 10, rest: 9),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 10, rest: 10),
              ETSets(eset: 2, exercise: 10, rest: 10),
              ETSets(eset: 3, exercise: 10, rest: 9),
              ETSets(eset: 4, exercise: 10, rest: 9),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 10, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 10, rest: 10),
              ETSets(eset: 2, exercise: 10, rest: 10),
              ETSets(eset: 3, exercise: 10, rest: 9),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 10, rest: 9),
              ETSets(eset: 8, exercise: 10, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 10, rest: 10),
              ETSets(eset: 2, exercise: 10, rest: 10),
              ETSets(eset: 3, exercise: 10, rest: 9),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 10, rest: 9),
              ETSets(eset: 8, exercise: 10, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 10, rest: 10),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 10, rest: 9),
              ETSets(eset: 6, exercise: 10, rest: 9),
              ETSets(eset: 7, exercise: 10, rest: 9),
              ETSets(eset: 8, exercise: 10, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 10, rest: 9),
              ETSets(eset: 5, exercise: 10, rest: 9),
              ETSets(eset: 6, exercise: 10, rest: 9),
              ETSets(eset: 7, exercise: 10, rest: 9),
              ETSets(eset: 8, exercise: 10, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 10, rest: 10),
              ETSets(eset: 2, exercise: 10, rest: 10),
              ETSets(eset: 3, exercise: 10, rest: 9),
              ETSets(eset: 4, exercise: 10, rest: 9),
              ETSets(eset: 5, exercise: 10, rest: 9),
              ETSets(eset: 6, exercise: 10, rest: 9),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 23,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 10, rest: 10),
              ETSets(eset: 2, exercise: 10, rest: 10),
              ETSets(eset: 3, exercise: 10, rest: 8),
              ETSets(eset: 4, exercise: 10, rest: 8),
              ETSets(eset: 5, exercise: 10, rest: 9),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 10, rest: 10),
              ETSets(eset: 2, exercise: 10, rest: 10),
              ETSets(eset: 3, exercise: 10, rest: 8),
              ETSets(eset: 4, exercise: 10, rest: 8),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 10, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 10, rest: 10),
              ETSets(eset: 2, exercise: 10, rest: 10),
              ETSets(eset: 3, exercise: 10, rest: 8),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 10, rest: 9),
              ETSets(eset: 8, exercise: 10, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 10, rest: 10),
              ETSets(eset: 2, exercise: 10, rest: 10),
              ETSets(eset: 3, exercise: 10, rest: 9),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 10, rest: 9),
              ETSets(eset: 8, exercise: 10, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 10, rest: 10),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 10, rest: 9),
              ETSets(eset: 6, exercise: 10, rest: 9),
              ETSets(eset: 7, exercise: 10, rest: 9),
              ETSets(eset: 8, exercise: 10, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 10, rest: 8),
              ETSets(eset: 5, exercise: 10, rest: 9),
              ETSets(eset: 6, exercise: 10, rest: 9),
              ETSets(eset: 7, exercise: 10, rest: 9),
              ETSets(eset: 8, exercise: 10, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 10, rest: 10),
              ETSets(eset: 2, exercise: 10, rest: 10),
              ETSets(eset: 3, exercise: 10, rest: 8),
              ETSets(eset: 4, exercise: 10, rest: 8),
              ETSets(eset: 5, exercise: 10, rest: 9),
              ETSets(eset: 6, exercise: 10, rest: 9),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 24,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 10, rest: 10),
              ETSets(eset: 2, exercise: 10, rest: 10),
              ETSets(eset: 3, exercise: 10, rest: 8),
              ETSets(eset: 4, exercise: 10, rest: 8),
              ETSets(eset: 5, exercise: 10, rest: 8),
              ETSets(eset: 6, exercise: 3, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 10, rest: 10),
              ETSets(eset: 2, exercise: 10, rest: 10),
              ETSets(eset: 3, exercise: 10, rest: 8),
              ETSets(eset: 4, exercise: 10, rest: 8),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 10, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 10, rest: 10),
              ETSets(eset: 2, exercise: 10, rest: 10),
              ETSets(eset: 3, exercise: 10, rest: 8),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 10, rest: 9),
              ETSets(eset: 8, exercise: 10, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 10, rest: 10),
              ETSets(eset: 2, exercise: 10, rest: 10),
              ETSets(eset: 3, exercise: 10, rest: 8),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 10, rest: 9),
              ETSets(eset: 8, exercise: 10, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 10, rest: 10),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 10, rest: 8),
              ETSets(eset: 6, exercise: 10, rest: 8),
              ETSets(eset: 7, exercise: 10, rest: 8),
              ETSets(eset: 8, exercise: 10, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 10, rest: 8),
              ETSets(eset: 5, exercise: 10, rest: 9),
              ETSets(eset: 6, exercise: 10, rest: 8),
              ETSets(eset: 7, exercise: 10, rest: 8),
              ETSets(eset: 8, exercise: 10, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 10, rest: 10),
              ETSets(eset: 2, exercise: 10, rest: 10),
              ETSets(eset: 3, exercise: 10, rest: 8),
              ETSets(eset: 4, exercise: 10, rest: 8),
              ETSets(eset: 5, exercise: 10, rest: 8),
              ETSets(eset: 6, exercise: 10, rest: 8),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 25,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 11),
              ETSets(eset: 2, exercise: 11, rest: 11),
              ETSets(eset: 3, exercise: 11, rest: 9),
              ETSets(eset: 4, exercise: 11, rest: 9),
              ETSets(eset: 5, exercise: 11, rest: 9),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 11),
              ETSets(eset: 2, exercise: 11, rest: 11),
              ETSets(eset: 3, exercise: 11, rest: 9),
              ETSets(eset: 4, exercise: 11, rest: 9),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 11, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 11),
              ETSets(eset: 2, exercise: 11, rest: 11),
              ETSets(eset: 3, exercise: 11, rest: 9),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 11, rest: 9),
              ETSets(eset: 8, exercise: 11, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 11),
              ETSets(eset: 2, exercise: 11, rest: 11),
              ETSets(eset: 3, exercise: 11, rest: 9),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 11, rest: 9),
              ETSets(eset: 8, exercise: 11, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 11),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 11, rest: 9),
              ETSets(eset: 6, exercise: 11, rest: 9),
              ETSets(eset: 7, exercise: 11, rest: 9),
              ETSets(eset: 8, exercise: 11, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 11, rest: 9),
              ETSets(eset: 5, exercise: 11, rest: 9),
              ETSets(eset: 6, exercise: 11, rest: 9),
              ETSets(eset: 7, exercise: 11, rest: 9),
              ETSets(eset: 8, exercise: 11, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 11),
              ETSets(eset: 2, exercise: 11, rest: 11),
              ETSets(eset: 3, exercise: 11, rest: 9),
              ETSets(eset: 4, exercise: 11, rest: 9),
              ETSets(eset: 5, exercise: 11, rest: 9),
              ETSets(eset: 6, exercise: 11, rest: 9),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 26,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 10),
              ETSets(eset: 2, exercise: 11, rest: 10),
              ETSets(eset: 3, exercise: 11, rest: 9),
              ETSets(eset: 4, exercise: 11, rest: 9),
              ETSets(eset: 5, exercise: 11, rest: 9),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 10),
              ETSets(eset: 2, exercise: 11, rest: 10),
              ETSets(eset: 3, exercise: 11, rest: 9),
              ETSets(eset: 4, exercise: 11, rest: 9),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 11, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 10),
              ETSets(eset: 2, exercise: 11, rest: 10),
              ETSets(eset: 3, exercise: 11, rest: 9),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 11, rest: 9),
              ETSets(eset: 8, exercise: 11, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 10),
              ETSets(eset: 2, exercise: 11, rest: 10),
              ETSets(eset: 3, exercise: 11, rest: 9),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 11, rest: 9),
              ETSets(eset: 8, exercise: 11, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 10),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 11, rest: 9),
              ETSets(eset: 6, exercise: 11, rest: 9),
              ETSets(eset: 7, exercise: 11, rest: 9),
              ETSets(eset: 8, exercise: 11, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 11, rest: 9),
              ETSets(eset: 5, exercise: 11, rest: 9),
              ETSets(eset: 6, exercise: 11, rest: 9),
              ETSets(eset: 7, exercise: 11, rest: 9),
              ETSets(eset: 8, exercise: 11, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 10),
              ETSets(eset: 2, exercise: 11, rest: 10),
              ETSets(eset: 3, exercise: 11, rest: 9),
              ETSets(eset: 4, exercise: 11, rest: 9),
              ETSets(eset: 5, exercise: 11, rest: 9),
              ETSets(eset: 6, exercise: 11, rest: 9),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 27,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 10),
              ETSets(eset: 2, exercise: 11, rest: 10),
              ETSets(eset: 3, exercise: 11, rest: 8),
              ETSets(eset: 4, exercise: 11, rest: 8),
              ETSets(eset: 5, exercise: 11, rest: 9),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 10),
              ETSets(eset: 2, exercise: 11, rest: 10),
              ETSets(eset: 3, exercise: 11, rest: 8),
              ETSets(eset: 4, exercise: 11, rest: 8),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 11, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 10),
              ETSets(eset: 2, exercise: 11, rest: 10),
              ETSets(eset: 3, exercise: 11, rest: 8),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 11, rest: 9),
              ETSets(eset: 8, exercise: 11, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 10),
              ETSets(eset: 2, exercise: 11, rest: 10),
              ETSets(eset: 3, exercise: 11, rest: 9),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 11, rest: 9),
              ETSets(eset: 8, exercise: 11, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 10),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 11, rest: 9),
              ETSets(eset: 6, exercise: 11, rest: 9),
              ETSets(eset: 7, exercise: 11, rest: 9),
              ETSets(eset: 8, exercise: 11, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 11, rest: 8),
              ETSets(eset: 5, exercise: 11, rest: 9),
              ETSets(eset: 6, exercise: 11, rest: 9),
              ETSets(eset: 7, exercise: 11, rest: 9),
              ETSets(eset: 8, exercise: 11, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 10),
              ETSets(eset: 2, exercise: 11, rest: 10),
              ETSets(eset: 3, exercise: 11, rest: 8),
              ETSets(eset: 4, exercise: 11, rest: 8),
              ETSets(eset: 5, exercise: 11, rest: 9),
              ETSets(eset: 6, exercise: 11, rest: 9),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 28,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 10),
              ETSets(eset: 2, exercise: 11, rest: 10),
              ETSets(eset: 3, exercise: 11, rest: 8),
              ETSets(eset: 4, exercise: 11, rest: 8),
              ETSets(eset: 5, exercise: 11, rest: 8),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 10),
              ETSets(eset: 2, exercise: 11, rest: 10),
              ETSets(eset: 3, exercise: 11, rest: 8),
              ETSets(eset: 4, exercise: 11, rest: 8),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 11, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 10),
              ETSets(eset: 2, exercise: 11, rest: 10),
              ETSets(eset: 3, exercise: 11, rest: 8),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 11, rest: 9),
              ETSets(eset: 8, exercise: 11, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 10),
              ETSets(eset: 2, exercise: 11, rest: 10),
              ETSets(eset: 3, exercise: 11, rest: 8),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 11, rest: 9),
              ETSets(eset: 8, exercise: 11, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 10),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 11, rest: 8),
              ETSets(eset: 6, exercise: 11, rest: 8),
              ETSets(eset: 7, exercise: 11, rest: 8),
              ETSets(eset: 8, exercise: 11, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 11, rest: 8),
              ETSets(eset: 5, exercise: 11, rest: 9),
              ETSets(eset: 6, exercise: 11, rest: 8),
              ETSets(eset: 7, exercise: 11, rest: 8),
              ETSets(eset: 8, exercise: 11, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 11, rest: 10),
              ETSets(eset: 2, exercise: 11, rest: 10),
              ETSets(eset: 3, exercise: 11, rest: 8),
              ETSets(eset: 4, exercise: 11, rest: 8),
              ETSets(eset: 5, exercise: 11, rest: 8),
              ETSets(eset: 6, exercise: 11, rest: 8),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 29,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 12, rest: 11),
              ETSets(eset: 2, exercise: 12, rest: 11),
              ETSets(eset: 3, exercise: 12, rest: 9),
              ETSets(eset: 4, exercise: 12, rest: 9),
              ETSets(eset: 5, exercise: 12, rest: 9),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 12, rest: 11),
              ETSets(eset: 2, exercise: 12, rest: 11),
              ETSets(eset: 3, exercise: 12, rest: 9),
              ETSets(eset: 4, exercise: 12, rest: 9),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 12, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 12, rest: 11),
              ETSets(eset: 2, exercise: 12, rest: 11),
              ETSets(eset: 3, exercise: 12, rest: 9),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 12, rest: 9),
              ETSets(eset: 8, exercise: 12, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 12, rest: 11),
              ETSets(eset: 2, exercise: 12, rest: 11),
              ETSets(eset: 3, exercise: 12, rest: 9),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 12, rest: 9),
              ETSets(eset: 8, exercise: 12, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 12, rest: 11),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 12, rest: 9),
              ETSets(eset: 6, exercise: 12, rest: 9),
              ETSets(eset: 7, exercise: 12, rest: 9),
              ETSets(eset: 8, exercise: 12, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 12, rest: 9),
              ETSets(eset: 5, exercise: 12, rest: 9),
              ETSets(eset: 6, exercise: 12, rest: 9),
              ETSets(eset: 7, exercise: 12, rest: 9),
              ETSets(eset: 8, exercise: 12, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 12, rest: 11),
              ETSets(eset: 2, exercise: 12, rest: 11),
              ETSets(eset: 3, exercise: 12, rest: 9),
              ETSets(eset: 4, exercise: 12, rest: 9),
              ETSets(eset: 5, exercise: 12, rest: 9),
              ETSets(eset: 6, exercise: 12, rest: 9),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 30,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 12, rest: 12),
              ETSets(eset: 2, exercise: 13, rest: 12),
              ETSets(eset: 3, exercise: 12, rest: 9),
              ETSets(eset: 4, exercise: 12, rest: 9),
              ETSets(eset: 5, exercise: 12, rest: 9),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 13, rest: 12),
              ETSets(eset: 2, exercise: 13, rest: 12),
              ETSets(eset: 3, exercise: 12, rest: 9),
              ETSets(eset: 4, exercise: 12, rest: 9),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 12, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 13, rest: 12),
              ETSets(eset: 2, exercise: 13, rest: 12),
              ETSets(eset: 3, exercise: 12, rest: 9),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 12, rest: 9),
              ETSets(eset: 8, exercise: 12, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 13, rest: 12),
              ETSets(eset: 2, exercise: 13, rest: 12),
              ETSets(eset: 3, exercise: 12, rest: 9),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 12, rest: 9),
              ETSets(eset: 8, exercise: 12, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 13, rest: 12),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 12, rest: 9),
              ETSets(eset: 6, exercise: 12, rest: 9),
              ETSets(eset: 7, exercise: 12, rest: 9),
              ETSets(eset: 8, exercise: 12, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 12, rest: 9),
              ETSets(eset: 5, exercise: 12, rest: 9),
              ETSets(eset: 6, exercise: 12, rest: 9),
              ETSets(eset: 7, exercise: 12, rest: 9),
              ETSets(eset: 8, exercise: 12, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 13, rest: 12),
              ETSets(eset: 2, exercise: 13, rest: 12),
              ETSets(eset: 3, exercise: 12, rest: 9),
              ETSets(eset: 4, exercise: 12, rest: 9),
              ETSets(eset: 5, exercise: 12, rest: 9),
              ETSets(eset: 6, exercise: 12, rest: 9),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 31,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 13, rest: 12),
              ETSets(eset: 2, exercise: 13, rest: 12),
              ETSets(eset: 3, exercise: 12, rest: 8),
              ETSets(eset: 4, exercise: 12, rest: 8),
              ETSets(eset: 5, exercise: 12, rest: 9),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 13, rest: 12),
              ETSets(eset: 2, exercise: 13, rest: 12),
              ETSets(eset: 3, exercise: 12, rest: 8),
              ETSets(eset: 4, exercise: 12, rest: 8),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 12, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 13, rest: 12),
              ETSets(eset: 2, exercise: 13, rest: 12),
              ETSets(eset: 3, exercise: 12, rest: 8),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 12, rest: 9),
              ETSets(eset: 8, exercise: 12, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 13, rest: 12),
              ETSets(eset: 2, exercise: 13, rest: 12),
              ETSets(eset: 3, exercise: 12, rest: 9),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 12, rest: 9),
              ETSets(eset: 8, exercise: 12, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 13, rest: 12),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 12, rest: 9),
              ETSets(eset: 6, exercise: 12, rest: 9),
              ETSets(eset: 7, exercise: 12, rest: 9),
              ETSets(eset: 8, exercise: 12, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 12, rest: 8),
              ETSets(eset: 5, exercise: 12, rest: 9),
              ETSets(eset: 6, exercise: 12, rest: 9),
              ETSets(eset: 7, exercise: 12, rest: 9),
              ETSets(eset: 8, exercise: 12, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 13, rest: 12),
              ETSets(eset: 2, exercise: 13, rest: 12),
              ETSets(eset: 3, exercise: 12, rest: 8),
              ETSets(eset: 4, exercise: 12, rest: 8),
              ETSets(eset: 5, exercise: 12, rest: 9),
              ETSets(eset: 6, exercise: 12, rest: 9),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 32,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 13, rest: 12),
              ETSets(eset: 2, exercise: 13, rest: 12),
              ETSets(eset: 3, exercise: 12, rest: 8),
              ETSets(eset: 4, exercise: 12, rest: 8),
              ETSets(eset: 5, exercise: 12, rest: 8),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 13, rest: 12),
              ETSets(eset: 2, exercise: 13, rest: 12),
              ETSets(eset: 3, exercise: 12, rest: 8),
              ETSets(eset: 4, exercise: 12, rest: 8),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 12, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 13, rest: 12),
              ETSets(eset: 2, exercise: 13, rest: 12),
              ETSets(eset: 3, exercise: 12, rest: 8),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 12, rest: 9),
              ETSets(eset: 8, exercise: 12, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 13, rest: 12),
              ETSets(eset: 2, exercise: 13, rest: 12),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 12, rest: 8),
              ETSets(eset: 7, exercise: 12, rest: 9),
              ETSets(eset: 8, exercise: 12, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 13, rest: 12),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 12, rest: 8),
              ETSets(eset: 6, exercise: 12, rest: 8),
              ETSets(eset: 7, exercise: 12, rest: 8),
              ETSets(eset: 8, exercise: 12, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 12, rest: 8),
              ETSets(eset: 5, exercise: 12, rest: 9),
              ETSets(eset: 6, exercise: 12, rest: 8),
              ETSets(eset: 7, exercise: 12, rest: 8),
              ETSets(eset: 8, exercise: 12, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 13, rest: 12),
              ETSets(eset: 2, exercise: 13, rest: 12),
              ETSets(eset: 3, exercise: 12, rest: 8),
              ETSets(eset: 4, exercise: 12, rest: 8),
              ETSets(eset: 5, exercise: 12, rest: 8),
              ETSets(eset: 6, exercise: 12, rest: 8),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 33,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 14, rest: 14),
              ETSets(eset: 2, exercise: 14, rest: 14),
              ETSets(eset: 3, exercise: 13, rest: 10),
              ETSets(eset: 4, exercise: 13, rest: 10),
              ETSets(eset: 5, exercise: 13, rest: 10),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 14, rest: 14),
              ETSets(eset: 2, exercise: 14, rest: 14),
              ETSets(eset: 3, exercise: 13, rest: 10),
              ETSets(eset: 4, exercise: 13, rest: 10),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 13, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 14, rest: 14),
              ETSets(eset: 2, exercise: 14, rest: 14),
              ETSets(eset: 3, exercise: 13, rest: 10),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 13, rest: 10),
              ETSets(eset: 8, exercise: 13, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 14, rest: 14),
              ETSets(eset: 2, exercise: 14, rest: 14),
              ETSets(eset: 3, exercise: 13, rest: 10),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 13, rest: 10),
              ETSets(eset: 8, exercise: 13, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 14, rest: 14),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 13, rest: 10),
              ETSets(eset: 6, exercise: 13, rest: 10),
              ETSets(eset: 7, exercise: 13, rest: 10),
              ETSets(eset: 8, exercise: 13, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 13, rest: 10),
              ETSets(eset: 5, exercise: 13, rest: 9),
              ETSets(eset: 6, exercise: 13, rest: 10),
              ETSets(eset: 7, exercise: 13, rest: 10),
              ETSets(eset: 8, exercise: 13, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 14, rest: 14),
              ETSets(eset: 2, exercise: 14, rest: 14),
              ETSets(eset: 3, exercise: 13, rest: 10),
              ETSets(eset: 4, exercise: 13, rest: 10),
              ETSets(eset: 5, exercise: 13, rest: 10),
              ETSets(eset: 6, exercise: 13, rest: 10),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 34,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 14, rest: 13),
              ETSets(eset: 2, exercise: 14, rest: 14),
              ETSets(eset: 3, exercise: 13, rest: 10),
              ETSets(eset: 4, exercise: 13, rest: 10),
              ETSets(eset: 5, exercise: 13, rest: 10),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 14, rest: 13),
              ETSets(eset: 2, exercise: 14, rest: 14),
              ETSets(eset: 3, exercise: 13, rest: 10),
              ETSets(eset: 4, exercise: 13, rest: 10),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 13, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 14, rest: 13),
              ETSets(eset: 2, exercise: 14, rest: 14),
              ETSets(eset: 3, exercise: 13, rest: 10),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 13, rest: 10),
              ETSets(eset: 8, exercise: 13, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 14, rest: 13),
              ETSets(eset: 2, exercise: 14, rest: 14),
              ETSets(eset: 3, exercise: 13, rest: 10),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 13, rest: 10),
              ETSets(eset: 8, exercise: 13, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 14, rest: 13),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 13, rest: 10),
              ETSets(eset: 6, exercise: 13, rest: 10),
              ETSets(eset: 7, exercise: 13, rest: 10),
              ETSets(eset: 8, exercise: 13, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 13, rest: 10),
              ETSets(eset: 5, exercise: 13, rest: 9),
              ETSets(eset: 6, exercise: 13, rest: 10),
              ETSets(eset: 7, exercise: 13, rest: 10),
              ETSets(eset: 8, exercise: 13, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 14, rest: 13),
              ETSets(eset: 2, exercise: 14, rest: 14),
              ETSets(eset: 3, exercise: 13, rest: 10),
              ETSets(eset: 4, exercise: 13, rest: 10),
              ETSets(eset: 5, exercise: 13, rest: 10),
              ETSets(eset: 6, exercise: 13, rest: 10),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 35,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 14, rest: 13),
              ETSets(eset: 2, exercise: 14, rest: 13),
              ETSets(eset: 3, exercise: 13, rest: 10),
              ETSets(eset: 4, exercise: 13, rest: 10),
              ETSets(eset: 5, exercise: 13, rest: 10),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 14, rest: 13),
              ETSets(eset: 2, exercise: 14, rest: 13),
              ETSets(eset: 3, exercise: 13, rest: 10),
              ETSets(eset: 4, exercise: 13, rest: 10),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 13, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 14, rest: 13),
              ETSets(eset: 2, exercise: 14, rest: 13),
              ETSets(eset: 3, exercise: 13, rest: 10),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 13, rest: 10),
              ETSets(eset: 8, exercise: 13, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 14, rest: 13),
              ETSets(eset: 2, exercise: 14, rest: 13),
              ETSets(eset: 3, exercise: 13, rest: 10),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 13, rest: 10),
              ETSets(eset: 8, exercise: 13, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 14, rest: 13),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 13, rest: 10),
              ETSets(eset: 6, exercise: 13, rest: 10),
              ETSets(eset: 7, exercise: 13, rest: 10),
              ETSets(eset: 8, exercise: 13, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 13, rest: 10),
              ETSets(eset: 5, exercise: 13, rest: 9),
              ETSets(eset: 6, exercise: 13, rest: 10),
              ETSets(eset: 7, exercise: 13, rest: 10),
              ETSets(eset: 8, exercise: 13, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 14, rest: 13),
              ETSets(eset: 2, exercise: 14, rest: 13),
              ETSets(eset: 3, exercise: 13, rest: 10),
              ETSets(eset: 4, exercise: 13, rest: 10),
              ETSets(eset: 5, exercise: 13, rest: 10),
              ETSets(eset: 6, exercise: 13, rest: 10),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 36,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 15, rest: 14),
              ETSets(eset: 2, exercise: 15, rest: 14),
              ETSets(eset: 3, exercise: 14, rest: 11),
              ETSets(eset: 4, exercise: 14, rest: 12),
              ETSets(eset: 5, exercise: 14, rest: 12),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 15, rest: 14),
              ETSets(eset: 2, exercise: 15, rest: 14),
              ETSets(eset: 3, exercise: 14, rest: 12),
              ETSets(eset: 4, exercise: 14, rest: 12),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 14, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 15, rest: 14),
              ETSets(eset: 2, exercise: 15, rest: 14),
              ETSets(eset: 3, exercise: 14, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 14, rest: 12),
              ETSets(eset: 8, exercise: 14, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 15, rest: 14),
              ETSets(eset: 2, exercise: 15, rest: 14),
              ETSets(eset: 3, exercise: 14, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 14, rest: 12),
              ETSets(eset: 8, exercise: 14, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 15, rest: 14),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 14, rest: 12),
              ETSets(eset: 6, exercise: 14, rest: 12),
              ETSets(eset: 7, exercise: 14, rest: 12),
              ETSets(eset: 8, exercise: 14, rest: 4),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 14, rest: 12),
              ETSets(eset: 5, exercise: 14, rest: 11),
              ETSets(eset: 6, exercise: 14, rest: 12),
              ETSets(eset: 7, exercise: 14, rest: 12),
              ETSets(eset: 8, exercise: 14, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 15, rest: 14),
              ETSets(eset: 2, exercise: 15, rest: 14),
              ETSets(eset: 3, exercise: 14, rest: 12),
              ETSets(eset: 4, exercise: 14, rest: 12),
              ETSets(eset: 5, exercise: 14, rest: 12),
              ETSets(eset: 6, exercise: 14, rest: 12),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 37,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 15, rest: 14),
              ETSets(eset: 2, exercise: 15, rest: 14),
              ETSets(eset: 3, exercise: 14, rest: 11),
              ETSets(eset: 4, exercise: 14, rest: 11),
              ETSets(eset: 5, exercise: 14, rest: 12),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 15, rest: 14),
              ETSets(eset: 2, exercise: 15, rest: 14),
              ETSets(eset: 3, exercise: 14, rest: 12),
              ETSets(eset: 4, exercise: 14, rest: 11),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 14, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 15, rest: 14),
              ETSets(eset: 2, exercise: 15, rest: 14),
              ETSets(eset: 3, exercise: 14, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 14, rest: 12),
              ETSets(eset: 8, exercise: 14, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 15, rest: 14),
              ETSets(eset: 2, exercise: 15, rest: 14),
              ETSets(eset: 3, exercise: 14, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 14, rest: 12),
              ETSets(eset: 8, exercise: 14, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 15, rest: 14),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 14, rest: 12),
              ETSets(eset: 6, exercise: 14, rest: 12),
              ETSets(eset: 7, exercise: 14, rest: 12),
              ETSets(eset: 8, exercise: 14, rest: 4),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 14, rest: 11),
              ETSets(eset: 5, exercise: 14, rest: 11),
              ETSets(eset: 6, exercise: 14, rest: 12),
              ETSets(eset: 7, exercise: 14, rest: 12),
              ETSets(eset: 8, exercise: 14, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 15, rest: 14),
              ETSets(eset: 2, exercise: 15, rest: 14),
              ETSets(eset: 3, exercise: 14, rest: 12),
              ETSets(eset: 4, exercise: 14, rest: 11),
              ETSets(eset: 5, exercise: 14, rest: 12),
              ETSets(eset: 6, exercise: 14, rest: 12),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 38,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 15, rest: 14),
              ETSets(eset: 2, exercise: 15, rest: 14),
              ETSets(eset: 3, exercise: 14, rest: 11),
              ETSets(eset: 4, exercise: 14, rest: 11),
              ETSets(eset: 5, exercise: 14, rest: 11),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 15, rest: 14),
              ETSets(eset: 2, exercise: 15, rest: 14),
              ETSets(eset: 3, exercise: 14, rest: 12),
              ETSets(eset: 4, exercise: 14, rest: 11),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 14, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 15, rest: 14),
              ETSets(eset: 2, exercise: 15, rest: 14),
              ETSets(eset: 3, exercise: 14, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 14, rest: 12),
              ETSets(eset: 8, exercise: 14, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 15, rest: 14),
              ETSets(eset: 2, exercise: 15, rest: 14),
              ETSets(eset: 3, exercise: 14, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 14, rest: 12),
              ETSets(eset: 8, exercise: 14, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 15, rest: 14),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 14, rest: 11),
              ETSets(eset: 6, exercise: 14, rest: 12),
              ETSets(eset: 7, exercise: 14, rest: 12),
              ETSets(eset: 8, exercise: 14, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 14, rest: 11),
              ETSets(eset: 5, exercise: 14, rest: 11),
              ETSets(eset: 6, exercise: 14, rest: 12),
              ETSets(eset: 7, exercise: 14, rest: 12),
              ETSets(eset: 8, exercise: 14, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 15, rest: 4),
              ETSets(eset: 2, exercise: 15, rest: 4),
              ETSets(eset: 3, exercise: 14, rest: 12),
              ETSets(eset: 4, exercise: 14, rest: 11),
              ETSets(eset: 5, exercise: 14, rest: 11),
              ETSets(eset: 6, exercise: 14, rest: 12),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 39,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 16, rest: 15),
              ETSets(eset: 2, exercise: 16, rest: 15),
              ETSets(eset: 3, exercise: 15, rest: 12),
              ETSets(eset: 4, exercise: 15, rest: 13),
              ETSets(eset: 5, exercise: 15, rest: 13),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 16, rest: 15),
              ETSets(eset: 2, exercise: 16, rest: 15),
              ETSets(eset: 3, exercise: 15, rest: 14),
              ETSets(eset: 4, exercise: 15, rest: 13),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 15, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 16, rest: 15),
              ETSets(eset: 2, exercise: 16, rest: 15),
              ETSets(eset: 3, exercise: 15, rest: 14),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 15, rest: 14),
              ETSets(eset: 8, exercise: 15, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 16, rest: 15),
              ETSets(eset: 2, exercise: 16, rest: 15),
              ETSets(eset: 3, exercise: 15, rest: 14),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 15, rest: 14),
              ETSets(eset: 8, exercise: 15, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 16, rest: 15),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 15, rest: 13),
              ETSets(eset: 6, exercise: 15, rest: 14),
              ETSets(eset: 7, exercise: 15, rest: 14),
              ETSets(eset: 8, exercise: 15, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 15, rest: 13),
              ETSets(eset: 5, exercise: 15, rest: 13),
              ETSets(eset: 6, exercise: 15, rest: 14),
              ETSets(eset: 7, exercise: 15, rest: 14),
              ETSets(eset: 8, exercise: 15, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 16, rest: 15),
              ETSets(eset: 2, exercise: 16, rest: 15),
              ETSets(eset: 3, exercise: 15, rest: 14),
              ETSets(eset: 4, exercise: 15, rest: 13),
              ETSets(eset: 5, exercise: 15, rest: 13),
              ETSets(eset: 6, exercise: 15, rest: 14),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 40,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 16, rest: 15),
              ETSets(eset: 2, exercise: 16, rest: 15),
              ETSets(eset: 3, exercise: 15, rest: 12),
              ETSets(eset: 4, exercise: 15, rest: 13),
              ETSets(eset: 5, exercise: 15, rest: 13),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 16, rest: 15),
              ETSets(eset: 2, exercise: 16, rest: 15),
              ETSets(eset: 3, exercise: 15, rest: 14),
              ETSets(eset: 4, exercise: 15, rest: 13),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 15, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 16, rest: 15),
              ETSets(eset: 2, exercise: 16, rest: 15),
              ETSets(eset: 3, exercise: 15, rest: 14),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 15, rest: 13),
              ETSets(eset: 8, exercise: 15, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 16, rest: 15),
              ETSets(eset: 2, exercise: 16, rest: 15),
              ETSets(eset: 3, exercise: 15, rest: 14),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 15, rest: 13),
              ETSets(eset: 8, exercise: 15, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 16, rest: 15),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 15, rest: 13),
              ETSets(eset: 6, exercise: 15, rest: 14),
              ETSets(eset: 7, exercise: 15, rest: 13),
              ETSets(eset: 8, exercise: 15, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 15, rest: 13),
              ETSets(eset: 5, exercise: 15, rest: 13),
              ETSets(eset: 6, exercise: 15, rest: 14),
              ETSets(eset: 7, exercise: 15, rest: 13),
              ETSets(eset: 8, exercise: 15, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 16, rest: 15),
              ETSets(eset: 2, exercise: 16, rest: 15),
              ETSets(eset: 3, exercise: 15, rest: 14),
              ETSets(eset: 4, exercise: 15, rest: 13),
              ETSets(eset: 5, exercise: 15, rest: 13),
              ETSets(eset: 6, exercise: 15, rest: 14),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 41,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 16, rest: 14),
              ETSets(eset: 2, exercise: 16, rest: 15),
              ETSets(eset: 3, exercise: 15, rest: 12),
              ETSets(eset: 4, exercise: 15, rest: 13),
              ETSets(eset: 5, exercise: 15, rest: 13),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 16, rest: 14),
              ETSets(eset: 2, exercise: 16, rest: 15),
              ETSets(eset: 3, exercise: 15, rest: 14),
              ETSets(eset: 4, exercise: 15, rest: 13),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 15, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 16, rest: 14),
              ETSets(eset: 2, exercise: 16, rest: 15),
              ETSets(eset: 3, exercise: 15, rest: 14),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 15, rest: 13),
              ETSets(eset: 8, exercise: 15, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 16, rest: 14),
              ETSets(eset: 2, exercise: 16, rest: 15),
              ETSets(eset: 3, exercise: 15, rest: 14),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 15, rest: 13),
              ETSets(eset: 8, exercise: 15, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 16, rest: 14),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 15, rest: 13),
              ETSets(eset: 6, exercise: 15, rest: 14),
              ETSets(eset: 7, exercise: 15, rest: 13),
              ETSets(eset: 8, exercise: 15, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 15, rest: 13),
              ETSets(eset: 5, exercise: 15, rest: 13),
              ETSets(eset: 6, exercise: 15, rest: 14),
              ETSets(eset: 7, exercise: 15, rest: 13),
              ETSets(eset: 8, exercise: 15, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 16, rest: 14),
              ETSets(eset: 2, exercise: 16, rest: 15),
              ETSets(eset: 3, exercise: 15, rest: 14),
              ETSets(eset: 4, exercise: 15, rest: 13),
              ETSets(eset: 5, exercise: 15, rest: 13),
              ETSets(eset: 6, exercise: 15, rest: 14),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 42,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 17, rest: 15),
              ETSets(eset: 2, exercise: 17, rest: 16),
              ETSets(eset: 3, exercise: 16, rest: 13),
              ETSets(eset: 4, exercise: 16, rest: 15),
              ETSets(eset: 5, exercise: 16, rest: 15),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 17, rest: 15),
              ETSets(eset: 2, exercise: 17, rest: 16),
              ETSets(eset: 3, exercise: 16, rest: 16),
              ETSets(eset: 4, exercise: 16, rest: 15),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 16, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 17, rest: 15),
              ETSets(eset: 2, exercise: 17, rest: 16),
              ETSets(eset: 3, exercise: 16, rest: 16),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 16, rest: 15),
              ETSets(eset: 8, exercise: 16, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 17, rest: 15),
              ETSets(eset: 2, exercise: 17, rest: 16),
              ETSets(eset: 3, exercise: 16, rest: 16),
              ETSets(eset: 4, exercise: 16, rest: 15),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 16, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 17, rest: 15),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 16, rest: 15),
              ETSets(eset: 6, exercise: 16, rest: 16),
              ETSets(eset: 7, exercise: 16, rest: 15),
              ETSets(eset: 8, exercise: 16, rest: 4),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 16, rest: 15),
              ETSets(eset: 5, exercise: 16, rest: 15),
              ETSets(eset: 6, exercise: 16, rest: 16),
              ETSets(eset: 7, exercise: 16, rest: 15),
              ETSets(eset: 8, exercise: 16, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 17, rest: 15),
              ETSets(eset: 2, exercise: 17, rest: 16),
              ETSets(eset: 3, exercise: 16, rest: 16),
              ETSets(eset: 4, exercise: 16, rest: 15),
              ETSets(eset: 5, exercise: 16, rest: 15),
              ETSets(eset: 6, exercise: 16, rest: 16),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 43,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 17, rest: 15),
              ETSets(eset: 2, exercise: 17, rest: 16),
              ETSets(eset: 3, exercise: 16, rest: 12),
              ETSets(eset: 4, exercise: 16, rest: 15),
              ETSets(eset: 5, exercise: 16, rest: 15),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 17, rest: 15),
              ETSets(eset: 2, exercise: 17, rest: 16),
              ETSets(eset: 3, exercise: 16, rest: 15),
              ETSets(eset: 4, exercise: 16, rest: 15),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 16, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 17, rest: 15),
              ETSets(eset: 2, exercise: 17, rest: 16),
              ETSets(eset: 3, exercise: 16, rest: 15),
              ETSets(eset: 4, exercise: 16, rest: 15),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 16, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 17, rest: 15),
              ETSets(eset: 2, exercise: 17, rest: 16),
              ETSets(eset: 3, exercise: 16, rest: 16),
              ETSets(eset: 4, exercise: 16, rest: 15),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 16, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 17, rest: 15),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 16, rest: 15),
              ETSets(eset: 6, exercise: 16, rest: 16),
              ETSets(eset: 7, exercise: 16, rest: 15),
              ETSets(eset: 8, exercise: 16, rest: 4),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 16, rest: 15),
              ETSets(eset: 5, exercise: 16, rest: 15),
              ETSets(eset: 6, exercise: 16, rest: 16),
              ETSets(eset: 7, exercise: 16, rest: 15),
              ETSets(eset: 8, exercise: 16, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 17, rest: 15),
              ETSets(eset: 2, exercise: 17, rest: 16),
              ETSets(eset: 3, exercise: 16, rest: 15),
              ETSets(eset: 4, exercise: 16, rest: 15),
              ETSets(eset: 5, exercise: 16, rest: 15),
              ETSets(eset: 6, exercise: 16, rest: 16),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 44,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 17, rest: 15),
              ETSets(eset: 2, exercise: 17, rest: 16),
              ETSets(eset: 3, exercise: 16, rest: 12),
              ETSets(eset: 4, exercise: 16, rest: 14),
              ETSets(eset: 5, exercise: 16, rest: 15),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 17, rest: 15),
              ETSets(eset: 2, exercise: 17, rest: 16),
              ETSets(eset: 3, exercise: 16, rest: 15),
              ETSets(eset: 4, exercise: 16, rest: 14),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 16, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 17, rest: 15),
              ETSets(eset: 2, exercise: 17, rest: 16),
              ETSets(eset: 3, exercise: 16, rest: 15),
              ETSets(eset: 4, exercise: 16, rest: 15),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 16, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 17, rest: 15),
              ETSets(eset: 2, exercise: 17, rest: 16),
              ETSets(eset: 3, exercise: 16, rest: 16),
              ETSets(eset: 4, exercise: 16, rest: 15),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 16, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 17, rest: 15),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 16, rest: 15),
              ETSets(eset: 6, exercise: 16, rest: 16),
              ETSets(eset: 7, exercise: 16, rest: 15),
              ETSets(eset: 8, exercise: 16, rest: 4),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 16, rest: 14),
              ETSets(eset: 5, exercise: 16, rest: 15),
              ETSets(eset: 6, exercise: 16, rest: 16),
              ETSets(eset: 7, exercise: 16, rest: 15),
              ETSets(eset: 8, exercise: 16, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 17, rest: 15),
              ETSets(eset: 2, exercise: 17, rest: 16),
              ETSets(eset: 3, exercise: 16, rest: 15),
              ETSets(eset: 4, exercise: 16, rest: 14),
              ETSets(eset: 5, exercise: 16, rest: 15),
              ETSets(eset: 6, exercise: 16, rest: 16),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 45,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 18, rest: 16),
              ETSets(eset: 2, exercise: 18, rest: 17),
              ETSets(eset: 3, exercise: 17, rest: 13),
              ETSets(eset: 4, exercise: 17, rest: 16),
              ETSets(eset: 5, exercise: 17, rest: 17),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 18, rest: 16),
              ETSets(eset: 2, exercise: 18, rest: 17),
              ETSets(eset: 3, exercise: 17, rest: 17),
              ETSets(eset: 4, exercise: 17, rest: 16),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 17, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 18, rest: 16),
              ETSets(eset: 2, exercise: 18, rest: 17),
              ETSets(eset: 3, exercise: 17, rest: 17),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 17, rest: 17),
              ETSets(eset: 8, exercise: 17, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 18, rest: 16),
              ETSets(eset: 2, exercise: 18, rest: 17),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 17, rest: 18),
              ETSets(eset: 7, exercise: 17, rest: 17),
              ETSets(eset: 8, exercise: 17, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 18, rest: 16),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 17, rest: 17),
              ETSets(eset: 6, exercise: 17, rest: 18),
              ETSets(eset: 7, exercise: 17, rest: 17),
              ETSets(eset: 8, exercise: 17, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 17, rest: 16),
              ETSets(eset: 5, exercise: 17, rest: 17),
              ETSets(eset: 6, exercise: 17, rest: 18),
              ETSets(eset: 7, exercise: 17, rest: 17),
              ETSets(eset: 8, exercise: 17, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 18, rest: 16),
              ETSets(eset: 2, exercise: 18, rest: 17),
              ETSets(eset: 3, exercise: 17, rest: 17),
              ETSets(eset: 4, exercise: 17, rest: 16),
              ETSets(eset: 5, exercise: 17, rest: 17),
              ETSets(eset: 6, exercise: 17, rest: 18),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 46,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 18, rest: 16),
              ETSets(eset: 2, exercise: 18, rest: 17),
              ETSets(eset: 3, exercise: 17, rest: 13),
              ETSets(eset: 4, exercise: 17, rest: 16),
              ETSets(eset: 5, exercise: 17, rest: 17),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 18, rest: 16),
              ETSets(eset: 2, exercise: 18, rest: 17),
              ETSets(eset: 3, exercise: 17, rest: 17),
              ETSets(eset: 4, exercise: 17, rest: 16),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 17, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 18, rest: 16),
              ETSets(eset: 2, exercise: 18, rest: 17),
              ETSets(eset: 3, exercise: 17, rest: 17),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 17, rest: 17),
              ETSets(eset: 8, exercise: 17, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 18, rest: 16),
              ETSets(eset: 2, exercise: 18, rest: 17),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 17, rest: 17),
              ETSets(eset: 7, exercise: 17, rest: 17),
              ETSets(eset: 8, exercise: 17, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 18, rest: 16),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 17, rest: 17),
              ETSets(eset: 6, exercise: 17, rest: 17),
              ETSets(eset: 7, exercise: 17, rest: 17),
              ETSets(eset: 8, exercise: 17, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 17, rest: 16),
              ETSets(eset: 5, exercise: 17, rest: 17),
              ETSets(eset: 6, exercise: 17, rest: 17),
              ETSets(eset: 7, exercise: 17, rest: 17),
              ETSets(eset: 8, exercise: 17, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 18, rest: 16),
              ETSets(eset: 2, exercise: 18, rest: 17),
              ETSets(eset: 3, exercise: 17, rest: 17),
              ETSets(eset: 4, exercise: 17, rest: 16),
              ETSets(eset: 5, exercise: 17, rest: 17),
              ETSets(eset: 6, exercise: 17, rest: 17),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 47,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 18, rest: 16),
              ETSets(eset: 2, exercise: 18, rest: 17),
              ETSets(eset: 3, exercise: 17, rest: 13),
              ETSets(eset: 4, exercise: 17, rest: 16),
              ETSets(eset: 5, exercise: 17, rest: 17),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 18, rest: 16),
              ETSets(eset: 2, exercise: 18, rest: 17),
              ETSets(eset: 3, exercise: 17, rest: 17),
              ETSets(eset: 4, exercise: 17, rest: 16),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 17, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 18, rest: 16),
              ETSets(eset: 2, exercise: 18, rest: 17),
              ETSets(eset: 3, exercise: 17, rest: 17),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 17, rest: 16),
              ETSets(eset: 8, exercise: 17, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 18, rest: 16),
              ETSets(eset: 2, exercise: 18, rest: 17),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 17, rest: 17),
              ETSets(eset: 7, exercise: 17, rest: 16),
              ETSets(eset: 8, exercise: 17, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 18, rest: 16),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 17, rest: 17),
              ETSets(eset: 6, exercise: 17, rest: 17),
              ETSets(eset: 7, exercise: 17, rest: 16),
              ETSets(eset: 8, exercise: 17, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 17, rest: 16),
              ETSets(eset: 5, exercise: 17, rest: 17),
              ETSets(eset: 6, exercise: 17, rest: 17),
              ETSets(eset: 7, exercise: 17, rest: 16),
              ETSets(eset: 8, exercise: 17, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 18, rest: 16),
              ETSets(eset: 2, exercise: 18, rest: 17),
              ETSets(eset: 3, exercise: 17, rest: 17),
              ETSets(eset: 4, exercise: 17, rest: 16),
              ETSets(eset: 5, exercise: 17, rest: 17),
              ETSets(eset: 6, exercise: 17, rest: 17),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 48,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 19, rest: 17),
              ETSets(eset: 2, exercise: 19, rest: 18),
              ETSets(eset: 3, exercise: 18, rest: 14),
              ETSets(eset: 4, exercise: 18, rest: 18),
              ETSets(eset: 5, exercise: 18, rest: 19),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 19, rest: 17),
              ETSets(eset: 2, exercise: 19, rest: 18),
              ETSets(eset: 3, exercise: 18, rest: 19),
              ETSets(eset: 4, exercise: 18, rest: 18),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 18, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 19, rest: 17),
              ETSets(eset: 2, exercise: 19, rest: 18),
              ETSets(eset: 3, exercise: 18, rest: 19),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 18, rest: 18),
              ETSets(eset: 8, exercise: 18, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 19, rest: 17),
              ETSets(eset: 2, exercise: 19, rest: 18),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 18, rest: 19),
              ETSets(eset: 7, exercise: 18, rest: 18),
              ETSets(eset: 8, exercise: 18, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 19, rest: 17),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 18, rest: 19),
              ETSets(eset: 6, exercise: 18, rest: 19),
              ETSets(eset: 7, exercise: 18, rest: 18),
              ETSets(eset: 8, exercise: 18, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 18, rest: 18),
              ETSets(eset: 5, exercise: 18, rest: 19),
              ETSets(eset: 6, exercise: 18, rest: 19),
              ETSets(eset: 7, exercise: 18, rest: 18),
              ETSets(eset: 8, exercise: 18, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 19, rest: 17),
              ETSets(eset: 2, exercise: 19, rest: 18),
              ETSets(eset: 3, exercise: 18, rest: 19),
              ETSets(eset: 4, exercise: 18, rest: 18),
              ETSets(eset: 5, exercise: 18, rest: 19),
              ETSets(eset: 6, exercise: 18, rest: 19),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 49,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 19, rest: 17),
              ETSets(eset: 2, exercise: 19, rest: 17),
              ETSets(eset: 3, exercise: 18, rest: 14),
              ETSets(eset: 4, exercise: 18, rest: 18),
              ETSets(eset: 5, exercise: 18, rest: 19),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 19, rest: 17),
              ETSets(eset: 2, exercise: 19, rest: 17),
              ETSets(eset: 3, exercise: 18, rest: 19),
              ETSets(eset: 4, exercise: 18, rest: 18),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 18, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 19, rest: 17),
              ETSets(eset: 2, exercise: 19, rest: 17),
              ETSets(eset: 3, exercise: 18, rest: 19),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 18, rest: 18),
              ETSets(eset: 8, exercise: 18, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 19, rest: 17),
              ETSets(eset: 2, exercise: 19, rest: 17),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 18, rest: 19),
              ETSets(eset: 7, exercise: 18, rest: 18),
              ETSets(eset: 8, exercise: 18, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 19, rest: 17),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 18, rest: 19),
              ETSets(eset: 6, exercise: 18, rest: 19),
              ETSets(eset: 7, exercise: 18, rest: 18),
              ETSets(eset: 8, exercise: 18, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 18, rest: 18),
              ETSets(eset: 5, exercise: 18, rest: 19),
              ETSets(eset: 6, exercise: 18, rest: 19),
              ETSets(eset: 7, exercise: 18, rest: 18),
              ETSets(eset: 8, exercise: 18, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 19, rest: 17),
              ETSets(eset: 2, exercise: 19, rest: 17),
              ETSets(eset: 3, exercise: 18, rest: 19),
              ETSets(eset: 4, exercise: 18, rest: 18),
              ETSets(eset: 5, exercise: 18, rest: 19),
              ETSets(eset: 6, exercise: 18, rest: 19),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
      TLevels(
        level: 50,
        exercises: <TExercises>[
          TExercises(
            exercise: 1,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 19, rest: 17),
              ETSets(eset: 2, exercise: 19, rest: 17),
              ETSets(eset: 3, exercise: 18, rest: 14),
              ETSets(eset: 4, exercise: 18, rest: 18),
              ETSets(eset: 5, exercise: 18, rest: 19),
              ETSets(eset: 6, exercise: 3, rest: 3),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 2),
            ],
          ),
          TExercises(
            exercise: 2,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 19, rest: 17),
              ETSets(eset: 2, exercise: 19, rest: 17),
              ETSets(eset: 3, exercise: 18, rest: 18),
              ETSets(eset: 4, exercise: 18, rest: 18),
              ETSets(eset: 5, exercise: 4, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 18, rest: 2),
            ],
          ),
          TExercises(
            exercise: 3,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 3, rest: 4),
            ],
          ),
          TExercises(
            exercise: 4,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 19, rest: 17),
              ETSets(eset: 2, exercise: 19, rest: 17),
              ETSets(eset: 3, exercise: 18, rest: 18),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 18, rest: 18),
              ETSets(eset: 8, exercise: 18, rest: 2),
            ],
          ),
          TExercises(
            exercise: 5,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 19, rest: 17),
              ETSets(eset: 2, exercise: 19, rest: 17),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 18, rest: 19),
              ETSets(eset: 7, exercise: 18, rest: 18),
              ETSets(eset: 8, exercise: 18, rest: 2),
            ],
          ),
          TExercises(
            exercise: 6,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 2, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 2),
            ],
          ),
          TExercises(
            exercise: 7,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 19, rest: 17),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 18, rest: 19),
              ETSets(eset: 6, exercise: 18, rest: 19),
              ETSets(eset: 7, exercise: 18, rest: 18),
              ETSets(eset: 8, exercise: 18, rest: 2),
            ],
          ),
          TExercises(
            exercise: 8,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 3, rest: 2),
              ETSets(eset: 4, exercise: 18, rest: 18),
              ETSets(eset: 5, exercise: 18, rest: 19),
              ETSets(eset: 6, exercise: 18, rest: 19),
              ETSets(eset: 7, exercise: 18, rest: 18),
              ETSets(eset: 8, exercise: 18, rest: 2),
            ],
          ),
          TExercises(
            exercise: 9,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 2, rest: 2),
              ETSets(eset: 2, exercise: 2, rest: 2),
              ETSets(eset: 3, exercise: 2, rest: 2),
              ETSets(eset: 4, exercise: 2, rest: 2),
              ETSets(eset: 5, exercise: 2, rest: 2),
              ETSets(eset: 6, exercise: 2, rest: 2),
              ETSets(eset: 7, exercise: 4, rest: 2),
              ETSets(eset: 8, exercise: 4, rest: 2),
            ],
          ),
          TExercises(
            exercise: 10,
            sets: <ETSets>[
              ETSets(eset: 1, exercise: 19, rest: 17),
              ETSets(eset: 2, exercise: 19, rest: 17),
              ETSets(eset: 3, exercise: 18, rest: 18),
              ETSets(eset: 4, exercise: 18, rest: 18),
              ETSets(eset: 5, exercise: 18, rest: 19),
              ETSets(eset: 6, exercise: 18, rest: 19),
              ETSets(eset: 7, exercise: 3, rest: 2),
              ETSets(eset: 8, exercise: 2, rest: 1),
            ],
          ),
        ],
      ),
    ],
  ),
];

List<AppModel> actionCategoryList = <AppModel>[
  AppModel('Category 1', '', value: 0),
  AppModel('Category 2', '', value: 1),
  AppModel('Category 3', '', value: 2),
  AppModel('Category 4', '', value: 3),
];

List<AppModel> urgencyList = <AppModel>[
  AppModel('', '', value: -1),
  AppModel('1: Urgent and important', '1', value: 0),
  AppModel('2: Not urgent but important', '2', value: 1),
  AppModel('3: Urgent but not important', '3', value: 2),
  AppModel('4: Not urgent and not important', '4', value: 3),
];

List<AppModel> pomodoroList = <AppModel>[
  AppModel('Pomodoro 25-5', '', value: 0, duration: 1500, rest: 300),
  AppModel('Pomodoro 50-10', '', value: 1, duration: 3000, rest: 600),
  AppModel('Pomodoro 100-20', '', value: 2, duration: 6000, rest: 1200),
  AppModel('None', '', value: 3, duration: 0, rest: 0),
];

List<AppModel> nudgeRoutineList = <AppModel>[
  AppModel('Morning Routine', '', value: 0),
  AppModel('Evening Routine', '', value: 1),
  AppModel('Afternoon Routine', '', value: 2),
  AppModel('Mindfulness', '', value: 3),
  AppModel('Gratitude', '', value: 4),
  AppModel('Mental', '', value: 5),
  AppModel('Breathing', '', value: 6),
  AppModel('Visualization', '', value: 7),
  AppModel('Reading', '', value: 8),
  AppModel('Planning & Behavior Design', '', value: 9),
  AppModel('Emotional', '', value: 10),
  AppModel('Therapy', '', value: 11),
  AppModel('Connection', '', value: 12),
  AppModel('Goals & Values', '', value: 13),
  AppModel('Purpose', '', value: 14),
  AppModel('Physical', '', value: 15),
  AppModel('Movement', '', value: 16),
  AppModel('Diet', '', value: 17),
  AppModel('Cold', '', value: 18),
  AppModel('PC', '', value: 19),
];

List<AppModel> alarmSoundList = <AppModel>[
  AppModel('No Alarm', '', value: 0),
  AppModel('Alarm Sound #1', '', value: 1),
  AppModel('Alarm Sound #2', '', value: 2),
  AppModel('Alarm Sound #3', '', value: 3),
  AppModel('Alarm Sound #4', '', value: 4),
  AppModel('Alarm Sound #5', '', value: 5),
];

List<AppModel> sortbyList = <AppModel>[
  AppModel('Date', '', value: 0),
  AppModel('Total Time (High to Low)', '', value: 1),
  AppModel('Quadrant', '', value: 2),
  AppModel('Category', '', value: 3),
];

List<AppModel> setupList = <AppModel>[
  AppModel('Prepare Clothes', '', value: 0),
  AppModel('Prepare files for work/ school', '', value: 1),
  AppModel('Get workspace tidy', '', value: 2),
  AppModel('Open laptop to most important work', '', value: 3),
  AppModel('Write in...', '', value: 4),
];

///0: health, 1: cardio (HIIT), 2: mobility,
/// 3: strength anywhere(bodyweight), 4: strength freeweight,
/// 5: strength machine
/// 6: cardio active, 7: cardio continous
/// type: 0- exercise, 1-rest
List<MRSetupModel> minviableMrExercisesList = <MRSetupModel>[
  /// overall health
  MRSetupModel(
    value: 0,
    type: 0,
    routine: 'warm up barebone',
    exercises: [
      MRSExercises(
        name: 'Side lunge with arm raises',
        time: 30,
        value: 0,
        type: 0,
      ),
      MRSExercises(
        name: 'Lunge with torso rotations',
        time: 30,
        value: 1,
        type: 0,
      ),
      MRSExercises(
        name: 'Hip rotations',
        time: 30,
        value: 2,
        type: 0,
      ),
      MRSExercises(
        name: 'Chest expansions with squats, palms facing upwards, thumbs out',
        time: 30,
        value: 3,
        type: 0,
      ),
    ],
  ),
  MRSetupModel(
    value: 1,
    type: 0,
    routine: 'Bodyweight Full Body barebones 1 set',
    exercises: [
      MRSExercises(name: 'Pullup', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 1, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 3, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 4, type: 0),
    ],
  ),
  MRSetupModel(
    value: 2,
    type: 0,
    routine: 'Static Stretching Full Body barebones 30 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 30, value: 1),
      MRSExercises(
        name: 'Butterfly (groin stretch)',
        time: 30,
        value: 2,
        type: 0,
      ),
      MRSExercises(name: 'low lunge (right side)', time: 30, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 30, value: 4, type: 0),
    ],
  ),

  /// cardio
  MRSetupModel(
    value: 3,
    type: 1,
    routine: 'warm up barebones cardio',
    exercises: [
      MRSExercises(
        name: 'Run in place, jump rope, or perform jumping jacks',
        time: 30,
        value: 0,
        type: 0,
      ),
      MRSExercises(
        name: 'Side lunge with arm raises',
        time: 30,
        value: 1,
        type: 0,
      ),
      MRSExercises(
        name: 'Lunge with torso rotations',
        time: 30,
        value: 2,
        type: 0,
      ),
      MRSExercises(
        name: 'Chest expansions with squats, palms facing upwards, thumbs out',
        time: 30,
        value: 3,
        type: 0,
      ),
    ],
  ),
  MRSetupModel(
    value: 4,
    type: 1,
    routine: 'Tabata 8 sets',
    exercises: [
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 0,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 1,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 2,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 3,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 4,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 5,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 6,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 7,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 8,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 9,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 10,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 11,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 12,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 13,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 14,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 15,
        type: 0,
      ),
    ],
  ),
  MRSetupModel(
    value: 5,
    type: 1,
    routine: 'Static Stretching Lower Body barebones 30 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes ', time: 30, value: 0, type: 0),
      MRSExercises(
        name: 'Downward dog',
        time: 30,
        value: 1,
        type: 0,
      ),
      MRSExercises(
        name: 'Butterfly (groin stretch)',
        time: 30,
        value: 2,
        type: 0,
      ),
      MRSExercises(name: 'Knees hug', time: 30, value: 3, type: 0),
      MRSExercises(name: 'Child\'s pose', time: 30, value: 4, type: 0),
    ],
  ),

  /// mobility
  MRSetupModel(
    value: 6,
    type: 2,
    routine: 'warm up barebones',
    exercises: [
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 0, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 1, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 2, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 3,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 7,
    type: 2,
    routine: 'Static Stretching Full Body barebones 30 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 30, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 30, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 30, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 30, value: 4, type: 0),
    ],
  ),

  /// strength anywhere (bodyweight)
  MRSetupModel(
    value: 8,
    type: 3,
    routine: 'warm up barebone',
    exercises: [
      MRSExercises(
          name: 'Side lunge with arm raises', time: 30, value: 0, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 1, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 2, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 3,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 9,
    type: 3,
    routine: 'Bodyweight Full Body barebones 1 set',
    exercises: [
      MRSExercises(name: 'Pullup', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 1, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 3, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 4, type: 0),
    ],
  ),
  MRSetupModel(
    value: 10,
    type: 3,
    routine: 'Static Stretching Full Body barebones 30 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 30, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 30, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 30, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 30, value: 4, type: 0),
    ],
  ),

  /// cardio continuous
  MRSetupModel(
    value: 17,
    type: 7,
    routine: 'warm up barebones cardio',
    exercises: [
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises', time: 30, value: 1, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 2, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 3,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 11,
    type: 7,
    routine: 'Low Intensity Steady State (Continuous) Cardio',
    exercises: [
      MRSExercises(
          name:
              'Medium Intensity Exercise (Walking, Jogging, Swimming, Biking, Etc.)',
          time: 300,
          value: 0,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 12,
    type: 7,
    routine: 'Static Stretching Lower Body barebones 30 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Downward dog', time: 30, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Knees hug', time: 30, value: 3, type: 0),
      MRSExercises(name: 'Child\'s pose', time: 30, value: 4, type: 0),
    ],
  ),

  /// strength machine
  MRSetupModel(
    value: 13,
    type: 5,
    routine: 'warm up barebones',
    exercises: [
      MRSExercises(
          name: 'Side lunge with arm raises', time: 30, value: 0, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 1, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 2, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 3,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 14,
    type: 5,
    routine: 'Machines Full Body barebones 1 set 30 work/ 30 rest',
    exercises: [
      MRSExercises(name: 'Lat Pull Down', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 1, type: 1),
      MRSExercises(name: 'Smith Machine Squat', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 3, type: 1),
      MRSExercises(name: 'Chest Press', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 5, type: 1),
      MRSExercises(name: 'Smith Machine Deadlift', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 7, type: 1),
      MRSExercises(name: 'Shoulder Press', time: 30, value: 8, type: 0),
    ],
  ),
  MRSetupModel(
    value: 15,
    type: 5,
    routine: 'Static Stretching Full Body barebones 30 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 30, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 30, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 30, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 30, value: 4, type: 0),
    ],
  ),

  /// cardio active recovery
  MRSetupModel(
    value: 16,
    type: 6,
    routine:
        'Light Intensity Exercise (Walking, Golfing, Swimming or Biking at a low intensity, Etc.)',
    exercises: [
      MRSExercises(
        name:
            'Light Intensity Exercise (Walking, Golfing, Swimming or Biking at a low intensity, Etc.)',
        value: 0,
        time: 600,
        type: 0,
      ),
    ],
  ),

  /// strength (free weight)
  MRSetupModel(
    value: 18,
    type: 4,
    routine: 'warm up barebones',
    exercises: [
      MRSExercises(
          name: 'Side lunge with arm raises', time: 30, value: 0, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 1, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 2, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 3,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 19,
    type: 4,
    routine: 'Free weights Full Body barebones 1 set 30 work/ 30 rest',
    exercises: [
      MRSExercises(name: 'Bent Over Row', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 1, type: 1),
      MRSExercises(name: 'Back Squat', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 3, type: 1),
      MRSExercises(name: 'Bench Press', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 5, type: 1),
      MRSExercises(name: 'Deadlift', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 7, type: 1),
      MRSExercises(name: 'Overhead Press', time: 30, value: 8, type: 0),
    ],
  ),
  MRSetupModel(
    value: 20,
    type: 4,
    routine: 'Static Stretching Full Body barebones 30 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 30, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 30, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 30, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 30, value: 4, type: 0),
    ],
  ),
];

List<MRSetupModel> progressionExercisesList = <MRSetupModel>[
  /// overall health
  MRSetupModel(
    value: 0,
    type: 0,
    routine: 'warm up full body',
    exercises: [
      MRSExercises(
        name: 'Neck rotations (clockwise and counter clockwise)',
        time: 30,
        value: 0,
        type: 0,
      ),
      MRSExercises(
        name: 'Run in place, jump rope, or perform jumping jacks',
        time: 30,
        value: 1,
        type: 0,
      ),
      MRSExercises(
        name:
            'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
        time: 30,
        value: 2,
        type: 0,
      ),
      MRSExercises(
        name: 'Side lunge with arm raises ',
        time: 30,
        value: 3,
        type: 0,
      ),
      MRSExercises(
        name: 'Lunge with torso rotations',
        time: 30,
        value: 4,
        type: 0,
      ),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
        name: 'Chest expansions with squats, palms facing upwards, thumbs out',
        time: 30,
        value: 6,
        type: 0,
      ),
    ],
  ),
  MRSetupModel(
    value: 1,
    type: 0,
    routine: 'Bodyweight- Full Version Balanced 1 set',
    exercises: [
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 1, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 3, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 5, type: 0),
      MRSExercises(name: 'Horizontal Pullup', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 7, type: 0),
    ],
  ),
  MRSetupModel(
    value: 2,
    type: 0,
    routine: 'Static Stretching- Full Body Short & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
        name: 'Butterfly (groin stretch)',
        time: 60,
        value: 2,
        type: 0,
      ),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
        name:
            'Neck Stretches (Left, right, front, back, and side to side lightly)',
        time: 60,
        value: 5,
        type: 0,
      ),
      MRSExercises(
        name: 'Horizontal Pole Front to Back',
        time: 60,
        value: 6,
        type: 0,
      ),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
    ],
  ),

  /// cardio
  MRSetupModel(
    value: 3,
    type: 1,
    routine: 'warm up full body cardio',
    exercises: [
      MRSExercises(
        name: 'Neck rotations (clockwise and counter clockwise)',
        time: 30,
        value: 0,
        type: 0,
      ),
      MRSExercises(
        name: 'Run in place, jump rope, or perform jumping jacks',
        time: 30,
        value: 1,
        type: 0,
      ),
      MRSExercises(
        name: 'High knees with lateral arm crosses',
        time: 30,
        value: 2,
        type: 0,
      ),
      MRSExercises(
        name: 'Side lunge with arm raises ',
        time: 30,
        value: 3,
        type: 0,
      ),
      MRSExercises(
        name: 'Lunge with torso rotations',
        time: 30,
        value: 4,
        type: 0,
      ),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
        name: 'Chest expansions with squats, palms facing upwards, thumbs out',
        time: 30,
        value: 6,
        type: 0,
      ),
    ],
  ),
  MRSetupModel(
    value: 4,
    type: 1,
    routine: 'Tabata 16 sets',
    exercises: [
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 0,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 1,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 2,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 3,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 4,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 5,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 6,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 7,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 8,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 9,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 10,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 11,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 12,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 13,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 14,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 15,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 16,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 17,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 18,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 19,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 20,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 21,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 22,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 23,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 24,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 25,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 26,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 26,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 28,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 29,
        type: 0,
      ),
      MRSExercises(
        name: 'High intensity exercise',
        time: 20,
        value: 30,
        type: 0,
      ),
      MRSExercises(
        name:
            'Active recovery (Walking, doing easy work, NOT completely resting)',
        time: 10,
        value: 31,
        type: 0,
      ),
    ],
  ),
  MRSetupModel(
    value: 5,
    type: 1,
    routine: 'Static Stretching Lower Body barebones 30 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes ', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Downward dog', time: 30, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Knees hug', time: 30, value: 3, type: 0),
      MRSExercises(name: 'Child\'s pose', time: 30, value: 4, type: 0),
    ],
  ),

  /// mobility
  MRSetupModel(
    value: 6,
    type: 2,
    routine: 'warm up full body',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 7,
    type: 2,
    routine: 'Static Stretching- Full Body Short & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 60, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 60,
          value: 5,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 6, type: 0),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
    ],
  ),

  ///  strength anywhere (bodyweight)
  MRSetupModel(
    value: 8,
    type: 3,
    routine: 'warm up full body',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 9,
    type: 3,
    routine: 'Bodyweight Full Body barebones 3 set',
    exercises: [
      MRSExercises(name: 'Pullup', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 1, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 3, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 5, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 7, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 8, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 9, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 10, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 11, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 12, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 13, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 14, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 15, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 16, type: 0),
    ],
  ),
  MRSetupModel(
    value: 10,
    type: 3,
    routine: 'Static Stretching Full Body barebones 30 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 30, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 30, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 30, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 30, value: 4, type: 0),
    ],
  ),

  /// cardio continuous
  MRSetupModel(
    value: 17,
    type: 7,
    routine: 'warm up barebones cardio',
    exercises: [
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises', time: 30, value: 1, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 2, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 3,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 11,
    type: 7,
    routine: 'Low Intensity Steady State (Continuous) Cardio',
    exercises: [
      MRSExercises(
          name:
              'Medium Intensity Exercise (Walking, Jogging, Swimming, Biking, Etc.)',
          time: 600,
          value: 0,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 12,
    type: 7,
    routine: 'Static Stretching Lower Body barebones 30 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Downward dog', time: 30, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Knees hug', time: 30, value: 3, type: 0),
      MRSExercises(name: 'Child\'s pose', time: 30, value: 4, type: 0),
    ],
  ),

  /// strength machine
  MRSetupModel(
    value: 13,
    type: 5,
    routine: 'warm up barebones',
    exercises: [
      MRSExercises(
          name: 'Side lunge with arm raises', time: 30, value: 0, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 1, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 2, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 3,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 14,
    type: 5,
    routine: 'Machines Full Body barebones 2 sets 30 work/ 30 rest',
    exercises: [
      MRSExercises(name: 'Lat Pull Down', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 1, type: 1),
      MRSExercises(name: 'Lat Pull Down', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 3, type: 1),
      MRSExercises(name: 'Smith Machine Squat', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 5, type: 1),
      MRSExercises(name: 'Smith Machine Deadlift', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 7, type: 1),
      MRSExercises(name: 'Chest Press', time: 30, value: 8, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 9, type: 1),
      MRSExercises(name: 'Chest Press', time: 30, value: 10, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 11, type: 1),
      MRSExercises(name: 'Smith Machine Squat', time: 30, value: 12, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 13, type: 1),
      MRSExercises(
          name: 'Smith Machine Deadlift', time: 30, value: 14, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 15, type: 1),
      MRSExercises(name: 'Shoulder Press', time: 30, value: 16, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 17, type: 1),
      MRSExercises(name: 'Shoulder Press', time: 30, value: 18, type: 0),
    ],
  ),
  MRSetupModel(
    value: 15,
    type: 5,
    routine: 'Static Stretching Full Body barebones 30 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 30, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 30, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 30, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 30, value: 4, type: 0),
    ],
  ),

  /// cardio active receovery
  MRSetupModel(
    value: 16,
    type: 6,
    routine:
        'Light Intensity Exercise (Walking, Golfing, Swimming or Biking at a low intensity, Etc.)',
    exercises: [
      MRSExercises(
          name:
              'Light Intensity Exercise (Walking, Golfing, Swimming or Biking at a low intensity, Etc.)',
          value: 0,
          time: 900,
          type: 0),
    ],
  ),

  /// strength (free weight)
  MRSetupModel(
    value: 18,
    type: 4,
    routine: 'warm up barebones',
    exercises: [
      MRSExercises(
          name: 'Side lunge with arm raises', time: 30, value: 0, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 1, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 2, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 3,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 19,
    type: 4,
    routine: 'Free weights Full Body barebones 1 set 30 work/ 30 rest',
    exercises: [
      MRSExercises(name: 'Bent Over Row', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 1, type: 1),
      MRSExercises(name: 'Bent Over Row', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 3, type: 1),
      MRSExercises(name: 'Back Squat', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 5, type: 1),
      MRSExercises(name: 'Back Squat', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 7, type: 1),
      MRSExercises(name: 'Bench Press', time: 30, value: 8, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 9, type: 1),
      MRSExercises(name: 'Bench Press', time: 30, value: 10, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 11, type: 1),
      MRSExercises(name: 'Deadlift', time: 30, value: 12, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 13, type: 1),
      MRSExercises(name: 'Deadlift', time: 30, value: 14, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 15, type: 1),
      MRSExercises(name: 'Overhead Press', time: 30, value: 16, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 17, type: 1),
      MRSExercises(name: 'Overhead Press', time: 30, value: 18, type: 0),
    ],
  ),
  MRSetupModel(
    value: 20,
    type: 4,
    routine: 'Static Stretching Full Body barebones 30 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 30, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 30, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 30, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 30, value: 4, type: 0),
    ],
  ),
];

List<MRSetupModel> fp1ExercisesList = <MRSetupModel>[
  /// overall health
  MRSetupModel(
    value: 0,
    type: 0,
    routine: 'warm up full body',
    exercises: [
      MRSExercises(
        name: 'Neck rotations (clockwise and counter clockwise)',
        time: 30,
        value: 0,
        type: 0,
      ),
      MRSExercises(
        name: 'Run in place, jump rope, or perform jumping jacks',
        time: 30,
        value: 1,
        type: 0,
      ),
      MRSExercises(
        name:
            'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
        time: 30,
        value: 2,
        type: 0,
      ),
      MRSExercises(
        name: 'Side lunge with arm raises ',
        time: 30,
        value: 3,
        type: 0,
      ),
      MRSExercises(
        name: 'Lunge with torso rotations',
        time: 30,
        value: 4,
        type: 0,
      ),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
        name: 'Chest expansions with squats, palms facing upwards, thumbs out',
        time: 30,
        value: 6,
        type: 0,
      ),
    ],
  ),
  MRSetupModel(
    value: 1,
    type: 0,
    routine: 'Bodyweight- Full Version Balanced 3 set',
    exercises: [
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 1, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 3, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 5, type: 0),
      MRSExercises(name: 'Horizontal Pullup', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 7, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 8, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 9, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 10, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 11, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 12, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 13, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 14, type: 0),
      MRSExercises(name: 'Horizontal Pullup', time: 30, value: 15, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 16, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 17, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 18, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 19, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 20, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 21, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 22, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 23, type: 0),
      MRSExercises(name: 'Horizontal Pullup', time: 30, value: 24, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 25, type: 0),
      // MRSExercises(name: 'Rest', time: 30, value: 26, type: 0),
    ],
  ),
  MRSetupModel(
    value: 2,
    type: 0,
    routine: 'Static Stretching- Full Body Short & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
        name: 'Butterfly (groin stretch)',
        time: 60,
        value: 2,
        type: 0,
      ),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
        name:
            'Neck Stretches (Left, right, front, back, and side to side lightly)',
        time: 60,
        value: 5,
        type: 0,
      ),
      MRSExercises(
        name: 'Horizontal Pole Front to Back',
        time: 60,
        value: 6,
        type: 0,
      ),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
    ],
  ),

  /// cardio
  MRSetupModel(
    value: 3,
    type: 1,
    routine: 'warm up full body cardio',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name: 'High knees with lateral arm crosses',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 4,
    type: 1,
    routine: 'Tabata 32 sets',
    exercises: [
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 0, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 1,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 2, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 3,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 4, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 5,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 6, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 7,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 8, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 9,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 10, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 11,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 12, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 13,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 14, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 15,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 16, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 17,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 18, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 19,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 20, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 21,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 22, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 23,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 24, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 25,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 26, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 26,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 28, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 29,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 30, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 31,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 32, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 33,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 34, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 35,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 36, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 37,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 38, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 39,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 40, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 41,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 42, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 43,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 44, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 45,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 46, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 47,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 48, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 49,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 50, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 51,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 52, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 53,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 54, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 55,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 56, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 57,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 58, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 59,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 60, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 61,
          type: 0),
      MRSExercises(
          name: 'High intensity exercise', time: 20, value: 62, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 10,
          value: 63,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 5,
    type: 1,
    routine: 'Static Stretching- Full Body Short & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 60, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 60,
          value: 5,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 6, type: 0),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
    ],
  ),

  /// mobility
  MRSetupModel(
    value: 6,
    type: 2,
    routine: 'warm up full body',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 7,
    type: 2,
    routine: 'Static Stretching- Full Body Complete & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 60, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(name: 'knee to chest', time: 60, value: 5, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 60,
          value: 6,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 7, type: 0),
      MRSExercises(name: 'grab door handle', time: 60, value: 8, type: 0),
      // MRSExercises(name: 'Split series', time: 60, value: 9),
      MRSExercises(name: 'Step 1: Hip opener', time: 60, value: 10, type: 0),
      MRSExercises(
          name: 'Step2: Hamstring opener', time: 60, value: 11, type: 0),
      MRSExercises(name: 'Step3: Full splits', time: 60, value: 12, type: 0),
      MRSExercises(name: 'Step4: Middle splits', time: 60, value: 13, type: 0),
      MRSExercises(name: 'downward dog', time: 60, value: 14, type: 0),
      MRSExercises(name: 'lying spinal twist', time: 60, value: 15, type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 16, type: 0),
      MRSExercises(name: 'cat cow stretch', time: 60, value: 17, type: 0),
      MRSExercises(name: 'Vertical Pole', time: 60, value: 18, type: 0),
    ],
  ),

  /// strength anywhere (bodyweight)
  MRSetupModel(
    value: 8,
    type: 3,
    routine: 'warm up full body',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 9,
    type: 3,
    routine: 'Bodyweight- Full Version Balanced 3 sets',
    exercises: [
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 1, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 3, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 5, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 7, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 8, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 9, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 10, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 11, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 12, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 13, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 14, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 15, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 16, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 17, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 18, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 19, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 20, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 21, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 22, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 23, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 24, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 25, type: 0),
    ],
  ),
  MRSetupModel(
    value: 10,
    type: 3,
    routine: 'Static Stretching Full Body barebones 30 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 60, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 60,
          value: 5,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 6, type: 0),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
    ],
  ),

  /// cardio continuous
  MRSetupModel(
    value: 17,
    type: 7,
    routine: 'warm up full body cardio',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name: 'High knees with lateral arm crosses',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 11,
    type: 7,
    routine: 'Low Intensity Steady State (Continuous) Cardio',
    exercises: [
      MRSExercises(
          name:
              'Medium Intensity Exercise (Walking, Jogging, Swimming, Biking, Etc.)',
          time: 1200,
          value: 0,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 12,
    type: 7,
    routine: 'Static Stretching- Full Body Short & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 60, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 60,
          value: 5,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 6, type: 0),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
    ],
  ),

  /// strength machine
  MRSetupModel(
    value: 13,
    type: 5,
    routine: 'warm up full body',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 14,
    type: 5,
    routine: 'Machines Full Body barebones 2 sets 30 work/ 30 rest',
    exercises: [
      MRSExercises(name: 'Lat Pull Down', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 1, type: 1),
      MRSExercises(name: 'Lat Pull Down', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 3, type: 1),
      MRSExercises(name: 'Lat Pull Down', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 5, type: 1),
      MRSExercises(name: 'Lat Pull Down', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 7, type: 1),
      MRSExercises(name: 'Smith Machine Squat', time: 30, value: 8, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 9, type: 1),
      MRSExercises(name: 'Smith Machine Squat', time: 30, value: 10, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 11, type: 1),
      MRSExercises(name: 'Smith Machine Squat', time: 30, value: 12, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 13, type: 1),
      MRSExercises(name: 'Smith Machine Squat', time: 30, value: 14, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 15, type: 1),
      MRSExercises(name: 'Chest Press', time: 30, value: 16, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 17, type: 1),
      MRSExercises(name: 'Chest Press', time: 30, value: 18, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 19, type: 1),
      MRSExercises(name: 'Chest Press', time: 30, value: 20, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 21, type: 1),
      MRSExercises(name: 'Chest Press', time: 30, value: 22, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 23, type: 1),
      MRSExercises(
          name: 'Smith Machine Deaslift', time: 30, value: 24, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 25, type: 1),
      MRSExercises(
          name: 'Smith Machine Deadlift', time: 30, value: 26, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 27, type: 1),
      MRSExercises(
          name: 'Smith Machine Deadlift', time: 30, value: 28, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 29, type: 1),
      MRSExercises(
          name: 'Smith Machine Deaslift', time: 30, value: 30, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 31, type: 1),
      MRSExercises(name: 'Shoulder Press', time: 30, value: 32, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 33, type: 1),
      MRSExercises(name: 'Shoulder Press', time: 30, value: 34, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 35, type: 1),
      MRSExercises(name: 'Shoulder Press', time: 30, value: 36, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 37, type: 1),
      MRSExercises(name: 'Shoulder Press', time: 30, value: 38, type: 0),
    ],
  ),
  MRSetupModel(
    value: 15,
    type: 5,
    routine: 'Static Stretching- Full Body Short & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 60, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 60,
          value: 5,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 6, type: 0),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
    ],
  ),

  /// cardio active recovery
  MRSetupModel(
    value: 16,
    type: 6,
    routine:
        'Light Intensity Exercise (Walking, Golfing, Swimming or Biking at a low intensity, Etc.)',
    exercises: [
      MRSExercises(
          name:
              'Light Intensity Exercise (Walking, Golfing, Swimming or Biking at a low intensity, Etc.)',
          value: 0,
          time: 1800,
          type: 0),
    ],
  ),

  /// strength (free weight)
  MRSetupModel(
    value: 18,
    type: 4,
    routine: 'warm up full body',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 19,
    type: 4,
    routine: 'Free weights Full Body barebones 4 sets 30 work/ 30 rest',
    exercises: [
      MRSExercises(name: 'Bent Over Row', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 1, type: 1),
      MRSExercises(name: 'Bent Over Row', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 3, type: 1),
      MRSExercises(name: 'Bent Over Row', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 5, type: 1),
      MRSExercises(name: 'Bent Over Row', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 7, type: 1),
      MRSExercises(name: 'Back Squat', time: 30, value: 8, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 9, type: 1),
      MRSExercises(name: 'Back Squat', time: 30, value: 10, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 11, type: 1),
      MRSExercises(name: 'Back Squat', time: 30, value: 12, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 13, type: 1),
      MRSExercises(name: 'Back Squat', time: 30, value: 14, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 15, type: 1),
      MRSExercises(name: 'Bench Press', time: 30, value: 16, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 17, type: 1),
      MRSExercises(name: 'Bench Press', time: 30, value: 18, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 19, type: 1),
      MRSExercises(name: 'Bench Press', time: 30, value: 20, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 21, type: 1),
      MRSExercises(name: 'Bench Press', time: 30, value: 22, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 23, type: 1),
      MRSExercises(name: 'Deadlift', time: 30, value: 24, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 25, type: 1),
      MRSExercises(name: 'Deadlift', time: 30, value: 26, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 27, type: 1),
      MRSExercises(name: 'Deadlift', time: 30, value: 28, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 29, type: 1),
      MRSExercises(name: 'Deadlift', time: 30, value: 30, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 31, type: 1),
      MRSExercises(name: 'Overhead Press', time: 30, value: 32, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 33, type: 1),
      MRSExercises(name: 'Overhead Press', time: 30, value: 34, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 25, type: 1),
      MRSExercises(name: 'Overhead Press', time: 30, value: 36, type: 0),
      MRSExercises(name: 'Rest', time: 30, value: 37, type: 1),
      MRSExercises(name: 'Overhead Press', time: 30, value: 38, type: 0),
    ],
  ),
  MRSetupModel(
    value: 20,
    type: 4,
    routine: 'Static Stretching- Full Body Short & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 60, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 60,
          value: 5,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 6, type: 0),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
    ],
  ),
];

List<MRSetupModel> fp2ExercisesList = <MRSetupModel>[
  /// overall health
  MRSetupModel(
    value: 0,
    type: 0,
    routine: 'warm up full body 2 sets',
    exercises: [
      MRSExercises(
        name: 'Neck rotations (clockwise and counter clockwise)',
        time: 30,
        value: 0,
        type: 0,
      ),
      MRSExercises(
        name: 'Run in place, jump rope, or perform jumping jacks',
        time: 30,
        value: 1,
        type: 0,
      ),
      MRSExercises(
        name:
            'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
        time: 30,
        value: 2,
        type: 0,
      ),
      MRSExercises(
        name: 'Side lunge with arm raises ',
        time: 30,
        value: 3,
        type: 0,
      ),
      MRSExercises(
        name: 'Lunge with torso rotations',
        time: 30,
        value: 4,
        type: 0,
      ),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
        name: 'Chest expansions with squats, palms facing upwards, thumbs out',
        time: 30,
        value: 6,
        type: 0,
      ),
      MRSExercises(
        name: 'Neck rotations (clockwise and counter clockwise)',
        time: 30,
        value: 7,
        type: 0,
      ),
      MRSExercises(
        name: 'Run in place, jump rope, or perform jumping jacks',
        time: 30,
        value: 8,
        type: 0,
      ),
      MRSExercises(
        name:
            'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
        time: 30,
        value: 9,
        type: 0,
      ),
      MRSExercises(
        name: 'Side lunge with arm raises ',
        time: 30,
        value: 10,
        type: 0,
      ),
      MRSExercises(
        name: 'Lunge with torso rotations',
        time: 30,
        value: 11,
        type: 0,
      ),
      MRSExercises(name: 'Hip rotations', time: 30, value: 12, type: 0),
      MRSExercises(
        name: 'Chest expansions with squats, palms facing upwards, thumbs out',
        time: 30,
        value: 13,
        type: 0,
      ),
    ],
  ),
  MRSetupModel(
    value: 1,
    type: 0,
    routine: 'Bodyweight- Full Version Balanced 4 sets 180 sec rests',
    exercises: [
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 1, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 3, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 5, type: 0),
      MRSExercises(name: 'Horizontal Pullup', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 7, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 8, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 9, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 10, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 11, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 12, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 13, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 14, type: 0),
      MRSExercises(name: 'Horizontal Pullup', time: 30, value: 15, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 16, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 17, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 18, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 19, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 20, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 21, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 22, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 23, type: 0),
      MRSExercises(name: 'Horizontal Pullup', time: 30, value: 24, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 25, type: 0),
      // MRSExercises(name: 'Rest', time: 30, value: 26, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 27, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 28, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 29, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 30, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 31, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 32, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 33, type: 0),
      MRSExercises(name: 'Horizontal Pullup', time: 30, value: 34, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 35, type: 0),
      // MRSExercises(name: 'Rest', time: 30, value: 36, type: 0),
    ],
  ),
  MRSetupModel(
    value: 2,
    type: 0,
    routine: 'Static Stretching- Full Body Complete & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
        name: 'Butterfly (groin stretch)',
        time: 60,
        value: 2,
        type: 0,
      ),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
        name:
            'Neck Stretches (Left, right, front, back, and side to side lightly)',
        time: 60,
        value: 5,
        type: 0,
      ),
      MRSExercises(
        name: 'Horizontal Pole Front to Back',
        time: 60,
        value: 6,
        type: 0,
      ),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
      // MRSExercises(name: 'Splits Series', time: 60, value: 8, type: 0),
      MRSExercises(name: 'Step 1: Hip opener', time: 60, value: 9, type: 0),
      MRSExercises(
        name: 'Step 2: Hamstring opener',
        time: 60,
        value: 10,
        type: 0,
      ),
      MRSExercises(name: 'Step 3: Full splits', time: 60, value: 11, type: 0),
      MRSExercises(name: 'Step 4: Middle Splits', time: 60, value: 12, type: 0),
      MRSExercises(name: 'Downward dog', time: 60, value: 13, type: 0),
      MRSExercises(name: 'lying spinal twist', time: 60, value: 14, type: 0),
      MRSExercises(
        name: 'Horizontal Pole Front to Back',
        time: 60,
        value: 15,
        type: 0,
      ),
      MRSExercises(name: 'car cow stretch', time: 60, value: 16, type: 0),
      MRSExercises(name: 'Vertical Pole', time: 60, value: 17, type: 0),
    ],
  ),

  /// cardio
  MRSetupModel(
    value: 3,
    type: 1,
    routine: 'warm up full body cardio 2 sets',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 7,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 8,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 9,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 10, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 11, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 12, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 13,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 4,
    type: 1,
    routine: '4X4 Intervals 4 sets',
    exercises: [
      MRSExercises(name: 'Medium-High Intensity', time: 240, value: 0, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 180,
          value: 1,
          type: 0),
      MRSExercises(name: 'Medium-High Intensity', time: 240, value: 2, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 180,
          value: 3,
          type: 0),
      MRSExercises(name: 'Medium-High Intensity', time: 240, value: 4, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 180,
          value: 5,
          type: 0),
      MRSExercises(name: 'Medium-High Intensity', time: 240, value: 6, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 180,
          value: 7,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 5,
    type: 1,
    routine: 'Static Stretching- Full Body Short & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 60, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 60,
          value: 5,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 6, type: 0),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
    ],
  ),

  /// mobility
  MRSetupModel(
    value: 6,
    type: 2,
    routine: 'warm up full body 2 sets',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 8,
          type: 0),
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 7,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 9,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 10, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 11, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 12, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 13,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 7,
    type: 2,
    routine: 'Static Stretching- Full Body Complete & Easy 120 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 120, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 120, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 120, value: 2, type: 0),
      MRSExercises(
          name: 'low lunge (right side)', time: 120, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 120, value: 4, type: 0),
      MRSExercises(name: 'knee to chest', time: 120, value: 5, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 120,
          value: 6,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 120, value: 7, type: 0),
      MRSExercises(name: 'grab door handle', time: 120, value: 8, type: 0),
      // MRSExercises(name: 'Split series', time: 120, value: 9),
      MRSExercises(name: 'Step 1: Hip opener', time: 120, value: 10, type: 0),
      MRSExercises(
          name: 'Step2: Hamstring opener', time: 120, value: 11, type: 0),
      MRSExercises(name: 'Step3: Full splits', time: 120, value: 12, type: 0),
      MRSExercises(name: 'Step4: Middle splits', time: 120, value: 13, type: 0),
      MRSExercises(name: 'downward dog', time: 120, value: 14, type: 0),
      MRSExercises(name: 'lying spinal twist', time: 120, value: 15, type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 120, value: 16, type: 0),
      MRSExercises(name: 'cat cow stretch', time: 120, value: 17, type: 0),
      MRSExercises(name: 'Vertical Pole', time: 120, value: 18, type: 0),
    ],
  ),

  /// strength anywhere (bodyweight)
  MRSetupModel(
    value: 8,
    type: 3,
    routine: 'warm up full body ',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 9,
    type: 3,
    routine: 'Bodyweight- Full Version Balanced 5 sets 180 sec rests',
    exercises: [
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 1, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 3, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 5, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 7, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 8, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 9, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 10, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 11, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 12, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 13, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 14, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 15, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 16, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 17, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 18, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 19, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 20, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 21, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 22, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 23, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 24, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 25, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 26, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 27, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 28, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 29, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 30, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 31, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 32, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 33, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 34, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 35, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 36, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 37, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 38, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 39, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 40, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 41, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 42, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 43, type: 0),
    ],
  ),
  MRSetupModel(
    value: 10,
    type: 3,
    routine: 'Static Stretching Full Body barebones 30 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 60, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 60,
          value: 5,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 6, type: 0),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
    ],
  ),

  /// cardio continuous
  MRSetupModel(
    value: 17,
    type: 7,
    routine: 'warm up full body cardio',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name: 'High knees with lateral arm crosses',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 11,
    type: 7,
    routine: 'Low Intensity Steady State (Continuous) Cardio',
    exercises: [
      MRSExercises(
          name:
              'Medium Intensity Exercise (Walking, Jogging, Swimming, Biking, Etc.)',
          time: 2100,
          value: 0,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 12,
    type: 7,
    routine: 'Static Stretching- Full Body Short & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 60, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 60,
          value: 5,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 6, type: 0),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
    ],
  ),

  /// strength machine
  MRSetupModel(
    value: 13,
    type: 5,
    routine: 'warm up full body',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 14,
    type: 5,
    routine: 'Machines Full Body barebones 4 sets 30 work/ 60 rest',
    exercises: [
      MRSExercises(name: 'Lat Pull Down', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 1, type: 1),
      MRSExercises(name: 'Lat Pull Down', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 3, type: 1),
      MRSExercises(name: 'Lat Pull Down', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 5, type: 1),
      MRSExercises(name: 'Lat Pull Down', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 7, type: 1),
      MRSExercises(name: 'Smith Machine Squat', time: 30, value: 8, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 9, type: 1),
      MRSExercises(name: 'Smith Machine Squat', time: 30, value: 10, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 11, type: 1),
      MRSExercises(name: 'Smith Machine Squat', time: 30, value: 12, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 13, type: 1),
      MRSExercises(name: 'Smith Machine Squat', time: 30, value: 14, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 15, type: 1),
      MRSExercises(name: 'Chest Press', time: 30, value: 16, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 17, type: 1),
      MRSExercises(name: 'Chest Press', time: 30, value: 18, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 19, type: 1),
      MRSExercises(name: 'Chest Press', time: 30, value: 20, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 21, type: 1),
      MRSExercises(name: 'Chest Press', time: 30, value: 22, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 23, type: 1),
      MRSExercises(
          name: 'Smith Machine Deadlift', time: 30, value: 24, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 25, type: 1),
      MRSExercises(
          name: 'Smith Machine Deadlift', time: 30, value: 26, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 27, type: 1),
      MRSExercises(
          name: 'Smith Machine Deadlift', time: 30, value: 28, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 29, type: 1),
      MRSExercises(
          name: 'Smith Machine Deadlift', time: 30, value: 30, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 31, type: 1),
      MRSExercises(name: 'Shoulder Press', time: 30, value: 32, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 33, type: 1),
      MRSExercises(name: 'Shoulder Press', time: 30, value: 34, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 35, type: 1),
      MRSExercises(name: 'Shoulder Press', time: 30, value: 36, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 37, type: 1),
      MRSExercises(name: 'Shoulder Press', time: 30, value: 38, type: 0),
    ],
  ),
  MRSetupModel(
    value: 15,
    type: 5,
    routine: 'Static Stretching- Full Body Short & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 60, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 60,
          value: 5,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 6, type: 0),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
    ],
  ),

  /// cardio active recovery
  MRSetupModel(
    value: 16,
    type: 6,
    routine:
        'Light Intensity Exercise (Walking, Golfing, Swimming or Biking at a low intensity, Etc.)',
    exercises: [
      MRSExercises(
          name:
              'Light Intensity Exercise (Walking, Golfing, Swimming or Biking at a low intensity, Etc.)',
          value: 0,
          time: 2700,
          type: 0),
    ],
  ),

  /// strength free weight
  MRSetupModel(
    value: 18,
    type: 4,
    routine: 'warm up full body',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 19,
    type: 4,
    routine: 'Free weights Full Body barebones 4 sets 30 work/ 60 rest',
    exercises: [
      MRSExercises(name: 'Bent Over Row', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 1, type: 1),
      MRSExercises(name: 'Bent Over Row', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 3, type: 1),
      MRSExercises(name: 'Bent Over Row', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 5, type: 1),
      MRSExercises(name: 'Bent Over Row', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 7, type: 1),
      MRSExercises(name: 'Back Squat', time: 30, value: 8, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 9, type: 1),
      MRSExercises(name: 'Back Squat', time: 30, value: 10, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 11, type: 1),
      MRSExercises(name: 'Back Squat', time: 30, value: 12, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 13, type: 1),
      MRSExercises(name: 'Back Squat', time: 30, value: 14, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 15, type: 1),
      MRSExercises(name: 'Bench Press', time: 30, value: 16, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 17, type: 1),
      MRSExercises(name: 'Bench Press', time: 30, value: 18, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 19, type: 1),
      MRSExercises(name: 'Bench Press', time: 30, value: 20, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 21, type: 1),
      MRSExercises(name: 'Bench Press', time: 30, value: 22, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 23, type: 1),
      MRSExercises(name: 'Deadlift', time: 30, value: 24, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 25, type: 1),
      MRSExercises(name: 'Deadlift', time: 30, value: 26, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 27, type: 1),
      MRSExercises(name: 'Deadlift', time: 30, value: 28, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 29, type: 1),
      MRSExercises(name: 'Deadlift', time: 30, value: 30, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 31, type: 1),
      MRSExercises(name: 'Overhead Press', time: 30, value: 32, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 33, type: 1),
      MRSExercises(name: 'Overhead Press', time: 30, value: 34, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 25, type: 1),
      MRSExercises(name: 'Overhead Press', time: 30, value: 36, type: 0),
      MRSExercises(name: 'Rest', time: 60, value: 37, type: 1),
      MRSExercises(name: 'Overhead Press', time: 30, value: 38, type: 0),
    ],
  ),
  MRSetupModel(
    value: 20,
    type: 4,
    routine: 'Static Stretching- Full Body Short & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 60, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 60,
          value: 5,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 6, type: 0),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
    ],
  ),
];

List<MRSetupModel> fp3ExercisesList = <MRSetupModel>[
  /// overall health
  MRSetupModel(
    value: 0,
    type: 0,
    routine: 'warm up full body 2 sets',
    exercises: [
      MRSExercises(
        name: 'Neck rotations (clockwise and counter clockwise)',
        time: 30,
        value: 0,
        type: 0,
      ),
      MRSExercises(
        name: 'Run in place, jump rope, or perform jumping jacks',
        time: 30,
        value: 1,
        type: 0,
      ),
      MRSExercises(
        name:
            'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
        time: 30,
        value: 2,
        type: 0,
      ),
      MRSExercises(
        name: 'Side lunge with arm raises ',
        time: 30,
        value: 3,
        type: 0,
      ),
      MRSExercises(
        name: 'Lunge with torso rotations',
        time: 30,
        value: 4,
        type: 0,
      ),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
        name: 'Chest expansions with squats, palms facing upwards, thumbs out',
        time: 30,
        value: 6,
        type: 0,
      ),
      MRSExercises(
        name: 'Run in place, jump rope, or perform jumping jacks',
        time: 30,
        value: 8,
        type: 0,
      ),
      MRSExercises(
        name: 'Neck rotations (clockwise and counter clockwise)',
        time: 30,
        value: 7,
        type: 0,
      ),
      MRSExercises(
        name:
            'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
        time: 30,
        value: 9,
        type: 0,
      ),
      MRSExercises(
        name: 'Side lunge with arm raises ',
        time: 30,
        value: 10,
        type: 0,
      ),
      MRSExercises(
        name: 'Lunge with torso rotations',
        time: 30,
        value: 11,
        type: 0,
      ),
      MRSExercises(name: 'Hip rotations', time: 30, value: 12, type: 0),
      MRSExercises(
        name: 'Chest expansions with squats, palms facing upwards, thumbs out',
        time: 30,
        value: 13,
        type: 0,
      ),
    ],
  ),
  MRSetupModel(
    value: 1,
    type: 0,
    routine: 'Bodyweight- Full Version Balanced 5 sets 180 sec rests',
    exercises: [
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 1, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 3, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 5, type: 0),
      MRSExercises(name: 'Horizontal Pullup', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 7, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 8, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 9, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 10, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 11, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 12, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 13, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 14, type: 0),
      MRSExercises(name: 'Horizontal Pullup', time: 30, value: 15, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 16, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 17, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 18, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 19, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 20, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 21, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 22, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 23, type: 0),
      MRSExercises(name: 'Horizontal Pullup', time: 30, value: 24, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 25, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 26, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 27, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 28, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 29, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 30, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 31, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 32, type: 0),
      MRSExercises(name: 'Horizontal Pullup', time: 30, value: 33, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 34, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 35, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 36, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 37, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 38, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 39, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 40, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 41, type: 0),
      MRSExercises(name: 'Horizontal Pullup', time: 30, value: 42, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 43, type: 0),
    ],
  ),
  MRSetupModel(
    value: 2,
    type: 0,
    routine: 'Static Stretching- Full Body Complete & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
        name: 'Butterfly (groin stretch)',
        time: 60,
        value: 2,
        type: 0,
      ),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
        name:
            'Neck Stretches (Left, right, front, back, and side to side lightly)',
        time: 60,
        value: 5,
        type: 0,
      ),
      MRSExercises(
        name: 'Horizontal Pole Front to Back',
        time: 60,
        value: 6,
        type: 0,
      ),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
      // MRSExercises(name: 'Splits Series', time: 60, value: 8),
      MRSExercises(name: 'Step 1: Hip opener', time: 60, value: 9, type: 0),
      MRSExercises(
        name: 'Step 2: Hamstring opener',
        time: 60,
        value: 10,
        type: 0,
      ),
      MRSExercises(name: 'Step 3: Full splits', time: 60, value: 11, type: 0),
      MRSExercises(name: 'Step 4: Middle Splits', time: 60, value: 12, type: 0),
      MRSExercises(name: 'Downward dog', time: 60, value: 13, type: 0),
      MRSExercises(name: 'lying spinal twist', time: 60, value: 14, type: 0),
      MRSExercises(
        name: 'Horizontal Pole Front to Back',
        time: 60,
        value: 15,
        type: 0,
      ),
      MRSExercises(name: 'car cow stretch', time: 60, value: 16, type: 0),
      MRSExercises(name: 'Vertical Pole', time: 60, value: 17, type: 0),
    ],
  ),

  /// cardio
  MRSetupModel(
    value: 6,
    type: 1,
    routine: 'warm up full body 2 sets',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 7,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 8,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 9,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 10, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 11, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 12, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 13,
          type: 0),
      // MRSExercises(
      //     name: 'Neck rotations (clockwise and counter clockwise)',
      //     time: 30,
      //     value: 14,
      //     type: 0),
      // MRSExercises(
      //     name: 'Run in place, jump rope, or perform jumping jacks',
      //     time: 30,
      //     value: 15,
      //     type: 0),
      // MRSExercises(
      //     name:
      //         'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
      //     time: 30,
      //     value: 16,
      //     type: 0),
      // MRSExercises(
      //     name: 'Side lunge with arm raises ', time: 30, value: 17, type: 0),
      // MRSExercises(
      //     name: 'Lunge with torso rotations', time: 30, value: 18, type: 0),
      // MRSExercises(name: 'Hip rotations', time: 30, value: 18, type: 0),
      // MRSExercises(
      //     name:
      //         'Chest expansions with squats, palms facing upwards, thumbs out',
      //     time: 30,
      //     value: 19,
      //     type: 0),
    ],
  ),
  MRSetupModel(
    value: 4,
    type: 1,
    routine: '4X4 Intervals 4 sets',
    exercises: [
      MRSExercises(name: 'Medium-High Intensity', time: 240, value: 0, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 180,
          value: 1,
          type: 0),
      MRSExercises(name: 'Medium-High Intensity', time: 240, value: 2, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 180,
          value: 3,
          type: 0),
      MRSExercises(name: 'Medium-High Intensity', time: 240, value: 4, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 180,
          value: 5,
          type: 0),
      MRSExercises(name: 'Medium-High Intensity', time: 240, value: 6, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 180,
          value: 7,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 7,
    type: 1,
    routine: 'Static Stretching- Full Body Complete & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 60, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      // MRSExercises(name: 'knee to chest', time: 60, value: 5, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 60,
          value: 6,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 7, type: 0),
      MRSExercises(name: 'grab door handle', time: 60, value: 8, type: 0),
      // MRSExercises(name: 'Split series', time: 120, value: 9),
      // MRSExercises(name: 'Step 1: Hip opener', time: 120, value: 10, type: 0),
      // MRSExercises(
      //     name: 'Step2: Hamstring opener', time: 120, value: 11, type: 0),
      // MRSExercises(name: 'Step3: Full splits', time: 120, value: 12, type: 0),
      // MRSExercises(name: 'Step4: Middle splits', time: 120, value: 13, type: 0),
      // MRSExercises(name: 'downward dog', time: 120, value: 14, type: 0),
      // MRSExercises(name: 'lying spinal twist', time: 120, value: 15, type: 0),
      // MRSExercises(
      //     name: 'Horizontal Pole Front to Back', time: 120, value: 16, type: 0),
      // MRSExercises(name: 'cat cow stretch', time: 120, value: 17, type: 0),
      // MRSExercises(name: 'Vertical Pole', time: 120, value: 18, type: 0),
    ],
  ),

  /// mobility
  MRSetupModel(
    value: 6,
    type: 2,
    routine: 'warm up full body 3 sets',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 8,
          type: 0),
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 7,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 9,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 10, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 11, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 12, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 13,
          type: 0),
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 14,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 15,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 16,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 17, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 18, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 19, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 20,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 7,
    type: 2,
    routine: 'Static Stretching- Full Body Complete & Easy 120 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 120, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 120, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 120, value: 2, type: 0),
      MRSExercises(
          name: 'low lunge (right side)', time: 120, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 120, value: 4, type: 0),
      MRSExercises(name: 'knee to chest', time: 120, value: 5, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 120,
          value: 6,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 120, value: 7, type: 0),
      MRSExercises(name: 'grab door handle', time: 120, value: 8, type: 0),
      // MRSExercises(name: 'Split series', time: 120, value: 9),
      MRSExercises(name: 'Step 1: Hip opener', time: 120, value: 10, type: 0),
      MRSExercises(
          name: 'Step2: Hamstring opener', time: 120, value: 11, type: 0),
      MRSExercises(name: 'Step3: Full splits', time: 120, value: 12, type: 0),
      MRSExercises(name: 'Step4: Middle splits', time: 120, value: 13, type: 0),
      MRSExercises(name: 'downward dog', time: 120, value: 14, type: 0),
      MRSExercises(name: 'lying spinal twist', time: 120, value: 15, type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 120, value: 16, type: 0),
      MRSExercises(name: 'cat cow stretch', time: 120, value: 17, type: 0),
      MRSExercises(name: 'Vertical Pole', time: 120, value: 18, type: 0),
    ],
  ),

  /// strength anywhere (bodyweight)
  MRSetupModel(
    value: 8,
    type: 3,
    routine: 'warm up full body 2 sets',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 7,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 8,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 9,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 10, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 11, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 12, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 13,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 9,
    type: 3,
    routine: 'Bodyweight- Full Version Balanced 5 sets 180 sec rests',
    exercises: [
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 1, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 3, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 5, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 7, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 8, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 9, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 10, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 11, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 12, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 13, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 14, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 15, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 16, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 17, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 18, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 19, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 20, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 21, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 22, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 23, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 24, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 25, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 26, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 27, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 28, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 29, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 30, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 31, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 32, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 33, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 34, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 35, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 36, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 37, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 38, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 39, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 40, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 41, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 42, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 43, type: 0),
    ],
  ),
  MRSetupModel(
    value: 10,
    type: 3,
    routine: 'Static Stretching- Full Body Short & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 60, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 60,
          value: 5,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 6, type: 0),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
    ],
  ),

  /// cardio continuous
  MRSetupModel(
    value: 17,
    type: 7,
    routine: 'warm up full body cardio',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name: 'High knees with lateral arm crosses',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 11,
    type: 7,
    routine: 'Low Intensity Steady State (Continuous) Cardio',
    exercises: [
      MRSExercises(
          name:
              'Medium Intensity Exercise (Walking, Jogging, Swimming, Biking, Etc.)',
          time: 3000,
          value: 0,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 12,
    type: 7,
    routine: 'Static Stretching- Full Body Short & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 60, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 60,
          value: 5,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 6, type: 0),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
    ],
  ),

  /// strength machine
  MRSetupModel(
    value: 13,
    type: 5,
    routine: 'warm up full body',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 14,
    type: 5,
    routine: 'Machines Full Body barebones 4 sets 30 work/ 120 rest',
    exercises: [
      MRSExercises(name: 'Lat Pull Down', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 1, type: 1),
      MRSExercises(name: 'Lat Pull Down', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 3, type: 1),
      MRSExercises(name: 'Lat Pull Down', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 5, type: 1),
      MRSExercises(name: 'Lat Pull Down', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 7, type: 1),
      MRSExercises(name: 'Smith Machine Squat', time: 30, value: 8, type: 1),
      MRSExercises(name: 'Rest', time: 120, value: 9, type: 1),
      MRSExercises(name: 'Smith Machine Squat', time: 30, value: 10, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 11, type: 1),
      MRSExercises(name: 'Smith Machine Squat', time: 30, value: 12, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 13, type: 1),
      MRSExercises(name: 'Smith Machine Squat', time: 30, value: 14, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 15, type: 1),
      MRSExercises(name: 'Chest Press', time: 30, value: 16, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 17, type: 1),
      MRSExercises(name: 'Chest Press', time: 30, value: 18, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 19, type: 1),
      MRSExercises(name: 'Chest Press', time: 30, value: 20, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 21, type: 1),
      MRSExercises(name: 'Chest Press', time: 30, value: 22, type: 1),
      MRSExercises(name: 'Rest', time: 120, value: 23, type: 1),
      MRSExercises(
          name: 'Smith Machine Deadlift', time: 30, value: 24, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 25, type: 1),
      MRSExercises(
          name: 'Smith Machine Deadlift', time: 30, value: 26, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 27, type: 1),
      MRSExercises(
          name: 'Smith Machine Deadlift', time: 30, value: 28, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 29, type: 1),
      MRSExercises(
          name: 'Smith Machine Deadlift', time: 30, value: 30, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 31, type: 1),
      MRSExercises(name: 'Shoulder Press', time: 30, value: 32, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 33, type: 1),
      MRSExercises(name: 'Shoulder Press', time: 30, value: 34, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 35, type: 1),
      MRSExercises(name: 'Shoulder Press', time: 30, value: 36, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 37, type: 1),
      MRSExercises(name: 'Shoulder Press', time: 30, value: 38, type: 0),
    ],
  ),
  MRSetupModel(
    value: 15,
    type: 5,
    routine: 'Static Stretching- Full Body Short & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 60, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 60,
          value: 5,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 6, type: 0),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
    ],
  ),

  /// cardio active recevery
  MRSetupModel(
    value: 16,
    type: 6,
    routine:
        'Light Intensity Exercise (Walking, Golfing, Swimming or Biking at a low intensity, Etc.)',
    exercises: [
      MRSExercises(
          name:
              'Light Intensity Exercise (Walking, Golfing, Swimming or Biking at a low intensity, Etc.)',
          value: 0,
          time: 3600,
          type: 0),
    ],
  ),

  /// strength free weight
  MRSetupModel(
    value: 18,
    type: 4,
    routine: 'warm up full body',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 19,
    type: 4,
    routine: 'Free weights Full Body barebones 4 sets 30 work/ 120 rest',
    exercises: [
      MRSExercises(name: 'Bent Over Row', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 1, type: 1),
      MRSExercises(name: 'Bent Over Row', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 3, type: 1),
      MRSExercises(name: 'Bent Over Row', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 5, type: 1),
      MRSExercises(name: 'Bent Over Row', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 7, type: 1),
      MRSExercises(name: 'Back Squat', time: 30, value: 8, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 9, type: 1),
      MRSExercises(name: 'Back Squat', time: 30, value: 10, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 11, type: 1),
      MRSExercises(name: 'Back Squat', time: 30, value: 12, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 13, type: 1),
      MRSExercises(name: 'Back Squat', time: 30, value: 14, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 15, type: 1),
      MRSExercises(name: 'Bench Press', time: 30, value: 16, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 17, type: 1),
      MRSExercises(name: 'Bench Press', time: 30, value: 18, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 19, type: 1),
      MRSExercises(name: 'Bench Press', time: 30, value: 20, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 21, type: 1),
      MRSExercises(name: 'Bench Press', time: 30, value: 22, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 23, type: 1),
      MRSExercises(name: 'Deadlift', time: 30, value: 24, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 25, type: 1),
      MRSExercises(name: 'Deadlift', time: 30, value: 26, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 27, type: 1),
      MRSExercises(name: 'Deadlift', time: 30, value: 28, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 29, type: 1),
      MRSExercises(name: 'Deadlift', time: 30, value: 30, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 31, type: 1),
      MRSExercises(name: 'Overhead Press', time: 30, value: 32, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 33, type: 1),
      MRSExercises(name: 'Overhead Press', time: 30, value: 34, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 25, type: 1),
      MRSExercises(name: 'Overhead Press', time: 30, value: 36, type: 0),
      MRSExercises(name: 'Rest', time: 120, value: 37, type: 1),
      MRSExercises(name: 'Overhead Press', time: 30, value: 38, type: 0),
    ],
  ),
   MRSetupModel(
    value: 20,
    type: 4,
    routine: 'Static Stretching- Full Body Short & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 60, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 60,
          value: 5,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 6, type: 0),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
    ],
  ),
];

List<MRSetupModel> fp4ExercisesList = <MRSetupModel>[
  /// overall health
  MRSetupModel(
    value: 0,
    type: 0,
    routine: 'warm up full body 3 sets',
    exercises: [
      MRSExercises(
        name: 'Neck rotations (clockwise and counter clockwise)',
        time: 30,
        value: 0,
        type: 0,
      ),
      MRSExercises(
        name: 'Run in place, jump rope, or perform jumping jacks',
        time: 30,
        value: 1,
        type: 0,
      ),
      MRSExercises(
        name:
            'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
        time: 30,
        value: 2,
        type: 0,
      ),
      MRSExercises(
        name: 'Side lunge with arm raises ',
        time: 30,
        value: 3,
        type: 0,
      ),
      MRSExercises(
        name: 'Lunge with torso rotations',
        time: 30,
        value: 4,
        type: 0,
      ),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
        name: 'Chest expansions with squats, palms facing upwards, thumbs out',
        time: 30,
        value: 6,
        type: 0,
      ),
      MRSExercises(
        name: 'Neck rotations (clockwise and counter clockwise)',
        time: 30,
        value: 7,
        type: 0,
      ),
      MRSExercises(
        name: 'Run in place, jump rope, or perform jumping jacks',
        time: 30,
        value: 8,
        type: 0,
      ),
      MRSExercises(
        name:
            'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
        time: 30,
        value: 9,
        type: 0,
      ),
      MRSExercises(
        name: 'Side lunge with arm raises ',
        time: 30,
        value: 10,
        type: 0,
      ),
      MRSExercises(
        name: 'Lunge with torso rotations',
        time: 30,
        value: 11,
        type: 0,
      ),
      MRSExercises(name: 'Hip rotations', time: 30, value: 12, type: 0),
      MRSExercises(
        name: 'Chest expansions with squats, palms facing upwards, thumbs out',
        time: 30,
        value: 13,
        type: 0,
      ),
      MRSExercises(
        name: 'Neck rotations (clockwise and counter clockwise)',
        time: 30,
        value: 14,
        type: 0,
      ),
      MRSExercises(
        name: 'Run in place, jump rope, or perform jumping jacks',
        time: 30,
        value: 15,
        type: 0,
      ),
      MRSExercises(
        name:
            'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
        time: 30,
        value: 16,
        type: 0,
      ),
      MRSExercises(
        name: 'Side lunge with arm raises ',
        time: 30,
        value: 17,
        type: 0,
      ),
      MRSExercises(
        name: 'Lunge with torso rotations',
        time: 30,
        value: 18,
        type: 0,
      ),
      MRSExercises(name: 'Hip rotations', time: 30, value: 19, type: 0),
      MRSExercises(
        name: 'Chest expansions with squats, palms facing upwards, thumbs out',
        time: 30,
        value: 20,
        type: 0,
      ),
    ],
  ),
  MRSetupModel(
    value: 1,
    type: 0,
    routine: 'Bodyweight- Full Version Balanced 5 sets 180 sec rests',
    exercises: [
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 1, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 3, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 5, type: 0),
      MRSExercises(name: 'Horizontal Pullup', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 7, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 8, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 9, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 10, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 11, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 12, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 13, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 14, type: 0),
      MRSExercises(name: 'Horizontal Pullup', time: 30, value: 15, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 16, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 17, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 18, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 19, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 20, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 21, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 22, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 23, type: 0),
      MRSExercises(name: 'Horizontal Pullup', time: 30, value: 24, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 25, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 26, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 27, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 28, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 29, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 30, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 31, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 32, type: 0),
      MRSExercises(name: 'Horizontal Pullup', time: 30, value: 33, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 34, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 35, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 36, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 37, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 38, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 39, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 40, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 41, type: 0),
      MRSExercises(name: 'Horizontal Pullup', time: 30, value: 42, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 43, type: 0),
    ],
  ),
  MRSetupModel(
    value: 2,
    type: 0,
    routine: 'Static Stretching- Full Body Complete & Easy 120 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 120, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 120, value: 1, type: 0),
      MRSExercises(
        name: 'Butterfly (groin stretch)',
        time: 120,
        value: 2,
        type: 0,
      ),
      MRSExercises(
        name: 'low lunge (right side)',
        time: 120,
        value: 3,
        type: 0,
      ),
      MRSExercises(name: 'low lunge (left side)', time: 120, value: 4, type: 0),
      MRSExercises(
        name:
            'Neck Stretches (Left, right, front, back, and side to side lightly)',
        time: 120,
        value: 5,
        type: 0,
      ),
      MRSExercises(
        name: 'Horizontal Pole Front to Back',
        time: 120,
        value: 6,
        type: 0,
      ),
      MRSExercises(name: 'grab door handle', time: 120, value: 7, type: 0),
      // MRSExercises(name: 'Splits Series', time: 120, value: 8, type: 0),
      MRSExercises(name: 'Step 1: Hip opener', time: 120, value: 9, type: 0),
      MRSExercises(
        name: 'Step 2: Hamstring opener',
        time: 120,
        value: 10,
        type: 0,
      ),
      MRSExercises(name: 'Step 3: Full splits', time: 120, value: 11, type: 0),
      MRSExercises(
        name: 'Step 4: Middle Splits',
        time: 120,
        value: 12,
        type: 0,
      ),
      MRSExercises(name: 'Downward dog', time: 120, value: 13, type: 0),
      MRSExercises(name: 'lying spinal twist', time: 120, value: 14, type: 0),
      MRSExercises(
        name: 'Horizontal Pole Front to Back',
        time: 120,
        value: 15,
        type: 0,
      ),
      MRSExercises(name: 'car cow stretch', time: 120, value: 16, type: 0),
      MRSExercises(name: 'Vertical Pole', time: 120, value: 17, type: 0),
    ],
  ),

  /// cardio
  MRSetupModel(
    value: 17,
    type: 1,
    routine: 'warm up full body cardio 2 sets',
    exercises: [
      MRSExercises(
        name: 'Neck rotations (clockwise and counter clockwise)',
        time: 30,
        value: 0,
        type: 0,
      ),
      MRSExercises(
        name: 'Run in place, jump rope, or perform jumping jacks',
        time: 30,
        value: 1,
        type: 0,
      ),
      MRSExercises(
        name: 'High knees with lateral arm crosses',
        time: 30,
        value: 2,
        type: 0,
      ),
      MRSExercises(
        name: 'Side lunge with arm raises ',
        time: 30,
        value: 3,
        type: 0,
      ),
      MRSExercises(
        name: 'Lunge with torso rotations',
        time: 30,
        value: 4,
        type: 0,
      ),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
        name: 'Chest expansions with squats, palms facing upwards, thumbs out',
        time: 30,
        value: 6,
        type: 0,
      ),
      MRSExercises(
        name: 'Neck rotations (clockwise and counter clockwise)',
        time: 30,
        value: 7,
        type: 0,
      ),
      MRSExercises(
        name: 'Run in place, jump rope, or perform jumping jacks',
        time: 30,
        value: 8,
        type: 0,
      ),
      MRSExercises(
        name: 'High knees with lateral arm crosses',
        time: 30,
        value: 9,
        type: 0,
      ),
      MRSExercises(
        name: 'Side lunge with arm raises ',
        time: 30,
        value: 10,
        type: 0,
      ),
      MRSExercises(
        name: 'Lunge with torso rotations',
        time: 30,
        value: 11,
        type: 0,
      ),
      MRSExercises(name: 'Hip rotations', time: 30, value: 12, type: 0),
      MRSExercises(
        name: 'Chest expansions with squats, palms facing upwards, thumbs out',
        time: 30,
        value: 13,
        type: 0,
      ),
    ],
  ),
  MRSetupModel(
    value: 4,
    type: 1,
    routine: '4X4 Intervals 4 sets',
    exercises: [
      MRSExercises(name: 'Medium-High Intensity', time: 240, value: 0, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 180,
          value: 1,
          type: 0),
      MRSExercises(name: 'Medium-High Intensity', time: 240, value: 2, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 180,
          value: 3,
          type: 0),
      MRSExercises(name: 'Medium-High Intensity', time: 240, value: 4, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 180,
          value: 5,
          type: 0),
      MRSExercises(name: 'Medium-High Intensity', time: 240, value: 6, type: 0),
      MRSExercises(
          name:
              'Active recovery (Walking, doing easy work, NOT completely resting)',
          time: 180,
          value: 7,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 7,
    type: 1,
    routine: 'Static Stretching- Full Body Complete & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 60, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 60,
          value: 6,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 7, type: 0),
      MRSExercises(name: 'grab door handle', time: 60, value: 8, type: 0),
    ],
  ),

  /// mobility
  MRSetupModel(
    value: 6,
    type: 2,
    routine: 'warm up full body 3 sets',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 8,
          type: 0),
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 7,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 9,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 10, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 11, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 12, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 13,
          type: 0),
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 14,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 15,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 16,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 17, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 18, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 19, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 20,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 7,
    type: 2,
    routine: 'Static Stretching- Full Body Complete & Easy 120 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 120, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 120, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 120, value: 2, type: 0),
      MRSExercises(
          name: 'low lunge (right side)', time: 120, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 120, value: 4, type: 0),
      MRSExercises(name: 'knee to chest', time: 120, value: 5, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 120,
          value: 6,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 120, value: 7, type: 0),
      MRSExercises(name: 'grab door handle', time: 120, value: 8, type: 0),
      // MRSExercises(name: 'Split series', time: 120, value: 9),
      MRSExercises(name: 'Step 1: Hip opener', time: 120, value: 10, type: 0),
      MRSExercises(
          name: 'Step2: Hamstring opener', time: 120, value: 11, type: 0),
      MRSExercises(name: 'Step3: Full splits', time: 120, value: 12, type: 0),
      MRSExercises(name: 'Step4: Middle splits', time: 120, value: 13, type: 0),
      MRSExercises(name: 'downward dog', time: 120, value: 14, type: 0),
      MRSExercises(name: 'lying spinal twist', time: 120, value: 15, type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 120, value: 16, type: 0),
      MRSExercises(name: 'cat cow stretch', time: 120, value: 17, type: 0),
      MRSExercises(name: 'Vertical Pole', time: 120, value: 18, type: 0),
    ],
  ),

  /// strength anywhere (bodyweight)
  MRSetupModel(
    value: 8,
    type: 3,
    routine: 'warm up full body 2 sets',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 7,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 8,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 9,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 10, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 11, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 12, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 13,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 9,
    type: 3,
    routine: 'Bodyweight- Full Version Balanced 5 sets 180 sec rests',
    exercises: [
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 1, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 3, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 5, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 7, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 8, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 9, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 10, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 11, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 12, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 13, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 14, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 15, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 16, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 17, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 18, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 19, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 20, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 21, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 22, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 23, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 24, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 25, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 26, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 27, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 28, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 29, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 30, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 31, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 32, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 33, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 34, type: 0),
      MRSExercises(name: 'Rest', time: 180, value: 35, type: 0),
      MRSExercises(name: 'Handstand Pushup', time: 30, value: 36, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 37, type: 0),
      MRSExercises(name: 'Bodyweight squat', time: 30, value: 38, type: 0),
      MRSExercises(name: 'Pushup', time: 30, value: 39, type: 0),
      MRSExercises(name: 'Leg Lift', time: 30, value: 40, type: 0),
      MRSExercises(name: 'Glute Bridge', time: 30, value: 41, type: 0),
      MRSExercises(name: 'Pullup', time: 30, value: 42, type: 0),
      MRSExercises(name: 'Plank', time: 30, value: 43, type: 0),
    ],
  ),
  MRSetupModel(
    value: 10,
    type: 3,
    routine: 'Static Stretching- Full Body Short & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 60, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 60,
          value: 5,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 6, type: 0),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
    ],
  ),

  /// cardio continuous
  MRSetupModel(
    value: 17,
    type: 7,
    routine: 'warm up full body cardio',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name: 'High knees with lateral arm crosses',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 11,
    type: 7,
    routine: 'Low Intensity Steady State (Continuous) Cardio',
    exercises: [
      MRSExercises(
        name:
            'Medium Intensity Exercise (Walking, Jogging, Swimming, Biking, Etc.)',
        time: 4000, // stopwatch
        value: 0,
        type: 0,
      ),
    ],
  ),
  MRSetupModel(
    value: 12,
    type: 7,
    routine: 'Static Stretching- Full Body Short & Easy 60 sec holds',
    exercises: [
      MRSExercises(name: 'Touch your toes', time: 60, value: 0, type: 0),
      MRSExercises(name: 'Doorway chest', time: 60, value: 1, type: 0),
      MRSExercises(
          name: 'Butterfly (groin stretch)', time: 60, value: 2, type: 0),
      MRSExercises(name: 'low lunge (right side)', time: 60, value: 3, type: 0),
      MRSExercises(name: 'low lunge (left side)', time: 60, value: 4, type: 0),
      MRSExercises(
          name:
              'Neck Stretches (Left, right, front, back, and side to side lightly)',
          time: 60,
          value: 5,
          type: 0),
      MRSExercises(
          name: 'Horizontal Pole Front to Back', time: 60, value: 6, type: 0),
      MRSExercises(name: 'grab door handle', time: 60, value: 7, type: 0),
    ],
  ),

  /// strength machine
  MRSetupModel(
    value: 13,
    type: 5,
    routine: 'warm up full body',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 14,
    type: 5,
    routine: 'Machines Full Body barebones 5 sets 30 work/ 150 rest',
    exercises: [
      MRSExercises(name: 'Lat Pull Down', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 1, type: 1),
      MRSExercises(name: 'Lat Pull Down', time: 30, value: 3, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 4, type: 1),
      MRSExercises(name: 'Lat Pull Down', time: 30, value: 5, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 6, type: 1),
      MRSExercises(name: 'Lat Pull Down', time: 30, value: 7, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 8, type: 1),
      MRSExercises(name: 'Lat Pull Down', time: 30, value: 9, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 10, type: 1),
      MRSExercises(name: 'Smith Machine Squat', time: 30, value: 11, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 12, type: 1),
      MRSExercises(name: 'Smith Machine Squat', time: 30, value: 13, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 14, type: 1),
      MRSExercises(name: 'Smith Machine Squat', time: 30, value: 15, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 16, type: 1),
      MRSExercises(name: 'Smith Machine Squat', time: 30, value: 17, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 18, type: 1),
      MRSExercises(name: 'Smith Machine Squat', time: 30, value: 19, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 20, type: 1),
      MRSExercises(name: 'Chest Press', time: 30, value: 21, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 22, type: 1),
      MRSExercises(name: 'Chest Press', time: 30, value: 23, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 24, type: 1),
      MRSExercises(name: 'Chest Press', time: 30, value: 25, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 26, type: 1),
      MRSExercises(name: 'Chest Press', time: 30, value: 27, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 28, type: 1),
      MRSExercises(name: 'Chest Press', time: 30, value: 29, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 30, type: 1),
      MRSExercises(
          name: 'Smith Machine Deadlift', time: 30, value: 31, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 32, type: 1),
      MRSExercises(
          name: 'Smith Machine Deadlift', time: 30, value: 33, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 34, type: 1),
      MRSExercises(
          name: 'Smith Machine Deadlift', time: 30, value: 35, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 36, type: 1),
      MRSExercises(
          name: 'Smith Machine Deadlift', time: 30, value: 37, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 38, type: 1),
      MRSExercises(
          name: 'Smith Machine Deadlift', time: 30, value: 39, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 40, type: 1),
      MRSExercises(name: 'Shoulder Press', time: 30, value: 41, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 42, type: 1),
      MRSExercises(name: 'Shoulder Press', time: 30, value: 43, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 44, type: 1),
      MRSExercises(name: 'Shoulder Press', time: 30, value: 45, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 46, type: 1),
      MRSExercises(name: 'Shoulder Press', time: 30, value: 47, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 48, type: 1),
      MRSExercises(name: 'Shoulder Press', time: 30, value: 49, type: 0),
    ],
  ),

  /// cardio active recovery
  MRSetupModel(
    value: 16,
    type: 6,
    routine:
        'Light Intensity Exercise (Walking, Golfing, Swimming or Biking at a low intensity, Etc.)',
    exercises: [
      MRSExercises(
          name:
              'Light Intensity Exercise (Walking, Golfing, Swimming or Biking at a low intensity, Etc.)',
          value: 0,
          time: 4800,
          type: 0),
    ],
  ),

  /// strength free weights
  MRSetupModel(
    value: 18,
    type: 4,
    routine: 'warm up full body',
    exercises: [
      MRSExercises(
          name: 'Neck rotations (clockwise and counter clockwise)',
          time: 30,
          value: 0,
          type: 0),
      MRSExercises(
          name: 'Run in place, jump rope, or perform jumping jacks',
          time: 30,
          value: 1,
          type: 0),
      MRSExercises(
          name:
              'Shoulder rotations both in small, medium, and large circles (clockwise and counter clockwise)',
          time: 30,
          value: 2,
          type: 0),
      MRSExercises(
          name: 'Side lunge with arm raises ', time: 30, value: 3, type: 0),
      MRSExercises(
          name: 'Lunge with torso rotations', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Hip rotations', time: 30, value: 5, type: 0),
      MRSExercises(
          name:
              'Chest expansions with squats, palms facing upwards, thumbs out',
          time: 30,
          value: 6,
          type: 0),
    ],
  ),
  MRSetupModel(
    value: 19,
    type: 4,
    routine: 'Free weights Full Body barebones 5 sets 30 work/ 150 restt',
    exercises: [
      MRSExercises(name: 'Bent Over Row', time: 30, value: 0, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 1, type: 1),
      MRSExercises(name: 'Bent Over Row', time: 30, value: 2, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 3, type: 1),
      MRSExercises(name: 'Bent Over Row', time: 30, value: 4, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 5, type: 1),
      MRSExercises(name: 'Bent Over Row', time: 30, value: 6, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 7, type: 1),
      MRSExercises(name: 'Bent Over Row', time: 30, value: 8, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 9, type: 1),
      MRSExercises(name: 'Back Squat', time: 30, value: 10, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 11, type: 1),
      MRSExercises(name: 'Back Squat', time: 30, value: 12, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 13, type: 1),
      MRSExercises(name: 'Back Squat', time: 30, value: 14, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 15, type: 1),
      MRSExercises(name: 'Back Squat', time: 30, value: 16, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 17, type: 1),
      MRSExercises(name: 'Back Squat', time: 30, value: 18, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 19, type: 1),
      MRSExercises(name: 'Bench Press', time: 30, value: 20, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 21, type: 1),
      MRSExercises(name: 'Bench Press', time: 30, value: 22, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 23, type: 1),
      MRSExercises(name: 'Bench Press', time: 30, value: 24, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 25, type: 1),
      MRSExercises(name: 'Bench Press', time: 30, value: 26, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 27, type: 1),
      MRSExercises(name: 'Bench Press', time: 30, value: 28, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 29, type: 1),
      MRSExercises(name: 'Deadlift', time: 30, value: 30, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 31, type: 1),
      MRSExercises(name: 'Deadlift', time: 30, value: 32, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 33, type: 1),
      MRSExercises(name: 'Deadlift', time: 30, value: 34, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 35, type: 1),
      MRSExercises(name: 'Deadlift', time: 30, value: 36, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 37, type: 1),
      MRSExercises(name: 'Deadlift', time: 30, value: 38, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 39, type: 1),
      MRSExercises(name: 'Overhead Press', time: 30, value: 40, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 41, type: 1),
      MRSExercises(name: 'Overhead Press', time: 30, value: 42, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 43, type: 1),
      MRSExercises(name: 'Overhead Press', time: 30, value: 44, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 45, type: 1),
      MRSExercises(name: 'Overhead Press', time: 30, value: 46, type: 0),
      MRSExercises(name: 'Rest', time: 150, value: 47, type: 1),
      MRSExercises(name: 'Overhead Press', time: 30, value: 48, type: 0),
    ],
  ),
];

///
List<AppModel> settingList = <AppModel>[
  AppModel(
    'Auto-continue (Automatically continue to the next exercise after allotted time is complete)',
    '',
    value: 0,
  ),
  AppModel(
    'Manual continue (Manually confirm you want to move to the next exercise by clicking a button)',
    '',
    value: 1,
  ),
];

List<AppModel> accomplistmentSortList = <AppModel>[
  AppModel('Date', '', value: 0),
  AppModel('Event', '', value: 1),
  AppModel('Category', '', value: 2),
  AppModel('Duration', '', value: 3),
];
