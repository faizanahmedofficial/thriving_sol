import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/constants.dart';

import '../../../Functions/functions.dart';
import '../../../Widgets/app_bar.dart';
import '../../../Widgets/text_widget.dart';
import '../../custom_bottom.dart';
import '../mindfulness_home.dart';

class MIntroReading extends StatefulWidget {
  const MIntroReading({Key? key}) : super(key: key);

  @override
  State<MIntroReading> createState() => _MIntroReadingState();
}

class _MIntroReadingState extends State<MIntroReading> {
 DateTime initial = DateTime.now(); @override
  void dispose() {final end = DateTime.now();
    if (Get.find<MindfulnessController>().history.value.value == 35) {
      debugPrint('disposing');
      Get.find<MindfulnessController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          children: [
            ReadingTitle(
              title: 'M Intro- Increase enjoyment from EVERYTHING you do!',
              ontap: () {},
            ).marginOnly(bottom: 20),
            const TextWidget(text: 'Dream content analysis\n'),
            const TextWidget(
              text:
                  'The following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.\n\n',
            ),
            const TextWidget(text: 'Results\n'),
            const TextWidget(
                text:
                    'All subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the \n\n'),
            const TextWidget(text: 'Procedure\n'),
            const TextWidget(
              text:
                  'The participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\n',
            ),
            const TextWidget(
                text: 'Statistical analyses were carried out with sas v \n'),
            const TextWidget(
              text:
                  'The participants were awakened by the experimenter who asked: ‘What was on your mind before I woke you up?’. After pauses in reporting, the experimenter prompted up to three times: ‘Was there anything else?’. Lastly, the participant was asked to estimate positive and negative dream emotions on 4‐point scales (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). For determining the emotional tone, the negative score was subtracted from the positive score. The interview was recorded and transcribed later. All words not related to the dream experience and repetitions were excluded. Mean word count was used as a measure for dream length.\n\n',
            ),
            const TextWidget(text: 'Dream content analyssi\n'),
            const TextWidget(
              text:
                  'The following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.\n\n',
            ),
            const TextWidget(text: 'Procedure\n '),
            const TextWidget(
              text:
                  'The participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\nStatistical analyses were carried out with sas version 9.1 (SAS Institute Inc., Cary, NC, USA). Data were submitted to analyses of variance for repeated measures with ‘stimulus type’ as within‐subject factor. Contrasts were computed by dependent t‐tests. Degrees of freedom are presented in brackets following the F‐values and t‐values. The alpha level was set at 0.05.\n\n',
            ),
            const TextWidget(text: 'Results\n'),
            const TextWidget(
              text:
                  'All subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the \n\n ',
            ),
          ],
        ),
      ),
    );
  }
}

class SmileAwarenessReading extends StatefulWidget {
  const SmileAwarenessReading({Key? key}) : super(key: key);

  @override
  State<SmileAwarenessReading> createState() => _SmileAwarenessReadingState();
}

class _SmileAwarenessReadingState extends State<SmileAwarenessReading> {
DateTime initial = DateTime.now();  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<MindfulnessController>().history.value.value == 40) {
      debugPrint('disposing');
      Get.find<MindfulnessController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          children: [
            ReadingTitle(
              title: 'M102- Smiling Awareness!',
              ontap: () {
                Get.to(
                  () => GuidedMinfulnessScreen(
                    fromExercise: true,
                    entity: mindfulnessList[mindfulnessListIndex(41)],
                    connectedReading: () => Get.back(),
                    onfinished: () => Get.back(),
                  ),
                );
              },
            ).marginOnly(bottom: 20),
            const TextWidget(text: 'Dream content analysis\n'),
            const TextWidget(
              text:
                  'The following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.\n\n',
            ),
            const TextWidget(text: 'Results\n'),
            const TextWidget(
                text:
                    'All subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the \n\n'),
            const TextWidget(text: 'Procedure\n'),
            const TextWidget(
              text:
                  'The participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\n',
            ),
            const TextWidget(
                text: 'Statistical analyses were carried out with sas v \n'),
            const TextWidget(
              text:
                  'The participants were awakened by the experimenter who asked: ‘What was on your mind before I woke you up?’. After pauses in reporting, the experimenter prompted up to three times: ‘Was there anything else?’. Lastly, the participant was asked to estimate positive and negative dream emotions on 4‐point scales (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). For determining the emotional tone, the negative score was subtracted from the positive score. The interview was recorded and transcribed later. All words not related to the dream experience and repetitions were excluded. Mean word count was used as a measure for dream length.\n\n',
            ),
            const TextWidget(text: 'Dream content analyssi\n'),
            const TextWidget(
              text:
                  'The following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.\n\n',
            ),
            const TextWidget(text: 'Procedure\n '),
            const TextWidget(
              text:
                  'The participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\nStatistical analyses were carried out with sas version 9.1 (SAS Institute Inc., Cary, NC, USA). Data were submitted to analyses of variance for repeated measures with ‘stimulus type’ as within‐subject factor. Contrasts were computed by dependent t‐tests. Degrees of freedom are presented in brackets following the F‐values and t‐values. The alpha level was set at 0.05.\n\n',
            ),
            const TextWidget(text: 'Results\n'),
            const TextWidget(
              text:
                  'All subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the \n\n ',
            ),
          ],
        ),
      ),
    );
  }
}

class MindfulnessDefinedReading extends StatefulWidget {
  const MindfulnessDefinedReading({Key? key}) : super(key: key);

  @override
  State<MindfulnessDefinedReading> createState() =>
      _MindfulnessDefinedReadingState();
}

class _MindfulnessDefinedReadingState extends State<MindfulnessDefinedReading> {
DateTime initial = DateTime.now();  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<MindfulnessController>().history.value.value == 37) {
      debugPrint('disposing');
      Get.find<MindfulnessController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          children: [
            ReadingTitle(
              title: 'M100- Mindfulness Defined',
              ontap: () {},
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'The differences of our findings in comparison to the earlier study by Trotter et al. (1988) indicated clearly that sophisticated technology in presenting olfactory stimuli is necessary, i.e. a technique without affecting the mechanical and thermal condition of the nasal mucosa, and that ensures that the odour is not detectable at the time of the awakening. With regard to these shortcomings, the results of the Trotter et al. (1988) study have limited generalizability.\n\nThat the lack of incorporated olfactory stimuli is explained by methodological issues (e.g. forgetting this part of the dream because it happened 1 min prior to awakening) is unlikely, because the procedure of the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that it is unlikely that an increase of stimulus intensity will produce stronger effects. In addition, the concentrations applied in the present study have been intense and clearly above threshold.\n\nFrom a methodological viewpoint, it is interesting that the findings regarding dream emotions are more pronounced for the self‐rating scales compared to the dream content analytical findings. Schredl and Doll (1998) have shown that external judges underestimate emotional intensity, particularly positive emotions, because of the fact that dreamers, even trained participants in dream studies, did not report all emotions experienced in the dream explicitly. This shift to more negative emotions in the externally rated emotions compared with self‐ratings was also found in the present data. Schredl and Doll (1998) concluded that self‐ratings are more valid measures of dream emotions than analysing dream reports, because of the selective underestimation of positive emotions by external judges.\n\nOther methodological issues, such as the setting (olfactometer and experimenter in the same room with the sleeping participants), are unlikely to have affected the present findings, as these parameters did not change between the conditions (positive and negative stimulation as well as control condition) in this within‐subject design. The subjects were not informed about the order of the different stimulus conditions, i.e. they were blind to the condition. Unfortunately, we did not ask them whether they were guessing regarding the stimulus. Previous studies with the same methodology showed clearly that the odour is not present at the time of waking the participant (1‐min delay). The experimenter was not blind to the condition; by keeping the interaction between experimenter and participant to a minimum in an exact standardized manner, experimenter effects should be minimal.\n\nWe did not analyse the electroencephalogram (EEG) after presentation within this study because the previous study by Stuck et al. (2007), with a large number of stimulations, showed clearly that EEG measures are not affected by this type of olfactory stimulation (without trigeminal component). On the other hand, the number of stimulations in the present study is far too small to detect an effect on scalp EEG parameters (event‐related potentials). Modern technology functional magnetic resonance imaging) might allow measuring the relationship between olfactory stimuli presentation and amygdala activation during REM sleep (cf. Wehrle et al., 2005).\n\nThe present study – as almost every other study in this field – was limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\nTo summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. The minimal effect on dream content might be explained by the lack of arousals in poststimulation EEG, indicating clearly that pure olfactory stimuli are processed differently to stimuli of other sensory modalities. We hypothesized that the strong effect on dream emotions is due to the direct connectivity of the olfactory bulb (and not for other sensory modalities) to the amygdala processing emotional memory during REM sleep. Whether olfactory stimuli are presented directly in dreams is a question which has not yet been answered; it might be speculated that declarative material which is associated with the specific odour might be found more often. Studies with presleep learning sessions in which odour cues are associated with specific cues might shed light on memory processing and consolidation during sleep. In addition, it would be interesting to study nightmare sufferers, i.e. whether positively toned olfactory stimuli yield a significant shift in the emotional tone of nightmares.\n\n',
            ),
            const TextWidget(text: 'Disclosure\n'),
            const TextWidget(
                text:
                    'This study received no financial support; no off‐label or investigational use.\nPublished: 05 October 2014\nOlfactory Stimulation During Sleep Can Reactivate Odor-Associated Images\nMichael Schredl, Leonie Hoffmann, J. Ulrich Sommer & Boris A. Stuck \n\nChemosensory Perception volume 7, pages140–146(2014)Cite this article\n\n859 Accesses\n\n9 Citations\n\n4 Altmetric\n\nMetricsdetails\n\n'),
            const TextWidget(text: 'Procedure\n'),
            const TextWidget(
              text:
                  'Abstract\nPurpose\nResearch has indicated that olfactory stimuli presented during sleep might reactivate memories that are associated with this odor. The present study is the first to examine whether learned associations between odor and images can be reactivated during sleep.\n\n',
            ),
            const TextWidget(
                text:
                    'Methods\nSixteen healthy, normosmic volunteers underwent a balanced learning task in which pictures of rural scenes and pictures of city scenes were associated with hydrogen sulfide (smell of rotten eggs) or phenyl ethyl alcohol (smell of roses) in the evening in a crossover design. During the subsequent night, they were stimulated with olfactory stimuli (hydrogen sulfide, phenyl ethyl alcohol, and neutral) during REM periods. Participants were awakened 1 min after the stimulation and dream reports were elicited.\n\n'),
            const TextWidget(
              text:
                  'Results\nThe olfactory congruent stimuli significantly increased the probability of dreams about rural scenes, whereas the same effect was not found for city scenes.\n\n',
            ),
            const TextWidget(
                text:
                    'Conclusions\nAs these findings support the hypothesis of reactivation during sleep, it would be very interesting to study the effect of dreams as a tool to measure reactivation of task material on sleep-dependent memory consolidation.\n'),
          ],
        ),
      ),
    );
  }
}

class BreathAwarenessReading extends StatefulWidget {
  const BreathAwarenessReading({Key? key}) : super(key: key);

  @override
  State<BreathAwarenessReading> createState() => _BreathAwarenessReadingState();
}

class _BreathAwarenessReadingState extends State<BreathAwarenessReading> {
 DateTime initial = DateTime.now(); @override
  void dispose() {final end = DateTime.now();
    if (Get.find<MindfulnessController>().history.value.value == 38) {
      debugPrint('disposing');
      Get.find<MindfulnessController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          children: [
            ReadingTitle(
              title: 'M101- Breath Awareness',
              ontap: () {
                Get.to(
                  () => GuidedMinfulnessScreen(
                    fromExercise: true,
                    entity: mindfulnessList[mindfulnessListIndex(39)],
                    connectedReading: () => Get.back(),
                    onfinished: () => Get.back(),
                  ),
                );
              },
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'Results\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the \n\n',
            ),
            const TextWidget(text: 'Procedure\n'),
            const TextWidget(
                text:
                    'The participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\n'),
            const TextWidget(
                text: 'Statistical analyses were carried out with sas \n'),
            const TextWidget(
              text:
                  'The participants were awakened by the experimenter who asked: ‘What was on your mind before I woke you up?’. After pauses in reporting, the experimenter prompted up to three times: ‘Was there anything else?’. Lastly, the participant was asked to estimate positive and negative dream emotions on 4‐point scales (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). For determining the emotional tone, the negative score was subtracted from the positive score. The interview was recorded and transcribed later. All words not related to the dream experience and repetitions were excluded. Mean word count was used as a measure for dream length.\n\n',
            ),
            const TextWidget(
                text:
                    'Dream content analysis\nThe following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.\n\n'),
            const TextWidget(
              text:
                  'Procedure\nThe participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\n',
            ),
            const TextWidget(
                text:
                    'Statistical analyses were carried out with sas version 9.1 (SAS Institute Inc., Cary, NC, USA). Data were submitted to analyses of variance for repeated measures with ‘stimulus type’ as within‐subject factor. Contrasts were computed by dependent t‐tests. Degrees of freedom are presented in brackets following the F‐values and t‐values. The alpha level was set at 0.05.\n\nResults\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the \n'),
          ],
        ),
      ),
    );
  }
}

class SightAwarenessReading extends StatefulWidget {
  const SightAwarenessReading({Key? key}) : super(key: key);

  @override
  State<SightAwarenessReading> createState() => _SightAwarenessReadingState();
}

class _SightAwarenessReadingState extends State<SightAwarenessReading> {
 DateTime initial = DateTime.now(); @override
  void dispose() {final end = DateTime.now();
    if (Get.find<MindfulnessController>().history.value.value == 43) {
      debugPrint('disposing');
      Get.find<MindfulnessController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          children: [
            ReadingTitle(
              title: 'M103a- Sight Awareness',
              ontap: () {
                Get.to(
                  () => GuidedMinfulnessScreen(
                    fromExercise: true,
                    entity: mindfulnessList[mindfulnessListIndex(44)],
                    connectedReading: () => Get.back(),
                    onfinished: () => Get.back(),
                  ),
                );
              },
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'Results\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the \n\n',
            ),
            const TextWidget(text: 'Procedure\n'),
            const TextWidget(
                text:
                    'The participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\n'),
            const TextWidget(
                text: 'Statistical analyses were carried out with sas \n'),
            const TextWidget(
              text:
                  'The participants were awakened by the experimenter who asked: ‘What was on your mind before I woke you up?’. After pauses in reporting, the experimenter prompted up to three times: ‘Was there anything else?’. Lastly, the participant was asked to estimate positive and negative dream emotions on 4‐point scales (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). For determining the emotional tone, the negative score was subtracted from the positive score. The interview was recorded and transcribed later. All words not related to the dream experience and repetitions were excluded. Mean word count was used as a measure for dream length.\n\n',
            ),
            const TextWidget(
                text:
                    'Dream content analysis\nThe following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.\n\n'),
            const TextWidget(
              text:
                  'Procedure\nThe participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\n',
            ),
            const TextWidget(
                text:
                    'Statistical analyses were carried out with sas version 9.1 (SAS Institute Inc., Cary, NC, USA). Data were submitted to analyses of variance for repeated measures with ‘stimulus type’ as within‐subject factor. Contrasts were computed by dependent t‐tests. Degrees of freedom are presented in brackets following the F‐values and t‐values. The alpha level was set at 0.05.\n\nResults\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the \n'),
          ],
        ),
      ),
    );
  }
}

class SoundAwarenessReading extends StatefulWidget {
  const SoundAwarenessReading({Key? key}) : super(key: key);

  @override
  State<SoundAwarenessReading> createState() => _SoundAwarenessReadingState();
}

class _SoundAwarenessReadingState extends State<SoundAwarenessReading> {
 DateTime initial = DateTime.now(); @override
  void dispose() {final end = DateTime.now();
    if (Get.find<MindfulnessController>().history.value.value == 45) {
      debugPrint('disposing');
      Get.find<MindfulnessController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          children: [
            ReadingTitle(
              title: 'M103b- Sound Awareness',
              ontap: () {
                Get.to(
                  () => GuidedMinfulnessScreen(
                    fromExercise: true,
                    entity: mindfulnessList[mindfulnessListIndex(46)],
                    connectedReading: () => Get.back(),
                    onfinished: () => Get.back(),
                  ),
                );
              },
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'Results\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the \n\n',
            ),
            const TextWidget(text: 'Procedure\n'),
            const TextWidget(
                text:
                    'The participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\n'),
            const TextWidget(
                text: 'Statistical analyses were carried out with sas \n'),
            const TextWidget(
              text:
                  'The participants were awakened by the experimenter who asked: ‘What was on your mind before I woke you up?’. After pauses in reporting, the experimenter prompted up to three times: ‘Was there anything else?’. Lastly, the participant was asked to estimate positive and negative dream emotions on 4‐point scales (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). For determining the emotional tone, the negative score was subtracted from the positive score. The interview was recorded and transcribed later. All words not related to the dream experience and repetitions were excluded. Mean word count was used as a measure for dream length.\n\n',
            ),
            const TextWidget(
                text:
                    'Dream content analysis\nThe following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.\n\n'),
            const TextWidget(
              text:
                  'Procedure\nThe participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\n',
            ),
            const TextWidget(
                text:
                    'Statistical analyses were carried out with sas version 9.1 (SAS Institute Inc., Cary, NC, USA). Data were submitted to analyses of variance for repeated measures with ‘stimulus type’ as within‐subject factor. Contrasts were computed by dependent t‐tests. Degrees of freedom are presented in brackets following the F‐values and t‐values. The alpha level was set at 0.05.\n\nResults\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the \n'),
          ],
        ),
      ),
    );
  }
}

class SmellAwareness extends StatefulWidget {
  const SmellAwareness({Key? key}) : super(key: key);

  @override
  State<SmellAwareness> createState() => _SmellAwarenessState();
}

class _SmellAwarenessState extends State<SmellAwareness> {
 DateTime initial = DateTime.now(); @override
  void dispose() {final end = DateTime.now();
    if (Get.find<MindfulnessController>().history.value.value == 47) {
      debugPrint('disposing');
      Get.find<MindfulnessController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          children: [
            ReadingTitle(
              title: 'M103c- Smell Awareness',
              ontap: () {
                Get.to(
                  () => GuidedMinfulnessScreen(
                    fromExercise: true,
                    entity: mindfulnessList[mindfulnessListIndex(48)],
                    connectedReading: () => Get.back(),
                    onfinished: () => Get.back(),
                  ),
                );
              },
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'Results\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the \n\n',
            ),
            const TextWidget(text: 'Procedure\n'),
            const TextWidget(
                text:
                    'The participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\n'),
            const TextWidget(
                text: 'Statistical analyses were carried out with sas \n'),
            const TextWidget(
              text:
                  'The participants were awakened by the experimenter who asked: ‘What was on your mind before I woke you up?’. After pauses in reporting, the experimenter prompted up to three times: ‘Was there anything else?’. Lastly, the participant was asked to estimate positive and negative dream emotions on 4‐point scales (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). For determining the emotional tone, the negative score was subtracted from the positive score. The interview was recorded and transcribed later. All words not related to the dream experience and repetitions were excluded. Mean word count was used as a measure for dream length.\n\n',
            ),
            const TextWidget(
                text:
                    'Dream content analysis\nThe following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.\n\n'),
            const TextWidget(
              text:
                  'Procedure\nThe participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\n',
            ),
            const TextWidget(
                text:
                    'Statistical analyses were carried out with sas version 9.1 (SAS Institute Inc., Cary, NC, USA). Data were submitted to analyses of variance for repeated measures with ‘stimulus type’ as within‐subject factor. Contrasts were computed by dependent t‐tests. Degrees of freedom are presented in brackets following the F‐values and t‐values. The alpha level was set at 0.05.\n\nResults\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the \n'),
          ],
        ),
      ),
    );
  }
}

class TouchAwarenessReading extends StatefulWidget {
  const TouchAwarenessReading({Key? key}) : super(key: key);

  @override
  State<TouchAwarenessReading> createState() => _TouchAwarenessReadingState();
}

class _TouchAwarenessReadingState extends State<TouchAwarenessReading> {
DateTime initial = DateTime.now();  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<MindfulnessController>().history.value.value == 49) {
      debugPrint('disposing');
      Get.find<MindfulnessController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          children: [
            ReadingTitle(
              title: 'M103d- Touch Awareness',
              ontap: () {
                Get.to(
                  () => GuidedMinfulnessScreen(
                    fromExercise: true,
                    entity: mindfulnessList[mindfulnessListIndex(50)],
                    connectedReading: () => Get.back(),
                    onfinished: () => Get.back(),
                  ),
                );
              },
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'Results\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the \n\n',
            ),
            const TextWidget(text: 'Procedure\n'),
            const TextWidget(
                text:
                    'The participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\n'),
            const TextWidget(
                text: 'Statistical analyses were carried out with sas \n'),
            const TextWidget(
              text:
                  'The participants were awakened by the experimenter who asked: ‘What was on your mind before I woke you up?’. After pauses in reporting, the experimenter prompted up to three times: ‘Was there anything else?’. Lastly, the participant was asked to estimate positive and negative dream emotions on 4‐point scales (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). For determining the emotional tone, the negative score was subtracted from the positive score. The interview was recorded and transcribed later. All words not related to the dream experience and repetitions were excluded. Mean word count was used as a measure for dream length.\n\n',
            ),
            const TextWidget(
                text:
                    'Dream content analysis\nThe following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.\n\n'),
            const TextWidget(
              text:
                  'Procedure\nThe participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\n',
            ),
            const TextWidget(
                text:
                    'Statistical analyses were carried out with sas version 9.1 (SAS Institute Inc., Cary, NC, USA). Data were submitted to analyses of variance for repeated measures with ‘stimulus type’ as within‐subject factor. Contrasts were computed by dependent t‐tests. Degrees of freedom are presented in brackets following the F‐values and t‐values. The alpha level was set at 0.05.\n\nResults\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the \n'),
          ],
        ),
      ),
    );
  }
}

class TasteAwarenessReading extends StatefulWidget {
  const TasteAwarenessReading({Key? key}) : super(key: key);

  @override
  State<TasteAwarenessReading> createState() => _TasteAwarenessReadingState();
}

class _TasteAwarenessReadingState extends State<TasteAwarenessReading> {
 DateTime initial = DateTime.now(); @override
  void dispose() {final end = DateTime.now();
    if (Get.find<MindfulnessController>().history.value.value == 51) {
      debugPrint('disposing');
      Get.find<MindfulnessController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          children: [
            ReadingTitle(
              title: 'M103e- Taste Awareness',
              ontap: () {
                Get.to(
                  () => GuidedMinfulnessScreen(
                    fromExercise: true,
                    entity: mindfulnessList[mindfulnessListIndex(52)],
                    connectedReading: () => Get.back(),
                    onfinished: () => Get.back(),
                  ),
                );
              },
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'Results\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the \n\n',
            ),
            const TextWidget(text: 'Procedure\n'),
            const TextWidget(
                text:
                    'The participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\n'),
            const TextWidget(
                text: 'Statistical analyses were carried out with sas \n'),
            const TextWidget(
              text:
                  'The participants were awakened by the experimenter who asked: ‘What was on your mind before I woke you up?’. After pauses in reporting, the experimenter prompted up to three times: ‘Was there anything else?’. Lastly, the participant was asked to estimate positive and negative dream emotions on 4‐point scales (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). For determining the emotional tone, the negative score was subtracted from the positive score. The interview was recorded and transcribed later. All words not related to the dream experience and repetitions were excluded. Mean word count was used as a measure for dream length.\n\n',
            ),
            const TextWidget(
                text:
                    'Dream content analysis\nThe following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.\n\n'),
            const TextWidget(
              text:
                  'Procedure\nThe participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\n',
            ),
            const TextWidget(
                text:
                    'Statistical analyses were carried out with sas version 9.1 (SAS Institute Inc., Cary, NC, USA). Data were submitted to analyses of variance for repeated measures with ‘stimulus type’ as within‐subject factor. Contrasts were computed by dependent t‐tests. Degrees of freedom are presented in brackets following the F‐values and t‐values. The alpha level was set at 0.05.\n\nResults\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the \n'),
          ],
        ),
      ),
    );
  }
}

class KinestheticAwarenessReading extends StatefulWidget {
  const KinestheticAwarenessReading({Key? key}) : super(key: key);

  @override
  State<KinestheticAwarenessReading> createState() =>
      _KinestheticAwarenessReadingState();
}

class _KinestheticAwarenessReadingState
    extends State<KinestheticAwarenessReading> {
DateTime initial = DateTime.now();  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<MindfulnessController>().history.value.value == 53) {
      debugPrint('disposing');
      Get.find<MindfulnessController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          children: [
            ReadingTitle(
              title: 'M103f- Kinesthetic Awareness',
              ontap: () {
                Get.to(
                  () => GuidedMinfulnessScreen(
                    fromExercise: true,
                    entity: mindfulnessList[mindfulnessListIndex(54)],
                    connectedReading: () => Get.back(),
                    onfinished: () => Get.back(),
                  ),
                );
              },
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'Results\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the \n\n',
            ),
            const TextWidget(text: 'Procedure\n'),
            const TextWidget(
                text:
                    'The participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\n'),
            const TextWidget(
                text: 'Statistical analyses were carried out with sas \n'),
            const TextWidget(
              text:
                  'The participants were awakened by the experimenter who asked: ‘What was on your mind before I woke you up?’. After pauses in reporting, the experimenter prompted up to three times: ‘Was there anything else?’. Lastly, the participant was asked to estimate positive and negative dream emotions on 4‐point scales (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). For determining the emotional tone, the negative score was subtracted from the positive score. The interview was recorded and transcribed later. All words not related to the dream experience and repetitions were excluded. Mean word count was used as a measure for dream length.\n\n',
            ),
            const TextWidget(
                text:
                    'Dream content analysis\nThe following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.\n\n'),
            const TextWidget(
              text:
                  'Procedure\nThe participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\n',
            ),
            const TextWidget(
                text:
                    'Statistical analyses were carried out with sas version 9.1 (SAS Institute Inc., Cary, NC, USA). Data were submitted to analyses of variance for repeated measures with ‘stimulus type’ as within‐subject factor. Contrasts were computed by dependent t‐tests. Degrees of freedom are presented in brackets following the F‐values and t‐values. The alpha level was set at 0.05.\n\nResults\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the \n'),
          ],
        ),
      ),
    );
  }
}

class BodyScanReading extends StatefulWidget {
  const BodyScanReading({Key? key}) : super(key: key);

  @override
  State<BodyScanReading> createState() => _BodyScanReadingState();
}

class _BodyScanReadingState extends State<BodyScanReading> {
DateTime initial = DateTime.now();  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<MindfulnessController>().history.value.value == 55) {
      debugPrint('disposing');
      Get.find<MindfulnessController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          children: [
            ReadingTitle(
              title: 'M104- Body Scans',
              ontap: () {
                Get.to(
                  () => GuidedMinfulnessScreen(
                    fromExercise: true,
                    entity: mindfulnessList[mindfulnessListIndex(56)],
                    connectedReading: () => Get.back(),
                    onfinished: () => Get.back(),
                  ),
                );
              },
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'The participants were awakened by the experimenter who asked: ‘What was on your mind before I woke you up?’. After pauses in reporting, the experimenter prompted up to three times: ‘Was there anything else?’. Lastly, the participant was asked to estimate positive and negative dream emotions on 4‐point scales (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). For determining the emotional tone, the negative score was subtracted from the positive score. The interview was recorded and transcribed later. All words not related to the dream experience and repetitions were excluded. Mean word count was used as a measure for dream length.\n\n',
            ),
            const TextWidget(text: 'Dream content analysis\n'),
            const TextWidget(
              text:
                  'The following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.\n\n',
            ),
            const TextWidget(
              text:
                  'Procedure\nThe participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses. \n\n',
            ),
            const TextWidget(
              text:
                  'Statistical analyses were carried out with sas version 9.1 (SAS Institute Inc., Cary, NC, USA). Data were submitted to analyses of variance for repeated measures with ‘stimulus type’ as within‐subject factor. Contrasts were computed by dependent t‐tests. Degrees of freedom are presented in brackets following the F‐values and t‐values. The alpha level was set at 0.05.\n\n',
            ),
            const TextWidget(
              text:
                  'Results\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the stimulation was repeated in the forth REM period.\n\n',
            ),
            const TextWidget(
              text:
                  'In Table 1 and Fig. 1, the findings of the dream content analysis and the self‐ratings of dream emotions are depicted. Because of missing values, anovas were computed for 10 participants supplying dream reports in all three conditions. In order to maximize statistical power, all non‐missing values were included in the pairwise comparisons. Note that because of differences in the number of included cases, anova and pairwise comparisons might produce divergent results. Dream length did not differ significantly between the three conditions [F(2,18) = 0.1, not significant (NS)]. Similarly, realism/bizarreness scores were comparable (F(2,18) = 0.0, NS).\n\n',
            ),
            const TextWidget(
              text:
                  'Table 1. Dream content and dream emotions across the three conditions (mean ± SD)\nVariable	Negative stimulus (n = 15)	Neutral Condition (n = 12)	Positive stimulus (n = 13)\nWord count	111.9 ± 66.1	123.9 ± 99.4	92.5 ± 59.4\nDream content analysis\nRealism/bizarreness	1.87 ± 0.83	1.75 ± 0.87	1.85 ± 0.90\nEmotional tone	−1.00 ± 1.20	−0.08 ± 1.08	0.31 ± 1.38\nExplicit olfactory perception (present versus not present)	 0%	 8.3%	0%\nActivities that are likely to be associated witholfactory perception (present versus not present)	13.3%	 0%	15.4% \nimage \n',
            ),
          ],
        ),
      ),
    );
  }
}

class OpenMonitoringReading extends StatefulWidget {
  const OpenMonitoringReading({Key? key}) : super(key: key);

  @override
  State<OpenMonitoringReading> createState() => _OpenMonitoringReadingState();
}

class _OpenMonitoringReadingState extends State<OpenMonitoringReading> {
 DateTime initial = DateTime.now(); @override
  void dispose() {final end = DateTime.now();
    if (Get.find<MindfulnessController>().history.value.value == 57) {
      debugPrint('disposing');
      Get.find<MindfulnessController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          children: [
            ReadingTitle(
              title: 'M105- Open Monitoring',
              ontap: () {
                Get.to(
                  () => GuidedMinfulnessScreen(
                    fromExercise: true,
                    entity: mindfulnessList[mindfulnessListIndex(58)],
                    connectedReading: () => Get.back(),
                    onfinished: () => Get.back(),
                  ),
                );
              },
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'The participants were awakened by the experimenter who asked: ‘What was on your mind before I woke you up?’. After pauses in reporting, the experimenter prompted up to three times: ‘Was there anything else?’. Lastly, the participant was asked to estimate positive and negative dream emotions on 4‐point scales (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). For determining the emotional tone, the negative score was subtracted from the positive score. The interview was recorded and transcribed later. All words not related to the dream experience and repetitions were excluded. Mean word count was used as a measure for dream length.\n\n',
            ),
            const TextWidget(text: 'Dream content analysis\n'),
            const TextWidget(
              text:
                  'The following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.\n\n',
            ),
            const TextWidget(
              text:
                  'Procedure\nThe participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses. \n\n',
            ),
            const TextWidget(
              text:
                  'Statistical analyses were carried out with sas version 9.1 (SAS Institute Inc., Cary, NC, USA). Data were submitted to analyses of variance for repeated measures with ‘stimulus type’ as within‐subject factor. Contrasts were computed by dependent t‐tests. Degrees of freedom are presented in brackets following the F‐values and t‐values. The alpha level was set at 0.05.\n\n',
            ),
            const TextWidget(
              text:
                  'Results\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the stimulation was repeated in the forth REM period.\n\n',
            ),
            const TextWidget(
              text:
                  'In Table 1 and Fig. 1, the findings of the dream content analysis and the self‐ratings of dream emotions are depicted. Because of missing values, anovas were computed for 10 participants supplying dream reports in all three conditions. In order to maximize statistical power, all non‐missing values were included in the pairwise comparisons. Note that because of differences in the number of included cases, anova and pairwise comparisons might produce divergent results. Dream length did not differ significantly between the three conditions [F(2,18) = 0.1, not significant (NS)]. Similarly, realism/bizarreness scores were comparable (F(2,18) = 0.0, NS).\n\n',
            ),
            const TextWidget(
              text:
                  'Table 1. Dream content and dream emotions across the three conditions (mean ± SD)\nVariable	Negative stimulus (n = 15)	Neutral Condition (n = 12)	Positive stimulus (n = 13)\nWord count	111.9 ± 66.1	123.9 ± 99.4	92.5 ± 59.4\nDream content analysis\nRealism/bizarreness	1.87 ± 0.83	1.75 ± 0.87	1.85 ± 0.90\nEmotional tone	−1.00 ± 1.20	−0.08 ± 1.08	0.31 ± 1.38\nExplicit olfactory perception (present versus not present)	 0%	 8.3%	0%\nActivities that are likely to be associated witholfactory perception (present versus not present)	13.3%	 0%	15.4% \nimage \n',
            ),
            const TextWidget(
              text:
                  'Open in figure viewerPowerPoint\nEmotional tone of the dreams of three different types of olfactory stimuli (self‐ratings, means and standard deviations). H2S, hydrogen sulphide; PEA, phenyl ethyl alcohol.\n\nRegarding externally rated dream emotions the statistical analysis yielded a marginally significant difference between the three conditions (F(2,18) = 3.6, P < 0.07), but two contrasts were significant (neutral versus negative: t(11) = 3.1, P < 0.01; negative versus positive: t(12) = 2.5, P < 0.02). Analysing the self‐rated dream emotions, the differences are more pronounced: F(2,18) = 6.2, P < 0.01, neutral versus negative: t(11) = 2.0, P < 0.04, neutral versus positive: t(9) = 2.7, P < 0.02, positive versus negative: t(12) = 2.9, P < 0.01).\n\nExplicit olfactory perception in the dream reports was scarce; i.e. in only one dream did the dreamer explicitly mention smelling something. Being part of a longer dream, the participant discussed with the experimenter why she did not wake her up more often because she had the impression of having dreamed more often. One of these dreams included a grinning Chinese woman who also looked disgusted because they (dreamer and Chinese woman) smelled something rotten. However, this dream was reported in the neutral condition. The statistical analysis (Fisher’s exact test) was non‐significant (P = 1.0). Four dreams included activities that are likely to be associated with olfactory perception in waking life: cleaning a toilet that was full of yellow liquid, eating a Kiwi fruit, eating potatoes with parsley and preparing a salad that included tuna, rice, corn and onions and being in a stuffy room. Again, the comparison between olfactory stimulation and control condition was not significant (Fisher’s exact test: P < 0.25). The matching task where the raters should guess what stimulus was present prior to awakening was not successful: rater 1 matched 13 dreams correctly and rater 2 matched 15. Given that guessing randomly would yield on average 14 correct guesses (33.3% of 40 reports), this is a chance finding.\n\nDiscussion\nOverall, the findings indicate that olfactory stimuli were processed by the sleeping brain and affect the emotions but were not incorporated explicitly into dreams. This is compatible with the model of specific processing of olfactory stimuli within the brain, i.e. the direct anatomical connectivity to the amygdala (Gottfried, 2006). Direct incorporations as reported by Trotter et al. (1988) or for other stimulus types (see Introduction) were not found, thus indicating that olfactory stimuli are processed differently to other sensory modalities on higher brain levels. Maquet and Franck (1997), based on the high activation of the amygdala during REM sleep (Maquet et al., 1996), proposed that the role of the amygdala is the processing of emotional memory. Given the direct connectivity of the olfactory bulb to this brain region, one might hypothesize that the emotional quality of the olfactory stimulus facilitates the processing of emotional memories with the same quality, i.e. the dream tone reflects the emotional tone of the stimulus but not the stimulus itself. Within this context, it would be interesting to pursue the idea studied by Saint‐Denys (1982), who reported that olfactory stimulation yielded dream reports including memories which were associated with this specific odour in a more systematic way and tested the link between emotional tone of odour stimuli and declarative memory. In a presleep learning session, positively toned and negatively toned odour stimuli could be paired with words or other declarative material. One would expect that after olfactory stimulation dreams would include this associated material more often. This follow‐up study would shed light on the psychological mechanisms underlying the present findings, i.e. whether the emotional tone of the olfactory stimuli might activate different sets of memories, including corresponding affects. Rasch et al. (2007) found that presenting a specific odour during slow‐wave sleep probably reactivates mental content which was learned during the day while the same odour was presented. It would also be interesting to study the effect of the emotional tone of other stimuli, e.g. acoustic stimuli such as words, on the emotional tone of dreams. We would expect that the effect would be much less pronounced than for odour stimuli because of the specific processing within the brain, but a sufficiently large number of trials should also result in a significant effect.\n\nThe differences of our findings in comparison to the earlier study by Trotter et al. (1988) indicated clearly that sophisticated technology in presenting olfactory stimuli is necessary, i.e. a technique without affecting the mechanical and thermal condition of the nasal mucosa, and that ensures that the odour is not detectable at the time of the awakening. With regard to these shortcomings, the results of the Trotter et al. (1988) study have limited generalizability.\n\nThat the lack of incorporated olfactory stimuli is explained by methodological issues (e.g. forgetting this part of the dream because it happened 1 min prior to awakening) is unlikely, because the procedure of the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that \nREM awakenings\nThe participants were awakened by the experimenter who asked: ‘What was on your mind before I woke you up?’. After pauses in reporting, the experimenter prompted up to three times: ‘Was there anything else?’. Lastly, the participant was asked to estimate positive and negative dream emotions on 4‐point scales (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). For determining the emotional tone, the negative score was subtracted from the positive score. The interview was recorded and transcribed later. All words not related to the dream experience and repetitions were excluded. Mean word count was used as a measure for dream length.\n\nDream content analysis\nThe following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.\n\nProcedure\nThe participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\nStatistical analyses were carried out with sas version 9.1 (SAS Institute Inc., Cary, NC, USA). Data were submitted to analyses of variance for repeated measures with ‘stimulus type’ as within‐subject factor. Contrasts were computed by dependent t‐tests. Degrees of freedom are presented in brackets following the F‐values and t‐values. The alpha level was set at 0.05.\n\nResults\n\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the stimulation was repeated in the forth REM period.\n\nIn Table 1 and Fig. 1, the findings of the dream content analysis and the self‐ratings of dream emotions are depicted. Because of missing values, anovas were computed for 10 participants supplying dream reports in all three conditions. In order to maximize statistical power, all non‐missing values were included in the pairwise comparisons. Note that because of differences in the number of included cases, anova and pairwise comparisons might produce divergent results. Dream length did not differ significantly between the three conditions [F(2,18) = 0.1, not significant (NS)]. Similarly, realism/bizarreness scores were comparable (F(2,18) = 0.0, NS).\n\nTable 1. Dream content and dream emotions across the three conditions (mean ± SD)\nVariable	Negative stimulus (n = 15)	Neutral Condition (n = 12)	Positive stimulus (n = 13)\nWord count	111.9 ± 66.1	123.9 ± 99.4	92.5 ± 59.4,Dream content analysis,Realism/bizarreness	1.87 ± 0.83	1.75 ± 0.87	1.85 ± 0.90\nEmotional tone	−1.00 ± 1.20	−0.08 ± 1.08	0.31 ± 1.38\nExplicit olfactory perception (present versus not present)	 0%	 8.3%	0%\nActivities that are likely to be associated witholfactory perception (present versus not present)	13.3%	 0%	15.4%\nimage\nFigure 1\nOpen in figure viewerPowerPoint',
            ),
          ],
        ),
      ),
    );
  }
}

class SensoryAwarenessReading extends StatefulWidget {
  const SensoryAwarenessReading({Key? key}) : super(key: key);

  @override
  State<SensoryAwarenessReading> createState() =>
      _SensoryAwarenessReadingState();
}

class _SensoryAwarenessReadingState extends State<SensoryAwarenessReading> {
DateTime initial = DateTime.now();  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<MindfulnessController>().history.value.value == 42) {
      debugPrint('disposing');
      Get.find<MindfulnessController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          children: [
            ReadingTitle(
              title: 'M103- Sensory Awareness!',
              ontap: () {
                // Get.to(
                // () => GuidedMinfulnessScreen(
                //   fromExercise: true,
                //   entity: mindfulnessList[mindfulnessListIndex(41)],
                //   connectedReading: () => Get.back(),
                //   onfinished: () => Get.back(),
                // ),
                // );
              },
            ).marginOnly(bottom: 20),
            const TextWidget(text: 'Dream content analysis\n'),
            const TextWidget(
              text:
                  'The following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.\n\n',
            ),
            const TextWidget(text: 'Results\n'),
            const TextWidget(
                text:
                    'All subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the \n\n'),
            const TextWidget(text: 'Procedure\n'),
            const TextWidget(
              text:
                  'The participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\n',
            ),
            const TextWidget(
                text: 'Statistical analyses were carried out with sas v \n'),
            const TextWidget(
              text:
                  'The participants were awakened by the experimenter who asked: ‘What was on your mind before I woke you up?’. After pauses in reporting, the experimenter prompted up to three times: ‘Was there anything else?’. Lastly, the participant was asked to estimate positive and negative dream emotions on 4‐point scales (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). For determining the emotional tone, the negative score was subtracted from the positive score. The interview was recorded and transcribed later. All words not related to the dream experience and repetitions were excluded. Mean word count was used as a measure for dream length.\n\n',
            ),
            const TextWidget(text: 'Dream content analyssi\n'),
            const TextWidget(
              text:
                  'The following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.\n\n',
            ),
            const TextWidget(text: 'Procedure\n '),
            const TextWidget(
              text:
                  'The participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\nStatistical analyses were carried out with sas version 9.1 (SAS Institute Inc., Cary, NC, USA). Data were submitted to analyses of variance for repeated measures with ‘stimulus type’ as within‐subject factor. Contrasts were computed by dependent t‐tests. Degrees of freedom are presented in brackets following the F‐values and t‐values. The alpha level was set at 0.05.\n\n',
            ),
            const TextWidget(text: 'Results\n'),
            const TextWidget(
              text:
                  'All subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the \n\n ',
            ),
          ],
        ),
      ),
    );
  }
}
