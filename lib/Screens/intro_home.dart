// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Screens/Routines/routine_screen.dart';
import 'package:schedular_project/Screens/reading_library.dart';

import '../../Global/firebase_collections.dart';
import '../../Model/app_user.dart';
import '../../Services/auth_services.dart';
import '../../Widgets/app_bar.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/text_widget.dart';
import '../Functions/functions.dart';
import '../Model/app_modal.dart';
import 'custom_bottom.dart';

class IntroController extends GetxController {
  final Rx<CurrentExercises> history = CurrentExercises(
    id: intro,
    index: 8,
    value: 0,
    time: DateTime.now(),
    previousPractice: 0,
    previousReading: 0,
    connectedPractice: 0,
    connectedReading: 0,
    completed: false,
  ).obs;

  @override
  void onInit() async {
    await fetchHistory();
    super.onInit();
  }

  Rx<AppModel> introModel = AppModel('', '').obs;

  Future fetchHistory() async {
    debugPrint('fetching');
    await currentExercises(Get.find<AuthServices>().userid)
        .doc(intro)
        .get()
        .then((value) async {
      if (value.data() == {} || value.data() == null) {
        await currentExercises(Get.find<AuthServices>().userid)
            .doc(intro)
            .set(history.value.toMap());
      } else {
        history.value = CurrentExercises.fromMap(value.data());
      }
    });
    introModel.value = introList[introIndex(history.value.value!)];
  }

  Future updateReadingHistory() async {
    if (history.value.value == 0) {
      userReadings(Get.find<AuthServices>().userid).set({
        'intro': {'value': 0, 'element': 0, 'id': intro}
      }, SetOptions(merge: true));
    } else {
      userReadings(Get.find<AuthServices>().userid).update({
        'intro.element': FieldValue.increment(1),
      });
    }
  }

  Future updateHistory() async {
    if (history.value.value != 4 && !history.value.completed!) {
      if (introModel.value.type == 1) await updateReadingHistory();
      history.value.value = history.value.value! + 1;
      _updateData();
    } else if (history.value.value == 4) {
      if (introModel.value.type == 1) await updateReadingHistory();
      history.value.value = 4;
      history.value.completed = true;
      _updateData();
    }
  }

  _updateData() async {
    final _intro = introList[introIndex(history.value.value!)];
    history.value.previousPractice = _intro.prePractice ?? history.value.value;
    history.value.connectedPractice =
        _intro.connectedPractice ?? history.value.value;
    history.value.connectedReading =
        _intro.connectedReading ?? history.value.value;
    history.value.previousReading = _intro.preReading ?? history.value.value;
    await currentExercises(Get.find<AuthServices>().userid)
        .doc(history.value.id)
        .update(history.value.toMap());
    await fetchHistory();
  }

  selectData(int value) {
    introModel.value = introList[introIndex(value)];
    history.value = CurrentExercises(
      id: intro,
      index: 8,
      value: value,
      time: DateTime.now(),
      completed: false,
      connectedPractice: introModel.value.connectedPractice ?? value,
      connectedReading: introModel.value.connectedReading ?? value,
      previousPractice: introModel.value.prePractice ?? value,
      previousReading: introModel.value.preReading ?? value,
    );
  }
}

class IntroHome extends StatelessWidget {
  IntroHome({Key? key}) : super(key: key);
  final IntroController controller = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              headline('Intro').marginOnly(bottom: 30),
              Obx(
                () => TopList(
                  list: introList,
                  play: controller.introModel.value.ontap,
                  value: controller.history.value.value!,
                  onchanged: (val) {
                    // controller.history.value.value = val;
                    controller.selectData(val);
                  },
                ),
              ),
              Column(
                children: [
                  AppButton(
                    onTap: controller.history.value.value != 4
                        ? () {}
                        : () => Get.to(() => const AppRoutines()),
                    title: 'Routine Creator',
                    description: '',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(
                      () => CustomReadingLibrary(
                        title: 'Intro Library',
                        list: introList
                            .where((element) => element.type == 1)
                            .toList(),
                        color: const Color(0xffC2B8B8),
                      ),
                    ),
                    title: 'Intro Library',
                    description:
                        'Gain knowledge that unlocks techniques with massive practical wellness benefits.',
                  ).marginOnly(bottom: 30),
                ],
              ).marginOnly(left: 25, right: 25),
            ],
          ),
        ),
      ),
    );
  }
}

class WhatReading extends StatefulWidget {
  const WhatReading({Key? key}) : super(key: key);

  @override
  State<WhatReading> createState() => _WhatReadingState();
}

class _WhatReadingState extends State<WhatReading> {
  @override
  void dispose() {
    debugPrint('disposing');
    Get.find<IntroController>().updateHistory();
    debugPrint('disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
        child: Column(
          children: [
            ReadingTitle(title: 'I100- What and Why?', ontap: () {})
                .marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'Today more than ever, we need a way to organize our physical health, mental health, emotional health, and our highest aspirations into one efficient and time-saving system. The sad truth is that you can\'t be happy just being mediocre, by just following the patterns ingrained since childhood, by constantly reacting instead of proactively creating your reality. You can\'t achieve your goals. You can\'t have the most rewarding relationships and connections that you deserve. You can\'t be the person you dreamed of being as a child. You deserve to be your best self and achieve your dreams. \n',
            ),
            const TextWidget(
              text:
                  'This doesn’t mean you have to be rich, but you have to try every day to be better- listen more attentively to your family, build habits that create lifelong joy and mastery, hone your body and mind, learn to control your emotional outbursts and inner demons, get out of your comfort zone and grow, build deeper and more rewarding relationships, be the example you want to set, and yes, maybe, start that business and make a million a month. Reject fear and live your ideal life. It is possible and it’s simpler than you may think. By leveraging evidence-based methods, modern scientific research and scientifically validated ancient knowledge we destroy mediocrity where it stands giving you an unfair advantage over your peers.\n',
            ),
            const TextWidget(
                text:
                    'Below we list just some of the benefits you should expect to see over your peers with regular practice of this program. \n●Improved physical health \n\t○Achieved ideal body composition \n\t○Lengthened lifespan \n\t○Improved muscle strength, bone density, and tendon strength \n\t○Improved cardiovascular health, heart health, and blood circulation  \n\t○Increased fat burning at rest \n\t○Improved immune response and defense against infections \n\t○Improved lung capacity, speed, and endurance \n\t○Improved sexual health in men and women \n\t○Reduced inflammation \n\t○Better sleep quality and duration \n\t○Increased resistance to pain and cold temperatures'),
            const TextWidget(
              text:
                  '●Improved mental health \n\t○Increased brain speed \n\t○Increased amount and strength of neural connections in your brain \n\t○Increased Intelligence Quotient (IQ) \n\t○Increased focus \n\t○Increased productivity \n',
            ),
            const TextWidget(
              text:
                  '●Improved emotional health \n\t○Increased happiness and life satisfaction  \n\t○Increased sense of well-being \n\t○Better emotional regulation especially in times of high stress \n\t○Stronger intimate relationships \n\t○Increased resilience to stress \n\t○Reduced stress \n\t○Increased confidence \n\t○Increased self-esteem \n\t○Increased Emotional Quotient (EQ) \n\t○Increased attention \n',
            ),
            const TextWidget(
              text:
                  '●Live up to your highest aspirations \n\t○Learn how to stop, start, and alter habitual behavior for the long term \n\t○Define and articulate highest aspirations, values, and deepest motivations \n\t○Create a custom system and plan to reach goals that align with deepest values and motivations \n\t○Execute system daily (with the help of the latest research in behavioral design to make sure you actually show up) creating unstoppable momentum  \n\t○Track progress against goals to watch your dreams come true \n',
            ),
            const TextWidget(text: 'Why?', fontStyle: FontStyle.italic),
            const TextWidget(
              text:
                  'Stress, competition, distractions, and ease of access to unhealthy behaviors & entertainment are at all-time highs leading to an overstressed, overweight, emotionally frail, lethargic, frustrated, and mentally under stimulated population paralyzed by information overload or fear of failure. Most don’t know what they really want or why, even less have a plan to get there, and a tiny minority are following their plan to succeed. Most don’t have the focus to do so. Most aren’t actively cultivating their minds and bodies to attain that level of focus, clarity, and energy that leads to extremely outsized results.  \nWe must approach health holistically (as a whole) instead of in pieces. Going to the gym alone is simply not enough to compete. We can’t just get really buff with no emotional regulation and mental development or we might as well be gorillas. Who cares if you’re physically fit if you’re not living a fulfilled life or emotional trauma is wreaking havoc on your life with no solution in sight? Going to a therapist while (sometimes) immensely helpful is also notoriously expensive. Not to mention, focusing only on emotions can make us happy but neglecting our physical health can cause early death and poor quality of life. Meditation is great, but how do you sift through the religious dogma of multiple traditions to get to a rational understanding of its concepts? Even if we can overcome this hurdle, focusing on concentration and mental mastery, although it may be the noblest of pursuits, is a recipe for disease and poor physical and emotional health if training our bodies and emotions are neglected. ',
            ),
            const TextWidget(
              text:
                  'To combat the extreme levels of stress and the malaise of unhealthy behaviors that have become the default option for many people we need a truly integrated program for total health, not just one small portion of your total health. Breaking away from the traditional piecemeal model, that is so common today, of only focusing on one small aspect of yourself such as just your physical health, mental health, emotional health, or only focusing on financial goals at the expense of the other aspects of yourself.  \n\nWhat is your current physical health like? Sexual health? How well can you regulate your emotions? Do anxiety, anger, depression, or other emotions sometimes take over? Are you stressed? Do you have a system for managing stress and/ or stopping it before it even starts? Do you have any bad habits? What is your system to change these habits and introduce new ones? What are your deepest values, goals, and motivations? Do you know? What does that mean for the direction of your life and those around you that you love? What is your daily system to attain your goals and when will you achieve your goals? How do you organize all these disparate elements into a single system? And how do you fit everything into your tight schedule? ',
            ),
            const TextWidget(
                text: 'Information Overload ', fontStyle: FontStyle.italic),
            const TextWidget(
              text:
                  'We know we need to take care of our physical, emotional, and mental health in order to thrive more than ever. How do we do it with so many options available? In the modern world taking care of our mental and physical wellbeing is both harder and easier than ever before. We have more knowledge than ever at our beck and call. The massive amount of information available is creating more stratification than ever forming an enormous split between those living in abundance and those in squalor.  \n\nThere are approximately 300 trillion words on the internet and counting. That is a massive quantity of information available to the world, mostly for free. There are resources all over the internet and in print to help us control our stress, regulate our emotions, get in better physical shape, recover, take care of our mental health, and reach our goals. That is amazing and creates huge opportunities to gain knowledge, but how do we determine which are the best resources and which are a waste of time? Those that can decipher these resources and manipulate them to their own ends can build upon the shoulders of giants and utilize the power of collective human knowledge gained over thousands of years; however, the majority of the information on the internet is riddled with errors, is outright false, outdated, or a base of specialized knowledge is needed to understand it. How do we mind this gap? Even if we did take all the time to research the nearly endless stream of information and find the best of each type of program, how would we integrate these programs into our lives so they worked together synergistically and fit into a realistic time commitment?\n\n',
            ),
            const TextWidget(
                text: 'Give Yourself an Unfair Advantage\n',
                fontStyle: FontStyle.italic),
            const TextWidget(
              text:
                  'The solution to information overload is to try every fad diet, mediation app, workout, therapist, life coach, and consultant that you can find then aimlessly wander through the abyss of all of their competing methodologies, ideologies, and time commitments to thoroughly confuse yourself and eventually quit no better off and with much lighter pockets complaining that life isn’t fair. Or you could rely on our team and their thousands of hours spent researching and refining methodologies to give you an unfair advantage in life. Life isn’t fair. We are here to give you an unfair advantage in the quality of information and practices you will learn. An unfair advantage in the organizational structure of the program to maximize your free time. An unfair advantage in optimizing your physical health, lifespan, and body composition. An unfair advantage in regulating difficult to control emotional states. An unfair advantage in attaining laser-like focus, higher productivity, and creating massive resilience to stress. An unfair advantage in creating and executing a custom system to achieve what it is you want most in this world. Take what\'s in front of you and let yourself flourish and thrive.\n\n ',
            ),
            const TextWidget(
                text: 'Time Commitment ', fontStyle: FontStyle.italic),
            const TextWidget(
              text:
                  'This program is designed to fit into any schedule no matter how full. The excuse most of us give for our piecemeal style to health and wellness is that we simply don’t have time within our busy lives to spare. We give you a system that lets you start by committing less time than most people spend at the gym. You can even start by dedicating just 5 minutes a day and slowly move forward, or start at full throttle if you prefer. The beauty of the small-time commitment is that your chances of showing up skyrocket, which, when done consistently forms a habit that can be built upon. We also incorporate numerous inbuilt time-saving strategies to utilize your downtime, maximize your free time, and minimize distractions to get more done at a higher quality in less time. \n\n',
            ),
            const TextWidget(
                text: 'Long-Term Gains \n', fontStyle: FontStyle.italic),
            const TextWidget(
              text:
                  'We are not in this just to get a six-pack before summer (although that can be a great side effect). This program is designed to create life-long habits that stick because working out for 3 months then stopping for 9 months wreaks havoc on your body and creates few long-term benefits. The same applies to diet or working towards your goals. By creating habits that stick you reap massive benefits that keep accruing and building upon themselves even if you choose to stop using this program in the future.\n\n',
            ),
            const TextWidget(
                text: "Synergy & Residual Benefits\n ",
                fontStyle: FontStyle.italic),
            const TextWidget(
              text:
                  'Synergy is when the combined effect of two things is greater than the sum of their parts. We focus on practices that work together to create synergistic benefits to maximize the return you\'re getting for your time investment. For example, by starting with focus and breathing practices before working out we have better workouts leading to more muscle growth. Another example is by doing physical exercise before work we not only improve our physical health but boost our mood and energy levels leading to better work quality and faster achievement of our goals. Residual benefits occur when we receive a seemingly unrelated benefit from an activity such as by learning proper breathing and meditation techniques we not only reduce stress and improve focus but improve physical health through lowering of blood pressure and resting heart rate and improve emotional regulation through increased mindfulness. Another example is by learning to regulate our emotions we not only can become happier, but we can improve our physical health by breaking bad habits and starting new healthy habits that stick.  \n',
            ),
            const TextWidget(
              text:
                  'Those are just examples of some of the myriad synergistic and residual benefits you will experience. By following a balanced approach, we maximize our gains in all areas of our lives.\n\n',
            ),
            const TextWidget(
                text: 'Practice Anywhere\n\n', fontStyle: FontStyle.italic),
            const TextWidget(
              text:
                  'This program is designed without the need for a gym, lots of equipment, or any other facilities. We want you to be able to practice this program anywhere at any time regardless of your access to costly facilities or any facilities at all. You can practice this program while camping in the mountains, on your lunch break in the park, or really anywhere that you have space to move your body in its full range of motion. Many of the practices in this program can even be completed while sitting down in your car or lying in bed.\n\n',
            ),
            const TextWidget(
                text: 'Customizability and Substitution\n',
                fontStyle: FontStyle.italic),
            const TextWidget(
                text:
                    'This is not a one trick pony type of program, but a fully customizable system for anyone in any walk of life. You can customize this program to become the best golfer, chef, husband, mother, best-selling author, business magnate, or simply to optimize your physical, emotional, and mental health.  \n'),
            const TextWidget(
              text:
                  'Each portion of this program is essential, but our method is not the only method. Feel free to substitute CrossFit, playing sports, or your qualified personal trainer’s workout for the workout we provide. If you go to a local Buddhist temple or yoga class feel free to substitute their breathing exercises for our own. If you are super organized and have a to-do list format that you have used for years substitute it for ours. We don’t try to dominate your life but fit in smoothly to make your life easier and better.  \n\n',
            ),
            const TextWidget(
              text: 'Specific, Actionable, Practical ',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'Everything in this program is meant to be clear, concise and actionable. You should be able to take action immediately in nearly every part of this course and apply it to your life.',
            ),
            const TextWidget(
              text:
                  'This isn\'t just a guide as you commonly find on the internet that entices you with grand promises then ends up giving you vague instructions. The result being that one often does nothing because one gets caught up trying to figure out important details that are left poorly explained or completely omitted. Another common scenario is your practice stagnates because one doesn’t know how to progress or is not at the proper aptitude level to perform the practice. We provide the precise format of each practice and exact steps to take to move forward to improve clarity and understanding.\n\n',
            ),
            const TextWidget(
              text:
                  'Everything in this program is designed to achieve practical gains and tangible benefits in the most important parts of our lives for the long term. Through your daily practice, you will optimize your physical, emotional, and mental health as well as get closer and closer to your goals. At the same time, you will be learning strategies, modes of thinking, and practices that you can apply to a broad range of real-life situations.\n\n',
            ),
            const TextWidget(
              text:
                  'Works for Beginners, Advanced Practitioners & Anyone In-between',
            ),
            const TextWidget(
              text:
                  'This program is designed to be used by anyone from absolute beginners to experts. We provide clear progressions so you can identify and start a practice at your current level then advance from there.\n\n',
            ),
            const TextWidget(text: 'Resilience ', fontStyle: FontStyle.italic),
            const TextWidget(
                text:
                    'Through training we become more resilient not only physically by improving immune response, increasing muscle and bone density, increasing resilience to pain & cold; but, also through increased resilience to stress, implementing strategies to deal with high-stress situations & other intense emotional responses, increased ability to understand and evaluate our thought processes leading to our actions, and increased ability to focus. Through building resilience, we create a new normal when responding to stressful stimuli. What was perceived as stressful in the past now bounces off us like a pebble thrown at a medieval castle wall. \n\n'),
            const TextWidget(
                text: 'Achieving What You Most Desire',
                fontStyle: FontStyle.italic),
            const TextWidget(
              text:
                  'When you start your day by getting in a peak mental and physical state you can get out of the gate running with massive energy and confidence. When you can clarify your goals and your deepest reasons for wanting to achieve those goals, you’re centering yourself and giving yourself a compass in life. Instead of just floating around you can say with conviction exactly why you are or aren’t doing something. If you don’t know what you want to do then how can you organize your time effectively? If you don’t know why you’re doing something, how can you prioritize and keep your focus on what’s important?',
            ),
          ],
        ),
      ),
    );
  }
}

class PrinciplesReading extends StatefulWidget {
  const PrinciplesReading({Key? key}) : super(key: key);

  @override
  State<PrinciplesReading> createState() => _PrinciplesReadingState();
}

class _PrinciplesReadingState extends State<PrinciplesReading> {
  @override
  void dispose() {
    debugPrint('disposing');
    Get.find<IntroController>().updateHistory();
    debugPrint('disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
        child: Column(
          children: [
            ReadingTitle(title: 'I102- How to use this program', ontap: () {})
                .marginOnly(bottom: 20),
            const TextWidget(text: 'Consistency and Momentum\n'),
            const TextWidget(
              text:
                  'Showing up is key. It will mean the difference between life changing results and staying in the exact same place. Staying consistent leads to forming ingrained habits and eventually showing up will feel completely natural. Our bodies and minds crave consistency and continually struggle to revert back to our “average” life and habits, both psychologically and physiologically. Making lasting changes to your weight, your body composition, your reaction to stress, and your financial situation will take showing up everyday. When starting a new practice your body and mind will be screaming at you to stop and go back to your old habits and return to your old equilibrium, but if you keep showing up everyday you will create new habits and a new equilibrium. When it’s normal to be healthy, feel amazing, not worry about money, and live your dream life your mind and body will scream at you if you try to fall back into your old habits. \nWe can be consistent and there are tricks to make it easier to show up everyday (we will explore these methods in much more detail shortly). By using our wits we can design ways to structure our lives where showing up to achieve our dreams and goals is easier and more natural than not achieving them. By showing up everyday you will build confidence, a desire to achieve, and build momentum that turns into an unstoppable force.  \n\n',
            ),
            const TextWidget(text: 'Complete Honesty with Yourself\n'),
            const TextWidget(
                text:
                    '	Honesty is key to growing as a person. You need to take stock of where you’re at in life and evaluate it honestly, as if you’re evaluating a 3rd party. You then need to continually evaluate yourself and your progress, honestly. The easiest way to be brutally honest with yourself is through monitoring and recording your progress. Quantitatively (using numbers) and qualitatively (describing with words) evaluating your progress will be extremely valuable tools for securing your ideal future.  \nAnother source of falsehoods is in our patterns of thinking that have been ingrained in us since childhood. There are numerous micro-lies we tell ourselves everyday to rationalize our experiences. There are also more destructive lies we tell ourselves, much of the time completely unaware we are even lying. An example in daily life could be that failing in one aspect of life (such as getting fired or divorced) would mean that the whole life itself is a complete failure. This type of thinking is called “overgeneralization” and can quickly devolve a situation (our lives) into chaos. If we can step back and see these negative events as part of the grander picture we can begin to formulate a plan of action instead of wallowing in sorrow. \nRejecting falsehoods and living your truth will free your mind from unnecessary pressures and build a platform to launch from. When you know where you have been and take a good look at where you are now you’ll be in the best position to transition to the person you want to become. When you can monitor your progress you’ll gain confidence from seeing your gains. Confidence and results beget confidence and results. This upward spiral causes a virtuous cycle that will increase your motivation to achieve even more. When you stop lying to yourself there will be no more excuses left to tell yourself and responsibility and hope for the future will feel more natural than ever.\n\n'),
            const TextWidget(text: 'Mindfulness/ Awareness in Everything\n'),
            const TextWidget(
              text:
                  'Floating through life on autopilot is sadly the default mode for the majority of the population. Not really paying attention to what your special someone is telling you, eating while not listening to your body, browsing a social media profile you don’t really care about, and mindlessly staring at the TV (or other screens) have become staples of our modern life. These ingrained patterns only serve to disconnect us from the ones we love, our surroundings, and ourselves. We need to make a conscious effort to give our undivided attention to those we love and to the things we dedicate our time to. Through this focused attention we can begin to grow exponentially while reevaluating what is important in our lives and further focus on only the most meaningful and important people, actions, and things. When we are mindful we can really enjoy what is happening right now and live fully. Through mindfulness we can experience a cup of coffee, sunset, a loved ones eyes, a stroll in the forest, or any infinite number of activities in a completely new, more engaging, and fuller light. By becoming mindful we turn off autopilot and take back our autonomy and joy in even the smallest things in life.\n\n',
            ),
            const TextWidget(
                text: 'Incremental Progression and Compound Interest\n'),
            const TextWidget(
              text:
                  'Remember the story of the tortoise and the hare? Slow and steady wins the race. Rome wasn’t built in a day nor was a body builder’s physique, the mind of a scholar, or a successful business. One of the keys to success is building up at a sustainable pace. It is great advice when embarking on a long term project especially when you actually want to finish it! People tend to crave instant results (gratification), but tend to be short sighted and not realize that true results come from steady progression. By progressing steadily you lower your chance of burning out (don\'t be the hare). It also applies very directly to physical exertion, because you can injure yourself and end up having the opposite of your intended effect on your health. \nIf you can get 1% better everyday you won’t be 365% better in one year. Due to the laws of compound growth you will be 3,678% better. Interest begets more interest which is why the rich stay rich and get richer just by sitting their money in an investment account. We can use this principle to skyrocket our gains by simply staying consistent and continuing to grow at a steady pace. John Doe wanted to write a book for the last 20 years, but felt like it was too time consuming and difficult so he did nothing. This year he focused on writing one page every morning when he woke up without fail. Some days he writes more than a page, but always commits to writing that one page. After 6 months his book is written and what seemed like an impossible task for his whole life is now complete. Humans generally have difficulty in seeing past immediate gratification to the long term. Short-sightedness is the key to why many of us don’t show up at all to achieve our most important goals and by using incremental progression we can hack this innate human quality. By achieving small wins everyday we can eventually (sooner than we think) achieve what may have seemed impossible just a short while ago.\n\nature',
            ),
            const TextWidget(text: 'Behavioral Design and Nudging\n'),
            const TextWidget(
              text:
                  'Our environment has profound impacts on our actions. Sometimes what you think was your choice was almost purely a result of your environment. It has been found that the majority of human decisions are intuitive and automatic (Kahneman, Thinking, Fast and Slow, 2011) . Our attention can be drawn and held by design, influencing our actions, nudging us in a certain direction. The corporate world has been using behavioral design for decades to influence our decision making. An especially well known nudge is the practice of putting items at eye level or at the entrance to a grocery to nudge you into purchasing these items. You can be nudged into eating more simply by using a bigger plate. By providing a simple visual cue as shown in the previous two examples you can affect the decision making process at a subconscious level. You are more likely to do something if you need to opt out of it rather than opt in due to the extra step in the process. By making the process more complicated it decreases your chances of completing that process while the opposite is also true- making a process simpler will result in a higher chance of completion. Designing spaces specifically for new activities has been shown effective as most people find it difficult to change their behavior when in a familiar setting. Also, by repeatedly performing an activity in a certain setting you are giving yourself a visual cue that it is time to engage in that activity (not to endlessly scroll through your preferred vice).\nHaving target goals has been shown to increase the chance of reaching those goals and improve overall performance. When you plan to do something at a specific time such as wednesday at 5:30PM you are more likely to complete the task than if it wasn’t scheduled. \nBasically, almost anything that makes a decision easier or simpler compared to the alternatives will lead to you making that decision more. To decide is to spend energy. Even if the decision is small it still takes mental energy especially when we’re making thousands of these decisions per day. Creating a setting, providing visual cues, having target goals, providing specific times to execute activities, and creating processes that you can follow automatically all reduce mental fatigue and together increase the probability of achieving your goals greatly. \n\n',
            ),
            const TextWidget(text: 'Bang for your Buck\n '),
            const TextWidget(
              text:
                  'This program is focused on gaining the maximum benefit for the least work. Time is our most precious resource that is currently not renewable. In our extremely busy modern lives, time is of the essence. Every single portion of the program is intended to use the least amount of time to create the largest impact on your life. We want you to be able to spend the time doing the things you love with the people you love while still achieving your dreams and growing your mental, physical, and emotional capacities tremendously!\n\n',
            ),
            const TextWidget(text: 'Evidence Based\n'),
            const TextWidget(
              text:
                  'Every aspect of this program strives to be thoroughly researched and evidence-based. We rely on the power of experts in their respective fields and though we believe in the wisdom of firsthand experience we protect our users from unfounded opinions without a proper source. We believe in the power of the modern scientific method to illuminate the crevices of the unknown. Interdisciplinary expertise, intradisciplinary cooperation, and professional knowledge guide our users to the most cutting edging techniques, proven methods, and scientifically validated ancient knowledge to supercharge their growth. \n\n ',
            ),
            const TextWidget(text: 'Start Now!\n '),
            const TextWidget(
              text:
                  'The time for dismissal, doubt and second guessing the amazing benefits that can be gained through these techniques is over. The scientific evidence is in and through relatively simple exercises with a small time commitment you can drastically improve nearly every aspect of your whole life! If this sounds too good to be true just read one (or all) or the myriad scientific studies that hail the almost unbelievable benefits of the components of the Ultimate Human. It\'s no coincidence that many of the highest achieving humans on the planet today are using some or all of these techniques. This is a hidden road that is in plain sight. All you have to do is take the first step to start your journey to extraordinary.\n\n',
            ),
          ],
        ),
      ),
    );
  }
}

class HowToUseReading extends StatefulWidget {
  const HowToUseReading({Key? key}) : super(key: key);

  @override
  State<HowToUseReading> createState() => _HowToUseReadingState();
}

class _HowToUseReadingState extends State<HowToUseReading> {
  @override
  void dispose() {
    debugPrint('disposing');
    Get.find<IntroController>().updateHistory();
    debugPrint('disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
        child: Column(
          children: [
            ReadingTitle(
              title: 'I102- How to use this program',
              ontap: () => Get.to(() => const AppRoutines()),
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'How do we improve nearly every aspect of your life and health? \n',
            ),
            const TextWidget(
              text:
                  'First, we take an accounting of your current situation in relevant areas that you want to improve and find out your goals. Once the test results are in, we can help you craft a custom program to finally break through the veil and become your dream self.  \nEach custom system includes at least one Practice from each Key Element ensuring you are continually improving in all aspects of your life. Each custom system has built in fail safes to make you show up every day regardless of your willpower and build habits that last a lifetime. \nThe Key Elements in each custom program are Breathing, Exercise, Emotional Regulation, Behavioral Design, Goals, Values, & Deepest Motivations, Visualization, Gratitude, Cold, Recording Progress & Reflection, and Reading. Each Key Element was strategically chosen based upon the criteria of being evidence based and getting the most bang for your buck across diverse areas of your life. These tend to be widely applicable strategies and high-level focused practices that not only maximize gains experienced across the whole health spectrum with a minimal time commitment, but also can be used in real life situations across broad swathes of our lives.  The Key Elements work synergistically with each other to maximize gains across all areas of life to optimize physical, mental, & emotional health while creating, executing, monitoring, & adjusting a plan to achieve your dreams. \nEach Key Element consists of Learning Modules that include both Readings and Practices. Readings give you the knowledge base to execute the Practices. By executing the Practices consistently, you create and strengthen habits that can continually improve your physical, mental, and emotional health drastically while moving you closer to your dreams.  \nEach Learning Module consists of Classes that progress starting from an absolute beginner level to more advanced Practices. This ensures that anyone at any physical or emotional level can begin this program even if they are a complete beginner or an advanced practitioner in one or all of the areas of this program. By progressing we keep growing and never stagnate. By progressing slowly, but surely, we make sure we’re building long lasting habits that stick. When we build long lasting habits that improve our emotional, physical, & mental health and/or get us closer to reaching our goals we are moving closer to what’s really important to us each and every day. \nBy combining all of the Key Elements together we create a practical daily schedule, including a Morning Routine and an Evening Routine, used to propel us forward in becoming our ideal selves. The Morning Routine serves to get us into peak mental and physical condition, refocus us on what’s really important, and prime us to perform at our best. The Evening Routine serves as a time of reflection, planning, and setting up for the next day. By being conscious about the only time most of us can control in the whole day we take control of our lives instead of falling prey to our automatic behaviors. When your Morning and Evening Routines become habits, you will start to create a momentum few get the chance to experience and your new normal will look nothing like the vast majority of people. \n\n',
            ),
            const TextWidget(text: 'Tests\n', fontStyle: FontStyle.italic),
            const TextWidget(
                text:
                    'All of us are different. We have different levels of proficiency, different strengths, different weaknesses, and different goals. Balance will look different for each of us depending on the aforementioned factors. We gauge your strengths and weaknesses through tests designed to give you an idea of where you stand relative to others. These tests can help you determine which areas need work and which need less work. From the tests and your specific goals, we show which areas to focus on and what practices will improve those areas.  \nWe then ask you a few simple questions about how much time you have to spend daily and what your basic goals are in using this program. Through these questions and the test results we create a custom system tailored to your specific needs and schedule. If you’re short on time you can skip the tests and come back to them later. In this case, you will decide which areas you want to focus on based on your own assumptions without the aid of the test data.   \n\n'),
            const TextWidget(
                text: 'Key Elements\n', fontStyle: FontStyle.italic),
            const TextWidget(
              text:
                  'Key Elements are the components that make up your custom system. Each Key Element was strategically chosen based upon the criteria of being evidence based and creating the most impact for the least amount of effort/ time in the most important areas of life. These tend to be widely applicable strategies and high-level focused practices that not only maximize gains experienced across the whole health spectrum with a minimal time commitment, but also can be used in real life situations across diverse areas of our lives. The Key Elements work synergistically with each other to maximize gains across all areas of life to optimize physical, mental, & emotional health while creating, executing, monitoring, & adjusting a plan to achieve your dreams. \nThe Key Elements in each custom program are Breathing, Exercise, Emotional Regulation, Planning & Behavioral Design, Goals, Values, & Deepest Motivations, Visualization, Gratitude, Cold, Recording Progress & Reflection, and Reading.  \n\n',
            ),
            const TextWidget(
                text: 'Learning Modules, Classes, & Practices \n',
                fontStyle: FontStyle.italic),
            const TextWidget(
              text:
                  'Each Key Element consists of Learning Modules which then are broken down further into Classes which are broken down ultimately into Readings and Practices.   \nEach Class consists of Readings to learn about the subject and Practice exercises to build efficacy. As you complete more Learning Modules and more Classes you can introduce more and more advanced/ diverse Practices into your custom program.   \nYour custom program will always include at least one Practice obtained from a Learning Module from each Key Element ensuring you are continually improving in all aspects of your life, but the practice itself will vary over time. For instance, Physical Exercise is a key element, but your Practice (exercise regimen in this case) will be altered as you advance in your Physical Exercise practice. Similarly, Breathing is a Key Element and your breathing exercises will change as you advance in skill level. ',
            ),
            const TextWidget(
                text: '\n\nCombining Key Elements Into A Custom Program   \n',
                fontStyle: FontStyle.italic),
            const TextWidget(
              text:
                  'We provide a structure that champions use to optimize their time and stay ahead of life’s challenges to be in a proactive and not a reactive state like 98% of the population. This is the most important and impactful change for most people and even highly organized types are commonly surprised by huge areas they have overlooked. We start with a Morning Routine that optimizes physical and mental condition, steeling us to stress, and re-focusing us on our deepest whys and big picture goals. In the evening we reflect on our day, plan for the next day, and execute a pre-plan to drastically increase our productivity and supercharge motivation. \n\n',
            ),
            const TextWidget(
                text: 'Morning Schedule\n ', fontStyle: FontStyle.italic),
            const TextWidget(
              text:
                  'Your morning schedule will start with getting into a state of optimized mental and physical functioning increasing mental toughness to let everyday stress bounce off you with ease. This can consist of physical exercise, cold exposure, stretching, breathing exercises, meditation, mental imagery, and/ or journaling. Every day you will stretch the limits of your physical and mental capacities exploring and expanding your capabilities like never before.   \nKey Elements involved: \n●Breathing \n●Visualization \n●Physical Exercise & Stretching \n●Gratitude \n●Goals, Values, & Deepest Motivation \n●Cold  \n\n',
            ),
            const TextWidget(
                text: 'Evening Schedule\n', fontStyle: FontStyle.italic),
            const TextWidget(
              text:
                  'Your evening schedule is about learning, reflecting, and planning. Each day you will record your progress for the day, reflect on that progress, plan for the following day, and create a path of least resistance to smoothly flow through tomorrow. \nKey Elements involved: \n●Planning & Behavioral Design \n●Emotional Regulation\n●Recording Progress & Reflection \n●Reading \n\n ',
            ),
            const TextWidget(
                text: 'Note about timing\n ', fontStyle: FontStyle.italic),
            const TextWidget(
              text:
                  'Morning and evening schedules can be customized to fit your schedule and needs. In fact, a morning schedule could be in the night and an evening schedule in the afternoon. You could also have a morning, afternoon, and evening schedule or break it up even further into 8 different blocs within the day if you prefer. For most people, however, no or slight modifications will be needed to the templates provided.    \n\n',
            ),
            const TextWidget(
                text: 'Getting Started\n ', fontStyle: FontStyle.italic),
            const TextWidget(
              text:
                  'If you’re feeling up to it you can begin with a practice from each Key Element, however with so many Key Elements it can be a bit overwhelming to get started. That is why we can start with just one Practice from one Key Element and slowly begin to integrate Practices from the other Key Elements as the days go on. The recommended Key Element to start with is Breathing, as breathing is so fundamental to our survival and breathing acts as a simple gateway to focus and stress relief, which is so crucial to succeeding in any other area. \n\n',
            ),
          ],
        ),
      ),
    );
  }
}

class BD101Reading extends StatefulWidget {
  const BD101Reading({Key? key}) : super(key: key);

  @override
  State<BD101Reading> createState() => _BD101ReadingState();
}

class _BD101ReadingState extends State<BD101Reading> {
  @override
  void dispose() {
    debugPrint('disposing');
    Get.find<IntroController>().updateHistory();
    debugPrint('disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
        child: Column(
          children: [
            ReadingTitle(
                    title:
                        'BD101- Behavioral Design Journal- Habits & Designing path to least resistance',
                    ontap: () {})
                .marginOnly(bottom: 20),
            const TextWidget(text: 'Consistency and Momentum\n'),
            const TextWidget(
              text:
                  'Showing up is key. It will mean the difference between life changing results and staying in the exact same place. Staying consistent leads to forming ingrained habits and eventually showing up will feel completely natural. Our bodies and minds crave consistency and continually struggle to revert back to our “average” life and habits, both psychologically and physiologically. Making lasting changes to your weight, your body composition, your reaction to stress, and your financial situation will take showing up everyday. When starting a new practice your body and mind will be screaming at you to stop and go back to your old habits and return to your old equilibrium, but if you keep showing up everyday you will create new habits and a new equilibrium. When it’s normal to be healthy, feel amazing, not worry about money, and live your dream life your mind and body will scream at you if you try to fall back into your old habits. \nWe can be consistent and there are tricks to make it easier to show up everyday (we will explore these methods in much more detail shortly). By using our wits we can design ways to structure our lives where showing up to achieve our dreams and goals is easier and more natural than not achieving them. By showing up everyday you will build confidence, a desire to achieve, and build momentum that turns into an unstoppable force.  \n\n',
            ),
            const TextWidget(text: 'Complete Honesty with Yourself\n'),
            const TextWidget(
                text:
                    '	Honesty is key to growing as a person. You need to take stock of where you’re at in life and evaluate it honestly, as if you’re evaluating a 3rd party. You then need to continually evaluate yourself and your progress, honestly. The easiest way to be brutally honest with yourself is through monitoring and recording your progress. Quantitatively (using numbers) and qualitatively (describing with words) evaluating your progress will be extremely valuable tools for securing your ideal future.  \nAnother source of falsehoods is in our patterns of thinking that have been ingrained in us since childhood. There are numerous micro-lies we tell ourselves everyday to rationalize our experiences. There are also more destructive lies we tell ourselves, much of the time completely unaware we are even lying. An example in daily life could be that failing in one aspect of life (such as getting fired or divorced) would mean that the whole life itself is a complete failure. This type of thinking is called “overgeneralization” and can quickly devolve a situation (our lives) into chaos. If we can step back and see these negative events as part of the grander picture we can begin to formulate a plan of action instead of wallowing in sorrow. \nRejecting falsehoods and living your truth will free your mind from unnecessary pressures and build a platform to launch from. When you know where you have been and take a good look at where you are now you’ll be in the best position to transition to the person you want to become. When you can monitor your progress you’ll gain confidence from seeing your gains. Confidence and results beget confidence and results. This upward spiral causes a virtuous cycle that will increase your motivation to achieve even more. When you stop lying to yourself there will be no more excuses left to tell yourself and responsibility and hope for the future will feel more natural than ever.\n\n'),
            const TextWidget(text: 'Mindfulness/ Awareness in Everything\n'),
            const TextWidget(
              text:
                  'Floating through life on autopilot is sadly the default mode for the majority of the population. Not really paying attention to what your special someone is telling you, eating while not listening to your body, browsing a social media profile you don’t really care about, and mindlessly staring at the TV (or other screens) have become staples of our modern life. These ingrained patterns only serve to disconnect us from the ones we love, our surroundings, and ourselves. We need to make a conscious effort to give our undivided attention to those we love and to the things we dedicate our time to. Through this focused attention we can begin to grow exponentially while reevaluating what is important in our lives and further focus on only the most meaningful and important people, actions, and things. When we are mindful we can really enjoy what is happening right now and live fully. Through mindfulness we can experience a cup of coffee, sunset, a loved ones eyes, a stroll in the forest, or any infinite number of activities in a completely new, more engaging, and fuller light. By becoming mindful we turn off autopilot and take back our autonomy and joy in even the smallest things in life.\n\n',
            ),
            const TextWidget(
                text: 'Incremental Progression and Compound Interest\n'),
            const TextWidget(
              text:
                  'Remember the story of the tortoise and the hare? Slow and steady wins the race. Rome wasn’t built in a day nor was a body builder’s physique, the mind of a scholar, or a successful business. One of the keys to success is building up at a sustainable pace. It is great advice when embarking on a long term project especially when you actually want to finish it! People tend to crave instant results (gratification), but tend to be short sighted and not realize that true results come from steady progression. By progressing steadily you lower your chance of burning out (don\'t be the hare). It also applies very directly to physical exertion, because you can injure yourself and end up having the opposite of your intended effect on your health. \nIf you can get 1% better everyday you won’t be 365% better in one year. Due to the laws of compound growth you will be 3,678% better. Interest begets more interest which is why the rich stay rich and get richer just by sitting their money in an investment account. We can use this principle to skyrocket our gains by simply staying consistent and continuing to grow at a steady pace. John Doe wanted to write a book for the last 20 years, but felt like it was too time consuming and difficult so he did nothing. This year he focused on writing one page every morning when he woke up without fail. Some days he writes more than a page, but always commits to writing that one page. After 6 months his book is written and what seemed like an impossible task for his whole life is now complete. Humans generally have difficulty in seeing past immediate gratification to the long term. Short-sightedness is the key to why many of us don’t show up at all to achieve our most important goals and by using incremental progression we can hack this innate human quality. By achieving small wins everyday we can eventually (sooner than we think) achieve what may have seemed impossible just a short while ago.\n\nature',
            ),
            const TextWidget(text: 'Behavioral Design and Nudging\n'),
            const TextWidget(
              text:
                  'Our environment has profound impacts on our actions. Sometimes what you think was your choice was almost purely a result of your environment. It has been found that the majority of human decisions are intuitive and automatic (Kahneman, Thinking, Fast and Slow, 2011) . Our attention can be drawn and held by design, influencing our actions, nudging us in a certain direction. The corporate world has been using behavioral design for decades to influence our decision making. An especially well known nudge is the practice of putting items at eye level or at the entrance to a grocery to nudge you into purchasing these items. You can be nudged into eating more simply by using a bigger plate. By providing a simple visual cue as shown in the previous two examples you can affect the decision making process at a subconscious level. You are more likely to do something if you need to opt out of it rather than opt in due to the extra step in the process. By making the process more complicated it decreases your chances of completing that process while the opposite is also true- making a process simpler will result in a higher chance of completion. Designing spaces specifically for new activities has been shown effective as most people find it difficult to change their behavior when in a familiar setting. Also, by repeatedly performing an activity in a certain setting you are giving yourself a visual cue that it is time to engage in that activity (not to endlessly scroll through your preferred vice).\nHaving target goals has been shown to increase the chance of reaching those goals and improve overall performance. When you plan to do something at a specific time such as wednesday at 5:30PM you are more likely to complete the task than if it wasn’t scheduled. \nBasically, almost anything that makes a decision easier or simpler compared to the alternatives will lead to you making that decision more. To decide is to spend energy. Even if the decision is small it still takes mental energy especially when we’re making thousands of these decisions per day. Creating a setting, providing visual cues, having target goals, providing specific times to execute activities, and creating processes that you can follow automatically all reduce mental fatigue and together increase the probability of achieving your goals greatly. \n\n',
            ),
            const TextWidget(text: 'Bang for your Buck\n '),
            const TextWidget(
              text:
                  'This program is focused on gaining the maximum benefit for the least work. Time is our most precious resource that is currently not renewable. In our extremely busy modern lives, time is of the essence. Every single portion of the program is intended to use the least amount of time to create the largest impact on your life. We want you to be able to spend the time doing the things you love with the people you love while still achieving your dreams and growing your mental, physical, and emotional capacities tremendously!\n\n',
            ),
            const TextWidget(text: 'Evidence Based\n'),
            const TextWidget(
              text:
                  'Every aspect of this program strives to be thoroughly researched and evidence-based. We rely on the power of experts in their respective fields and though we believe in the wisdom of firsthand experience we protect our users from unfounded opinions without a proper source. We believe in the power of the modern scientific method to illuminate the crevices of the unknown. Interdisciplinary expertise, intradisciplinary cooperation, and professional knowledge guide our users to the most cutting edging techniques, proven methods, and scientifically validated ancient knowledge to supercharge their growth. \n\n ',
            ),
            const TextWidget(text: 'Start Now!\n '),
            const TextWidget(
              text:
                  'The time for dismissal, doubt and second guessing the amazing benefits that can be gained through these techniques is over. The scientific evidence is in and through relatively simple exercises with a small time commitment you can drastically improve nearly every aspect of your whole life! If this sounds too good to be true just read one (or all) or the myriad scientific studies that hail the almost unbelievable benefits of the components of the Ultimate Human. It\'s no coincidence that many of the highest achieving humans on the planet today are using some or all of these techniques. This is a hidden road that is in plain sight. All you have to do is take the first step to start your journey to extraordinary.\n\n',
            ),
          ],
        ),
      ),
    );
  }
}
