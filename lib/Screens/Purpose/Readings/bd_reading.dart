// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Screens/Purpose/exercises/ideal_time.dart';
import 'package:schedular_project/Screens/Purpose/journals/action_journal_lvl0.dart';
import 'package:schedular_project/Screens/Purpose/journals/tactical_review.dart';

import '../../../Widgets/app_bar.dart';
import '../../../Widgets/text_widget.dart';
import '../../custom_bottom.dart';
import '../bd_home.dart';
import '../exercises/nudges_screen.dart';
import '../exercises/pomodoro_screen.dart';
import '../journals/action_journal_lvl2.dart';

class PIntroReading extends StatefulWidget {
  const PIntroReading({Key? key}) : super(key: key);

  @override
  State<PIntroReading> createState() => _PIntroReadingState();
}

class _PIntroReadingState extends State<PIntroReading> {
  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<BdController>().history.value.value == 119) {
      Get.find<BdController>().updateHistory(end.difference(initial).inSeconds);
    }
    super.dispose();
  }DateTime initial = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 10,
          bottom: 10,
        ),
        child: Column(
          children: [
            const ReadingTitle(title: 'P Intro- Get EVERYTHING done with ZERO')
                .marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'emotional intensity, particularly positive emotions, because of the fact that dreamers, even trained participants in dream studies, did not report all emotions experienced in the dream explicitly. This shift to more negative emotions in the externally rated emotions compared with self‐ratings was also found in the present data. Schredl and Doll (1998) concluded that self‐ratings are more valid measures of dream emotions than analysing dream reports, because of the selective underestimation of positive emotions by external judges.\n\nOther methodological issues, such as the setting (olfactometer and experimenter in the same room with the sleeping participants), are unlikely to have affected the present findings, as these parameters did not change between the conditions (positive and negative stimulation as well as control condition) in this within‐subject design. The subjects were not informed about the order of the different stimulus conditions, i.e. they were blind to the condition. Unfortunately, we did not ask them whether they were guessing regarding the stimulus. Previous studies with the same methodology showed clearly that the odour is not present at the time of waking the participant (1‐min delay). The experimenter was not blind to the condition; by keeping the interaction between experimenter and participant to a minimum in an exact standardized manner, experimenter effects should be minimal.\n\nWe did not analyse the electroencephalogram (EEG) after presentation within this study because the previous study by Stuck et al. (2007), with a large number of stimulations, showed clearly that EEG measures are not affected by this type of olfactory stimulation (without trigeminal component). On the other hand, the number of stimulations in the present study is far too small to detect an effect on scalp EEG parameters (event‐related potentials). Modern technology functional magnetic resonance imaging) might allow measuring the relationship between olfactory stimuli presentation and amygdala activation during REM sleep (cf. Wehrle et al., 2005).\n\nThe present study – as almost every other study in this field – was limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\nTo summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. emotional intensity, particularly positive emotions, because of the fact that dreamers, even trained participants in dream studies, did not report all emotions experienced in the dream explicitly. This shift to more negative emotions in the externally rated emotions compared with self‐ratings was also found in the present data. Schredl and Doll (1998) concluded that self‐ratings are more valid measures of dream emotions than analysing dream reports, because of the selective underestimation of positive emotions by external judges.\n\nOther methodological issues, such as the setting (olfactometer and experimenter in the same room with the sleeping participants), are unlikely to have affected the present findings, as these parameters did not change between the conditions (positive and negative stimulation as well as control condition) in this within‐subject design. The subjects were not informed about the order of the different stimulus conditions, i.e. they were blind to the condition. Unfortunately, we did not ask them whether they were guessing regarding the stimulus. Previous studies with the same methodology showed clearly that the odour is not present at the time of waking the participant (1‐min delay). The experimenter was not blind to the condition; by keeping the interaction between experimenter and participant to a minimum in an exact standardized manner, experimenter effects should be minimal.\n\nWe did not analyse the electroencephalogram (EEG) after presentation within this study because the previous study by Stuck et al. (2007), with a large number of stimulations, showed clearly that EEG measures are not affected by this type of olfactory stimulation (without trigeminal component). On the other hand, the number of stimulations in the present study is far too small to detect an effect on scalp EEG parameters (event‐related potentials). Modern technology functional magnetic resonance imaging) might allow measuring the relationship between olfactory stimuli presentation and amygdala activation during REM sleep (cf. Wehrle et al., 2005).\n\nThe present study – as almost every other study in this field – was limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).',
            ),
            const TextWidget(
              text:
                  'To summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. The minimal effect on dream content might be explained by the lack of arousals in poststimulation EEG, indicating clearly that pure olfactory stimuli are processed differently to stimuli of other sensory modalities. We hypothesized that the strong effect on dream emotions is due to the direct connectivity of the olfactory bulb (and not for other sensory modalities) to the amygdala processing emotional memory during REM sleep. Whether olfactory stimuli are presented directly in dreams is a question which has not yet been answered; it might be speculated that declarative material which is associated with the specific odour might be found more often. Studies with presleep learning sessions in which odour cues are associated with specific cues might shed light on memory processing and consolidation during sleep. In addition, it would be interesting to study nightmare sufferers, i.e. whether positively toned olfactory stimuli yield a significant shift in the emotional tone of nightmares.\n\n',
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
                  'Open in figure viewerPowerPoint\nEmotional tone of the dreams of three different types of olfactory stimuli (self‐ratings, means and standard deviations). H2S, hydrogen sulphide; PEA, phenyl ethyl alcohol.\n\nRegarding externally rated dream emotions the statistical analysis yielded a marginally significant difference between the three conditions (F(2,18) = 3.6, P < 0.07), but two contrasts were significant (neutral versus negative: t(11) = 3.1, P < 0.01; negative versus positive: t(12) = 2.5, P < 0.02). Analysing the self‐rated dream emotions, the differences are more pronounced: F(2,18) = 6.2, P < 0.01, neutral versus negative: t(11) = 2.0, P < 0.04, neutral versus positive: t(9) = 2.7, P < 0.02, positive versus negative: t(12) = 2.9, P < 0.01).\n\nExplicit olfactory perception in the dream reports was scarce; i.e. in only one dream did the dreamer explicitly mention smelling something. Being part of a longer dream, the participant discussed with the experimenter why she did not wake her up more often because she had the impression of having dreamed more often. One of these dreams included a grinning Chinese woman who also looked disgusted because they (dreamer and Chinese woman) smelled something rotten. However, this dream was reported in the neutral condition. The statistical analysis (Fisher’s exact test) was non‐significant (P = 1.0). Four dreams included activities that are likely to be associated with olfactory perception in waking life: cleaning a toilet that was full of yellow liquid, eating a Kiwi fruit, eating potatoes with parsley and preparing a salad that included tuna, rice, corn and onions and being in a stuffy room. Again, the comparison between olfactory stimulation and control condition was not significant (Fisher’s exact test: P < 0.25). The matching task where the raters should guess what stimulus was present prior to awakening was not successful: rater 1 matched 13 dreams correctly and rater 2 matched 15. Given that guessing randomly would yield on average 14 correct guesses (33.3% of 40 reports), this is a chance finding.\n\nDiscussion\nOverall, the findings indicate that olfactory stimuli were processed by the sleeping brain and affect the emotions but were not incorporated explicitly into dreams. This is compatible with the model of specific processing of olfactory stimuli within the brain, i.e. the direct anatomical connectivity to the amygdala (Gottfried, 2006). Direct incorporations as reported by Trotter et al. (1988) or for other stimulus types (see Introduction) were not found, thus indicating that olfactory stimuli are processed differently to other sensory modalities on higher brain levels. Maquet and Franck (1997), based on the high activation of the amygdala during REM sleep (Maquet et al., 1996), proposed that the role of the amygdala is the processing of emotional memory. Given the direct connectivity of the olfactory bulb to this brain region, one might hypothesize that the emotional quality of the olfactory stimulus facilitates the processing of emotional memories with the same quality, i.e. the dream tone reflects the emotional tone of the stimulus but not the stimulus itself. Within this context, it would be interesting to pursue the idea studied by Saint‐Denys (1982), who reported that olfactory stimulation yielded dream reports including memories which were associated with this specific odour in a more systematic way and tested the link between emotional tone of odour stimuli and declarative memory. In a presleep learning session, positively toned and negatively toned odour stimuli could be paired with words or other declarative material. One would expect that after olfactory stimulation dreams would include this associated material more often. This follow‐up study would shed light on the psychological mechanisms underlying the present findings, i.e. whether the emotional tone of the olfactory stimuli might activate different sets of memories, including corresponding affects. Rasch et al. (2007) found that presenting a specific odour during slow‐wave sleep probably reactivates mental content which was learned during the day while the same odour was presented. It would also be interesting to study the effect of the emotional tone of other stimuli, e.g. acoustic stimuli such as words, on the emotional tone of dreams. We would expect that the effect would be much less pronounced than for odour stimuli because of the specific processing within the brain, but a sufficiently large number of trials should also result in a significant effect.\n\nThe differences of our findings in comparison to the earlier study by Trotter et al. (1988) indicated clearly that sophisticated technology in presenting olfactory stimuli is necessary, i.e. a technique without affecting the mechanical and thermal condition of the nasal mucosa, and that ensures that the odour is not detectable at the time of the awakening. With regard to these shortcomings, the results of the Trotter et al. (1988) study have limited generalizability.\n\nThat the lack of incorporated olfactory stimuli is explained by methodological issues (e.g. forgetting this part of the dream because it happened 1 min prior to awakening) is unlikely, because the procedure of the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that \nREM awakenings\nThe participants were awakened by the experimenter who asked: ‘What was on your mind before I woke you up?’. After pauses in reporting, the experimenter prompted up to three times: ‘Was there anything else?’. Lastly, the participant was asked to estimate positive and negative dream emotions on 4‐point scales (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). For determining the emotional tone, the negative score was subtracted from the positive score. The interview was recorded and transcribed later. All words not related to the dream experience and repetitions were excluded. Mean word count was used as a measure for dream length.\n\nDream content analysis\nThe following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.\n\nProcedure\nThe participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\nStatistical analyses were carried out with sas version 9.1 (SAS Institute Inc., Cary, NC, USA). Data were submitted to analyses of variance for repeated measures with ‘stimulus type’ as within‐subject factor. Contrasts were computed by dependent t‐tests. Degrees of freedom are presented in brackets following the F‐values and t‐values. The alpha level was set at 0.05.\n\nResults\n\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the stimulation was repeated in the forth REM period.\n\nIn Table 1 and Fig. 1, the findings of the dream content analysis and the self‐ratings of dream emotions are depicted. Because of missing values, anovas were computed for 10 participants supplying dream reports in all three conditions. In order to maximize statistical power, all non‐missing values were included in the pairwise comparisons. Note that because of differences in the number of included cases, anova and pairwise comparisons might produce divergent results. Dream length did not differ significantly between the three conditions [F(2,18) = 0.1, not significant (NS)]. Similarly, realism/bizarreness scores were comparable (F(2,18) = 0.0, NS).\n\nTable 1. Dream content and dream emotions across the three conditions (mean ± SD)\nVariable	Negative stimulus (n = 15)	Neutral Condition (n = 12)	Positive stimulus (n = 13)\nWord count	111.9 ± 66.1	123.9 ± 99.4	92.5 ± 59.4,Dream content analysis\n,Realism/bizarreness	1.87 ± 0.83	1.75 ± 0.87	1.85 ± 0.90\nEmotional tone	−1.00 ± 1.20	−0.08 ± 1.08	0.31 ± 1.38\nExplicit olfactory perception (present versus not present)	 0%	 8.3%	0%\nActivities that are likely to be associated witholfactory perception (present versus not present)	13.3%	 0%	15.4%\nimage\nFigure 1\nOpen in figure viewerPowerPoint',
            ),
            const TextWidget(
              text:
                  'Methods\nThe study was conducted at the Sleep Disorders Center at the Department of Otorhinolaryngology, Head and Neck Surgery Mannheim. The study protocol was approved by the local ethics board of the Faculty of Clinical Medicine Mannheim of the University of Heidelberg; written informed consent was obtained from all participants.\n\nParticipants\nGiven that young females have demonstrated the best olfactory performance among human subjects (Covington et al., 1999; Stuck et al., 2006b), 15 young healthy female volunteers were included in this prospective study (mean age 23.0 ± 2.1 years, range: 20–28 years). Exclusion criteria were actual/previous history of smell or taste disorders, use of any medication known to affect chemosensory function and a history of sleep disorders. At the screening visit, relevant nasal pathology, such as mucosal inflammation, significant septal deviation and nasal polyposis were ruled out via a detailed clinical examination, including nasal endoscopy. Patency of the nasal airways was ascertained additionally using active anterior rhinomanometry (Rhinomanometer 300; ATMOS Medizintechnik GmbH & Co. KG, Lenzkirch, Germany).\n\nPsychophysical testing of olfactory function\nAll participants underwent olfactory testing using the ‘Sniffin’ Sticks’ test kit to establish normal olfactory function (Hummel et al., 1997; Kobal et al., 2000). Odorants were presented in odour dispensers similar to felt‐tip pens. Testing involved assessment of n‐butanol odour thresholds, odour discrimination and odour identification. In order to categorize olfactory function in terms of functional anosmia, hyposmia and normosmia, the sum of the three scores for odour thresholds, odour discrimination and odour identification was used [threshold–discrimination–identification (TDI) score; Wolfensberger et al., 2000].\n\nSleep recordings\nThe participants were admitted to the Sleep Disorders Center. Analogous to routine sleep studies, an overnight polysomnography was performed to assess nocturnal sleep. Monitoring included two electroencephalographic recordings (C3‐A2, C4‐A1), two electro‐oculograms (left, right), two submental and two leg electromyograms (left, right). Sleep stages were scored according to Rechtschaffen and Kales (1968).\n\n',
            ),
            const TextWidget(
              text:
                  'Chemosensory stimulation\nFor stimulation, a dynamic olfactometer based on air‐dilution olfactometry was used (OM6b; Burghart Instruments, Wedel, Germany). This allows the presentation of odorous stimuli within a continuous airstream of 8 L min−1, which does not alter the mechanical or thermal conditions at the nasal mucosa (Kobal, 1981). Moreover, this constant airstream ensures that the influence of breathing patterns on stimulus presentation to the olfactory epithelium is minimized. For specific olfactory stimulation the unpleasant H2S, described typically as smelling like rotten eggs, was presented at 4 parts per million. The positive olfactory stimulus was phenyl ethyl alcohol (PEA), described typically as smelling like roses, administered at 20% v/v (both stimuli are clearly above threshold). Stimulus duration was 10 s. Odourless stimuli were presented additionally as a control.\n\nTo allow sufficient mobility during sleep, a tube of approximately 60 cm length was used to connect the subjects’ nostril with the olfactometer outlet. This ensured that changes in body position had little influence on stimulus presentation. The tube was secured with tape to the nostril. A curtain separated the subjects’ bed from the olfactometer and the investigator. Earplugs were administered to dampen external sounds.\n\nREM awakenings\nThe participants were awakened by the experimenter who asked: ‘What was on your mind before I woke you up?’. After pauses in reporting, the experimenter prompted up to three times: ‘Was there anything else?’. Lastly, the participant was asked to estimate positive and negative dream emotions on 4‐point scales (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). For determining the emotional tone, the negative score was subtracted from the positive score. The interview was recorded and transcribed later. All words not related to the dream experience and repetitions were excluded. Mean word count was used as a measure for dream length.\n\nDream content analysis\nThe following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.',
            ),
            const TextWidget(
              text:
                  'Procedure\nThe participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\n',
            ),
            const TextWidget(
              text:
                  'Statistical analyses were carried out with sas version 9.1 (SAS Institute Inc., Cary, NC, USA). Data were submitted to analyses of variance for repeated measures with ‘stimulus type’ as within‐subject factor. Contrasts were computed by dependent t‐tests. Degrees of freedom are presented in brackets following the F‐values and t‐values. The alpha level was set at 0.05.\n\n',
            ),
            const TextWidget(
              text:
                  'Results\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the stimulation was repeated in the forth REM period.\n\n',
            ),
          ],
        ),
      ),
    );
  }
}

class IdealTImeUseReading extends StatefulWidget {
  const IdealTImeUseReading({Key? key}) : super(key: key);

  @override
  State<IdealTImeUseReading> createState() => _IdealTImeUseReadingState();
}

class _IdealTImeUseReadingState extends State<IdealTImeUseReading> {
  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<BdController>().history.value.value == 123) {
      Get.find<BdController>().updateHistory(end.difference(initial).inSeconds);
    }
    super.dispose();
  }DateTime initial = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
        child: Column(
          children: [
            ReadingTitle(
              title: 'Ideal Time Use',
              ontap: () =>
                  Get.to(() => const IdealTimeScreen(), arguments: [false]),
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that it is unlikely that an increase of stimulus intensity will produce stronger effects. In addition, the concentrations applied in the present study have been intense and clearly above threshold.\n\n',
            ),
            const TextWidget(
              text:
                  'From a methodological viewpoint, it is interesting that the findings regarding dream emotions are more pronounced for the self‐rating scales compared to the dream content analytical findings. Schredl and Doll (1998) have shown that external judges underestimate emotional intensity, particularly positive emotions, because of the fact that dreamers, even trained participants in dream studies, did not report all emotions experienced in the dream explicitly. This shift to more negative emotions in the externally rated emotions compared with self‐ratings was also found in the present data. Schredl and Doll (1998) concluded that self‐ratings are more valid measures of dream emotions than analysing dream reports, because of the selective underestimation of positive emotions by external judges.\n\n',
            ),
            const TextWidget(
              text:
                  'Other methodological issues, such as the setting (olfactometer and experimenter in the same room with the sleeping participants), are unlikely to have affected the present findings, as these parameters did not change between the conditions (positive and negative stimulation as well as control condition) in this within‐subject design. The subjects were not informed about the order of the different stimulus conditions, i.e. they were blind to the condition. Unfortunately, we did not ask them whether they were guessing regarding the stimulus. Previous studies with the same methodology showed clearly that the odour is not present at the time of waking the participant (1‐min delay). The experimenter was not blind to the condition; by keeping the interaction between experimenter and participant to a minimum in an exact standardized manner, experimenter effects should be minimal.\n\n',
            ),
            const TextWidget(
              text:
                  'We did not analyse the electroencephalogram (EEG) after presentation within this study because the previous study by Stuck et al. (2007), with a large number of stimulations, showed clearly that EEG measures are not affected by this type of olfactory stimulation (without trigeminal component). On the other hand, the number of stimulations in the present study is far too small to detect an effect on scalp EEG parameters (event‐related potentials). Modern technology functional magnetic resonance imaging) might allow measuring the relationship between olfactory stimuli presentation and amygdala activation during REM sleep (cf. Wehrle et al., 2005).\n\n',
            ),
            const TextWidget(
              text:
                  'The present study – as almost every other study in this field – was limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\n',
            ),
            const TextWidget(
              text:
                  'To summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. The minimal effect on dream content might be explained by the lack of arousals in poststimulation EEG, indicating clearly that pure olfactory stimuli are processed differently to stimuli of other sensory modalities. We hypothesized that the strong effect on dream emotions is due to the direct connectivity of the olfactory bulb (and not for other sensory modalities) to the amygdala processing emotional memory during REM sleep. Whether olfactory stimuli are presented directly in dreams is a question which has not yet been answered; it might be speculated that declarative material \n\n',
            ),
          ],
        ),
      ),
    );
  }
}

class P98Reading extends StatefulWidget {
  const P98Reading({Key? key}) : super(key: key);

  @override
  State<P98Reading> createState() => _P98ReadingState();
}

class _P98ReadingState extends State<P98Reading> {
  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<BdController>().history.value.value == 120) {
      Get.find<BdController>().updateHistory(end.difference(initial).inSeconds);
    }
    super.dispose();
  }
DateTime initial = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 10,
          bottom: 10,
        ),
        child: Column(
          children: [
            const ReadingTitle(title: 'P98- Action Journal')
                .marginOnly(bottom: 20),
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
                  'Open in figure viewerPowerPoint\nEmotional tone of the dreams of three different types of olfactory stimuli (self‐ratings, means and standard deviations). H2S, hydrogen sulphide; PEA, phenyl ethyl alcohol.\n\nRegarding externally rated dream emotions the statistical analysis yielded a marginally significant difference between the three conditions (F(2,18) = 3.6, P < 0.07), but two contrasts were significant (neutral versus negative: t(11) = 3.1, P < 0.01; negative versus positive: t(12) = 2.5, P < 0.02). Analysing the self‐rated dream emotions, the differences are more pronounced: F(2,18) = 6.2, P < 0.01, neutral versus negative: t(11) = 2.0, P < 0.04, neutral versus positive: t(9) = 2.7, P < 0.02, positive versus negative: t(12) = 2.9, P < 0.01).\n\nExplicit olfactory perception in the dream reports was scarce; i.e. in only one dream did the dreamer explicitly mention smelling something. Being part of a longer dream, the participant discussed with the experimenter why she did not wake her up more often because she had the impression of having dreamed more often. One of these dreams included a grinning Chinese woman who also looked disgusted because they (dreamer and Chinese woman) smelled something rotten. However, this dream was reported in the neutral condition. The statistical analysis (Fisher’s exact test) was non‐significant (P = 1.0). Four dreams included activities that are likely to be associated with olfactory perception in waking life: cleaning a toilet that was full of yellow liquid, eating a Kiwi fruit, eating potatoes with parsley and preparing a salad that included tuna, rice, corn and onions and being in a stuffy room. Again, the comparison between olfactory stimulation and control condition was not significant (Fisher’s exact test: P < 0.25). The matching task where the raters should guess what stimulus was present prior to awakening was not successful: rater 1 matched 13 dreams correctly and rater 2 matched 15. Given that guessing randomly would yield on average 14 correct guesses (33.3% of 40 reports), this is a chance finding.\n\nDiscussion\nOverall, the findings indicate that olfactory stimuli were processed by the sleeping brain and affect the emotions but were not incorporated explicitly into dreams. This is compatible with the model of specific processing of olfactory stimuli within the brain, i.e. the direct anatomical connectivity to the amygdala (Gottfried, 2006). Direct incorporations as reported by Trotter et al. (1988) or for other stimulus types (see Introduction) were not found, thus indicating that olfactory stimuli are processed differently to other sensory modalities on higher brain levels. Maquet and Franck (1997), based on the high activation of the amygdala during REM sleep (Maquet et al., 1996), proposed that the role of the amygdala is the processing of emotional memory. Given the direct connectivity of the olfactory bulb to this brain region, one might hypothesize that the emotional quality of the olfactory stimulus facilitates the processing of emotional memories with the same quality, i.e. the dream tone reflects the emotional tone of the stimulus but not the stimulus itself. Within this context, it would be interesting to pursue the idea studied by Saint‐Denys (1982), who reported that olfactory stimulation yielded dream reports including memories which were associated with this specific odour in a more systematic way and tested the link between emotional tone of odour stimuli and declarative memory. In a presleep learning session, positively toned and negatively toned odour stimuli could be paired with words or other declarative material. One would expect that after olfactory stimulation dreams would include this associated material more often. This follow‐up study would shed light on the psychological mechanisms underlying the present findings, i.e. whether the emotional tone of the olfactory stimuli might activate different sets of memories, including corresponding affects. Rasch et al. (2007) found that presenting a specific odour during slow‐wave sleep probably reactivates mental content which was learned during the day while the same odour was presented. It would also be interesting to study the effect of the emotional tone of other stimuli, e.g. acoustic stimuli such as words, on the emotional tone of dreams. We would expect that the effect would be much less pronounced than for odour stimuli because of the specific processing within the brain, but a sufficiently large number of trials should also result in a significant effect.\n\nThe differences of our findings in comparison to the earlier study by Trotter et al. (1988) indicated clearly that sophisticated technology in presenting olfactory stimuli is necessary, i.e. a technique without affecting the mechanical and thermal condition of the nasal mucosa, and that ensures that the odour is not detectable at the time of the awakening. With regard to these shortcomings, the results of the Trotter et al. (1988) study have limited generalizability.\n\nThat the lack of incorporated olfactory stimuli is explained by methodological issues (e.g. forgetting this part of the dream because it happened 1 min prior to awakening) is unlikely, because the procedure of the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that \nREM awakenings\nThe participants were awakened by the experimenter who asked: ‘What was on your mind before I woke you up?’. After pauses in reporting, the experimenter prompted up to three times: ‘Was there anything else?’. Lastly, the participant was asked to estimate positive and negative dream emotions on 4‐point scales (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). For determining the emotional tone, the negative score was subtracted from the positive score. The interview was recorded and transcribed later. All words not related to the dream experience and repetitions were excluded. Mean word count was used as a measure for dream length.\n\nDream content analysis\nThe following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.\n\nProcedure\nThe participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\nStatistical analyses were carried out with sas version 9.1 (SAS Institute Inc., Cary, NC, USA). Data were submitted to analyses of variance for repeated measures with ‘stimulus type’ as within‐subject factor. Contrasts were computed by dependent t‐tests. Degrees of freedom are presented in brackets following the F‐values and t‐values. The alpha level was set at 0.05.\n\nResults\n\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the stimulation was repeated in the forth REM period.\n\nIn Table 1 and Fig. 1, the findings of the dream content analysis and the self‐ratings of dream emotions are depicted. Because of missing values, anovas were computed for 10 participants supplying dream reports in all three conditions. In order to maximize statistical power, all non‐missing values were included in the pairwise comparisons. Note that because of differences in the number of included cases, anova and pairwise comparisons might produce divergent results. Dream length did not differ significantly between the three conditions [F(2,18) = 0.1, not significant (NS)]. Similarly, realism/bizarreness scores were comparable (F(2,18) = 0.0, NS).\n\nTable 1. Dream content and dream emotions across the three conditions (mean ± SD)\nVariable	Negative stimulus (n = 15)	Neutral Condition (n = 12)	Positive stimulus (n = 13)\nWord count	111.9 ± 66.1	123.9 ± 99.4	92.5 ± 59.4,Dream content analysis\n,Realism/bizarreness	1.87 ± 0.83	1.75 ± 0.87	1.85 ± 0.90\nEmotional tone	−1.00 ± 1.20	−0.08 ± 1.08	0.31 ± 1.38\nExplicit olfactory perception (present versus not present)	 0%	 8.3%	0%\nActivities that are likely to be associated witholfactory perception (present versus not present)	13.3%	 0%	15.4%\nimage\nFigure 1\nOpen in figure viewerPowerPoint',
            ),
            const TextWidget(
              text:
                  'emotional intensity, particularly positive emotions, because of the fact that dreamers, even trained participants in dream studies, did not report all emotions experienced in the dream explicitly. This shift to more negative emotions in the externally rated emotions compared with self‐ratings was also found in the present data. Schredl and Doll (1998) concluded that self‐ratings are more valid measures of dream emotions than analysing dream reports, because of the selective underestimation of positive emotions by external judges.\n\nOther methodological issues, such as the setting (olfactometer and experimenter in the same room with the sleeping participants), are unlikely to have affected the present findings, as these parameters did not change between the conditions (positive and negative stimulation as well as control condition) in this within‐subject design. The subjects were not informed about the order of the different stimulus conditions, i.e. they were blind to the condition. Unfortunately, we did not ask them whether they were guessing regarding the stimulus. Previous studies with the same methodology showed clearly that the odour is not present at the time of waking the participant (1‐min delay). The experimenter was not blind to the condition; by keeping the interaction between experimenter and participant to a minimum in an exact standardized manner, experimenter effects should be minimal.\n\nWe did not analyse the electroencephalogram (EEG) after presentation within this study because the previous study by Stuck et al. (2007), with a large number of stimulations, showed clearly that EEG measures are not affected by this type of olfactory stimulation (without trigeminal component). On the other hand, the number of stimulations in the present study is far too small to detect an effect on scalp EEG parameters (event‐related potentials). Modern technology functional magnetic resonance imaging) might allow measuring the relationship between olfactory stimuli presentation and amygdala activation during REM sleep (cf. Wehrle et al., 2005).\n\nThe present study – as almost every other study in this field – was limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\nTo summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. emotional intensity, particularly positive emotions, because of the fact that dreamers, even trained participants in dream studies, did not report all emotions experienced in the dream explicitly. This shift to more negative emotions in the externally rated emotions compared with self‐ratings was also found in the present data. Schredl and Doll (1998) concluded that self‐ratings are more valid measures of dream emotions than analysing dream reports, because of the selective underestimation of positive emotions by external judges.\n\nOther methodological issues, such as the setting (olfactometer and experimenter in the same room with the sleeping participants), are unlikely to have affected the present findings, as these parameters did not change between the conditions (positive and negative stimulation as well as control condition) in this within‐subject design. The subjects were not informed about the order of the different stimulus conditions, i.e. they were blind to the condition. Unfortunately, we did not ask them whether they were guessing regarding the stimulus. Previous studies with the same methodology showed clearly that the odour is not present at the time of waking the participant (1‐min delay). The experimenter was not blind to the condition; by keeping the interaction between experimenter and participant to a minimum in an exact standardized manner, experimenter effects should be minimal.\n\nWe did not analyse the electroencephalogram (EEG) after presentation within this study because the previous study by Stuck et al. (2007), with a large number of stimulations, showed clearly that EEG measures are not affected by this type of olfactory stimulation (without trigeminal component). On the other hand, the number of stimulations in the present study is far too small to detect an effect on scalp EEG parameters (event‐related potentials). Modern technology functional magnetic resonance imaging) might allow measuring the relationship between olfactory stimuli presentation and amygdala activation during REM sleep (cf. Wehrle et al., 2005).\n\nThe present study – as almost every other study in this field – was limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).',
            ),
            const TextWidget(
              text:
                  'To summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. The minimal effect on dream content might be explained by the lack of arousals in poststimulation EEG, indicating clearly that pure olfactory stimuli are processed differently to stimuli of other sensory modalities. We hypothesized that the strong effect on dream emotions is due to the direct connectivity of the olfactory bulb (and not for other sensory modalities) to the amygdala processing emotional memory during REM sleep. Whether olfactory stimuli are presented directly in dreams is a question which has not yet been answered; it might be speculated that declarative material which is associated with the specific odour might be found more often. Studies with presleep learning sessions in which odour cues are associated with specific cues might shed light on memory processing and consolidation during sleep. In addition, it would be interesting to study nightmare sufferers, i.e. whether positively toned olfactory stimuli yield a significant shift in the emotional tone of nightmares.\n\n',
            ),
            const TextWidget(
              text:
                  'Methods\nThe study was conducted at the Sleep Disorders Center at the Department of Otorhinolaryngology, Head and Neck Surgery Mannheim. The study protocol was approved by the local ethics board of the Faculty of Clinical Medicine Mannheim of the University of Heidelberg; written informed consent was obtained from all participants.\n\nParticipants\nGiven that young females have demonstrated the best olfactory performance among human subjects (Covington et al., 1999; Stuck et al., 2006b), 15 young healthy female volunteers were included in this prospective study (mean age 23.0 ± 2.1 years, range: 20–28 years). Exclusion criteria were actual/previous history of smell or taste disorders, use of any medication known to affect chemosensory function and a history of sleep disorders. At the screening visit, relevant nasal pathology, such as mucosal inflammation, significant septal deviation and nasal polyposis were ruled out via a detailed clinical examination, including nasal endoscopy. Patency of the nasal airways was ascertained additionally using active anterior rhinomanometry (Rhinomanometer 300; ATMOS Medizintechnik GmbH & Co. KG, Lenzkirch, Germany).\n\nPsychophysical testing of olfactory function\nAll participants underwent olfactory testing using the ‘Sniffin’ Sticks’ test kit to establish normal olfactory function (Hummel et al., 1997; Kobal et al., 2000). Odorants were presented in odour dispensers similar to felt‐tip pens. Testing involved assessment of n‐butanol odour thresholds, odour discrimination and odour identification. In order to categorize olfactory function in terms of functional anosmia, hyposmia and normosmia, the sum of the three scores for odour thresholds, odour discrimination and odour identification was used [threshold–discrimination–identification (TDI) score; Wolfensberger et al., 2000].\n\nSleep recordings\nThe participants were admitted to the Sleep Disorders Center. Analogous to routine sleep studies, an overnight polysomnography was performed to assess nocturnal sleep. Monitoring included two electroencephalographic recordings (C3‐A2, C4‐A1), two electro‐oculograms (left, right), two submental and two leg electromyograms (left, right). Sleep stages were scored according to Rechtschaffen and Kales (1968).\n\n',
            ),
            const TextWidget(
              text:
                  'Chemosensory stimulation\nFor stimulation, a dynamic olfactometer based on air‐dilution olfactometry was used (OM6b; Burghart Instruments, Wedel, Germany). This allows the presentation of odorous stimuli within a continuous airstream of 8 L min−1, which does not alter the mechanical or thermal conditions at the nasal mucosa (Kobal, 1981). Moreover, this constant airstream ensures that the influence of breathing patterns on stimulus presentation to the olfactory epithelium is minimized. For specific olfactory stimulation the unpleasant H2S, described typically as smelling like rotten eggs, was presented at 4 parts per million. The positive olfactory stimulus was phenyl ethyl alcohol (PEA), described typically as smelling like roses, administered at 20% v/v (both stimuli are clearly above threshold). Stimulus duration was 10 s. Odourless stimuli were presented additionally as a control.\n\nTo allow sufficient mobility during sleep, a tube of approximately 60 cm length was used to connect the subjects’ nostril with the olfactometer outlet. This ensured that changes in body position had little influence on stimulus presentation. The tube was secured with tape to the nostril. A curtain separated the subjects’ bed from the olfactometer and the investigator. Earplugs were administered to dampen external sounds.\n\nREM awakenings\nThe participants were awakened by the experimenter who asked: ‘What was on your mind before I woke you up?’. After pauses in reporting, the experimenter prompted up to three times: ‘Was there anything else?’. Lastly, the participant was asked to estimate positive and negative dream emotions on 4‐point scales (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). For determining the emotional tone, the negative score was subtracted from the positive score. The interview was recorded and transcribed later. All words not related to the dream experience and repetitions were excluded. Mean word count was used as a measure for dream length.\n\nDream content analysis\nThe following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.',
            ),
            const TextWidget(
              text:
                  'Procedure\nThe participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\n',
            ),
            const TextWidget(
              text:
                  'Statistical analyses were carried out with sas version 9.1 (SAS Institute Inc., Cary, NC, USA). Data were submitted to analyses of variance for repeated measures with ‘stimulus type’ as within‐subject factor. Contrasts were computed by dependent t‐tests. Degrees of freedom are presented in brackets following the F‐values and t‐values. The alpha level was set at 0.05.\n\n',
            ),
            const TextWidget(
              text:
                  'Results\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the stimulation was repeated in the forth REM period.\n\n',
            ),
          ],
        ),
      ),
    );
  }
}

class P99Reading extends StatefulWidget {
  const P99Reading({Key? key}) : super(key: key);

  @override
  State<P99Reading> createState() => _P99ReadingState();
}

class _P99ReadingState extends State<P99Reading> {
  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<BdController>().history.value.value == 121) {
      Get.find<BdController>().updateHistory(end.difference(initial).inSeconds);
    }
    super.dispose();
  }DateTime initial = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 10,
          bottom: 10,
        ),
        child: Column(
          children: [
            ReadingTitle(
              title: 'P99- Brutally Honest',
              ontap: () =>
                  Get.to(() => const ActionJournalLvl0(), arguments: [false]),
            ).marginOnly(bottom: 20),
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
                  'Open in figure viewerPowerPoint\nEmotional tone of the dreams of three different types of olfactory stimuli (self‐ratings, means and standard deviations). H2S, hydrogen sulphide; PEA, phenyl ethyl alcohol.\n\nRegarding externally rated dream emotions the statistical analysis yielded a marginally significant difference between the three conditions (F(2,18) = 3.6, P < 0.07), but two contrasts were significant (neutral versus negative: t(11) = 3.1, P < 0.01; negative versus positive: t(12) = 2.5, P < 0.02). Analysing the self‐rated dream emotions, the differences are more pronounced: F(2,18) = 6.2, P < 0.01, neutral versus negative: t(11) = 2.0, P < 0.04, neutral versus positive: t(9) = 2.7, P < 0.02, positive versus negative: t(12) = 2.9, P < 0.01).\n\nExplicit olfactory perception in the dream reports was scarce; i.e. in only one dream did the dreamer explicitly mention smelling something. Being part of a longer dream, the participant discussed with the experimenter why she did not wake her up more often because she had the impression of having dreamed more often. One of these dreams included a grinning Chinese woman who also looked disgusted because they (dreamer and Chinese woman) smelled something rotten. However, this dream was reported in the neutral condition. The statistical analysis (Fisher’s exact test) was non‐significant (P = 1.0). Four dreams included activities that are likely to be associated with olfactory perception in waking life: cleaning a toilet that was full of yellow liquid, eating a Kiwi fruit, eating potatoes with parsley and preparing a salad that included tuna, rice, corn and onions and being in a stuffy room. Again, the comparison between olfactory stimulation and control condition was not significant (Fisher’s exact test: P < 0.25). The matching task where the raters should guess what stimulus was present prior to awakening was not successful: rater 1 matched 13 dreams correctly and rater 2 matched 15. Given that guessing randomly would yield on average 14 correct guesses (33.3% of 40 reports), this is a chance finding.\n\nDiscussion\nOverall, the findings indicate that olfactory stimuli were processed by the sleeping brain and affect the emotions but were not incorporated explicitly into dreams. This is compatible with the model of specific processing of olfactory stimuli within the brain, i.e. the direct anatomical connectivity to the amygdala (Gottfried, 2006). Direct incorporations as reported by Trotter et al. (1988) or for other stimulus types (see Introduction) were not found, thus indicating that olfactory stimuli are processed differently to other sensory modalities on higher brain levels. Maquet and Franck (1997), based on the high activation of the amygdala during REM sleep (Maquet et al., 1996), proposed that the role of the amygdala is the processing of emotional memory. Given the direct connectivity of the olfactory bulb to this brain region, one might hypothesize that the emotional quality of the olfactory stimulus facilitates the processing of emotional memories with the same quality, i.e. the dream tone reflects the emotional tone of the stimulus but not the stimulus itself. Within this context, it would be interesting to pursue the idea studied by Saint‐Denys (1982), who reported that olfactory stimulation yielded dream reports including memories which were associated with this specific odour in a more systematic way and tested the link between emotional tone of odour stimuli and declarative memory. In a presleep learning session, positively toned and negatively toned odour stimuli could be paired with words or other declarative material. One would expect that after olfactory stimulation dreams would include this associated material more often. This follow‐up study would shed light on the psychological mechanisms underlying the present findings, i.e. whether the emotional tone of the olfactory stimuli might activate different sets of memories, including corresponding affects. Rasch et al. (2007) found that presenting a specific odour during slow‐wave sleep probably reactivates mental content which was learned during the day while the same odour was presented. It would also be interesting to study the effect of the emotional tone of other stimuli, e.g. acoustic stimuli such as words, on the emotional tone of dreams. We would expect that the effect would be much less pronounced than for odour stimuli because of the specific processing within the brain, but a sufficiently large number of trials should also result in a significant effect.\n\nThe differences of our findings in comparison to the earlier study by Trotter et al. (1988) indicated clearly that sophisticated technology in presenting olfactory stimuli is necessary, i.e. a technique without affecting the mechanical and thermal condition of the nasal mucosa, and that ensures that the odour is not detectable at the time of the awakening. With regard to these shortcomings, the results of the Trotter et al. (1988) study have limited generalizability.\n\nThat the lack of incorporated olfactory stimuli is explained by methodological issues (e.g. forgetting this part of the dream because it happened 1 min prior to awakening) is unlikely, because the procedure of the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that \nREM awakenings\nThe participants were awakened by the experimenter who asked: ‘What was on your mind before I woke you up?’. After pauses in reporting, the experimenter prompted up to three times: ‘Was there anything else?’. Lastly, the participant was asked to estimate positive and negative dream emotions on 4‐point scales (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). For determining the emotional tone, the negative score was subtracted from the positive score. The interview was recorded and transcribed later. All words not related to the dream experience and repetitions were excluded. Mean word count was used as a measure for dream length.\n\nDream content analysis\nThe following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.\n\nProcedure\nThe participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\nStatistical analyses were carried out with sas version 9.1 (SAS Institute Inc., Cary, NC, USA). Data were submitted to analyses of variance for repeated measures with ‘stimulus type’ as within‐subject factor. Contrasts were computed by dependent t‐tests. Degrees of freedom are presented in brackets following the F‐values and t‐values. The alpha level was set at 0.05.\n\nResults\n\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the stimulation was repeated in the forth REM period.\n\nIn Table 1 and Fig. 1, the findings of the dream content analysis and the self‐ratings of dream emotions are depicted. Because of missing values, anovas were computed for 10 participants supplying dream reports in all three conditions. In order to maximize statistical power, all non‐missing values were included in the pairwise comparisons. Note that because of differences in the number of included cases, anova and pairwise comparisons might produce divergent results. Dream length did not differ significantly between the three conditions [F(2,18) = 0.1, not significant (NS)]. Similarly, realism/bizarreness scores were comparable (F(2,18) = 0.0, NS).\n\nTable 1. Dream content and dream emotions across the three conditions (mean ± SD)\nVariable	Negative stimulus (n = 15)	Neutral Condition (n = 12)	Positive stimulus (n = 13)\nWord count	111.9 ± 66.1	123.9 ± 99.4	92.5 ± 59.4,Dream content analysis\n,Realism/bizarreness	1.87 ± 0.83	1.75 ± 0.87	1.85 ± 0.90\nEmotional tone	−1.00 ± 1.20	−0.08 ± 1.08	0.31 ± 1.38\nExplicit olfactory perception (present versus not present)	 0%	 8.3%	0%\nActivities that are likely to be associated witholfactory perception (present versus not present)	13.3%	 0%	15.4%\nimage\nFigure 1\nOpen in figure viewerPowerPoint',
            ),
            const TextWidget(
              text:
                  'emotional intensity, particularly positive emotions, because of the fact that dreamers, even trained participants in dream studies, did not report all emotions experienced in the dream explicitly. This shift to more negative emotions in the externally rated emotions compared with self‐ratings was also found in the present data. Schredl and Doll (1998) concluded that self‐ratings are more valid measures of dream emotions than analysing dream reports, because of the selective underestimation of positive emotions by external judges.\n\nOther methodological issues, such as the setting (olfactometer and experimenter in the same room with the sleeping participants), are unlikely to have affected the present findings, as these parameters did not change between the conditions (positive and negative stimulation as well as control condition) in this within‐subject design. The subjects were not informed about the order of the different stimulus conditions, i.e. they were blind to the condition. Unfortunately, we did not ask them whether they were guessing regarding the stimulus. Previous studies with the same methodology showed clearly that the odour is not present at the time of waking the participant (1‐min delay). The experimenter was not blind to the condition; by keeping the interaction between experimenter and participant to a minimum in an exact standardized manner, experimenter effects should be minimal.\n\nWe did not analyse the electroencephalogram (EEG) after presentation within this study because the previous study by Stuck et al. (2007), with a large number of stimulations, showed clearly that EEG measures are not affected by this type of olfactory stimulation (without trigeminal component). On the other hand, the number of stimulations in the present study is far too small to detect an effect on scalp EEG parameters (event‐related potentials). Modern technology functional magnetic resonance imaging) might allow measuring the relationship between olfactory stimuli presentation and amygdala activation during REM sleep (cf. Wehrle et al., 2005).\n\nThe present study – as almost every other study in this field – was limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\nTo summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. emotional intensity, particularly positive emotions, because of the fact that dreamers, even trained participants in dream studies, did not report all emotions experienced in the dream explicitly. This shift to more negative emotions in the externally rated emotions compared with self‐ratings was also found in the present data. Schredl and Doll (1998) concluded that self‐ratings are more valid measures of dream emotions than analysing dream reports, because of the selective underestimation of positive emotions by external judges.\n\nOther methodological issues, such as the setting (olfactometer and experimenter in the same room with the sleeping participants), are unlikely to have affected the present findings, as these parameters did not change between the conditions (positive and negative stimulation as well as control condition) in this within‐subject design. The subjects were not informed about the order of the different stimulus conditions, i.e. they were blind to the condition. Unfortunately, we did not ask them whether they were guessing regarding the stimulus. Previous studies with the same methodology showed clearly that the odour is not present at the time of waking the participant (1‐min delay). The experimenter was not blind to the condition; by keeping the interaction between experimenter and participant to a minimum in an exact standardized manner, experimenter effects should be minimal.\n\nWe did not analyse the electroencephalogram (EEG) after presentation within this study because the previous study by Stuck et al. (2007), with a large number of stimulations, showed clearly that EEG measures are not affected by this type of olfactory stimulation (without trigeminal component). On the other hand, the number of stimulations in the present study is far too small to detect an effect on scalp EEG parameters (event‐related potentials). Modern technology functional magnetic resonance imaging) might allow measuring the relationship between olfactory stimuli presentation and amygdala activation during REM sleep (cf. Wehrle et al., 2005).\n\nThe present study – as almost every other study in this field – was limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).',
            ),
            const TextWidget(
              text:
                  'To summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. The minimal effect on dream content might be explained by the lack of arousals in poststimulation EEG, indicating clearly that pure olfactory stimuli are processed differently to stimuli of other sensory modalities. We hypothesized that the strong effect on dream emotions is due to the direct connectivity of the olfactory bulb (and not for other sensory modalities) to the amygdala processing emotional memory during REM sleep. Whether olfactory stimuli are presented directly in dreams is a question which has not yet been answered; it might be speculated that declarative material which is associated with the specific odour might be found more often. Studies with presleep learning sessions in which odour cues are associated with specific cues might shed light on memory processing and consolidation during sleep. In addition, it would be interesting to study nightmare sufferers, i.e. whether positively toned olfactory stimuli yield a significant shift in the emotional tone of nightmares.\n\n',
            ),
            const TextWidget(
              text:
                  'Methods\nThe study was conducted at the Sleep Disorders Center at the Department of Otorhinolaryngology, Head and Neck Surgery Mannheim. The study protocol was approved by the local ethics board of the Faculty of Clinical Medicine Mannheim of the University of Heidelberg; written informed consent was obtained from all participants.\n\nParticipants\nGiven that young females have demonstrated the best olfactory performance among human subjects (Covington et al., 1999; Stuck et al., 2006b), 15 young healthy female volunteers were included in this prospective study (mean age 23.0 ± 2.1 years, range: 20–28 years). Exclusion criteria were actual/previous history of smell or taste disorders, use of any medication known to affect chemosensory function and a history of sleep disorders. At the screening visit, relevant nasal pathology, such as mucosal inflammation, significant septal deviation and nasal polyposis were ruled out via a detailed clinical examination, including nasal endoscopy. Patency of the nasal airways was ascertained additionally using active anterior rhinomanometry (Rhinomanometer 300; ATMOS Medizintechnik GmbH & Co. KG, Lenzkirch, Germany).\n\nPsychophysical testing of olfactory function\nAll participants underwent olfactory testing using the ‘Sniffin’ Sticks’ test kit to establish normal olfactory function (Hummel et al., 1997; Kobal et al., 2000). Odorants were presented in odour dispensers similar to felt‐tip pens. Testing involved assessment of n‐butanol odour thresholds, odour discrimination and odour identification. In order to categorize olfactory function in terms of functional anosmia, hyposmia and normosmia, the sum of the three scores for odour thresholds, odour discrimination and odour identification was used [threshold–discrimination–identification (TDI) score; Wolfensberger et al., 2000].\n\nSleep recordings\nThe participants were admitted to the Sleep Disorders Center. Analogous to routine sleep studies, an overnight polysomnography was performed to assess nocturnal sleep. Monitoring included two electroencephalographic recordings (C3‐A2, C4‐A1), two electro‐oculograms (left, right), two submental and two leg electromyograms (left, right). Sleep stages were scored according to Rechtschaffen and Kales (1968).\n\n',
            ),
            const TextWidget(
              text:
                  'Chemosensory stimulation\nFor stimulation, a dynamic olfactometer based on air‐dilution olfactometry was used (OM6b; Burghart Instruments, Wedel, Germany). This allows the presentation of odorous stimuli within a continuous airstream of 8 L min−1, which does not alter the mechanical or thermal conditions at the nasal mucosa (Kobal, 1981). Moreover, this constant airstream ensures that the influence of breathing patterns on stimulus presentation to the olfactory epithelium is minimized. For specific olfactory stimulation the unpleasant H2S, described typically as smelling like rotten eggs, was presented at 4 parts per million. The positive olfactory stimulus was phenyl ethyl alcohol (PEA), described typically as smelling like roses, administered at 20% v/v (both stimuli are clearly above threshold). Stimulus duration was 10 s. Odourless stimuli were presented additionally as a control.\n\nTo allow sufficient mobility during sleep, a tube of approximately 60 cm length was used to connect the subjects’ nostril with the olfactometer outlet. This ensured that changes in body position had little influence on stimulus presentation. The tube was secured with tape to the nostril. A curtain separated the subjects’ bed from the olfactometer and the investigator. Earplugs were administered to dampen external sounds.\n\nREM awakenings\nThe participants were awakened by the experimenter who asked: ‘What was on your mind before I woke you up?’. After pauses in reporting, the experimenter prompted up to three times: ‘Was there anything else?’. Lastly, the participant was asked to estimate positive and negative dream emotions on 4‐point scales (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). For determining the emotional tone, the negative score was subtracted from the positive score. The interview was recorded and transcribed later. All words not related to the dream experience and repetitions were excluded. Mean word count was used as a measure for dream length.\n\nDream content analysis\nThe following scales were adapted from Schredl et al. (1998): realism/bizarreness (1 = realistic, 2 = realistic but extraordinary, 3 = one or two bizarre elements, 4 = several bizarre elements) and positive and negative dream emotions (0 = none, 1 = mild, 2 = moderate, 3 = strong feelings). These scales showed good inter‐rater reliability ranged r = 0.642–0.825 (Schredl et al., 2004). For the purpose of the study, two additional scales were developed: explicit mention of perception of smelling something (present versus not present) and dream elements which are associated normally with strong odour (present versus not present). Lastly, for each dream report the judges should make a guess as to what kind of stimulus (positive, negative, neutral) was applied.',
            ),
            const TextWidget(
              text:
                  'Procedure\nThe participant slept for 2 consecutive nights in the laboratory. The first night served as adaptation to the setting including polysomnography and taped tube of the olfactometer. Stimuli (pleasant, unpleasant, neutral) were presented in a balanced order during the second night during each REM period. Stimulation (duration 10 s) was started after 5 min into the first REM period, 10 min into the second REM period and 15 min of all following REM periods. One minute after presentation, the investigator awakened the participant and elicited dream content and self‐rated dream emotions. Dream reports were taped, transcribed, randomized in order and rated by two independent judges along the rating scales described above. The judges were, therefore, blind to the condition and also not involved in the collection of the reports. Emotional tone (positive emotions − negative emotions) was used as variable for statistical analyses.\n\n',
            ),
            const TextWidget(
              text:
                  'Statistical analyses were carried out with sas version 9.1 (SAS Institute Inc., Cary, NC, USA). Data were submitted to analyses of variance for repeated measures with ‘stimulus type’ as within‐subject factor. Contrasts were computed by dependent t‐tests. Degrees of freedom are presented in brackets following the F‐values and t‐values. The alpha level was set at 0.05.\n\n',
            ),
            const TextWidget(
              text:
                  'Results\nAll subjects were normosmic (mean TDI score 38.4 ± 5.1; range 33.5–45.0). No abnormalities were detected during the overnight sleep recordings of the first night. Because of the limited number of REM periods in several participants, 12 awakenings in the neutral condition and 13 awakenings in the positive condition could be carried out, whereas for the negative stimulus all 15 awakenings were performed. The time of night (measured as hours from midnight) was comparable across conditions and means were not statistically different (neutral condition: 4.37 ± 2.47 h, negative stimulation: 4.46 ± 1.39 h and positive stimulation: 4.02 ± 2.02 h). Dream recall was almost 100%; only one of 40 awakenings yielded no dream report, but for this participant the stimulation was repeated in the forth REM period.\n\n',
            ),
          ],
        ),
      ),
    );
  }
}

class P100Reading extends StatefulWidget {
  const P100Reading({Key? key}) : super(key: key);

  @override
  State<P100Reading> createState() => _P100ReadingState();
}

class _P100ReadingState extends State<P100Reading> {
  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<BdController>().history.value.value == 126) {
      Get.find<BdController>().updateHistory(end.difference(initial).inSeconds);
    }
    super.dispose();
  }
DateTime initial = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
        child: Column(
          children: [
            ReadingTitle(
              title: 'P100- Simple TO-DO List',
              ontap: () =>
                  Get.to(() => const ActionJournalLvl2(), arguments: [false]),
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that it is unlikely that an increase of stimulus intensity will produce stronger effects. In addition, the concentrations applied in the present study have been intense and clearly above threshold.\n\n',
            ),
            const TextWidget(
              text:
                  'From a methodological viewpoint, it is interesting that the findings regarding dream emotions are more pronounced for the self‐rating scales compared to the dream content analytical findings. Schredl and Doll (1998) have shown that external judges underestimate emotional intensity, particularly positive emotions, because of the fact that dreamers, even trained participants in dream studies, did not report all emotions experienced in the dream explicitly. This shift to more negative emotions in the externally rated emotions compared with self‐ratings was also found in the present data. Schredl and Doll (1998) concluded that self‐ratings are more valid measures of dream emotions than analysing dream reports, because of the selective underestimation of positive emotions by external judges.\n\n',
            ),
            const TextWidget(
              text:
                  'Other methodological issues, such as the setting (olfactometer and experimenter in the same room with the sleeping participants), are unlikely to have affected the present findings, as these parameters did not change between the conditions (positive and negative stimulation as well as control condition) in this within‐subject design. The subjects were not informed about the order of the different stimulus conditions, i.e. they were blind to the condition. Unfortunately, we did not ask them whether they were guessing regarding the stimulus. Previous studies with the same methodology showed clearly that the odour is not present at the time of waking the participant (1‐min delay). The experimenter was not blind to the condition; by keeping the interaction between experimenter and participant to a minimum in an exact standardized manner, experimenter effects should be minimal.\n\n',
            ),
            const TextWidget(
              text:
                  'We did not analyse the electroencephalogram (EEG) after presentation within this study because the previous study by Stuck et al. (2007), with a large number of stimulations, showed clearly that EEG measures are not affected by this type of olfactory stimulation (without trigeminal component). On the other hand, the number of stimulations in the present study is far too small to detect an effect on scalp EEG parameters (event‐related potentials). Modern technology functional magnetic resonance imaging) might allow measuring the relationship between olfactory stimuli presentation and amygdala activation during REM sleep (cf. Wehrle et al., 2005).\n\n',
            ),
            const TextWidget(
              text:
                  'The present study – as almost every other study in this field – was limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\n',
            ),
            const TextWidget(
              text:
                  'To summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. The minimal effect on dream content might be explained by the lack of arousals in poststimulation EEG, indicating clearly that pure olfactory stimuli are processed differently to stimuli of other sensory modalities. We hypothesized that the strong effect on dream emotions is due to the direct connectivity of the olfactory bulb (and not for other sensory modalities) to the amygdala processing emotional memory during REM sleep. Whether olfactory stimuli are presented directly in dreams is a question which has not yet been answered; it might be speculated that declarative material \n\n',
            ),
          ],
        ),
      ),
    );
  }
}

class P101Reading extends StatefulWidget {
  const P101Reading({Key? key}) : super(key: key);

  @override
  State<P101Reading> createState() => _P101ReadingState();
}

class _P101ReadingState extends State<P101Reading> {
  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<BdController>().history.value.value == 129) {
      Get.find<BdController>().updateHistory(end.difference(initial).inSeconds);
    }
    super.dispose();
  }DateTime initial = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
        child: Column(
          children: [
            ReadingTitle(
              title: 'P101- Pomodoro Taking breaks and deep workouts',
              ontap: () =>
                  Get.to(() => const PomodoroScreen(), arguments: [false]),
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that it is unlikely that an increase of stimulus intensity will produce stronger effects. In addition, the concentrations applied in the present study have been intense and clearly above threshold.\n\n',
            ),
            const TextWidget(
              text:
                  'From a methodological viewpoint, it is interesting that the findings regarding dream emotions are more pronounced for the self‐rating scales compared to the dream content analytical findings. Schredl and Doll (1998) have shown that external judges underestimate emotional intensity, particularly positive emotions, because of the fact that dreamers, even trained participants in dream studies, did not report all emotions experienced in the dream explicitly. This shift to more negative emotions in the externally rated emotions compared with self‐ratings was also found in the present data. Schredl and Doll (1998) concluded that self‐ratings are more valid measures of dream emotions than analysing dream reports, because of the selective underestimation of positive emotions by external judges.\n\n',
            ),
            const TextWidget(
              text:
                  'Other methodological issues, such as the setting (olfactometer and experimenter in the same room with the sleeping participants), are unlikely to have affected the present findings, as these parameters did not change between the conditions (positive and negative stimulation as well as control condition) in this within‐subject design. The subjects were not informed about the order of the different stimulus conditions, i.e. they were blind to the condition. Unfortunately, we did not ask them whether they were guessing regarding the stimulus. Previous studies with the same methodology showed clearly that the odour is not present at the time of waking the participant (1‐min delay). The experimenter was not blind to the condition; by keeping the interaction between experimenter and participant to a minimum in an exact standardized manner, experimenter effects should be minimal.\n\n',
            ),
            const TextWidget(
              text:
                  'We did not analyse the electroencephalogram (EEG) after presentation within this study because the previous study by Stuck et al. (2007), with a large number of stimulations, showed clearly that EEG measures are not affected by this type of olfactory stimulation (without trigeminal component). On the other hand, the number of stimulations in the present study is far too small to detect an effect on scalp EEG parameters (event‐related potentials). Modern technology functional magnetic resonance imaging) might allow measuring the relationship between olfactory stimuli presentation and amygdala activation during REM sleep (cf. Wehrle et al., 2005).\n\n',
            ),
            const TextWidget(
              text:
                  'The present study – as almost every other study in this field – was limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\n',
            ),
            const TextWidget(
              text:
                  'To summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. The minimal effect on dream content might be explained by the lack of arousals in poststimulation EEG, indicating clearly that pure olfactory stimuli are processed differently to stimuli of other sensory modalities. We hypothesized that the strong effect on dream emotions is due to the direct connectivity of the olfactory bulb (and not for other sensory modalities) to the amygdala processing emotional memory during REM sleep. Whether olfactory stimuli are presented directly in dreams is a question which has not yet been answered; it might be speculated that declarative material \n\n',
            ),
          ],
        ),
      ),
    );
  }
}

class Bd101Reading extends StatefulWidget {
  const Bd101Reading({Key? key}) : super(key: key);

  @override
  State<Bd101Reading> createState() => _Bd101ReadingState();
}

class _Bd101ReadingState extends State<Bd101Reading> {
  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<BdController>().history.value.value == 116) {
      Get.find<BdController>().updateHistory(end.difference(initial).inSeconds);
    }
    super.dispose();
  }DateTime initial = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 10,
          bottom: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title: 'BD101- Habits & Behavioral Design',
              ontap: () =>
                  Get.to(() => const NudgesScreen(), arguments: [false]),
            ).marginOnly(bottom: 20),
            headline1('Introduction'),
            const TextWidget(
              text:
                  'Do you want to start new positive habits and/ or stop negative habits? Do you want to maximize your chances of completing whatever activities you desire to complete today as well as minimize the chances of engaging in any undesired activity? Do you want to learn the underpinnings of creating a system to achieve any goal you can imagine? These are just some of the questions we will explore in this section. ',
            ),
            headline1('The Habit Loop'),
            const TextWidget(
              text:
                  'Habitual behavior is often described as a loop. A habit starts with a cue to begin the habit. After the cue the habit itself is performed. Finally, a reward is received for performing the habit. Every time the loop is completed the habit grows stronger. An example of this loop is waking up and hearing your alarm (the cue) then walking to the bathroom and taking a shower (the habit). You then feel refreshed and clean (the reward).\n\nBy using our knowledge of the habit loop and drawing from the mass of habit formation research in the behavioral science field we can consciously form a strategy to create, eliminate, replace, or modify any habit for the long-term. We can also use these same strategies to decrease or increase the likelihood of performing almost any activity. We refer to this process as “designing a path of least resistance” and we will learn to use this process daily to drastically change and shape our lives to the forms of our choosing.',
            ),
            headline1('How to “Design” your Behavior '),
            const TextWidget(
              text:
                  'Humans can achieve amazing things, but we inherently are creatures of habit and tend to follow the same paths (and even sit in the same chairs) day after day without much thought. We groggily walk to the kitchen after pressing snooze a few times and see a chocolate muffin (or a pop tart, lucky charms, etc.) sitting on the counter. It looks good and is easy to prepare so we eat it for breakfast even though we know it\'s unhealthy and could lead to a premature death down the road. If we had woken up to an alarm that we had to walk to turn off in the office (which forces you to get out of bed), and there was a large plate of fresh fruits and a jug of pristine spring water staring us in the face, what would our decision be then? Would we get ready, leave the house, drive to the store, buy chocolate muffins, go back to the house, heat up the muffin, then eat the muffin? No, we would take the path of least resistance, drink the water, eat the fruit, and feel amazing knowing we made a positive decision for our long term health.\nThis strategy beats seeing if this will finally be the day that we defeat our urge for chocolate muffins. By designing our environment for specific outcomes success becomes an automatic process instead of a daily struggle. \n\nCreating a path of least resistance is incredibly important at a physical and subconscious level to success. At a physical level you can flow through your day more easily and at a subconscious level you already “know” you’re going to be successful because you have a plan and you know exactly what you’re going to do. Creating a path of least resistance acts as a generous spray of DW-40 on the rusty hinges of life. Now the door swings open without resistance and you pop through with ease. When you know where you’re going, have a plan to get there, and make it easy to follow through on that plan you begin to create a positive self-fulfilling prophecy, confidence, and positive momentum that can quickly snowball into an unstoppable force. \n\nThe field of behavioral design has given us a useful toolkit to nudge ourselves in the right direction. We will use these simple tools for a few minutes each day to drastically change the course of our days and bypass willpower so our easiest decision is also the best decision! These tools are very basic and often overlap making them even easier to use. The main nudges we will take advantage of are listed below. ',
            ),
            headline1(
                '1) Simplify things you want to do. Complicate things you want to avoid '),
            const TextWidget(
              text:
                  'Examples include:\na)Elimination of things from your environment you do not want to negatively affect you. An example is not keeping unhealthy or problematic foods/ drinks (or alcohol) in the house or at least keeping them in difficult to access and locked locations. \nb)Group like activities. When you have to switch from one type of activity to another your brain gets confused. The less you have to switch contexts to wrap your head around an idea the easier it will be to smoothly continue working productively. Block entire hours or days to focus on completing similar tasks.\nc)Only shop at healthy food stores to complicate access to unhealthy foods and simplify access to healthy foods. Another strategy to achieve the same goal is creating a pre-planned shopping list that you use to purchase your food online further eliminating physical distractions and temptations (such as entering a grocery store with delicious bakery smells).\nd)Put your phone in the other room while working to complicate the process of using it and potentially wasting valuable time. \ne)Delete unwanted/ unused (social media) apps so you must re-download to use them, complicating the process. Using your phone’s or laptop’s home screen to only house shortcuts to apps that you need to use to simplify the process of accessing them. \nf)Take the TV out of the bedroom to make it more difficult to watch.\ng)Set the book you\'re reading on the table next to your reading chair (or directly on top of the reading chair).',
            ),
            headline1('2) Provide sensory cues, especially visual cues'),
            const TextWidget(
              text:
                  'Visual cues can spur us to action, remind us what we should be doing, provide motivation, and nudge us in the right direction. There are a couple of different ways to use visual cues. One way is to use a visual cue to start a behavior while another is to use a visual cue to measure progress. Using a visual cue to start a behavior would look like hanging your workout clothes on your bedroom door to remind you to work out in the morning. Using a visual cue to measure progress would look like having a large calendar in your room and marking an X for every day you worked out. When using a visual cue to measure progress it usually also serves the function of a reminder as well. Some other relevant examples of using visual cues include:\na)Using coins or paper clips to track progress by having two jars, one full and one empty, and transferring one coin or paper clip to the other jar for each completed action (pushup, sales call, book read to child). This strategy serves as a reminder and records progress.\nb)Changing passwords to desired actions such as “QuitDrinkingN0\/\/” or “wRitEL0\/Eletters2wyfe” can serve as a reminder and call to action.\nc)Placing soccer cleats in front of your door to encourage practice. \nd)Placing a visual note in plain view as a call to action.\ne)Using a jar of pennies as a representation of debt and removing a penny for each \$100 of debt that you paid off\nf)Placing a picture of your dream vacation above your TV with a note reading, “If you want to be here you need to perform deep work every day.”',
            ),
            headline1('3) Provide a defualt option'),
            const TextWidget(
              text:
                  'Most people will usually go with the default option because any other option requires the use of willpower, focus, and time that are in short supply for all of us. You probably wouldn’t choose to join the mailing list, but opting out of joining it takes extra time and you’re busy (so you join by default and are spammed forever). A famous example has been numerous governments increasing the number of organ donors substantially simply by asking people if they’d like to opt-out of organ donation as opposed to the previous practice of having people opt-in to organ donation. Create situations where your default option is your best option and opting out is hard. Creating a default option often can also involve simplifying a process and/ or providing a visual cue. Examples include:	\na)Laying out the work you will do tomorrow on your desk or opening the files in your laptop the night before so they are ready to be worked on the next day.\nb)Laying out healthy food options at eye level or in easy to view locations in your kitchen or places you usually eat.\nc)Pre-preparing healthy meals for the day or week.\nd)Setting the floss and toothbrush on the bathroom sink in plain view. \ne)Having a book to read your child right next to their bed opened to the first page.\nf) Laying out clothes for the next day the night before',
            ),
            headline1('4) Create a task-specific environment'),
            const TextWidget(
              text:
                  'Organize rooms (or other areas) for specific activities. Make these rooms as distraction-free as possible, and don’t use them for other activities (don’t use your workout room to watch TV on Saturdays). Your mind associates environments and the actions usually done in the environments signaling to your body and brain to act a certain way. Studies have shown that people can begin to feel inebriated by entering a familiar bar even if they haven’t had one drink. \nSurround yourself with people and/or things that will help you reach your goals. Create a setting for each important action you take in the day to automatically prime your mind to begin the type of thinking needed. Examples include:\na)A desk for working\nb)A workout niche or room\nc)A meditation mat, rug, or room\nd)A reading chair\ne)Putting on “successful” clothes (whatever your definition of that may be). Your clothes act as the direct environment you surround yourself in and also exert a subconscious influence. ',
            ),
            headline1('5) Start a habit chain'),
            const TextWidget(
              text:
                  'Chaining refers to performing one habit directly after another activity using the activity as a cue to begin the habit. Preferably, the activity used as a cue is already an ingrained habit. You can chain multiple habits together to form what is commonly referred to as a routine. Chaining is another form of a cue and a very powerful one because it’s based on an activity that you already are almost guaranteed to perform so you’re guaranteed to receive the cue. This acts as a built in reminder to start your habit which can increase your chances of starting and continuing your habit.\nExamples include:\na) If you want to start the habit of flossing and you already brush your teeth everyday, you can floss everyday after you brush your teeth. \nb)If you want to start the habit of stretching and you already lift weights, then every time you finish lifting you can immediately begin stretching.\nc)If you want to start the habit of learning through audiobooks and you already commute to work everyday then you can turn listen to your audiobook everytime you enter your car \nd)Group like activities together in a chain to create a routine of similar activities. This will lessen the amount of context switching that occurs, further maximizing your productivity.',
            ),
            headline1('6) Celebrate'),
            const TextWidget(
              text:
                  'Celebrate during your habit and/ or directly after your habit to release a small hit of dopamine into your brain to get you hooked on the high. Getting high naturally and naturally creating an addiction to healthy habits is a great way to hack your body to make sticking to your habits easier. If you can create this emotional reaction by legitimately feeling success and joy you will create a need in your brain to perform this activity again. Something as simple as smiling and saying “that was pretty easy.” is an example of simple celebration. Dancing, patting yourself on the back, visualizing your loyal fans cheering for you, throwing your hands in the air, high fiving someone, giving thanks to yourself or someone else, taking a mindful breath, or winking at yourself. The options for celebrations are endless and are only limited by your imagination.\nThe initial celebrations are the most important to ingrain the habitat into your head. After this period you gain diminishing returns from each celebration and it is not completely necessary to continue celebrating. So, you do not need to celebrate forever and stop if it is a hassle, but by all means continue if you enjoy celebrating.',
            ),
            headline1('7) Receive short-term rewards'),
            const TextWidget(
              text:
                  'The habit loop discussed at the beginning of this section ends in a reward. It reinforces the habit and makes us want to perform the habit again. The reward can be a feeling we get while or after performing the activity or can be a physical reward of some kind. The best rewards are emotional and primitive. Think basic needs and desires. Just don’t use a reward that completely cancels out the good done by the habit such as eating a whole box of chocolates after working out. The last point is extremely obvious, but needs to be said. Your reward should be rewarding for you personally. Don’t just take a reward from this list. Think about what you personally enjoy. Examples of short-term rewards include:\na)Gardening after you complete your habit\nb)Enjoying family time after completing your habit\nc)Having a planned romantic time after completion of an activity\nd)Take a hot bath upon completing your activity or habit\ne)Play your favorite game after completing a habit\nf)Enjoy your favorite hobby after completing your habit\ng)Listen to your favorite music  after completing your habit\nh)Watch your favorite show after completing your habit\ni)Take a nap after completing your habit',
            ),
            headline1(
                '8) Clarify your deepest whys and remind yourself of them daily'),
            const TextWidget(
              text:
                  'What is the reason you want to complete this activity or habit? Not the surface reason, but the reason deep within you that stems from your core beliefs. Your motivation for completing the habit or activity needs to be extremely important to you or why do it at all? This can take some time, effort, and also requires complete honesty with yourself. See “P102 - Goal Setting and your Deepest Why” for more information and an easy worksheet to help you clarify your deepest whys. This exercise is so powerful not only in its effect of supercharging your motivation, but also in giving you back control by exploring your deepest beliefs that oddly enough you usually don’t think about. This lack of conscious effort in developing our deepest intentions and reasons behind them is one of the key drivers in leading an unexamined life on autopilot. Examples of deepest whys could include:\na)If your goal is to better regulate your anger, your deepest whsy may be to not pass those unhelpful modes of thinking and acting onto your child to give them the best opportunity to thrive in the future. \nb)If your goal is to consistently workout your deepest why could be living longer to see your grandchildren. \nc)If your goal is to make 10k/ month in an online passion business your deepest whys may be to free yourself from the shackles of creative confinement that your 9-5 job provides, free yourself from financial worries, and free up your days to enjoy more time with your loved ones.',
            ),
            headline1('9) Visualize every step'),
            const TextWidget(
              text:
                  'Visualizing the whole habit loop can increase your chances of performing a habit and continuing your practice by priming your brain to perform the habit. It’s very important to visualize each step in the process including any cues, the habit itself, the reward, and the positive feelings felt after completing the habit. To learn how to perform this process and a much more in-depth discussion consult the visualization section, in particular, “V101 - Creating your Script” and “V103 - Habits”. ',
            ),
            headline1('10) Take baby steps'),
            const TextWidget(
              text:
                  'Start your habit with a tiny commitment either in time or results. Since just showing up consistently is key to forming a new habit we need to make that a key priority. When we set a seemingly ridiculously small target such as working out for 1 minute we will probably end up doing more than 1 minute. Our goal is just to start and show up because for most of us that is the most challenging part. By starting out tiny we can increase the likelihood that we will show up and begin to develop the habit organically, improving incrementally,  instead of jumping into something we aren\'t ready for and burning out. Examples include:\na)If your goal is to get to a healthy weight and your method is doing a 20 minute HIIT workout daily you can start with a 1-minute version of the workout.\nb)If your goal is to write a book and your method to achieve that goal is to write 3 pages daily then you can start by writing just one sentence daily.\nc)If your goal is to start a daily 30-minute meditation practice you can start by setting aside a moment to just take 10 deep breaths every day.',
            ),
            headline1('11) Create contingency plans for common obstacles'),
            const TextWidget(
              text:
                  'There are always obstacles in the way of practicing our habits and achieving our goals. Whether it be how to avoid those extra calories when enjoying a night on the town with friends or how to finish work that was delayed due to a surprise meeting, having a contingency plan can be the difference between completely giving up and barely missing a beat. Life happens and creating a contingency plan for common obstacles gives us a first line of defense in preparation to keep us focused regardless of what life throws at us.\nTo create a contingency plan we first need to identify what common obstacles we may face that hinder our ability to practice a habit. Common obstacles vary greatly depending on the habit and you will certainly learn what they are the more you perform your habit. To go back to our previous example, if you are trying to eat healthy but still want to have a social life, social events can be treacherous territory not only with unhealthy food, but also the lure of high calorie alcoholic drinks. A sample contingency plan to deal with high calorie unhealthy restaurant food is to eat healthy before going out to dinner to lessen the craving for the food and give you an excuse when people ask you why you’re not eating very much. If being around alcohol or friends that trigger you to drink alcohol excessively is a common obstacle to your health goals you can create a contingency plan where you bring your own alcohol that is low percentage, high volume, and low calorie such as a seltzer water mixer and make it a point to drink slowly and mindfully. An alternative contingency plan would be to plab another activity that would force you to leave the event after a certain amount of time thus limiting your time and potential to drink to excess. \nIf you have a nagging injury that completely takes the life out of your workouts and makes you feel like you\'re just spinning your wheels, sapping your motivation- have an alternate routine that you can go to when you feel that injury getting aggravated.\nSome events can never be planned for, but we can be prepared for many of the common obstacles that lie in wait to thwart our plans. By experiencing new obstacles we have a chance to explore new strategies to avoid or conquer these obstacles. By being prepared we can eliminate much of the resistance to starting and keeping a habit alive.',
            ),
            headline1('Consistency'),
            const TextWidget(
              text:
                  'Some recent studies have shown habit formation takes an average of between 66 and 122 days. Sticking it out for the first few months (or longer) is arguably the hardest part of the whole process. Once you do the hard work of showing up consistently and the habit is formed everything becomes much easier and more automatic. Using all the tools discussed above should make this process much easier. ',
            ),
            headline1('Overview'),
            const TextWidget(
              text:
                  'There’s so much noise in our life, so many distractions coming at us at a million miles an hour each day. So many ideas, so many possibilities, so many decisions that eat away at our time and our willpower each day. When we design a path of least resistance and nudge ourselves in the right direction we make the easiest choice, the right decision, and we remove alternative options that serve to distract us. \n\nThe strategies we’ve discussed to change behavior sometimes overlap and are very simple, yet they are evidence-backed, used by major governments, used by major corporations, and are extremely effective. These strategies cost little in time, effort, and capital to execute yet provide outsized results. They are a no brainer to implement and are key to your progress in building productivity and streamlining a busy life.',
            ),
            headline1('Behavioral Design Journal'),
            const TextWidget(
              text:
                  'Your Behavioral Design Journal is used to design a path of least resistance so your desired habits and behaviors actually get done. The journal not only helps you design a path of least resistance for each desired activity to perform but also keeps a record of the time spent and the description of nudging activities performed each day. With this journal, you can get your most important things done, start habits to change your life, and monitor how well it’s all working. A few moments of time dedicated to creating a path of least resistance for your to-do list and habits each day can pay huge dividends and increase your chances of completing your tasks and moving forward towards your goals. Nudges that you will need to perform regularly for your habits and eventually for your personalized system to achieve whatever goals you have dreamt up will become like second nature and grease the gears that will launch you forward.\n\nJournaling is a great way to stay on track and monitor your progress. Reflecting on your time creating a path of least resistance will make the practice even more fluid and second nature for you to perform. It will also help you think more closely about what habits you want to modify or adjust and how you can move through your day more smoothly every day. ',
            ),
            headline1('Using the Behavioral Design Journal'),
            const TextWidget(
              text:
                  '1)Identify what habits you want to start or change and/ or what tasks you want to get done. This is referred to as the “Desired Activity to Perform” in the Behavioral Design Journal. A great place to start is your to-do list especially if you have activities that recur on a daily basis. You get the most bang for your buck identifying recurring tasks or habits because if you can design good nudges you use them over and over again sometimes automating them so you can push yourself in the right direction continually by only exerting that initial effort and minimal maintenance effort. \n2)Go through each item thoughtfully referring to this reading when needed. Some habits and activities won’t be conducive to every single nudge on this list and one nudge is infinitely more powerful than none, but completing every nudge will be the most effective option. How much work you put into completing this section will determine the effectiveness of this practice; however, we need to also consider the time spent vs. the benefit received. We don’t necessarily want to spend hours creating the perfect nudges for a to-do list item that will take less time than that to complete. If the task is short-lived, non-recurring, and not necessarily meaningful, less time should be spent designing and carrying out your path of least resistance. In fact, a simple cue and a reminder that this seemingly insignificant task is tied to one of your deepest whys would probably be sufficient. \n3)Once you have identified which nudges write them down in their assigned spaces.\n4)Once you have written all your nudges in the spaces provided immediately carry out all of the physical prep activities for the nudges. \n\n5)Check your Behavioral Design Journal nightly to prepare for the following day and make meaningful changes to your habits and life.\n\n6)When you get the hang of using the Behavioral Design Journal for one habit you can move onto using it for your daily to-do list and to work on developing new habits.',
            ),
            headline1('Habit Builder Worksheet'),
            const TextWidget(
              text:
                  'The Habit Builder worksheet narrows your focus down to just a single activity that you would like to change into a habit. This worksheet form makes it simpler to get started on creating a habit. Go through the worksheet and answer each question. When you are finished you will have a worksheet completed dedicated to changing one activity into a habit for the rest of your life. ',
            ),
            headline1('Summary'),
            const TextWidget(
              text:
                  'First, use the Behavioral Design Journal to design a behavior or habit that’s designed to stick for the long term. Second, use the Behavioral Design Journal to record your progress and make sure you’re staying consistent with this practice. Once you can do this for one habit or activity, branch out to using the Behavioral Design Journal for your To-Do List daily and for new habits when needed.',
            ),
          ],
        ),
      ),
    );
  }
}

class P100AReading extends StatefulWidget {
  const P100AReading({Key? key}) : super(key: key);

  @override
  State<P100AReading> createState() => _P100AReadingState();
}

class _P100AReadingState extends State<P100AReading> {
  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<BdController>().history.value.value == 128) {
      Get.find<BdController>().updateHistory(end.difference(initial).inSeconds);
    }
    super.dispose();
  }DateTime initial = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 10,
          bottom: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title:
                  'P100A- Timeboxing & Time Blocking: Elon Musk\'s Best Friend',
              ontap: () => {},
            ).marginOnly(bottom: 20),
            headline1('Introduction'),
            const TextWidget(
              text:
                  'Timeboxing and time blocking are some of the most simple, elegant, and useful ways of organizing time. They both involve partitioning off sections of your days in blocks of time to work on specific tasks or types of tasks. Time blocking and time boxing can give your days the structure they need for achieving maximizing productivity. Time blocking is famously used by Elon Musk, who is arguably one of the most productive people alive.\n\nTime blocking and time boxing both do wonders against Parkinson’s Law. Parkinson\'s law states “Work expands so as to fill the time available for its completion”. That means if you don’t assign any time limit by creating a time block or box your simple task could end up taking a very long time. [1], [2], [3], [4], [5] If you have all day to do a task then that task can end up taking all day. A one page paper could take a week of perfecting or it could be written within a matter of minutes or hours. Time blocking and time boxing allow you to defeat this tendency and stop wasting time. Beyond working around Parkinson’s law when you use time blocking or time boxing you have a record of exactly how your time was spent and can use these records as part of a feedback loop to get better. ',
            ),
            headline1('Time Blocking'),
            const TextWidget(
              text:
                  'Time blocking is when you assign a specific period of time to completing a specific task or type of task. Your goal is to complete the task in that time period. At the end of the time period you evaluate your work to see if you completed your task. You can also set a recurring timeblock to work on something consistently day after day, or week after week. \nTime blocking is primarily used to set aside time for activities you are worried you will not find time for or worried you will not work on consistently if they are not scheduled into specific blocks of time. \nFor example, you may think you can finish writing one page of a psych essay in an  hour so you assign that task for tomorrow from 7:00PM to 8:00PM. You finish the task and mark it as complete. You could also set a timeblock from 7:00 to 8:00AM each morning for exercise then set a timeblock for breakfast from 8:05AM to 8:20AM, then a 10 minute time block for your shower, then etc. etc....You can even timeblock your whole day including your freetime. Time blocking can lead to more free time and more enjoyment because you actually planned a hobby in your free time instead of just scrolling on social media. Elon Musk, the founder of SpaceX, and one of the busiest guys around runs a handful of companies while still finding time for his 7 kids and even his hobbies. Elon is a testament to the power of time blocking.',
            ),
            headline1('Time Boxing'),
            const TextWidget(
              text:
                  'Time boxing is when you set a specific start time to work on a task or project and a non-negotiable deadline. When that deadline is hit the work is done, regardless of if you consider the work finished or not. These hard deadlines act as reality checks and push us to produce,  focusing on what needs to be done to complete the project rather than focusing on perfection. \n\nTime boxing is primarily used as a tool to maximize productivity by limiting the time spent on large projects that seem too overwhelming and activities we would rather not spend lots of time on, such as chores. You can timebox that childrens’ book you have always wanted to write or timebox washing your car. A time box for writing a childrens’ book may have a six month deadline which really is just setting a goal, but you can use timeboxing for short term planning by setting deadlines for a related daily task such as writing 10000 words from 12:00PM to 3:00PM. When you have recurring timeboxes like this you can record how long it took you to complete the task or where your production was when your deadline came up if you did not complete the task. By comparing how long the activity took versus your timebox you can become more and more realistic with your estimations of the duration of activities. When you timebox you race through activities trying to set new personal bests. You can gamify boring activities like washing the dishes by seeing how fast you can complete the task and measuring it against your old times.\nTimeboxing, especially with tight deadlines, becomes a do or die situation that forces you to find new ways to work faster and get more done in the same time period.',
            ),
            headline1('How to integrate into your dialy to do list'),
            const TextWidget(
              text:
                  'The Simple To Do list considers priorities but doesn’t set a time limit for any task. This works great for some types of tasks and certain types of people, but not for everyone. Those that do not like lists in general and feel stifled by them, those that prefer improvisation, those that value flexibility very highly, or those that complete tasks on time with little oversight. The biggest value of the Simple To Do is that it has something to say about the relative importance of tasks. We can identify tasks based on their importance and prioritize them. Time blocking and time boxing can be great additions to The Simple To Do by adding the dimension of time to the equation. By integrating the Simple To Do with time blocking and time boxing we reach the To Do Level 2. In this daily to do list we consider what is really important. What are my priorities? Now, when exactly will I spend time completing my priorities?  ',
            ),
            headline1('Overview'),
            const TextWidget(
              text:
                  'You cannot time box without time blocking, but you can time block without time boxing. Time blocking is great for partitioning your day to provide time to work on all your different projects. Time blocking can also be great for giving you a repeatable schedule without always concerning yourself with the details. \n\nTimeboxing can go one step further to focus you on production and finishing what’s really important. By adding deadlines and enforcing them you can get your projects done faster. You can even gamify boring tasks using timeboxing to beat your old high scores. Is basketball really that different than getting all your clothes in the hamper? Is organizing the garage really that different from tetris? Get a new high score and have more time to do what you really want to do!\n\nTime blocking and time boxing are simple and effective tools to organize your days and life. By assigning tasks a time and performing the task in that time you plan your future, then actualize it. By having a record you can create a feedback loop that works to improve the productivity of any task. Time boxing and time blocking work as system loops that allow you to manage every part of your schedule from the future, to the present, to looking back at the past, to putting it all together for constant improvement. ',
            ),
          ],
        ),
      ),
    );
  }
}

class TacticalReviewReading extends StatefulWidget {
  const TacticalReviewReading({Key? key}) : super(key: key);

  @override
  State<TacticalReviewReading> createState() => _TacticalReviewReadingState();
}

class _TacticalReviewReadingState extends State<TacticalReviewReading> {
  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<BdController>().history.value.value == 132) {
      Get.find<BdController>().updateHistory(end.difference(initial).inSeconds);
    }
    super.dispose();
  }DateTime initial = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 10,
          bottom: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title: 'Tactical Review',
              ontap: () => Get.to(() => const TacticalReviewScreen(),
                  arguments: [false]),
            ).marginOnly(bottom: 20),
            headline1('Introduction: Congratulations!'),
            const TextWidget(
              text:
                  'Congratulations on completing the Goals module! Now, you have the complete setup for reaching your dreams. You have explored your ideal self, best life, and purpose. You have methods to define and live up to your values and goals. You have mapped out the exact steps to reach your goals and created a custom system to get you there. If you follow your plan and system you will live your purpose and move closer to your ideal self and ideal life daily. You have done the hard part, but you still need to do maintenance to keep your system purring like a kitty (or roaring like a lion) and that is where the Periodic Review comes in. ',
            ),
            headline1('Benefits of Periodic Reviews'),
            const TextWidget(
              text:
                  'When you record progress towards your goals, you focus more on your goals, and you increase your likelihood of completing the goal. [1], [2] You will get this same boost in likelihood of success by monitoring your progress and then performing periodic reviews of your progress towards your goals and milestones. Periodic reviews should be part of any good system. If you are operating based on stale information you can’t respond to today’s issues. If you are constantly recording and updating, you can stay on top of all new challenges that arise. No plan will be perfect from the get go. Every great plan needs to have wiggle room, room to change and to stay ahead of potential issues. ',
            ),
            headline1('What is a Periodic Review?'),
            headline1('\n\nDefinition'),
            const TextWidget(
              text:
                  'The Periodic Reviews will serve to evaluate your progress in working towards your values, goals, and milestones. This is where you will examine what you have reaped. You will use the entries from your Purpose Journal as valuable information to assess the progress you have made against your estimates and pinpoint exactly which areas of your strategy are responsible for your progress or lack thereof. You will have a chance to brainstorm improvements to your methods, as well as formulate solutions to challenges that you are currently facing and that you will likely face. If necessary, you can use this analysis to update your roadmap and/ or system to deal with current challenges, preemptively eliminate future challenges, increase productivity, increase performance, as well as live up to your goals, values, and purpose fully. No action is required to be taken based on the review if everything is going smoothly. In the instance that everything is going smoothly your review still serves as a valuable tool to objectively verify performance. It also serves as roadmarker to summarize overall progress that can be easily referenced for future planning, especially when used in concert with other periodic reviews. Taking the time to reflect, even if everything is going perfectly, is essential to increasing the chances of achieving your goal, increasing your focus on that goal, unveiling methods to drastically increase your performance, revealing potential pitfalls before they occur, and providing assurance that you are fully prepared for the next phase of your plan. ',
            ),
            headline1('Frequency'),
            const TextWidget(
              text:
                  'A Periodic Review should be carried out at least once every quarter, but can be completed more often, such as once a month, for goals that are estimated to completed in less than a quarter. ',
            ),
            headline1('Duration'),
            const TextWidget(
              text:
                  'This should be a deep dive and the time it takes to complete can vary drastically depending on the amount and complexity of your values, goals and systems. Devoting at least an hour or four to this exercise every three months can be crucial to long term success. Below we will go over the various sections in the Periodic Review.',
            ),
            headline1('How to Perform a Periodic Review\n\n\nValues'),
            const TextWidget(
              text:
                  'First, you need to evaluate if you are living up to your values and why this is or is not so. Uncover what has been effective in living up to your values and identify the common stumbling blocks you have encountered, then design a strategy to improve your authenticity even further.',
            ),
            headline1('Authenticity'),
            const TextWidget(
              text:
                  'If you are using the app, the authenticity scores you assigned to your values in all Purpose Journals for the date range chosen will be averaged giving you a plain number to evaluate how truly you think you are living up to your values. If you are not using the app then assign yourself an authenticity score from 1-10 for each of your core values based on how authentically you think you lived up to each value during this period. Reflect on this number and ask yourself, “Why do you think you have this authenticity score?” Think about the who’s, what’s, and where’s that have influenced your authenticity score. ',
            ),
            headline1('Behavioral Design'),
            const TextWidget(
              text:
                  'After you have identified the factors that are influencing this authenticity score ask yourself, “How can you design your environment (surroundings, people, media you consume, etc.) to make living up to your value easier and more natural?” Think about your answer to the first question and what has influenced your authenticity the score the most. Devise strategies to increase your exposure to the things that are increasing your authenticity and decrease your exposure to things that are decreasing your authenticity. Make exposure to people, places, things, and ideas that increase your authenticity easier, simpler, and more automatic. This can be through using nudges (See Behavioral Design 101) or simply by committing to new habits that force you to be exposed to these positive factors. Think about what habits will guarantee you to live up to your value and implement them for the next period.',
            ),
            headline1('Solve & Anticipate Challenges'),
            const TextWidget(
              text:
                  'After you have come up with strategies to design your life for success think about what, who, where, and why you are not fully living up to your values. What are the challenges that you are facing or even that you may face that will stop you from living up to your values fully. Ask yourself, “What is stopping you from living up to your value fully? What is your plan to deal with this stumbling block?” Identify these stumbling blocks and formulate if/then plans to deal with them. If you run into the stumbling block you will execute a certain plan to deal with it. Even better, is if you can develop a plan to avoid the stumbling block altogether. ',
            ),
            headline1('Goals'),
            const TextWidget(
              text:
                  'This is your chance to evaluate your goals, deepest why’s, and milestones to see if you are on the right track. It’s also time to brainstorm ways to ten times your progress, resolve lingering issues quickly, and strategize solutions to challenges that you are facing or will likely face.',
            ),
            headline1('Deepest Why\'s'),
            const TextWidget(
              text:
                  'Start by reviewing your deepest whys. Are they still ringing true? If not, complete the “Deepest Why”  exercise for those deepest why\'s that aren’t still setting you on fire with motivation.',
            ),
            headline1('Roadmap'),
            const TextWidget(
              text:
                  'Take a moment to review your roadmap then ask yourself, “Have you met your deadlines in your goals and milestones? If so, what do you attribute your success to? If not, why? How can you rectify the situation?” This is a four part question and can be very involved depending on the number of milestones that were scheduled for the period in question. Go through each milestone and check off whether it was completed and whether or not its deadline was met. If you did meet the deadline then why do you think that was so? What were the contributing factors to meeting the deadline and what stalled your progress including the people, places, things, plans, attitudes, and habits you used. If you did not meet your deadline then why didn’t you? What people, places, things, plan, attitudes, and habits were used? What challenges did you face that stalled your progress? How can you do more of the activities that led to your success and less of the activities that stalled success? What are completely new strategies you can use that will conquer the challenges you faced? Brainstorm multiple ideas before settling on your preferred strategies.\n\nReview your milestones going into the future. What do you have planned out for the next period. Depending on your progress in the past period your roadmap may be outdated or unrealistic. Ask yourself, “Do you have realistic milestones planned out for the next period?” If not, go to your Roadmap and add or alter them. If so, no action is required, simply review them.',
            ),
            headline('Enhance Performance'),
            const TextWidget(
              text:
                  'This is a more abstract strategizing session. It’s time to think outside of the box. What have you learned over the past period that may completely change the game? Try to completely leapfrog your prior self here using your new knowledge and ask yourself, “How could you work towards your goal ten times more efficiently?” This is your time to brainstorm as well as ruthlessly eliminate what isn’t creating any results and devote time to the most productive and fulfilling activities. \n\nThis is your time to defeat mental blocks that may be standing in your way, especially self doubt, imposter syndrome, and discouragement. You also want to make sure that you are not selling yourself short and making excuses about your production. If you feel like there are some milestones that are impossible to meet think about how you can create a version that is good enough for now, but not perfect. Ask yourself, “How can you use the resources you have at hand right now to get the job done and complete your goal?” It’s infinitely better to create something that can be improved upon then to wallow in inaction, doubt, and possibly hopelessness.',
            ),
            headline1('Challenges'),
            const TextWidget(
              text:
                  'This section is rather straightforward. It is meant to get in front of challenges before you face them and create strategies to overcome challenges you are currently facing. Ask yourself, “What are the biggest challenges you are facing to reaching your goals/milestones and how can you overcome them?” Incorporate the answers to the questions you have just answered and think about the challenges that stand out most and are having the largest negative impact on your performance and wellbeing. How can you mitigate or eliminate these challenges? The strategies you formulate will serve you in the future for similar challenges. Given what you have learned what challenges will you likely face in the future? How will you know when you begin to face those challenges? What strategies can you put in place to deal with those challenges or to avoid them entirely?',
            ),
            headline1('Systems'),
            const TextWidget(
              text:
                  'This is your chance to evaluate your personal system for success. Are you consistently showing up? What results have you seen from implementing your habits? What are the challenges to performing your habit and what contingency plans will you put in place to face those obstacles?',
            ),
            headline1('Consistency'),
            const TextWidget(
              text:
                  'Consistency is key to any habit so if you’re not being consistent you likely aren’t going to see results. Be honest with yourself and ask yourself, “Are you staying consistent? If so, what do you attribute your success to? If not, then how can you design your environment (surroundings, people, media you consume, etc.) to make success easier and more natural?” Use the behavioral design elements to update your system’s path of least resistance if you’re having difficulty with showing up or consistency (See Behavioral Design 101). ',
            ),
            headline1('Performance'),
            const TextWidget(
              text:
                  'Your system is designed to improve mastery, performance, and get results. If you are not seeing any of these results then that can be indicative of a serious problem such as lack of consistency or a poorly chosen habit. In the case of a solid habit it may simply be the case that you need to stick at it longer before you see results. Ask yourself, “Am I improving, even slightly, in my quality, quantity or another measure of my system activities? If not, how can I keep improving?” It can help to think about how can you modify your system to get the best results with the littlest time commitment in the simplest manner. This will give you the most bang for your buck. If your system is not providing any results you may want to redo the “Creating a System: Roadmap” and spend more time evaluating the questions. It can also help to copy the best and research what habits people follow that have already achieved your goal or are at the top of your chosen industry or field.',
            ),
            headline1('Challenges'),
            const TextWidget(
              text:
                  'You will experience challenges to your system in consistency, motivation, and performance. Think about the answers to your previous system review questions and ask yourself, “What are your biggest challenges to completing this habit and what is your plan to overcome them?” If you are not experiencing many challenges then anticipate likely future challenges and create a contingency plan to meet them head on when they strike.',
            ),
            headline1('Overview & Next Quarter'),
            const TextWidget(
              text:
                  'Look at the big picture and start planning for the next period (quarter). This is where you will bring all the answers from the previous questions together along with the knowledge you have gained working towards your values and goals so far. You will also plan for the future and make sure you have a clear path going forward. If you only complete one portion of the Periodic Review then it should be this portion.',
            ),
            headline1('Performance'),
            const TextWidget(
              text:
                  'Ask yourself, “What can you do this quarter that will propel you rapidly towards your long-term ideal lifestyle, values, and goals?” Draw on the answers to your previous performance questions and brainstorm what are the most important methods that you can use to move more quickly towards your values, best life, and goals. What few activities or even just one activity out of all your brainstormed methods would make the greatest positive impact on your performance? ',
            ),
            headline1('Challenges'),
            const TextWidget(
              text:
                  'Ask yourself, “What are the biggest challenges to living your purpose and ideal life? How can you overcome them?” Draw on the answers to your previous challenge questions and identify the greatest challenge to living your purpose and ideal life. What one thing is holding you back and what is the simplest and easiest solution to that challenge? Do you simply need to change your environment to remove friction towards success? Do you need to change yourself in some way such as increasing your competency or mastery? Create your plan of action to confront this challenge.',
            ),
            headline1('Habits'),
            const TextWidget(
              text:
                  'Ask yourself, “Which habits, people, thoughts, goals, environments, and strategies are moving you forward towards your best self the fastest? Which are acting as a drag on your energy?” Draw on your previous answers and think about what habits have effected your performance most. What habits are moving you towards your best self? What habits are moving you towards your values and purpose? Which habits are moving you away from your ideal lifestyle? Be honest with yourself and create a plan of action to implement more of the good while eliminating or at least minimizing the bad.',
            ),
            headline1('Goals'),
            const TextWidget(
              text:
                  'Review your calendar for the next period and ask yourself, “Have you planned your most important goals and milestones?” If not, do so now. You should have done this in the goals section of the review, but this serves as a final fail safe. So, double check your roadmap(s) and make sure you are satisfied with the path you have set towards your values, goals, ideal life, ideal self, and purpose. If you are not satisfied then modify your current roadmap and/ or goals. \n\nNote: Sometimes, when you realize you have been living a complete lie or you skimmed over the initial parts of this program it is better to start anew and go back to the values worksheet. This can save a lot of wasted time working towards the wrong goals and values. ',
            ),
            headline1('Next Review'),
            const TextWidget(
              text:
                  'This is the simplest portion of the Periodic Review. At this point you will schedule a Periodic Review for next period (quarter) and add it to your calendar. Take a moment to do this now as it is so easy to forget to do it later.\n\n',
            ),
            headline1('Conclusion'),
            const TextWidget(
              text:
                  'You have evaluated your performance towards your purpose across many different metrics and you have thought deeply about your values, goals, and habits. You have a solid plan going forward, you are ready to meet challenges, and you have strategized solutions to potential problems to preempt them. You may have even uncovered methods to drastically increase your performance and productivity. You fine tuned the strategies leading you to the ideal vision you have for yourself, your loved ones, your life, as well as the changes you want to see in the world. You know exactly how you will live your purpose and are more confident than ever at reaching your definition of success',
            ),
          ],
        ),
      ),
    );
  }
}
