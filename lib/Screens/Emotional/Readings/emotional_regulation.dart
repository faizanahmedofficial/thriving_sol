import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Screens/Emotional/Exercises/abc_root_analysis.dart';
import 'package:schedular_project/Screens/Emotional/Exercises/baby_reframing.dart';
import 'package:schedular_project/Screens/Emotional/Exercises/congnitive_distortions.dart';
import 'package:schedular_project/Screens/Emotional/Exercises/fact_checking.dart';
import 'package:schedular_project/Screens/Emotional/Exercises/reframing.dart';
import 'package:schedular_project/Screens/Emotional/Exercises/resolution.dart';
import 'package:schedular_project/Screens/Emotional/er_home.dart';
import 'package:schedular_project/Screens/Emotional/journals/emotional_check_in.dart';
import 'package:schedular_project/Screens/Emotional/journals/observe_sf.dart';

import '../../../Widgets/app_bar.dart';
import '../../../Widgets/text_widget.dart';
import '../../custom_bottom.dart';

class ER106Reading extends StatefulWidget {
  const ER106Reading({Key? key}) : super(key: key);

  @override
  State<ER106Reading> createState() => _ER106ReadingState();
}

class _ER106ReadingState extends State<ER106Reading> {
 DateTime initial = DateTime.now(); @override
  void dispose() {
    final end = DateTime.now();
    if (Get.find<ErController>().history.value.value == 93) {
      debugPrint('disposing');
      Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title: 'ER106- Take Action',
              ontap: () =>
                  Get.to(() => const EmotionalCheckIn(), arguments: [false]),
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'which is associated with the specific odour might be found more often. Studies with presleep learning sessions in which odour cues are associated with specific cues might shed light on memory processing and consolidation during sleep. In addition, it would be interesting to study nightmare sufferers, i.e. whether positively toned olfactory stimuli yield a significant shift in the emotional tone of nightmares.\n\nDisclosure\nThis study received no financial support; no off‐label or investigational use.\nPublished: 05 October 2014\nOlfactory Stimulation During Sleep Can Reactivate Odor-Associated Images\nMichael Schredl, Leonie Hoffmann, J. Ulrich Sommer & Boris A. Stuck \nChemosensory Perception volume 7, pages140–146(2014)Cite this article\n\n859 Accesses\n\n9 Citations\n\n4 Altmetric\n\nMetricsdetails\n\nAbstract\nPurpose\nResearch has indicated that olfactory stimuli presented during sleep might reactivate memories that are associated with this odor. The present study is the first to examine whether learned associations between odor and images can be reactivated during sleep.\n\nMethods\nSixteen healthy, normosmic volunteers underwent a balanced learning task in which pictures of rural scenes and pictures of city scenes were associated with hydrogen sulfide (smell of rotten eggs) or phenyl ethyl alcohol (smell of roses) in the evening in a crossover design. During the subsequent night, they were stimulated with olfactory stimuli (hydrogen sulfide, phenyl ethyl alcohol, and neutral) during REM periods. Participants were awakened 1 min after the stimulation and dream reports were elicited.\n\nResults\nThe olfactory congruent stimuli significantly increased the probability of dreams about rural scenes, whereas the same effect was not found for city scenes.\n\n',
            ),
            const TextWidget(
              text:
                  'Conclusions\nAs these findings support the hypothesis of reactivation during sleep, it would be very interesting to study the effect of dreams as a tool to measure reactivation of task material on sleep-dependent memory consolidation.\n\nThis is a preview of subscription content, log in to check access.\n\nReferences\nArzi A, Sela L, Green A, Givaty G, Dagan Y, Sobel N (2010) The influence of odorants on respiratory patterns in sleep. Chem Senses 35:31–40\n\nArticle\nGoogle Scholar\nArzi A, Shedlesky L, Ben-Shaul M, Nasser K, Oksenberg A, Hairston IS, Sobel N (2012) Humans can learn new information during sleep. Nat Neurosci 15:1460–1465. doi:10.1038/nn.3193\n\nCAS\nArticle\nGoogle Scholar\nBastuji H, Garcia-Larrea L (1999) Evoked potentials as a tool for the investigation of human sleep. Sleep Med Rev 3:23–45\n\nCAS\nArticle\nGoogle Scholar\nBradley MM, Lang PJ (2007) The International Affective Picture System (IAPS) in the study of emotion and attention. In: Coan JA, Allen JJB (eds) Handbook of emotion elicitation and assessment. Oxford University Press, New York, pp 29–46\n\nGoogle Scholar\nCarskadon MA, Herz RS (2004) Minimal olfactory perception during sleep: why odor alarms will not work for humans. Sleep 27:402–405\n\nGoogle Scholar\nDe Koninck J, Prevost F, Lortie-Lussier M (1996) Vertical inversion of the visual field and REM sleep mentation. J Sleep Res 5:16–20\n\nArticle\nGoogle Scholar\nDeuker L et al (2013) Memory consolidation by replay of stimulus-specific neural activity. J Neurosci 33:19373–19383\n\nCAS\n\nArticle\nGoogle Scholar\nDiekelmann S, Wilhelm I, Born J (2009) The whats and whens of sleep-dependent memory consolidation. Sleep Med Rev 13:309–321\n\n',
            ),
          ],
        ),
      ),
    );
  }
}

class ER105Reading extends StatefulWidget {
  const ER105Reading({Key? key}) : super(key: key);

  @override
  State<ER105Reading> createState() => _ER105ReadingState();
}

class _ER105ReadingState extends State<ER105Reading> {
 DateTime initial = DateTime.now(); @override
  void dispose() {
    final end = DateTime.now();
    if (Get.find<ErController>().history.value.value == 89) {
      debugPrint('disposing');
      Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title:
                  'ER105- Reframing Cognitive Distortions and Negative Thoughts',
              ontap: () => Get.to(() => const Reframing(), arguments: [false]),
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'technology functional magnetic resonance imaging) might allow measuring the relationship between olfactory stimuli presentation and amygdala activation during REM sleep (cf. Wehrle et al., 2005).\n\nThe present study – as almost every other study in this field – was limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\nTo summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect emotional intensity, particularly positive emotions, because of the fact that dreamers, even trained participants in dream studies, did not report all emotions experienced in the dream explicitly. This shift to more negative emotions in the externally rated emotions compared with self‐ratings was also found in the present data. Schredl and Doll (1998) concluded that self‐ratings are more valid measures of dream emotions than analysing dream reports, because of the selective underestimation of positive emotions by external judges.\n\nOther methodological issues, such as the setting (olfactometer and experimenter in the same room with the sleeping participants), are unlikely to have affected the present findings, as these parameters did not change between the conditions (positive and negative stimulation as well as control condition) in this within‐subject design. The subjects were not informed about the order of the different stimulus conditions, i.e. they were blind to the condition. Unfortunately, we did not ask them whether they were guessing regarding the stimulus. Previous studies with the same methodology showed clearly that the odour is not present at the time of waking the participant (1‐min delay). The experimenter was not blind to the condition; by keeping the interaction between experimenter and participant to a minimum in an exact standardized manner, experimenter effects should be minimal.\n\nWe did not analyse the electroencephalogram (EEG) after presentation within this study because the previous study by Stuck et al. (2007), with a large number of stimulations, showed clearly that EEG measures are not affected by this type of olfactory stimulation (without trigeminal component). On the other hand, the number of stimulations in the present study is far too small to detect an effect on scalp EEG parameters (event‐related potentials). Modern technology functional magnetic resonance imaging) might allow measuring the relationship between olfactory stimuli presentation and amygdala activation during REM sleep (cf. Wehrle et al., 2005).\n\nThe present study – as almost every other study in this field – was limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\nTo summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. emotional intensity, particularly positive emotions, because of the fact that dreamers, even trained participants in dream studies, did not report all emotions experienced in the dream explicitly. This shift to more negative emotions in the externally rated emotions compared with self‐ratings was also found in the present data. Schredl and Doll (1998) concluded that self‐ratings are more valid measures of dream emotions than analysing dream reports, because of the selective underestimation of positive emotions by external judges.\n\n',
            ),
            const TextWidget(
              text:
                  'Other methodological issues, such as the setting (olfactometer and experimenter in the same room with the sleeping participants), are unlikely to have affected the present findings, as these parameters did not change between the conditions (positive and negative stimulation as well as control condition) in this within‐subject design. The subjects were not informed about the order of the different stimulus conditions, i.e. they were blind to the condition. Unfortunately, we did not ask them whether they were guessing regarding the stimulus. Previous studies with the same methodology showed clearly that the odour is not present at the time of waking the participant (1‐min delay). The experimenter was not blind to the condition; by keeping the interaction between experimenter and participant to a minimum in an exact standardized manner, experimenter effects should be minimal.\n\nWe did not analyse the electroencephalogram (EEG) after presentation within this study because the previous study by Stuck et al. (2007), with a large number of stimulations, showed clearly that EEG measures are not affected by this type of olfactory stimulation (without trigeminal component). On the other hand, the number of stimulations in the present study is far too small to detect an effect on scalp EEG parameters (event‐related potentials). Modern technology functional magnetic resonance imaging) might allow measuring the relationship between olfactory stimuli presentation and amygdala activation during REM sleep (cf. Wehrle et al., 2005).\n\nThe present study – as almost every other study in this field – was limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\nTo summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. (F(2,18) = 0.0, NS).\n\nTable 1. Dream content and dream emotions across the three conditions (mean ± SD)\nVariable	Negative stimulus (n = 15)	Neutral Condition (n = 12)	Positive stimulus (n = 13)\nWord count	111.9 ± 66.1	123.9 ± 99.4	92.5 ± 59.4\nDream content analysis\nRealism/bizarreness	1.87 ± 0.83	1.75 ± 0.87	1.85 ± 0.90\nEmotional tone	−1.00 ± 1.20	−0.08 ± 1.08	0.31 ± 1.38\nExplicit olfactory perception (present versus not present)	 0%	 8.3%	0%\nActivities that are likely to be associated witholfactory perception (present versus not present)	13.3%	 0%	15.4%\nimage\nFigure 1\nOpen in figure viewerPowerPoint\n\nEmotional tone of the dreams of three different types of olfactory stimuli (self‐ratings, means and standard deviations). H2S, hydrogen sulphide; PEA, phenyl ethyl alcohol.\n\nRegarding externally rated dream emotions the statistical analysis yielded a marginally significant difference between the three conditions (F(2,18) = 3.6, P < 0.07), but two contrasts were significant (neutral versus negative: t(11) = 3.1, P < 0.01; negative versus positive: t(12) = 2.5, P < 0.02). Analysing the self‐rated dream emotions, the differences are more pronounced: F(2,18) = 6.2, P < 0.01, neutral versus negative: t(11) = 2.0, P < 0.04, neutral versus positive: t(9) = 2.7, P < 0.02, positive versus negative: t(12) = 2.9, P < 0.01).\n\nExplicit olfactory perception in the dream reports was scarce; i.e. in only one dream did the dreamer explicitly mention smelling something. Being part of a longer dream, the participant discussed with the experimenter why she did not wake her up more often because she had the impression of having dreamed more often. One of these dreams included a grinning Chinese woman who also looked disgusted because they (dreamer and Chinese woman) smelled something rotten. However, this dream was reported in the neutral condition. The statistical analysis (Fisher’s exact test) was non‐significant (P = 1.0). Four dreams included activities that are likely to be associated with olfactory perception in waking life: cleaning a toilet that was full of yellow liquid, eating a Kiwi fruit, eating potatoes with parsley and preparing a salad that included tuna, rice, corn and onions and being in a stuffy room. Again, the comparison between olfactory stimulation and control condition was not significant (Fisher’s exact test: P < 0.25). The matching task where the raters should guess what stimulus was present prior to awakening was not successful: rater 1 matched 13 dreams correctly and rater 2 matched 15. Given that guessing randomly would yield on average 14 correct guesses (33.3% of 40 reports), this is a chance finding.\n\n',
            ),
            const TextWidget(
              text:
                  'Discussion\nOverall, the findings indicate that olfactory stimuli were processed by the sleeping brain and affect the emotions but were not incorporated explicitly into dreams. This is compatible with the model of specific processing of olfactory stimuli within the brain, i.e. the direct anatomical connectivity to the amygdala (Gottfried, 2006). Direct incorporations as reported by Trotter et al. (1988) or for other stimulus types (see Introduction) were not found, thus indicating that olfactory stimuli are processed differently to other sensory modalities on higher brain levels. Maquet and Franck (1997), based on the high activation of the amygdala during REM sleep (Maquet et al., 1996), proposed that the role of the amygdala is the processing of emotional memory. Given the direct connectivity of the olfactory bulb to this brain region, one might hypothesize that the emotional quality of the olfactory stimulus facilitates the processing of emotional memories with the same quality, i.e. the dream tone reflects the emotional tone of the stimulus but not the stimulus itself. Within this context, it would be interesting to pursue the idea studied by Saint‐Denys (1982), who reported that olfactory stimulation yielded dream reports including memories which were associated with this specific odour in a more systematic way and tested the link between emotional tone of odour stimuli and declarative memory. In a presleep learning session, positively toned and negatively toned odour stimuli could be paired with words or other declarative material. One would expect that after olfactory stimulation dreams would include this associated material more often. This follow‐up study would shed light on the psychological mechanisms underlying the present findings, i.e. whether the emotional tone of the olfactory stimuli might activate different sets of memories, including corresponding affects. Rasch et al. (2007) found that presenting a specific odour during slow‐wave sleep probably reactivates mental content which was learned during the day while the same odour was presented. It would also be interesting to study the effect of the emotional tone of other stimuli, e.g. acoustic stimuli such as words, on the emotional tone of dreams. We would expect that the effect We did not analyse the electroencephalogram (EEG) after presentation within this study because the previous study by Stuck et al. (2007), with a large number of stimulations, showed clearly that EEG measures are not affected by this type of olfactory stimulation (without trigeminal component). On the other hand, the number of stimulations in the present study is far too small to detect an effect on scalp EEG parameters (event‐related potentials). Modern technology functional magnetic resonance imaging) might allow measuring the relationship between olfactory stimuli presentation and amygdala activation during REM sleep (cf. Wehrle et al., 2005).\n\n',
            ),
            const TextWidget(
              text:
                  'The present study – as almost every other study in this field – was limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\nTo summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. emotional intensity, particularly positive emotions, because of the fact that dreamers, even trained participants in dream studies, did not report all emotions experienced in the dream explicitly. This shift to more negative emotions in the externally rated emotions compared with self‐ratings was also found in the present data. Schredl and Doll (1998) concluded that self‐ratings are more valid measures of dream emotions than analysing dream reports, because of the selective underestimation of positive emotions by external judges.\n\nOther methodological issues, such as the setting (olfactometer and experimenter in the same room with the sleeping participants), are unlikely to have affected the present findings, as these parameters did not change between the conditions (positive and negative stimulation as well as control condition) in this within‐subject design. The subjects were not informed about the order of the different stimulus conditions, i.e. they were blind to the condition. Unfortunately, we did not ask them whether they were guessing regarding the stimulus. Previous studies with the same methodology showed clearly that the odour is not present at the time of waking the participant (1‐min delay). The experimenter was not blind to the condition; by keeping the interaction between experimenter and participant to a minimum in an exact standardized manner, experimenter effects should be minimal.\n\nWe did not analyse the electroencephalogram (EEG) after presentation within this study because the previous study by Stuck et al. (2007), with a large number of stimulations, showed clearly that EEG measures are not affected by this type of olfactory stimulation (without trigeminal component). On the other hand, the number of stimulations in the present study is far too small to detect an effect on scalp EEG parameters (event‐related potentials). Modern technology functional magnetic resonance imaging) might allow measuring the relationship between olfactory stimuli presentation and amygdala activation during REM sleep (cf. Wehrle et al., 2005).\n\n',
            ),
            const TextWidget(
              text:
                  'The present study – as almost every other study in this field – was limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\nTo summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to\n\n',
            ),
          ],
        ),
      ),
    );
  }
}

class ER104Reading extends StatefulWidget {
  const ER104Reading({Key? key}) : super(key: key);

  @override
  State<ER104Reading> createState() => _ER104ReadingState();
}

class _ER104ReadingState extends State<ER104Reading> {
DateTime initial = DateTime.now();  @override
  void dispose() {
    final end = DateTime.now();
    if (Get.find<ErController>().history.value.value == 87) {
      debugPrint('disposing');
      Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title: 'ER104- Cognitive Distortion',
              ontap: () =>
                  Get.to(() => const CognitiveDistortion(), arguments: [false]),
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'We did not analyse the electroencephalogram (EEG) after presentation within this study because the previous study by Stuck et al. (2007), with a large number of stimulations, showed clearly that EEG measures are not affected by this type of olfactory stimulation (without trigeminal component). On the other hand, the number of stimulations in the present study is far too small to detect an effect on scalp EEG parameters (event‐related potentials). Modern technology functional magnetic resonance imaging) might allow measuring the relationship between olfactory stimuli presentation and amygdala activation during REM sleep (cf. Wehrle et al., 2005).\n\nThe present study – as almost every other study in this field – was limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\nTo summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. emotional intensity, particularly positive emotions, because of the fact that dreamers, even trained participants in dream studies, did not report all emotions experienced in the dream explicitly. This shift to more negative emotions in the externally rated emotions compared with self‐ratings was also found in the present data. Schredl and Doll (1998) concluded that self‐ratings are more valid measures of dream emotions than analysing dream reports, because of the selective underestimation of positive emotions by external judges.\n\nOther methodological issues, such as the setting (olfactometer and experimenter in the same room with the sleeping participants), are unlikely to have affected the present findings, as these parameters did not change between the conditions (positive and negative stimulation as well as control condition) in this within‐subject design. The subjects were not informed about the order of the different stimulus conditions, i.e. they were blind to the condition. Unfortunately, we did not ask them whether they were guessing regarding the stimulus. Previous studies with the same methodology showed clearly that the odour is not present at the time of waking the participant (1‐min delay). The experimenter was not blind to the condition; by keeping the interaction between experimenter and participant to a minimum in an exact standardized manner, experimenter effects should be minimal.\n\nWe did not analyse the electroencephalogram (EEG) after presentation within this study because the previous study by Stuck et al. (2007), with a large number of stimulations, showed clearly that EEG measures are not affected by this type of olfactory stimulation (without trigeminal component). On the other hand, the number of stimulations in the present study is far too small to detect an effect on scalp EEG parameters (event‐related potentials). Modern technology functional magnetic resonance imaging) might allow measuring the relationship between olfactory stimuli presentation and amygdala activation during REM sleep (cf. Wehrle et al., 2005).\n\nThe present study – as almost every other study in this field – was limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\nTo summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. (F(2,18) = 0.0, NS).\n\n',
            ),
            const TextWidget(
              text:
                  'Table 1. Dream content and dream emotions across the three conditions (mean ± SD)\nVariable	Negative stimulus (n = 15)	Neutral Condition (n = 12)	Positive stimulus (n = 13)\nWord count	111.9 ± 66.1	123.9 ± 99.4	92.5 ± 59.4\nDream content analysis\nRealism/bizarreness	1.87 ± 0.83	1.75 ± 0.87	1.85 ± 0.90\nEmotional tone	−1.00 ± 1.20	−0.08 ± 1.08	0.31 ± 1.38\nExplicit olfactory perception (present versus not present)	 0%	 8.3%	0%\nActivities that are likely to be associated witholfactory perception (present versus not present)	13.3%	 0%	15.4%\nimage\nFigure 1\nOpen in figure viewerPowerPoint\nEmotional tone of the dreams of three different types of olfactory stimuli (self‐ratings, means and standard deviations). H2S, hydrogen sulphide; PEA, phenyl ethyl alcohol.\n\nRegarding externally rated dream emotions the statistical analysis yielded a marginally significant difference between the three conditions (F(2,18) = 3.6, P < 0.07), but two contrasts were significant (neutral versus negative: t(11) = 3.1, P < 0.01; negative versus positive: t(12) = 2.5, P < 0.02). Analysing the self‐rated dream emotions, the differences are more pronounced: F(2,18) = 6.2, P < 0.01, neutral versus negative: t(11) = 2.0, P < 0.04, neutral versus positive: t(9) = 2.7, P < 0.02, positive versus negative: t(12) = 2.9, P < 0.01).\n\nExplicit olfactory perception in the dream reports was scarce; i.e. in only one dream did the dreamer explicitly mention smelling something. Being part of a longer dream, the participant discussed with the experimenter why she did not wake her up more often because she had the impression of having dreamed more often. One of these dreams included a grinning Chinese woman who also looked disgusted because they (dreamer and Chinese woman) smelled something rotten. However, this dream was reported in the neutral condition. The statistical analysis (Fisher’s exact test) was non‐significant (P = 1.0). Four dreams included activities that are likely to be associated with olfactory perception in waking life: cleaning a toilet that was full of yellow liquid, eating a Kiwi fruit, eating potatoes with parsley and preparing a salad that included tuna, rice, corn and onions and being in a stuffy room. Again, the comparison between olfactory stimulation and control condition was not significant (Fisher’s exact test: P < 0.25). The matching task where the raters should guess what stimulus was present prior to awakening was not successful: rater 1 matched 13 dreams correctly and rater 2 matched 15. Given that guessing randomly would yield on average 14 correct guesses (33.3% of 40 reports), this is a chance finding.\n\nDiscussion\nOverall, the findings indicate that olfactory stimuli were processed by the sleeping brain and affect the emotions but were not incorporated explicitly into dreams. This is compatible with the model of specific processing of olfactory stimuli within the brain, i.e. the direct anatomical connectivity to the amygdala (Gottfried, 2006). Direct incorporations as reported by Trotter et al. (1988) or for other stimulus types (see Introduction) were not found, thus indicating that olfactory stimuli are processed differently to other sensory modalities on higher brain levels. Maquet and Franck (1997), based on the high activation of the amygdala during REM sleep (Maquet et al., 1996), proposed that the role of the amygdala is the processing of emotional memory. Given the direct connectivity of the olfactory bulb to this brain region, one might hypothesize that the emotional quality of the olfactory stimulus facilitates the processing of emotional memories with the same quality, i.e. the dream tone reflects the emotional tone of the stimulus but not the stimulus itself. Within this context, it would be interesting to pursue the idea studied by Saint‐Denys (1982), who reported that olfactory stimulation yielded dream reports including memories which were associated with this specific odour in a more systematic way and tested the link between emotional tone of odour stimuli and declarative memory. In a presleep learning session, positively toned and negatively toned odour stimuli could be paired with words or other declarative material. One would expect that after olfactory stimulation dreams would include this associated material more often. This follow‐up study would shed light on the psychological mechanisms underlying the present findings, i.e. whether the emotional tone of the olfactory stimuli might activate different sets of memories, including corresponding affects. Rasch et al. (2007) found that presenting a specific odour during slow‐wave sleep probably reactivates mental content which was learned during the day while the same odour was presented. It would also be interesting to study the effect of the emotional tone of other stimuli, e.g. acoustic stimuli such as words, on the emotional tone of dreams. We would expect that the effect would be much less pronounced than for odour stimuli because of the specific processing within the brain, but a sufficiently large number of trials should also result in a significant effect.\n\nThe differences of our findings in comparison to the earlier study by Trotter et al. (1988) indicated clearly that sophisticated technology in presenting olfactory stimuli is necessary, i.e. a technique without affecting the mechanical and thermal condition of the nasal mucosa, and that ensures that the odour is not detectable at the time of the awakening. With regard to these shortcomings, the results of the Trotter et al. (1988) study have limited generalizability.\n\nThat the lack of incorporated olfactory stimuli is explained by methodological issues (e.g. forgetting this part of the dream because it happened 1 min prior to awakening) is unlikely, because the procedure of the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that it is unlikely that an increase of stimulus intensity will produce stronger effects. In addition, the concentrations applied in the present study have been intense and clearly above threshold.\n\nFrom a methodological viewpoint, it is interesting that the findings regarding dream emotions are more pronounced for the self‐rating scales compared to the dream content analytical findings. Schredl and Doll (1998) have shown that external judges underestimate emotional intensity, particularly positive emotions, because of the fact that dreamers, even trained participants in dream studies, did not report all emotions experienced in the dream explicitly. This shift to more negative emotions in the externally rated emotions compared with self‐ratings was also found in the present data. Schredl and Doll (1998) concluded that self‐ratings are more valid measures of dream emotions than analysing dream reports, because of the selective underestimation of positive emotions by external judges.\n\nOther methodological issues, such as the setting (olfactometer and experimenter in the same room with the sleeping participants), are unlikely to have affected the present findings, as these parameters did not change between the conditions (positive and negative stimulation as well as control condition) in this within‐subject design. The subjects were not informed about the order of the different stimulus conditions, i.e. they were blind to the condition. Unfortunately, we did not ask them whether they were guessing regarding the stimulus. Previous studies with the same methodology showed clearly that the odour is not present at the time of waking the participant (1‐min delay). The experimenter was not blind to the condition; by keeping the interaction between experimenter and participant to a minimum in an exact standardized manner, experimenter effects should be minimal.\n\n',
            ),
          ],
        ),
      ),
    );
  }
}

class ER103Reading extends StatefulWidget {
  const ER103Reading({Key? key}) : super(key: key);

  @override
  State<ER103Reading> createState() => _ER103ReadingState();
}

class _ER103ReadingState extends State<ER103Reading> {
 DateTime initial = DateTime.now(); @override
  void dispose() {
    final end = DateTime.now();
    if (Get.find<ErController>().history.value.value == 82) {
      debugPrint('disposing');
      Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title: 'ER103- Are Your Thoughts Facts?',
              ontap: () =>
                  Get.to(() => const FactChecking(), arguments: [false]),
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'Given the direct connectivity of the olfactory bulb to this brain region, one might hypothesize that the emotional quality of the olfactory stimulus facilitates the processing of emotional memories with the same quality, i.e. the dream tone reflects the emotional tone of the stimulus but not the stimulus itself. Within this context, it would be interesting to pursue the idea studied by Saint‐Denys (1982), who reported that olfactory stimulation yielded dream reports including memories which were associated with this specific odour in a more systematic way and tested the link between emotional tone of odour stimuli and declarative memory. \nother sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. (F(2,18) = 0.0, NS).\nTable 1. Dream content and dream emotions across the three conditions (mean ± SD)\nVariable	Negative stimulus (n = 15)	Neutral Condition (n = 12)	Positive stimulus (n = 13)\nWord count	111.9 ± 66.1	123.9 ± 99.4	92.5 ± 59.4\nDream content analysis\nRealism/bizarreness	1.87 ± 0.83	1.75 ± 0.87	1.85 ± 0.90\nEmotional tone	−1.00 ± 1.20	−0.08 ± 1.08	0.31 ± 1.38\nExplicit olfactory perception (present versus not present)	 0%	 8.3%	0%\nActivities that are likely to be associated witholfactory perception (present versus not present)	13.3%	 0%	15.4%\nimage\nFigure 1\nOpen in figure viewerPowerPoint\nEmotional tone of the dreams of three different types of olfactory stimuli (self‐ratings, means and standard deviations). H2S, hydrogen sulphide; PEA, phenyl ethyl alcohol.\n\n',
            ),
            const TextWidget(
              text:
                  'Regarding externally rated dream emotions the statistical analysis yielded a marginally significant difference between the three conditions (F(2,18) = 3.6, P < 0.07), but two contrasts were significant (neutral versus negative: t(11) = 3.1, P < 0.01; negative versus positive: t(12) = 2.5, P < 0.02). Analysing the self‐rated dream emotions, the differences are more pronounced: F(2,18) = 6.2, P < 0.01, neutral versus negative: t(11) = 2.0, P < 0.04, neutral versus positive: t(9) = 2.7, P < 0.02, positive versus negative: t(12) = 2.9, P < 0.01).\n\nExplicit olfactory perception in the dream reports was scarce; i.e. in only one dream did the dreamer explicitly mention smelling something. Being part of a longer dream, the participant discussed with the experimenter why she did not wake her up more often because she had the impression of having dreamed more often. One of these dreams included a grinning Chinese woman who also looked disgusted because they (dreamer and Chinese woman) smelled something rotten. However, this dream was reported in the neutral condition. The statistical analysis (Fisher’s exact test) was non‐significant (P = 1.0). Four dreams included activities that are likely to be associated with olfactory perception in waking life: cleaning a toilet that was full of yellow liquid, eating a Kiwi fruit, eating potatoes with parsley and preparing a salad that included tuna, rice, corn and onions and being in a stuffy room. Again, the comparison between olfactory stimulation and control condition was not significant (Fisher’s exact test: P < 0.25). The matching task where the raters should guess what stimulus was present prior to awakening was not successful: rater 1 matched 13 dreams correctly and rater 2 matched 15. Given that guessing randomly would yield on average 14 correct guesses (33.3% of 40 reports), this is a chance finding.\n\n',
            ),
            const TextWidget(
              text:
                  'Discussion\nOverall, the findings indicate that olfactory stimuli were processed by the sleeping brain and affect the emotions but were not incorporated explicitly into dreams. This is compatible with the model of specific processing of olfactory stimuli within the brain, i.e. the direct anatomical connectivity to the amygdala (Gottfried, 2006). Direct incorporations as reported by Trotter et al. (1988) or for other stimulus types (see Introduction) were not found, thus indicating that olfactory stimuli are processed differently to other sensory modalities on higher brain levels. Maquet and Franck (1997), based on the high activation of the amygdala during REM sleep (Maquet et al., 1996), proposed that the role of the amygdala is the processing of emotional memory. Given the direct connectivity of the olfactory bulb to this brain region, one might hypothesize that the emotional quality of the olfactory stimulus facilitates the processing of emotional memories with the same quality, i.e. the dream tone reflects the emotional tone of the stimulus but not the stimulus itself. Within this context, it would be interesting to pursue the idea studied by Saint‐Denys (1982), who reported that olfactory stimulation yielded dream reports including memories which were associated with this specific odour in a more systematic way and tested the link between emotional tone of odour stimuli and declarative memory. In a presleep learning session, positively toned and negatively toned odour stimuli could be paired with words or other declarative material. One would expect that after olfactory stimulation dreams would include this associated material more often. This follow‐up study would shed light on the psychological mechanisms underlying the present findings, i.e. whether the emotional tone of the olfactory stimuli might activate different sets of memories, including corresponding affects. Rasch et al. (2007) found that presenting a specific odour during slow‐wave sleep probably reactivates mental content which was learned during the day while the same odour was presented. It would also be interesting to study the effect of the emotional tone of other stimuli, e.g. acoustic stimuli such as words, on the emotional tone o\n\n',
            ),
          ],
        ),
      ),
    );
  }
}

class ER102Reading extends StatefulWidget {
  const ER102Reading({Key? key}) : super(key: key);

  @override
  State<ER102Reading> createState() => _ER102ReadingState();
}

class _ER102ReadingState extends State<ER102Reading> {
DateTime initial = DateTime.now();  @override
  void dispose() {
    final end = DateTime.now();
    if (Get.find<ErController>().history.value.value == 78) {
      debugPrint('disposing');
      Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title: 'ER102- ABC Root Analysis',
              ontap: () =>
                  Get.to(() => const AbcRootAnalysis(), arguments: [false]),
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'Given the direct connectivity of the olfactory bulb to this brain region, one might hypothesize that the emotional quality of the olfactory stimulus facilitates the processing of emotional memories with the same quality, i.e. the dream tone reflects the emotional tone of the stimulus but not the stimulus itself. Within this context, it would be interesting to pursue the idea studied by Saint‐Denys (1982), who reported that olfactory stimulation yielded dream reports including memories which were associated with this specific odour in a more systematic way and tested the link between emotional tone of odour stimuli and declarative memory. \nother sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. (F(2,18) = 0.0, NS).\nTable 1. Dream content and dream emotions across the three conditions (mean ± SD)\nVariable	Negative stimulus (n = 15)	Neutral Condition (n = 12)	Positive stimulus (n = 13)\nWord count	111.9 ± 66.1	123.9 ± 99.4	92.5 ± 59.4\nDream content analysis\nRealism/bizarreness	1.87 ± 0.83	1.75 ± 0.87	1.85 ± 0.90\nEmotional tone	−1.00 ± 1.20	−0.08 ± 1.08	0.31 ± 1.38\nExplicit olfactory perception (present versus not present)	 0%	 8.3%	0%\nActivities that are likely to be associated witholfactory perception (present versus not present)	13.3%	 0%	15.4%\nimage\nFigure 1\nOpen in figure viewerPowerPoint\nEmotional tone of the dreams of three different types of olfactory stimuli (self‐ratings, means and standard deviations). H2S, hydrogen sulphide; PEA, phenyl ethyl alcohol.\n\n',
            ),
            const TextWidget(
              text:
                  'Regarding externally rated dream emotions the statistical analysis yielded a marginally significant difference between the three conditions (F(2,18) = 3.6, P < 0.07), but two contrasts were significant (neutral versus negative: t(11) = 3.1, P < 0.01; negative versus positive: t(12) = 2.5, P < 0.02). Analysing the self‐rated dream emotions, the differences are more pronounced: F(2,18) = 6.2, P < 0.01, neutral versus negative: t(11) = 2.0, P < 0.04, neutral versus positive: t(9) = 2.7, P < 0.02, positive versus negative: t(12) = 2.9, P < 0.01).\n\nExplicit olfactory perception in the dream reports was scarce; i.e. in only one dream did the dreamer explicitly mention smelling something. Being part of a longer dream, the participant discussed with the experimenter why she did not wake her up more often because she had the impression of having dreamed more often. One of these dreams included a grinning Chinese woman who also looked disgusted because they (dreamer and Chinese woman) smelled something rotten. However, this dream was reported in the neutral condition. The statistical analysis (Fisher’s exact test) was non‐significant (P = 1.0). Four dreams included activities that are likely to be associated with olfactory perception in waking life: cleaning a toilet that was full of yellow liquid, eating a Kiwi fruit, eating potatoes with parsley and preparing a salad that included tuna, rice, corn and onions and being in a stuffy room. Again, the comparison between olfactory stimulation and control condition was not significant (Fisher’s exact test: P < 0.25). The matching task where the raters should guess what stimulus was present prior to awakening was not successful: rater 1 matched 13 dreams correctly and rater 2 matched 15. Given that guessing randomly would yield on average 14 correct guesses (33.3% of 40 reports), this is a chance finding.\n\n',
            ),
            const TextWidget(
              text:
                  'Discussion\nOverall, the findings indicate that olfactory stimuli were processed by the sleeping brain and affect the emotions but were not incorporated explicitly into dreams. This is compatible with the model of specific processing of olfactory stimuli within the brain, i.e. the direct anatomical connectivity to the amygdala (Gottfried, 2006). Direct incorporations as reported by Trotter et al. (1988) or for other stimulus types (see Introduction) were not found, thus indicating that olfactory stimuli are processed differently to other sensory modalities on higher brain levels. Maquet and Franck (1997), based on the high activation of the amygdala during REM sleep (Maquet et al., 1996), proposed that the role of the amygdala is the processing of emotional memory. Given the direct connectivity of the olfactory bulb to this brain region, one might hypothesize that the emotional quality of the olfactory stimulus facilitates the processing of emotional memories with the same quality, i.e. the dream tone reflects the emotional tone of the stimulus but not the stimulus itself. Within this context, it would be interesting to pursue the idea studied by Saint‐Denys (1982), who reported that olfactory stimulation yielded dream reports including memories which were associated with this specific odour in a more systematic way and tested the link between emotional tone of odour stimuli and declarative memory. In a presleep learning session, positively toned and negatively toned odour stimuli could be paired with words or other declarative material. One would expect that after olfactory stimulation dreams would include this associated material more often. This follow‐up study would shed light on the psychological mechanisms underlying the present findings, i.e. whether the emotional tone of the olfactory stimuli might activate different sets of memories, including corresponding affects. Rasch et al. (2007) found that presenting a specific odour during slow‐wave sleep probably reactivates mental content which was learned during the day while the same odour was presented. It would also be interesting to study the effect of the emotional tone of other stimuli, e.g. acoustic stimuli such as words, on the emotional tone o\n\n',
            ),
          ],
        ),
      ),
    );
  }
}

class ER101aReading extends StatefulWidget {
  const ER101aReading({Key? key}) : super(key: key);

  @override
  State<ER101aReading> createState() => _ER101aReadingState();
}

class _ER101aReadingState extends State<ER101aReading> {
 DateTime initial = DateTime.now(); @override
  void dispose() {
    final end = DateTime.now();
    if (Get.find<ErController>().history.value.value == 74) {
      debugPrint('disposing');
      Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title: 'ER101a- Resolve the Situation',
              ontap: () => Get.to(() => const Resolution(), arguments: [false]),
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'which is associated with the specific odour might be found more often. Studies with presleep learning sessions in which odour cues are associated with specific cues might shed light on memory processing and consolidation during sleep. In addition, it would be interesting to study nightmare sufferers, i.e. whether positively toned olfactory stimuli yield a significant shift in the emotional tone of nightmares.\n\nDisclosure\nThis study received no financial support; no off‐label or investigational use.\nPublished: 05 October 2014\nOlfactory Stimulation During Sleep Can Reactivate Odor-Associated Images\nMichael Schredl, Leonie Hoffmann, J. Ulrich Sommer & Boris A. Stuck \nChemosensory Perception volume 7, pages140–146(2014)Cite this article\n\n859 Accesses\n\n9 Citations\n\n4 Altmetric\n\nMetricsdetails\n\nAbstract\nPurpose\nResearch has indicated that olfactory stimuli presented during sleep might reactivate memories that are associated with this odor. The present study is the first to examine whether learned associations between odor and images can be reactivated during sleep.\n\nMethods\nSixteen healthy, normosmic volunteers underwent a balanced learning task in which pictures of rural scenes and pictures of city scenes were associated with hydrogen sulfide (smell of rotten eggs) or phenyl ethyl alcohol (smell of roses) in the evening in a crossover design. During the subsequent night, they were stimulated with olfactory stimuli (hydrogen sulfide, phenyl ethyl alcohol, and neutral) during REM periods. Participants were awakened 1 min after the stimulation and dream reports were elicited.\n\nResults\nThe olfactory congruent stimuli significantly increased the probability of dreams about rural scenes, whereas the same effect was not found for city scenes.\n\n',
            ),
            const TextWidget(
              text:
                  'Conclusions\nAs these findings support the hypothesis of reactivation during sleep, it would be very interesting to study the effect of dreams as a tool to measure reactivation of task material on sleep-dependent memory consolidation.\n\nThis is a preview of subscription content, log in to check access.\n\nReferences\nArzi A, Sela L, Green A, Givaty G, Dagan Y, Sobel N (2010) The influence of odorants on respiratory patterns in sleep. Chem Senses 35:31–40\n\nArticle\nGoogle Scholar\nArzi A, Shedlesky L, Ben-Shaul M, Nasser K, Oksenberg A, Hairston IS, Sobel N (2012) Humans can learn new information during sleep. Nat Neurosci 15:1460–1465. doi:10.1038/nn.3193\n\nCAS\nArticle\nGoogle Scholar\nBastuji H, Garcia-Larrea L (1999) Evoked potentials as a tool for the investigation of human sleep. Sleep Med Rev 3:23–45\n\nCAS\nArticle\nGoogle Scholar\nBradley MM, Lang PJ (2007) The International Affective Picture System (IAPS) in the study of emotion and attention. In: Coan JA, Allen JJB (eds) Handbook of emotion elicitation and assessment. Oxford University Press, New York, pp 29–46\n\nGoogle Scholar\nCarskadon MA, Herz RS (2004) Minimal olfactory perception during sleep: why odor alarms will not work for humans. Sleep 27:402–405\n\nGoogle Scholar\nDe Koninck J, Prevost F, Lortie-Lussier M (1996) Vertical inversion of the visual field and REM sleep mentation. J Sleep Res 5:16–20\n\nArticle\nGoogle Scholar\nDeuker L et al (2013) Memory consolidation by replay of stimulus-specific neural activity. J Neurosci 33:19373–19383\n\nCAS\n\nArticle\nGoogle Scholar\nDiekelmann S, Wilhelm I, Born J (2009) The whats and whens of sleep-dependent memory consolidation. Sleep Med Rev 13:309–321\n\n',
            ),
          ],
        ),
      ),
    );
  }
}

class ER101Reading extends StatefulWidget {
  const ER101Reading({Key? key}) : super(key: key);

  @override
  State<ER101Reading> createState() => _ER101ReadingState();
}

class _ER101ReadingState extends State<ER101Reading> {
 DateTime initial = DateTime.now(); @override
  void dispose() {
    final end = DateTime.now();
    if (Get.find<ErController>().history.value.value == 73) {
      debugPrint('disposing');
      Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title: 'ER101- Emotional Check-In and Limiting Damage',
              ontap: () =>
                  Get.to(() => const EmotionalCheckIn(), arguments: [false]),
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. (F(2,18) = 0.0, NS).\n\nTable 1. Dream content and dream emotions across the three conditions (mean ± SD)\nVariable	Negative stimulus (n = 15)	Neutral Condition (n = 12)	Positive stimulus (n = 13)\nWord count	111.9 ± 66.1	123.9 ± 99.4	92.5 ± 59.4\nDream content analysis\nRealism/bizarreness	1.87 ± 0.83	1.75 ± 0.87	1.85 ± 0.90\nEmotional tone	−1.00 ± 1.20	−0.08 ± 1.08	0.31 ± 1.38\nExplicit olfactory perception (present versus not present)	 0%	 8.3%	0%\nActivities that are likely to be associated witholfactory perception (present versus not present)	13.3%	 0%	15.4%\nimage\nFigure 1\nOpen in figure viewerPowerPoint\nEmotional tone of the dreams of three different types of olfactory stimuli (self‐ratings, means and standard deviations). H2S, hydrogen sulphide; PEA, phenyl ethyl alcohol.\n\n',
            ),
            const TextWidget(
              text:
                  'Regarding externally rated dream emotions the statistical analysis yielded a marginally significant difference between the three conditions (F(2,18) = 3.6, P < 0.07), but two contrasts were significant (neutral versus negative: t(11) = 3.1, P < 0.01; negative versus positive: t(12) = 2.5, P < 0.02). Analysing the self‐rated dream emotions, the differences are more pronounced: F(2,18) = 6.2, P < 0.01, neutral versus negative: t(11) = 2.0, P < 0.04, neutral versus positive: t(9) = 2.7, P < 0.02, positive versus negative: t(12) = 2.9, P < 0.01).\n\nExplicit olfactory perception in the dream reports was scarce; i.e. in only one dream did the dreamer explicitly mention smelling something. Being part of a longer dream, the participant discussed with the experimenter why she did not wake her up more often because she had the impression of having dreamed more often. One of these dreams included a grinning Chinese woman who also looked disgusted because they (dreamer and Chinese woman) smelled something rotten. However, this dream was reported in the neutral condition. The statistical analysis (Fisher’s exact test) was non‐significant (P = 1.0). Four dreams included activities that are likely to be associated with olfactory perception in waking life: cleaning a toilet that was full of yellow liquid, eating a Kiwi fruit, eating potatoes with parsley and preparing a salad that included tuna, rice, corn and onions and being in a stuffy room. Again, the comparison between olfactory stimulation and control condition was not significant (Fisher’s exact test: P < 0.25). The matching task where the raters should guess what stimulus was present prior to awakening was not successful: rater 1 matched 13 dreams correctly and rater 2 matched 15. Given that guessing randomly would yield on average 14 correct guesses (33.3% of 40 reports), this is a chance finding.\n\n',
            ),
            const TextWidget(
              text:
                  'Discussion\nOverall, the findings indicate that olfactory stimuli were processed by the sleeping brain and affect the emotions but were not incorporated explicitly into dreams. This is compatible with the model of specific processing of olfactory stimuli within the brain, i.e. the direct anatomical connectivity to the amygdala (Gottfried, 2006). Direct incorporations as reported by Trotter et al. (1988) or for other stimulus types (see Introduction) were not found, thus indicating that olfactory stimuli are processed differently to other sensory modalities on higher brain levels. Maquet and Franck (1997), based on the high activation of the amygdala during REM sleep (Maquet et al., 1996), proposed that the role of the amygdala is the processing of emotional memory. Given the direct connectivity of the olfactory bulb to this brain region, one might hypothesize that the emotional quality of the olfactory stimulus facilitates the processing of emotional memories with the same quality, i.e. the dream tone reflects the emotional tone of the stimulus but not the stimulus itself. Within this context, it would be interesting to pursue the idea studied by Saint‐Denys (1982), who reported that olfactory stimulation yielded dream reports including memories which were associated with this specific odour in a more systematic way and tested the link between emotional tone of odour stimuli and declarative memory. In a presleep learning session, positively toned and negatively toned odour stimuli could be paired with words or other declarative material. One would expect that after olfactory stimulation dreams would include this associated material more often. This follow‐up study would shed light on the psychological mechanisms underlying the present findings, i.e. whether the emotional tone of the olfactory stimuli might activate different sets of memories, including corresponding affects. Rasch et al. (2007) found that presenting a specific odour during slow‐wave sleep probably reactivates mental content which was learned during the day while the same odour was presented. It would also be interesting to study the effect of the emotional tone of other stimuli, e.g. acoustic stimuli such as words, on the emotional tone of dreams. We would expect that the effect We did not analyse the electroencephalogram (EEG) after presentation within this study because the previous study by Stuck et al. (2007), with a large number of stimulations, showed clearly that EEG measures are not affected by this type of olfactory stimulation (without trigeminal component). On the other hand, the number of stimulations in the present study is far too small to detect an effect on scalp EEG parameters (event‐related potentials). Modern technology functional magnetic resonance imaging) might allow measuring the relationship between olfactory stimuli presentation and amygdala activation during REM sleep (cf. Wehrle et al., 2005).\n\n',
            ),
            const TextWidget(
              text:
                  'The present study – as almost every other study in this field – was limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\nTo summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. emotional intensity, particularly positive emotions, because of the fact that dreamers, even trained participants in dream studies, did not report all emotions experienced in the dream explicitly. This shift to more negative emotions in the externally rated emotions compared with self‐ratings was also found in the present data. Schredl and Doll (1998) concluded that self‐ratings are more valid measures of dream emotions than analysing dream reports, because of the selective underestimation of positive emotions by external judges.\n\nOther methodological issues, such as the setting (olfactometer and experimenter in the same room with the sleeping participants), are unlikely to have affected the present findings, as these parameters did not change between the conditions (positive and negative stimulation as well as control condition) in this within‐subject design. The subjects were not informed about the order of the different stimulus conditions, i.e. they were blind to the condition. Unfortunately, we did not ask them whether they were guessing regarding the stimulus. Previous studies with the same methodology showed clearly that the odour is not present at the time of waking the participant (1‐min delay). The experimenter was not blind to the condition; by keeping the interaction between experimenter and participant to a minimum in an exact standardized manner, experimenter effects should be minimal.\n\nWe did not analyse the electroencephalogram (EEG) after presentation within this study because the previous study by Stuck et al. (2007), with a large number of stimulations, showed clearly that EEG measures are not affected by this type of olfactory stimulation (without trigeminal component). On the other hand, the number of stimulations in the present study is far too small to detect an effect on scalp EEG parameters (event‐related potentials). Modern technology functional magnetic resonance imaging) might allow measuring the relationship between olfactory stimuli presentation and amygdala activation during REM sleep (cf. Wehrle et al., 2005).\n\n',
            ),
            const TextWidget(
              text:
                  'The present study – as almost every other study in this field – was limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\nTo summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to\n\n',
            ),
          ],
        ),
      ),
    );
  }
}

class ER100Reading extends StatefulWidget {
  const ER100Reading({Key? key}) : super(key: key);

  @override
  State<ER100Reading> createState() => _ER100ReadingState();
}

class _ER100ReadingState extends State<ER100Reading> {
 DateTime initial = DateTime.now(); @override
  void dispose() {
    final end = DateTime.now();
    if (Get.find<ErController>().history.value.value == 68) {
      debugPrint('disposing');
      Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title: 'ER100- A Brief Introduction to CBT',
              ontap: () => Get.to(() => BabyReframing(), arguments: [false]),
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'Disclosure\nThis study received no financial support; no off‐label or investigational use.\nPublished: 05 October 2014\nOlfactory Stimulation During Sleep Can Reactivate Odor-Associated Images\nMichael Schredl, Leonie Hoffmann, J. Ulrich Sommer & Boris A. Stuck \nChemosensory Perception volume 7, pages140–146(2014)Cite this article\n\n859 Accesses\n\n9 Citations\n\n4 Altmetric\n\nMetricsdetails\nAbstract\nPurpose\nResearch has indicated that olfactory stimuli presented during sleep might reactivate memories that are associated with this odor. The present study is the first to examine whether learned associations between odor and images can be reactivated during sleep.\n\n',
            ),
            const TextWidget(
              text:
                  'Methods\nSixteen healthy, normosmic volunteers underwent a balanced learning task in which pictures of rural scenes and pictures of city scenes were associated with hydrogen sulfide (smell of rotten eggs) or phenyl ethyl alcohol (smell of roses) in the evening in a crossover design. During the subsequent night, they were stimulated with olfactory stimuli (hydrogen sulfide, phenyl ethyl alcohol, and neutral) during REM periods. Participants were awakened 1 min after the stimulation and dream reports were elicited.\n\nResults\nThe olfactory congruent stimuli significantly increased the probability of dreams about rural scenes, whereas the same effect was not found for city scenes.\n\nConclusions\nAs these findings support the hypothesis of reactivation during sleep, it would be very interesting to study the effect of dreams as a tool to measure reactivation of task material on sleep-dependent memory consolidation.\n\nThis is a preview of subscription content, log in to check access.\n\n',
            ),
            const TextWidget(
              text:
                  'References\nArzi A, Sela L, Green A, Givaty G, Dagan Y, Sobel N (2010) The influence of odorants on respiratory patterns in sleep. Chem Senses 35:31–40\n\nArticle\nGoogle Scholar\nArzi A, Shedlesky L, Ben-Shaul M, Nasser K, Oksenberg A, Hairston IS, Sobel N (2012) Humans can learn new information during sleep. Nat Neurosci 15:1460–1465. doi:10.1038/nn.3193\n\nCAS\nArticle\nGoogle Scholar\nBastuji H, Garcia-Larrea L (1999) Evoked potentials as a tool for the investigation of human sleep. Sleep Med Rev 3:23–45\n\nCAS\nArticle\nGoogle Scholar\nBradley MM, Lang PJ (2007) The International Affective Picture System (IAPS) in the study of emotion and attention. In: Coan JA, Allen JJB (eds) Handbook of emotion elicitation and assessment. Oxford University Press, New York, pp 29–46\n\nGoogle Scholar\nCarskadon MA, Herz RS (2004) Minimal olfactory perception during sleep: why odor alarms will not work for humans. Sleep 27:402–405\n\nGoogle Scholar\nDe Koninck J, Prevost F, Lortie-Lussier M (1996) Vertical inversion of the visual field and REM sleep mentation. J Sleep Res 5:16–20\n\nArticle\n\nGoogle Scholar\nDeuker L et al (2013) Memory consolidation by replay of stimulus-specific neural activity. J Neurosci 33:19373–19383\n\nCAS\nArticle\nGoogle Scholar\nDiekelmann S, Wilhelm I, Born J (2009) The whats and whens of sleep-dependent memory consolidation. Sleep Med Rev 13:309–321\n\nArticle\nGoogle Scholar\nErlacher D, Schredl M (2010) Practicing a motor task in a lucid dream enhances subsequent performance: a pilot study. Sport Psychol 24:157–167\n\nGoogle Scholar\nGottfried JA (2006) Smell: central nervous processing. Adv Otorhinolaryngol 63:44–69. doi:10.1159/000093750\n\n',
            ),
          ],
        ),
      ),
    );
  }
}

class ERIntro extends StatefulWidget {
  const ERIntro({Key? key}) : super(key: key);

  @override
  State<ERIntro> createState() => _ERIntroState();
}

class _ERIntroState extends State<ERIntro> {
 DateTime initial = DateTime.now(); @override
  void dispose() {
    final end = DateTime.now();
    if (Get.find<ErController>().history.value.value == 67) {
      debugPrint('disposing');
      Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title: 'ER Intro- Generational Curses and Their Cure',
              ontap: () => Get.to(() => const ObserveSF(), arguments: [false]),
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'Author information\nAffiliations\nSleep Laboratory, Central Institute of Mental Health, Medical Faculty Mannheim/Heidelberg University, Mannheim, Germany\nMichael Schredl\nDepartment of Otorhinolaryngology, Head and Neck Surgery, University Hospital Mannheim, Mannheim, Germany\nLeonie Hoffmann, J. Ulrich Sommer & Boris A. Stuck\nSchlaflabor, Zentralinstitut für Seelische Gesundheit, Postfach 12 21 20, 68072, Mannheim, Germany\nMichael Schredl\nCorresponding author\nCorrespondence to Michael Schredl.https://link.springer.com/article/10.1007/s12078-014-9173-4\nThis study received no financial support; no off‐label or investigational use.\nPublished: 05 October 2014\nOlfactory Stimulation During Sleep Can Reactivate Odor-Associated Images\nMichael Schredl, Leonie Hoffmann, J. Ulrich Sommer & Boris A. Stuck \nChemosensory Perception volume 7, pages140–146(2014)Cite this article\n\n',
            ),
            const TextWidget(
              text:
                  '859 Accesses\n\n9 Citations\n\n4 Altmetric\n\nMetricsdetails\n\nAbstract\n\nPurpose\nResearch has indicated that olfactory stimuli presented during sleep might reactivate memories that are associated with this odor. The present study is the first to examine whether learned associations between odor and images can be reactivated during sleep.\n\nMethods\nSixteen healthy, normosmic volunteers underwent a balanced learning task in which pictures of rural scenes and pictures of city scenes were associated with hydrogen sulfide (smell of rotten eggs) or phenyl ethyl alcohol (smell of roses) in the evening in a crossover design. During the subsequent night, they were stimulated with olfactory stimuli (hydrogen sulfide, phenyl ethyl alcohol, and neutral) during REM periods. Participants were awakened 1 min after the stimulation and dream reports were elicited.\n\nResults\nThe olfactory congruent stimuli significantly increased the probability of dreams about rural scenes, whereas the same effect was not found for city scenes.\n\n',
            ),
            const TextWidget(
              text:
                  'Conclusions\nAs these findings support the hypothesis of reactivation during sleep, it would be very interesting to study the effect of dreams as a tool to measure reactivation of task material on sleep-dependent memory consolidation.\n\nThis is a preview of subscription content, log in to check access.\n\nReferences\nArzi A, Sela L, Green A, Givaty G, Dagan Y, Sobel N (2010) The influence of odorants on respiratory patterns in sleep. Chem Senses 35:31–40\n\nArticle\nGoogle Scholar\nArzi A, Shedlesky L, Ben-Shaul M, Nasser K, Oksenberg A, Hairston IS, Sobel N (2012) Humans can learn new information during sleep. Nat Neurosci 15:1460–1465. doi:10.1038/nn.3193\n\nCAS\nArticle\nGoogle Scholar\nBastuji H, Garcia-Larrea L (1999) Evoked potentials as a tool for the investigation of human sleep. Sleep Med Rev 3:23–45\n\nCAS\nArticle\nGoogle Scholar\nBradley MM, Lang PJ (2007) The International Affective Picture System (IAPS) in the study of emotion and attention. In: Coan JA, Allen JJB (eds) Handbook of emotion elicitation and assessment. Oxford University Press, New York, pp 29–46\n\nGoogle Scholar\nCarskadon MA, Herz RS (2004) Minimal olfactory perception during sleep: why odor alarms will not work for humans. Sleep 27:402–405\n\nGoogle Scholar\nDe Koninck J, Prevost F, Lortie-Lussier M (1996) Vertical inversion of the visual field and REM sleep mentation. J Sleep Res 5:16–20\n\nArticle\n\nGoogle Scholar\nDeuker L et al (2013) Memory consolidation by replay of stimulus-specific neural activity. J Neurosci 33:19373–19383\n\nCAS\nArticle\nGoogle Scholar\nDiekelmann S, Wilhelm I, Born J (2009) The whats and whens of sleep-dependent memory consolidation. Sleep Med Rev 13:309–321\n\nArticle\nGoogle Scholar\nErlacher D, Schredl M (2010) Practicing a motor task in a lucid dream enhances subsequent performance: a pilot study. Sport Psychol 24:157–167\n\nGoogle Scholar\nGottfried JA (2006) Smell: central nervous processing. Adv Otorhinolaryngol 63:44–69. doi:10.1159/000093750\n\n',
            ),
          ],
        ),
      ),
    );
  }
}
