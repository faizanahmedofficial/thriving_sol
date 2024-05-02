// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Screens/mental/breathing_home.dart';
import 'package:schedular_project/Widgets/custom_images.dart';

import '../../../Widgets/app_bar.dart';
import '../../../Widgets/text_widget.dart';
import '../../../app_icons.dart';
import '../../custom_bottom.dart';

class BIntroReading extends StatefulWidget {
  const BIntroReading({Key? key}) : super(key: key);

  @override
  State<BIntroReading> createState() => _BIntroReadingState();
}

class _BIntroReadingState extends State<BIntroReading> {
 DateTime initial = DateTime.now(); @override
  void dispose() {
    final end = DateTime.now();
    if (Get.find<BreathingController>().history.value.value == 7) {
      Get.find<BreathingController>().updateHistory(end.difference(initial).inSeconds);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title:
                  'B Intro- Unlock the Anti-Stress Pathway and Build a Base to Exploring Your Inner World',
              ontap: () => Get.to(
                () => GuidedBreathingScreen(
                  fromExercise: true,
                  entity: breathingList[breathingListIndex(5)],
                  connectedReading: () => Get.back(),
                  onfinished: () => Get.back(),
                ),
              ),
            ).marginOnly(bottom: 20),
            const TextWidget(
              text: 'Why is Breathing Important?\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'Respiration or breathing as it is commonly known is one of the most fundamental processes of life and has a profound impact on your mental state, physical performance, and quality of life. \n\nEven though breathing is profoundly important, easy to change, and pleasurable, we often take the action of breathing for granted since we do it automatically and rarely think much about it. Unfortunately, ignoring the action of breathing can have dire consequences for our lives, relationships, mental capacity, physical capacity, and emotional regulation. The good news is fixing bad respiration habits is relatively easy and the benefits are far reaching. First, let’s take a look at how breathing affects every part of your body and mind through the nervous system.\n\n',
            ),
            const TextWidget(
              text: 'Breathing and the Nervous System\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'Breathing has been closely linked to spiritual practices in the east, west, and everywhere in between. Yogic and buddhist breathing practices are the most well known, but breathing is also integral in Christian monastic traditions such as gregorian chants and Russian Orthodox breath moving[ Vasiliev V. Let every breath. Secrets of the Russian breath masters. Richmond Hill (Ontario): Russian Martial Art; 2006\nhttps://www.amazon.com/Every-Breath-Secrets-Russian-Masters/dp/0978104900] \n as well as across the world in islamic, greek, chinese, and shamanic traditions [ "Breath and Breathing ." Encyclopedia of Religion. . Retrieved June 17, 2019 from Encyclopedia.com: \nhttps://www.encyclopedia.com/environment/encyclopedias-almanacs-transcripts-and-maps/breath-and-breathing]. \nModern medical research has discovered that breathing is intimately tied to nervous system functioning (both the autonomic nervous system (ANS) and central nervous system (CNS)) which includes your brain, spinal cord, “fight or flight” response, “rest and digest” response, and a large part of how you perceive and interpret the world.[ Zaccaro, A., Piarulli, A., Laurino, M., Garbella, E., Menicucci, D., Neri, B., & Gemignani, A. (2018). How Breath-Control Can Change Your Life: A Systematic Review on Psycho-Physiological Correlates of Slow Breathing. Frontiers in human neuroscience, 12, 353.\nhttps://doi.org/10.3389/fnhum.2018.00353] \nOur ancestors in disparate parts of the world noticed the power breathing had over the very essence of a person and now science is beginning to catch up\n\nIn fact, “Neuroanatomic and brain imaging studies reveal breath-activated pathways to all major networks involved in emotion regulation, cognitive function, attention, perception, subjective awareness, and decision making.” \n\nThat means that breathing can directly influence your intelligence, decision making, mood, perception of reality, and your ability to deal with stress, anger, anxiety, as well as other difficult emotions.\n You can reap massive benefits with little physical effort through proper breathing or you can face very real and devastating dangers when breathing improperly. First let’s start with what happens when you improperly breathe. \n\n',
            ),
            const TextWidget(
              text: 'Dangers of Improper Breathing\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'Improper breathing is shallow, erratic, and oftentimes completely through the mouth. Breathing in and out through the mouth is the default mode for most of the western world. In 2015, a survey of over 1,000 adults from the Breathe Right brand, found that 61% of respondents identify themselves as mouth breathers. Mouth breathing promotes shallow breathing and can lead to numerous physical problems including: \n\n●Structural deformities in the face of children [ Crelin E. S. (1976). Development of the upper respiratory system. Clinical symposia (Summit, N.J. : 1957), 28(3), 1–30.\nhttps://pubmed.ncbi.nlm.nih.gov/1053096/ ] [ Guilleminault, C., Partinen, M., Hollman, K., Powell, N., & Stoohs, R. (1995). Familial aggregates in obstructive sleep apnea syndrome. Chest, 107(6), 1545–1551. \nhttps://doi.org/10.1378/chest.107.6.1545 \n] [ Okuro, R. T., Morcillo, A. M., Sakano, E., Schivinski, C. I., Ribeiro, M. Â., & Ribeiro, J. D. (2011). Exercise capacity, respiratory mechanics and posture in mouth breathers. Brazilian journal of otorhinolaryngology, 77(5), 656–662. \nhttps://doi.org/10.1590/s1808-86942011000500020 \n] [ Jefferson Y. (2010). Mouth breathing: adverse effects on facial growth, health, academics, and behavior. General dentistry, 58(1), 18–80.\nhttps://pubmed.ncbi.nlm.nih.gov/20129889/]\n●Chronic bad breath, dry lips, sleep apnea, and snoring [ Pacheco, M. C., Casagrande, C. F., Teixeira, L. P., Finck, N. S., & de Araújo, M. T. (2015). Guidelines proposal for clinical recognition of mouth breathing children. Dental press journal of orthodontics, 20(4), 39–44. \nhttps://doi.org/10.1590/2176-9451.20.4.039-044.oar ] [ Katz, E. S., Mitchell, R. B., & D\'Ambrosio, C. M. (2012). Obstructive sleep apnea in infants. American journal of respiratory and critical care medicine, 185(8), 805–816. \nhttps://doi.org/10.1164/rccm.201108-1455CI ]\n ●Increased risk of gum disease, tooth decay and crowded teeth [ Felcar, J. M., Bueno, I. R., Massan, A. C., Torezan, R. P., & Cardoso, J. R. (2010). Prevalência de respiradores bucais em crianças de idade escolar [Prevalence of mouth breathing in children from an elementary school]. Ciencia & saude coletiva, 15(2), 437–444. \nhttps://doi.org/10.1590/S1413-81232010000200020 \n] [ Mummolo, S., Nota, A., Caruso, S., Quinzi, V., Marchetti, E., & Marzo, G. (2018). Salivary Markers and Microbial Flora in Mouth Breathing Late Adolescents. BioMed research international, 2018, 8687608. \nhttps://doi.org/10.1155/2018/8687608 ]\n ●Reduced brain function and brain speed [ Genef Caroline Andrade Ribeiro, Isadora Diniz dos Santos, Ana Claudia Nascimento Santos, Luiz Renato Paranhos, Carla Patrícia Hernandez Alves Ribeiro César, Influence of the breathing pattern on the learning process: a systematic review of literature, Brazilian Journal of Otorhinolaryngology, Volume 82, Issue 4, 2016, Pages 466-478, ISSN 1808-8694,\nhttps://doi.org/10.1016/j.bjorl.2015.08.026 \n] [ Academy of General Dentistry. (2010, April 6). Mouth breathing can cause major health problems. ScienceDaily. Retrieved June 9, 2021 from \nwww.sciencedaily.com/releases/2010/04/100406125714.htm \n] [ Leng, Y., McEvoy, C. T., Allen, I. E., & Yaffe, K. (2017). Association of Sleep-Disordered Breathing With Cognitive Function and Risk of Cognitive Impairment: A Systematic Review and Meta-analysis. JAMA neurology, 74(10), 1237–1245. \nhttps://doi.org/10.1001/jamaneurol.2017.2180 ]\n●Narrowing of airways [ Fayez Saleh and Wisam Al Hamadi (November 5th 2018). Orthosurgical Correction of Severe Vertical Maxillary Excess: Gummy Smile, Current Approaches in Orthodontics, Belma Işık Aslan and Fatma Deniz Uzuner, IntechOpen, DOI: 10.5772/intechopen.80384. Available from: \nhttps://www.intechopen.com/books/current-approaches-in-orthodontics/orthosurgical-correction-of-severe-vertical-maxillary-excess-gummy-smile ]●Increased stress and risk of disease. [ Fan, C., Guo, L., Gu, H., Huo, Y., & Lin, H. (2020). Alterations in Oral-Nasal-Pharyngeal Microbiota and Salivary Proteins in Mouth-Breathing Children. Frontiers in microbiology, 11, 575550. \nhttps://doi.org/10.3389/fmicb.2020.575550 ]&\n ●Chronic stress, increased anxiety and depression. [ Won, E., & Kim, Y. K. (2016). Stress, the Autonomic Nervous System, and the Immune-kynurenine Pathway in the Etiology of Depression. Current neuropharmacology, 14(7), 665–673. \n https://doi.org/10.2174/1570159x14666151208113006 ] [ Yaribeygi, H., Panahi, , Sahraei, H., Johnston, T. P., & Sahebkar, A. (2017). The impact of stress on body function: A review. EXCLI journal, 16, 1057–1072. \nhttps://doi.org/10.17179/excli2017-480 ] [ McKeown, P., O\'Connor-Reina, C., & Plaza, G. (2021). Breathing Re-Education and Phenotypes of Sleep Apnea: A Review. Journal of clinical medicine, 10(3), 471. https://doi.org/10.3390/jcm10030471 ]\nWhen you breathe in through the mouth you may be artificially creating an environment in your body mimicking a constant fight or flight situation. Living in a constant state of stress and suboptimal energy can create a downward spiral that often leads to anxiety and/or depression\n\n',
            ),
            const TextWidget(
              text: 'Benefits of Proper Breathing\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'Improper breathing may plague over half the populace and lead to devastating consequences like chronic stress, disease, and death. The saddest part is that these people may have been able to alter their futures by spending a few minutes a day breathing differently. The good news is that changing something as simple as your breathing pattern can have a hugely positive impact on deep and meaningful parts of your life including improving your mental functioning and emotional control. Improper patterns of breathing can be unlearned and they can be unlearned from the comfort of a chair, couch or bed which makes it almost seem too easy.\nOnce you have the correct knowledge and begin to practice proper breathing regularly you can expect to see major benefits such as: \n\n●Decreased stress and increased stress tolerance. [ Brown, R. P., & Gerbarg, P. L. (2005). Sudarshan Kriya Yogic breathing in the treatment of stress, anxiety, and depression. Part II--clinical applications and guidelines. Journal of alternative and complementary medicine (New York, N.Y.), 11(4), 711–717. \nhttps://doi.org/10.1089/acm.2005.11.711 ] [ Critchley, H. D., Nicotra, A., Chiesa, P. A., Nagai, Y., Gray, M. A., Minati, L., & Bernardi, L. (2015). Slow breathing and hypoxic challenge: cardiorespiratory consequences and their central neural substrates. PloS one, 10(5), e0127082. \nhttps://doi.org/10.1371/journal.pone.0127082 ] [ Telles, S., Naveen, K. V., & Dash, M. (2007). Yoga reduces symptoms of distress in tsunami survivors in the andaman islands. Evidence-based complementary and alternative medicine : eCAM, 4(4), 503–509. https://doi.org/10.1093/ecam/nem069 ] [ Ma, X., Yue, Z. Q., Gong, Z. Q., Zhang, H., Duan, N. Y., Shi, Y. T., Wei, G. X., & Li, Y. F. (2017). The Effect of Diaphragmatic Breathing on Attention, Negative Affect and Stress in Healthy Adults. Frontiers in psychology, 8, 874. \nhttps://doi.org/10.3389/fpsyg.2017.00874 ]\n\n○Breathing can directly stimulate the “rest and digest” and “fight or flight” responses made by the autonomic nervous system (ANS) to influence how much stress you feel. Decreasing and managing stress is more important than ever considering the American Medical Association (AMA) reports 80 percent of all health problems are stress related and the World Health Organization (WHO) has classified stress as the health epidemic of the 21st century. [ World Health Organization. Guidelines for the management of conditions specifically related to stress [Internet]. Geneva: 2013 . Available from: \n http://apps.who.int/iris/bitstream/10665/85119/1/9789241505406_eng.pdf?ua=1  ]\n\n●Improved cognitive ability, focus and decision making. [ Yu, X., Fumoto, M., Nakatani, Y., Sekiyama, T., Kikuchi, H., Seki, Y., Sato-Suzuki, I., & Arita, H. (2011). Activation of the anterior prefrontal cortex and serotonergic system is associated with improvements in mood and EEG changes induced by Zen meditation practice in novices. International journal of psychophysiology : official journal of the International Organization of Psychophysiology, 80(2), 103–111. \n https://doi.org/10.1016/j.ijpsycho.2011.02.004 ] [ Lehrer, P., Kaur, K., Sharma, A., Shah, K., Huseby, R., Bhavsar, J., & Zhang, Y. (2020). Heart Rate Variability Biofeedback Improves Emotional and Physical Health and Performance: A Systematic Review and Meta Analysis. Applied psychophysiology and biofeedback, 45(3), 109–129. \nhttps://doi.org/10.1007/s10484-020-09466-z ] [ The rhythm of memory: how breathing shapes memory function Detlef H. Heck, Robert Kozma, and Leslie M. Kay Journal of Neurophysiology 2019 122:2, 563-571https://doi.org/10.1152/jn.00200.2019 ] [ Zelano, C., Jiang, H., Zhou, G., Arora, N., Schuele, S., Rosenow, J., & Gottfried, J. A. (2016). Nasal Respiration Entrains Human Limbic Oscillations and Modulates Cognitive Function. The Journal of neuroscience : the official journal of the Society for Neuroscience, 36(49), 12448–12467. \nhttps://doi.org/10.1523/JNEUROSCI.2586-16.2016 ] [ Gothe, N. P., & McAuley, E. (2015). Yoga and Cognition: A Meta-Analysis of Chronic and Acute Effects. Psychosomatic medicine, 77(7), 784–797. \nhttps://doi.org/10.1097/PSY.0000000000000218 ]\n○By providing more circulation to the brain and stimulating neural pathways directly linked to focus and decision making you can be the best version of yourself simply through breathing properly.\n\nIncreased well being and emotional regulation (including more control over anxiety, \n\n',
            ),
            const TextWidget(
              text: 'Additional Benefits of Proper Breathing\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  '●Increased pain tolerance \n●Reduces symptoms of insomnia \n●Reduces symptoms of ADD, ADHD, PTSD, OCD, & Schizophrenia\n\n',
            ),
            const TextWidget(
              text: 'Elimination of Waste\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'Everytime we breathe in we inhale oxygen to our lungs that gets transported into our blood and throughout our bodies to our organs, tissues, and eventually every cell in our body. When we breathe out,  waste is gathered in the form of carbon dioxide and exhaled. Breathing is the primary means of eliminating waste from our bodies accounting for 70% of the waste elimination. The other 30% is primarily through defecation and urination. Imagine a gross thought for a moment - combine all your poop, pee, and sweat throughout the day into a giant ball. The amount of waste you eliminate through breathing is over double the size of that ball.\n\n',
            ),
            const TextWidget(
              text: 'Learn to Breathe, Reap the Rewards\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'How can you gain all the benefits of proper breathing? How can you learn to freshen your mind at will to markedly improve your focus, eliminate stress, maximize your cognitive abilities, improve your wellbeing, increase your lifespan, and improve heart, brain, and lung health? And how can you do it all without becoming a monk? \n',
            ),
            const TextWidget(
              text: 'Thriving.org Breathing MasterClass\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'That’s where we come in. At Thriving.org we offer an evidence based, no-nonsense course, that focuses on brevity for the busy professional. By dedicating as little as one minute a day to breathing you can begin to conquer stress and increase your emotional control, gaining profound benefits to your mental health.\n\n',
            ),
            const TextWidget(
              text: 'How do we do it?\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'We simplify and condense scientifically validated breathing exercises from monastic traditions across the world, professional sports that specialize in breathing such as freedivers, and clinical breathing practices for health and wellness, into simple practices for the modern professional with little free time. \n\n',
            ),
            const TextWidget(
              text:
                  'Progressions: Start at any level and progress as fast as you want. \n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'We have created a simple step by step format that you can follow at your own pace, no matter how fast or relaxed it may be. You can start this course right now regardless of your current knowledge and/or current level of breathing skill. \n\n',
            ),
            const TextWidget(
              text: 'Doing & Learning: Learn through taking action!\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'You will learn through audio, video, and readings, but primarily through doing. Each level has practice(s) that will be key in your progress. In this MasterClass the practices will be breathing exercises with accompanying guided audio. For most exercises there are multiple guided audios with varying durations to choose from which allow you to customize how long your practice will be.\n\nAll you have to do is sit down comfortably and listen to the audios to gain benefits that humans have spent hundreds of lifetime\'s worth of time striving for and perfecting. You will learn breathing skills, strategies, and tactics that are clearly defined and are custom made to seamlessly integrate into your daily schedule in a practical and time efficient manner. This is a course that will benefit you for the rest of your life with an extremely low time investment. Once you learn the skills and integrate them into your life they start to become second nature and the benefits continue to flow to you for life like free daily deposits into your bank account. \n\n',
            ),
            const TextWidget(
              text: 'Behavioral Science: Habits that stick, for life\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'We focus on providing you true value by changing your life for the long term. That is why we integrate evidence based behavioral science tools designed to make proper ways of breathing lifelong habits. Basically, behavioral science has shown that you can increase your motivation by making everything as easy as possible and by tying learning objectives to your deepest wants, needs, and purpose. We do things like providing two versions of every reading, one extremely short reading that you can scan through in less than a minute and one longer, more in-depth reading for comprehensive study. This allows you to use your time effectively and get right to real world applications if desired. \n\nMake no mistake, regular practice is required to see drastic change. We give you the tools to make regular practice as easy as possible by leveraging technology and the study of behavioral science, but you still must put in the effort (minimum of 10 seconds per practice).\n\n',
            ),
            const TextWidget(
              text: 'Course Benefits\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'What you should expect from this course:\n\n●Ability to active your anti-stress pathway to destress when stress hits\n●Increase emotional regulation and decrease anxiety, depression, and anger\n●Increase your stress threshold (feel less stress than you used to for similar situations)\n●Increase your resistance to illness\n●Enhance physical markers of health such as resting heart rate, blood pressure, VO2 max, and increase the efficiency of your lungs\n●Avoid structural deformities (especially in the face) caused by poor breathing habits (if your body is still growing)\n●Build a base of knowledge that will allow you to engage in advanced practices designed to further steel you to stress, deal with emotional trauma, and improve skills in sport, music, or anything else you desire. \n●Build a solid foundation for a meditation practice and to really understand what “meditation” actually is.\n\n',
            ),
            const TextWidget(text: 'Overview\n', fontStyle: FontStyle.italic),
            const TextWidget(
              text:
                  'Breathing is a foundational practice that can increase your cognitive abilities, improve your mental health, and increase the control you have over your emotional state at any time. Breathing properly can increase your resilience against viruses and diseases. Breathing properly can reduce or eliminate certain deformities from forming in a growing body. When you learn to breathe properly you also learn how to take control of your autonomic nervous system which you can use to decrease your stress and increase your resilience to stress. \n\nLearn simple techniques, built upon ancient knowledge discovered by sages of ages past, recently scientifically verified, and commonly used by top performers including Olympic gold medalists, military special forces, and filthy rich CEOs to “hack” your body into producing a feeling of natural calm whenever you want. Build your practice into a force that transforms your life and empowers you to control your emotional and mental states with greater ease while increasing your resilience to stress so practically nothing can phase you. We make it easy to start, easy to progress, and easy to reap all the benefits of proper breathing by creating a long term habit. \n\n\nGet started in the Breathing Masterclass FREE here.\n\n\n\nDumdum: \n-Stress kills and is responsible for 80% of health problems (and you are stressed..so connect the dots)\n-Improper breathing can deform your face, give you bad breath, constantly stress you out, and lead to energy loss, disease and death.\n-Use the scientifically validated techniques of monks, top performers, and elite Olympic athletes to reduce stress, improve emotional control, and improve your mental and physical health.\n-Practice for as little as 10 seconds a day to learn to control and hack your body to destress, refocus, and control your emotional state.\n\n',
            ),
          ],
        ),
      ),
    );
  }
}

class B101Reading extends StatefulWidget {
  const B101Reading({Key? key}) : super(key: key);

  @override
  State<B101Reading> createState() => _B101ReadingState();
}

class _B101ReadingState extends State<B101Reading> {
DateTime initial = DateTime.now();  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<BreathingController>().history.value.value == 11) {
      Get.find<BreathingController>().updateHistory(end.difference(initial).inSeconds);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title: 'B101- 3 Stage Breathing',
              ontap: () => Get.to(
                () => GuidedBreathingScreen(
                  fromExercise: true,
                  entity: breathingList[breathingListIndex(12)],
                  onfinished: () => Get.back(),
                  connectedReading: () => Get.back(),
                ),
              ),
            ).marginOnly(bottom: 20),
            const TextWidget(
              text: 'Maximize the Benefits of Proper Breathing\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'You have learned how to alter your breathing patterns to strengthen your lungs, heart, and vascular systems. You have activated your diaphragm and breathed deeply into your abdomen by belly breathing. \n\nNow, you can graduate to 3 stage breathing, which will utilize the maximum capacity of your lungs. You will learn to breathe even deeper and magnify all the benefits outlined in previous lessons including:\n●Increased cognition●Better decision making\n●Increased physical & sexual health●Increased happiness\n●Increased resilience to stress & decreased stress\n●Increased control of your emotions\n\nIn this lesson we are moving away from theory and diving into practice. Make sure you have practiced belly breathing and learned to breathe using your diaphragm before jumping into 3 stage deep breathing. Building a strong foundation is essential to reaping the full benefits of deep nasal breathing. When you breathe, make the process of breathing your focus, and in short order you will be begin controlling your body’s anti-stress pathways\n\n',
            ),
            // const CustomImageWidget(image: AppIcons.b100),
            const TextWidget(
              text: 'Basics of 3 Stage Breathing \n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  '3 stage breathing is performed almost identically to belly breathing except now you will not just focus on filling & emptying your lower lungs with air, but also your middle and upper lungs as well. Your goal when performing 3 stage breathing is to keep your focus on your breath while filling and emptying your lungs completely with air. As the name implies breathing can be broken down into 3 stages. Each stage corresponds with the area of the lungs filled with oxygen at each point in time. Stage 1 corresponds to your lower lungs which you focused on while belly breathing. Stage 2 corresponds to middle stomach and lower chest. Stage 3 corresponds to your upper chest and your throat. \n\n',
            ),
            const TextWidget(
              text: '3 Stage Breathing Instructions\nPosition Instructions:\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'Step 1:\nSit comfortably with your back straight or lay down on your back. \n\nStep 2:\nPlace one hand on your abdomen and one on your chest to monitor your breathing. \n\nNote: Always breathe in through your nose. You can exhale through your mouth or nose, whichever is more comfortable.\n\n',
            ),
            const TextWidget(
              text: 'Breathing In:\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'Step 1: \nDraw air into the bottom of the lungs and feel your abdomen expand with your diaphragm.\n\nStep 2: \nFeel the middle third of the lungs fill with air as you expand your upper abdomen and chest cavity.\n\nStep 3: \nDraw air into the top third of  your lungs, shoulders, upper chest, throat, and even into your brain feeling your shoulders rise\n\n',
            ),
            const TextWidget(
              text: 'Breathing Out:\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'Step 1: \nPurse your lips as you let the air go from the top third of your lungs, your shoulders relax.\n\nStep 2: \nPush air out of the middle third of lungs while contracting your chest cavity.\n\nStep 3: \nPull in your abdomen and force all the remaining air out of your lungs.\n\n',
            ),
            const TextWidget(
                text: 'How to Use This Exercise\n',
                fontStyle: FontStyle.italic),
            const TextWidget(
              text:
                  'Congratulations! You have learned to breathe properly. You can now move onto higher pursuits but always remember what you have learned here and continue practicing. This breathing technique will serve as the foundation for most meditative practices and will be a fundamental habit for continued health and wellness throughout your life. Beyond your structured breathing practice, attempt to breathe like this as much as you can in your everyday life. \n\n\nDumDum:\n\n-You can utilize the full capacity of your lungs by breathing into the lungs from the bottom up, then breathing out from the top down. In practice you inhale and feel your belly rise, then your upper abdomen, and then your chest. When you exhale you feel your shoulders fall first, then your chest, then your upper abdomen, and finally your belly sucks in when there is no more air to let out. This is called 3 stage breathing.\n\n-Three stage breathing is a foundational practice which helps you maximize all the benefits outlined in Breathe 100 including a faster brain, improved memory, better decision making, increased physical & sexual health, more happiness, less stress, and more control over your emotions.\n',
            ),
          ],
        ),
      ),
    );
  }
}

class B100Reading extends StatefulWidget {
  const B100Reading({Key? key}) : super(key: key);

  @override
  State<B100Reading> createState() => _B100ReadingState();
}

class _B100ReadingState extends State<B100Reading> {
 DateTime initial = DateTime.now(); @override
  void dispose() {final end = DateTime.now();
    if (Get.find<BreathingController>().history.value.value == 8) {
      Get.find<BreathingController>().updateHistory(end.difference(initial).inSeconds);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title: 'B100- Just Breath',
              ontap: () => Get.to(
                () => GuidedBreathingScreen(
                  fromExercise: true,
                  entity: breathingList[breathingListIndex(9)],
                  onfinished: () => Get.back(),
                  connectedReading: () => Get.back(),
                ),
              ),
            ).marginOnly(bottom: 20),
            const TextWidget(
              text: 'Breathing and Stress\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'Stress is extremely common and closely linked to disease, depression, and death. The physical processes that lead to stress are directly tied to breathing, through the autonomic nervous system. One of the only known ways to directly influence the autonomic nervous system (and the easiest) is by controlling your breathing patterns. \n\nThe autonomic nervous system is named so because it runs on autopilot without any conscious control . It is hugely important in regulating many essential bodily functions. The autonomic nervous system controls:\n\n-heart rate \n-blood pressure \n-body temperature\n-adrenaline production\n-some healing processes and much much more\n\n',
            ),
            const CustomImageWidget(image: AppIcons.b100),
            const TextWidget(
              text:
                  'The autonomic nervous system is broken into two main divisions. These two main parts are:\n\n-The parasympathetic nervous system (PNS)\n-Known as the regulator of the “rest and digest” response, which promotes a slower heart rate and calmness.\n\n\n-The sympathetic nervous system (SNS)\n-Known as the regulator of the “fight-or-flight”response, which causes an increase in adrenaline production. a faster heart rate, and taxes the body to put it in a state of high alert. \n\n\nThe PNS and SNS and their stress responses are akin to the roles of a wise president and strict dictator. The president (rest and digest) is calm, cool, & collected. It has time to think long term, gather inputs from all the different systems in your body and develop a measured response with proper stratagems. Your body goes into this mode when the rest and digest response is activated.In times of special turmoil or life and death you need the dictator. Someone who will act quickly and decisively, possibly with incomplete information. The dictator will think short term, because in a life or death situation no action in the short term means there may be no long term. The body is stretched to the limit in these trying times to hopefully overcome the extreme challenge, but afterwards the body will be spent both mentally and physically. This is what occurs to varying degrees when the “fight or flight” response is activated. \n\nThe “fight or flight” response releases adrenaline and primes the body to act in stressful situations. This was extremely useful to our ancestors in life or death situations, but in the modern age - especially when neither flight or fight are practical it can cause stress that leads to health problems. This can be severely taxing to our bodies sometimes leading to chronic illness such as heart disease or digestive problems. In fact, The American Medical Association (AMA) states 80 percent of all health problems are stress related. Let that sink in for a moment and consider how calming your body through proper breathing can change your health outcomes drastically.  \n\n',
            ),
            const TextWidget(
              text: 'Improper Breathing’s Effects on Stress\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'The “fight or flight” response is heavily influenced by how you are breathing. Specifically, how slow or fast you are breathing in and out as well as where you are breathing from. The default mode of breathing in the Western world is commonly too shallow which can stimulate the nerves connected to the sympathetic nervous system (“fight or flight response”). \n\n\nBy breathing poorly you can keep yourself in a chronic condition of stress that wears down on you slowly, sucking your energy, motivation, and the very life from you. The fact of the matter is death from stress or stemming from stress is a very real possibility and even if you do not die from a stress related disease you can experience a whole slew of negative consequences from stress, especially from chronic stress, including:\n\n\nMental Symptoms\n●Anger\n●Anxiety\n●Depression\n●Lack of motivation \n\n\nPhysical Symptoms\n●Loss of sexual drive\n●Lack of energy\n●Headaches\n●Upset stomach \n●Feeling tight and/ or muscle tension\n\n(Source: The American Psychological Association (APA), through its annual Stress in America report)\n\n',
            ),
            const TextWidget(
              text: 'Prevalence of Stress\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'Stress is clearly linked to poor physical health, mental health, and even to decreased longevity and quality of life. This link to disease and depression is especially alarming when you realize how common stress is in the modern world.\n\nAccording to the American Psychological Association: \n\n●49% of adults in 2020 from the United States said that stress has negatively affected their behavior in the past year.\n●More than 75% of adults report symptoms of stress.\n●1 in 4 health workers has been diagnosed with a mental health disorder since the covid pandemic started.\n\nAccording to The American Institute of Stress:\n\n●Nearly 75% of people experience stress which negatively impacts their mental health.\n●Over 75% of people experience stress which negatively impacts their physical health.\n●One third of the world populace reports feeling extreme stress.\n●8 out of 10 workers in the United States report stress on the job.\n●Nearly half of the populace may suffer effects on their sleep from stress. \n\nAccording to The Global Organization for Stress:\n\n●Over 90% of Australians feel stressed about at least one important area of their life.\n●Close to half a million (~450k) employees in Britain think their stress is causing them to get sick.\n●Over 85% percent of Chinese laborers report being stressed.\n\n',
            ),
            const TextWidget(
              text: 'How to Breathe Naturally for Health & Wellness\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'The solution to chronic stress is regulating the very processes that create the stress response. Many processes that lead to the sensation of stress are regulated by the autonomic nervous system, which is directly tied to nerves that can be stimulated by breathing. By regulating your breathing you can not only manage your stress more effectively, but also increase focus, improve your quality of life, physical health and mental health. In the following section we will discuss the foundations of proper breathing for maximum health benefits.\n\n',
            ),
            const TextWidget(
              text: 'Nasal Breathinh\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'The solution to mouth breathing and the host of negative consequences it brings including chronic stress is nasal breathing. Nasal breathing is the way the human body was designed to breathe. Inhaling through the nose is superior to mouth breathing for many reasons that are outlined below.\n\n',
            ),
            const TextWidget(text: 'Cilia\n', fontStyle: FontStyle.italic),
            const TextWidget(
              text:
                  'When you breathe in through the nose tiny hairs called cilia filter the air you breathe and can protect you from harmful bacteria entering your lungs.  \n',
            ),
            const TextWidget(
              text: 'Nitric Oxide\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  '●When inhaling through your nose, air mixes with nitric oxide, which both warms and moistens incoming air, priming it for your lungs. Nitric oxide is not effectively produced when inhaling through the mouth.. [ Lundberg, J. O., Settergren, G., Gelinder, S., Lundberg, J. M., Alving, K., & Weitzberg, E. (1996). Inhalation of nasally derived nitric oxide modulates pulmonary function in humans. Acta physiologica Scandinavica, 158(4), 343–347.\n●Nitric oxide can kill harmful bacteria, viruses. and fungi adding another layer of defense against infections beyond the protection by the cilia. \n●Nitric oxide widens the airways and blood vessels ,which makes oxygen absorption much more efficient.  This would suggest vast benefits for physical and sexual health.\n\n',
            ),
            const CustomImageWidget(image: AppIcons.b1001),
            const TextWidget(
              text: 'Nose-Brain Connection\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'Your nose is an extension of the brain region called the hypothalamus which regulates the autonomic nervous system. When you breathe through your nose you’re giving your hypothalamus the proper inputs it needs to do its jobs which include regulating heart rate, blood pressure, sleeping/waking, and hunger/thirst. By providing the proper inputs to the hypothalamus it can create the proper outputs which can lead to a calmer mental state and a better functioning body along with a whole host of other benefits, including:\n\n-Improved blood oxygenation and circulation \n-Better lung function \n-Improved memory and brain function \n-Improved defense against infections \n-Improved stamina and cardiovascular health \n-Improved sexual health\n\n',
            ),
            const TextWidget(
              text: 'Deep Diaphragmatic Breathing \n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'Deep breathing is the antithesis of shallow breathing. Instead of just using the throat muscles to draw in air, the domed shaped muscle beneath your ribcage, called the diaphragm, is used. This muscle creates a vacuum effect drawing air deep within the lower reaches of your lungs. \n\nWhen you breathe with your diaphragm you can begin “belly breathing” where you appear to be filling your belly with air. In reality you will actually just be filling the bottom of your lungs completely with air. This will help you maximize the capacity of your lungs- providing more oxygen to your whole body.\n\nWhen you breathe in deeply it helps promote  a deep exhalation, naturally. Exhaling deeply and slowly can promote feelings of calm by stimulating your parasympathetic nervous system. To make your exhale slower try pursing your lips and letting the air out of your lungs as slowly as possible. \n\nBy breathing deeply you are naturally giving your body the oxygen it needs and loudly proclaiming to your body that everything is OK and you it’s time to relax. When your body gets that signal clear, long term, effective thinking abounds, healing processes begin, and a cascade of benefits are commonly experienced, including:\n\n-Improved cognition-Improved business decision making\n-Slower heart rate and increased heart rate variability (HRV)\n-Reduced stress\n-Improved lung function \n-Reduced blood pressure\n-Improved digestion\n-Improved pain management ability\n-Improved immunity\nThe simple act of breathing deeply can change your long term health outcomes and even improve your decision making ability and mental health, creating a life changing practice. \n\n',
            ),
            const TextWidget(
              text: 'Overview\n',
              fontStyle: FontStyle.italic,
              weight: FontWeight.bold,
            ),
            const TextWidget(
              text:
                  'Stress is a prevalent problem around the world and disrupts the proper functioning of the body and mind. By breathing properly you can defend yourself from many of the harmful effects of stress, and reduce your feelings of stress leading to better decision making and increased cognition. Breathing properly starts with breathing into your “belly” slowly and deeply using your diaphragm. Breathing in through your nose is how the human body was designed to breathe. By doing so you are providing important information your brain uses to adjust sophisticated processes within your body, you are providing better oxygenation, you are filtering out potentially dangerous pathogens, protecting your body from some bacteria and even viruses.\n\n\nDumDum:\n-Breathing in through your nose filters harmful bacteria, warms air going to your lungs, and increases oxygen uptake.\n-Breathing slowly and deeply activates your body’s natural anti-stress pathways reducing stress, improving cognition, improving decision making, slowing your heart rate, lowering blood pressure, improving lung function, and increasing your ability to manage pain. \n\n',
            ),
          ],
        ),
      ),
    );
  }
}

class B102Reading extends StatefulWidget {
  const B102Reading({Key? key}) : super(key: key);

  @override
  State<B102Reading> createState() => _B102ReadingState();
}

class _B102ReadingState extends State<B102Reading> {
DateTime initial = DateTime.now(); @override
  void dispose() {final end = DateTime.now();
    if (Get.find<BreathingController>().history.value.value == 15) {
      Get.find<BreathingController>().updateHistory(end.difference(initial).inSeconds);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title: 'B102- Secret Ingredient',
              ontap: () => Get.to(
                () => GuidedBreathingScreen(
                 fromExercise: true,
                  entity: breathingList[breathingListIndex(16)],
                  onfinished: () {},
                  connectedReading: () => Get.back(),
                ),
              ),
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'An Unlikely Trick Boosts the Benefits of Deep Breathing \n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'Many of the breathing traditions around the world incorporate a secret ingredient that has been scientifically proven to massively boost the benefits received from normal deep breathing. This secret weapon is used by Christian monks in Gregorian chant, by Buddhist monks chanting “om”, and by the happy guy humming his way down the street. \nAs you may have guessed by now the “secret ingredient” we are referring to is humming or singing. Humming and/ or singing are universal across human cultures and are likely more ancient than language itself. There is even some evidence that singing predates modern man and may have even been a key driver in the evolution of our recent ancestors into modern man.\nThe benefits of humming and singing have now been studied thoroughly and include:\n\n●More happiness & less stress\n○Reduces brain activity in areas associated with depression \n○Less stress and more relaxation \n○Boosts happiness naturally through increased levels of endorphins and oxytocin \n\n●Better sleep \n○Better sleep quality and increased levels of melatonin \n\n●Better heart health \n○Reduced heart rate and blood pressure \n○Increased heart rate variability \n○Decreased type 2 diabetes risk\n\n●Clearer and healthier sinuses.\n○Improved sinus health and clearing of the nasal pathways \n\n●Increases nitric oxide (natural viagra) levels by 1500%! \n\n○The 1998 Nobel Prize in physiology or medicine was awarded for discovering nitric oxides’ (NO) hugely important role in the cardiovascular system in regulating blood flow to the organs, and as a natural defense against infections. This Nobel prize winning research also explained why Viagra works. \n\n○Nitric oxide is a vasodilator, which means it relaxes your blood vessels’ inner muscles, making the vessels widen, which causes increased blood flow and lower blood pressure.  This increased blood flow can provide practical benefits that you can use each and  everyday, including: \n\n■Improved sport & workout performance \n■Improved sexual health for males and helps treat erectile dysfunction\n\n',
            ),
            const TextWidget(
              text: 'One Nerve To Rule Them All\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'The vagus nerve is in control of the coordination of internal organ functions, including:\n\n●Breathing rate\n●Heart rate\n●Digestion\n●Weight\n●Inflammatory responses\n●Constriction & dilation of blood vessels. \n\nThe vagus nerve is also called the 10th cranial nerve and it is the most complex as well as the longest of all the cranial nerves. Vagus means “wanderer” in Greek because the vagus nerve meanders through the human body touching disparate corners, stretching its tendrils into your throat, stomach, heart, lungs, and brain. \n\n',
            ),
            const TextWidget(
              text: 'Vagus Nerve & Stress\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'The vagus nerve is the main nerve in the parasympathetic nervous system (PNS), which regulates the bodies’ “rest and digest” response, discussed in Breathe 100. Many of the benefits received from proper breathing and meditation stem from the activation of the “rest and digest” response, which slows your heart rate, while increasing relaxation and focus simultaneously. \nA strong vagus nerve is associated with a reduction in stress and more control over emotional states. In fact, stimulating the vagus nerve electrically is an FDA approved treatment for clinical depression resistant to medication. Through stimulating the vagus nerve you can regulate hardwired stress and depression reduction mechanisms common to all humans.\n\n',
            ),
            const TextWidget(
              text:
                  'How to Stimulate the Vagus Nerve (without fancy medical machinery)\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'The larynx or “voice box” and vocal cords within it are directly connected to the vagus nerve. When you hum or sing you are mechanically stimulating your vagus nerve, the PNS, and your “rest and digest” response. \n\n',
            ),
            const TextWidget(
              text: 'Adding Humming or Singing to Your Breathing Practice\n',
              fontStyle: FontStyle.italic,
            ),
            const TextWidget(
              text:
                  'To add humming to your breathing routine simply hum or sing while you breathe out.  The easiest way for many people to get started is to keep the mouth closed, breathing in through the nose and breathing out through the nose while humming. Continue to use three stage breathing and take deep diaphragmatic breaths while humming and/ or singing. \n\nAnother option is to combine both singing and humming. This is the format that the traditional “om” chant uses. The first portion of the exhale is open mouth singing and the last portion is closed mouth humming. \n\nTry to create a vibration in your upper lip, lower ears, and/ or chest to stimulate the vagus nerve and increase nitric oxide production. Following and amplifying these vibrations can be a great way to hone and expand your abilities. It can also be a very useful exercise for those that find it hard to meditate or focus just on breathing. The vibrations created from humming/ singing are more pronounced and easier felt than soft breathing. They can distract one from over-thinking and are generally easier to concentrate on than an automatic function like breathing. \n\n',
            ),
            const TextWidget(
                text: 'Bottom Line\n', fontStyle: FontStyle.italic),
            const TextWidget(
              text:
                  'Adding humming/singing to your breathing practice is easy. Simply hum, sing, or do a combination of the two as you breathe out. Humming or singing when exhaling can feel downright weird at first, but there are huge benefits to be had with only a small amount of effort and time required. \n\nHumming and singing naturally lengthen and deepen your breathing. Humming in particular, leads to a massive boost in nitric oxide (Up to 15 times normal levels) that can:\n●Help stave off illness \n●Improve sexual & physical performance\n●Improve heart health\n●Improve sinus health \n\nWhen you hum or sing you also mechanically stimulate your vagus nerve because it is connected to your voice box. Since your vagus nerve is a major component in emotional control, stress reduction, and internal organ function this stimulation can lead to:\n●Reduced stress\n●Increased happiness\n●Improved digestion\n●Decreased inflammation (which is a major contributor to disease)\n\nTry incorporating this secret ingredient into your breathing practice to create “Vibration Breathing”. You may notice that you are naturally calmer and your breathing practice has become your favorite part of the day. You can further increase the already massive benefits you are receiving from deep nasal breathing without spending any additional time breathing by adding humming. \n\nP.S. You may feel a bit self conscience when humming, but just think of all the benefits or try it alone first. If you’re with someone else and can’t stop giggling, that\'s okay too and completely normal at first (laughter is good for you). \n',
            ),
            const TextWidget(
              text:
                  'Dum Dum:\n\n\n\Humming while breathing out releases endorphins, reduces brain activity in areas associated with depression, increases sleep quality and melatonin production, reduces heart rate and blood pressure, and reduces stress while increasing levels of relaxation. You may want to do it alone because it sounds weird, but it\'s simple, easy, and has far reaching benefits. \n\n',
            ),
          ],
        ),
      ),
    );
  }
}
