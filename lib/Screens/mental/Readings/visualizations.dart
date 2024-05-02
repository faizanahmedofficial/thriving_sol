import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Screens/mental/lsrt.dart';
import 'package:schedular_project/Screens/mental/v101_create_script.dart';

import '../../../Widgets/app_bar.dart';
import '../../../Widgets/text_widget.dart';
import '../../custom_bottom.dart';
import '../visualization_home.dart';

class VIntroReading extends StatefulWidget {
  const VIntroReading({Key? key}) : super(key: key);

  @override
  State<VIntroReading> createState() => _VIntroReadingState();
}

class _VIntroReadingState extends State<VIntroReading> {
  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<VisualizationController>().history.value.value == 19) {
      debugPrint('disposing');
      Get.find<VisualizationController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title:
                  'V Intro- Einstein\'s secret weapon. Increase your skill at anything while laying on the couch',
              ontap: () {
                Get.to(
                  () => GuidedVisualization(
                    fromExercise: true,
                    entity: visualizationList[visualizationIndex(24)],
                    connectedReading: () => Get.back(),
                    onfinished: () => Get.back(),
                  ),
                );
              },
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'M, Reinhard I (2009–2010) The continuity between waking mood and dream emotions: direct and second-order effects. Imagin Cogn Pers 29:271–282\nSchredl M, Burchert N, Grabatin Y (2004) The effect of training on interrater reliability in dream content analysis. Sleep Hypn 6:139–144\nGoogle Scholar\nSchredl M, Atanasova D, Hörmann K, Maurer JT, Hummel T, Stuck BA (2009) Information processing during sleep: the effect of olfactory stimuli on dream content and dream emotions. J Sleep Res 18:285–290\n\nArticle\nGoogle Scholar\nSchredl M, Sahin V, Schäfer G (1998) Gender differences in dreams: do they reflect gender differences in waking life? Personality and Individual Differences, 25:433–442\n\nSmith DV, Shepherd GM (2003) Chemical senses: taste and olfaction. In: Squire LR (ed) Fundamental neuroscience, 2nd edn. Academic, Amsterdam, pp 631–666\n\nGoogle Scholar\nStrauch I, Meier B (1996) In search of dreams: results of experimental dream research. State University of New York Press, Albany\n\nGoogle Scholar\nStuck BA, Weitz H, Hörmann K, Maurer JT, Hummel T (2006) Chemosensory event-related potentials during sleep—a pilot study. Neurosci Lett 406:222–226\n\nCAS\nArticle\nGoogle Scholar\nStuck BA, Stieber K, Frey S, Freiburg C, Hörmann K, Maurer JT, Hummel T (2007) Arousal responses to olfactory or trigeminal stimulation during sleep. Sleep 30:506–510\n\nGoogle Scholar\nTrotter K, Dallas K, Verdone P (1988) Olfactory stimuli and their effects on REM dreams. Psychiatr J Univ Ott 13:94–96\n\nCAS\nGoogle Scholar\nWagner U, Gais S, Born J (2001) Emotional memory formation is enhanced across sleep intervals with high amounts of rapid eye movement sleep. Learn Mem 8:112–119\n\nCAS\n\nArticle\nGoogle Scholar\nWamsley EJ, Tucker M, Payne JD, Benavides JA, Stickgold R (2010) Dreaming of a learning task is associated with enhanced sleep-dependent memory consolidation. Curr Biol 20:850–855\n\nCAS\nArticle\nGoogle Scholar\nDownload references\nwhich is associated with the specific odour might be found more often. Studies with presleep learning sessions in which odour cues are associated with specific cues might shed light on memory processing and consolidation during sleep. In addition, it would be interesting to study nightmare sufferers, i.e. whether positively toned olfactory stimuli yield a significant shift in the emotional tone of nightmares.\n\nDisclosure\nThis study received no financial support; no off‐label or investigational use.\nPublished: 05 October 2014\nOlfactory Stimulation During Sleep Can Reactivate Odor-Associated Images\nMichael Schredl, Leonie Hoffmann, J. Ulrich Sommer & Boris A. Stuck \nChemosensory Perception volume 7, pages140–146(2014)Cite this article\n\n859 Accesses\n\n9 Citations\n\n4 Altmetric\n\nMetricsdetails\n\nAbstract\nPurpose\n\nResearch has indicated that olfactory stimuli presented during sleep might reactivate memories that are associated with this odor. The present study is the first to examine whether learned associations between odor and images can be reactivated during sleep.\n\nMethods\nSixteen healthy, normosmic volunteers underwent a balanced learning task in which pictures of rural scenes and pictures of city scenes were associated with hydrogen sulfide (smell of rotten eggs) or phenyl ethyl alcohol (smell of roses) in the evening in a crossover design. During the subsequent night, they were stimulated with olfactory stimuli (hydrogen sulfide, phenyl ethyl alcohol, and neutral) during REM periods. Participants were awakened 1 min after the stimulation and dream reports were elicited.\n\nResults\nThe olfactory congruent stimuli significantly increased the probability of dreams about rural scenes, whereas the same effect was not found for city scenes.\n\nConclusions\nAs these findings support the hypothesis of reactivation during sleep, it would be very interesting to study the effect of dreams as a tool to measure reactivation of task material on sleep-dependent memory consolidation.\n\nThis is a preview of subscription content, log in to check access.',
            ),
          ],
        ),
      ),
    );
  }
}

class WhatIsVisualizationReading extends StatefulWidget {
  const WhatIsVisualizationReading({Key? key}) : super(key: key);

  @override
  State<WhatIsVisualizationReading> createState() =>
      _WhatIsVisualizationReadingState();
}

class _WhatIsVisualizationReadingState
    extends State<WhatIsVisualizationReading> {
  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<VisualizationController>().history.value.value == 20) {
      debugPrint('disposing');
      Get.find<VisualizationController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title: 'V100- What is Visualization? ',
              ontap: () {
                Get.to(
                  () => GuidedVisualization(
                    fromExercise: true,
                    entity: visualizationList[visualizationIndex(23)],
                    connectedReading: () => Get.back(),
                    onfinished: () => Get.back(),
                  ),
                );
              },
            ).marginOnly(bottom: 20),
            const Text(
              'Stuck BA, Stieber K, Frey S, Freiburg C, Hörmann K, Maurer JT, Hummel T (2007) Arousal responses to olfactory or trigeminal stimulation during sleep. Sleep 30:506–510',
            ),
            const Text('Google Scholar'),
            const Text(
              'Trotter K, Dallas K, Verdone P (1988) Olfactory stimuli and their effects on REM dreams. Psychiatr J Univ Ott 13:94–96',
            ),
            const Text('CAS'),
            const Text('Google Scholar'),
            const Text(
              'Wagner U, Gais S, Born J (2001) Emotional memory formation is enhanced across sleep intervals with high amounts of rapid eye movement sleep. Learn Mem 8:112–119',
            ),
            const Text('CAS'),
            const Text('Article'),
            const Text('Google Scholar'),
            const Text(
              'Wamsley EJ, Tucker M, Payne JD, Benavides JA, Stickgold R (2010) Dreaming of a learning task is associated with enhanced sleep-dependent memory consolidation. Curr Biol 20:850–855',
            ),
            const Text('Google Scholar'),
            const Text(
                'Trotter K, Dallas K, Verdone P (1988) Olfactory stimuli and their effects on REM dreams. Psychiatr J Univ Ott 13:94–96'),
            const Text('CAS'),
            const Text('Google Scholar'),
            const Text(
                'Wagner U, Gais S, Born J (2001) Emotional memory formation is enhanced across sleep intervals with high amounts of rapid eye movement sleep. Learn Mem 8:112–119'),
            const Text('CAS'),
            const Text('Article'),
            const Text('Google Scholar'),
            const Text(
                'Wamsley EJ, Tucker M, Payne JD, Benavides JA, Stickgold R (2010) Dreaming of a learning task is associated with enhanced sleep-dependent memory consolidation. Curr Biol 20:850–855'),
            const Text('Abstract'),
            const Text('Purpose'),
            const Text(
                'Research has indicated that olfactory stimuli presented during sleep might reactivate memories that are associated with this odor. The present study is the first to examine whether learned associations between odor and images can be reactivated during sleep.'),
            const Text('Methods'),
            const Text(
                'Sixteen healthy, normosmic volunteers underwent a balanced learning task in which pictures of rural scenes and pictures of city scenes were associated with hydrogen sulfide (smell of rotten eggs) or phenyl ethyl alcohol (smell of roses) in the evening in a crossover design. During the subsequent night, they were stimulated with olfactory stimuli (hydrogen sulfide, phenyl ethyl alcohol, and neutral) during REM periods. Participants were awakened 1 min after the stimulation and dream reports were elicited.'),
            const Text('Results'),
            const Text(
                'The olfactory congruent stimuli significantly increased the probability of dreams about rural scenes, whereas the same effect was not found for city scenes.'),
            const Text('Conclusions'),
            const Text(
                'As these findings support the hypothesis of reactivation during sleep, it would be very interesting to study the effect of dreams as a tool to measure reactivation of task material on sleep-dependent memory consolidation.'),
          ],
        ),
      ),
    );
  }
}

class GuidedVisualizationFruitReading extends StatefulWidget {
  const GuidedVisualizationFruitReading({Key? key}) : super(key: key);

  @override
  State<GuidedVisualizationFruitReading> createState() =>
      _GuidedVisualizationFruitReadingState();
}

class _GuidedVisualizationFruitReadingState
    extends State<GuidedVisualizationFruitReading> {
  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<VisualizationController>().history.value.value == 21) {
      debugPrint('disposing');
      Get.find<VisualizationController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title:
                  'Guided Visualization for Improving Physical Strength -Fruit',
              ontap: () {
                Get.to(
                  () => GuidedVisualization(
                    fromExercise: true,
                    entity: visualizationList[visualizationIndex(22)],
                    connectedReading: () => Get.back(),
                    onfinished: () => Get.back(),
                  ),
                );
              },
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'The differences of our findings in comparison to the earlier study by Trotter et al. (1988) indicated clearly that sophisticated technology in presenting olfactory stimuli is necessary, i.e. a technique without affecting the mechanical and thermal condition of the nasal mucosa, and that ensures that the odour is not detectable at the time of the awakening. With regard to these shortcomings, the results of the Trotter et al. (1988) study have limited generalizability.\n\nThat the lack of incorporated olfactory stimuli is explained by methodological issues (e.g. forgetting this part of the dream because it happened 1 min prior to awakening) is unlikely, because the procedure of the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that it is unlikely that an increase of stimulus intensity will produce stronger effects. In addition, the concentrations applied in the present study have been intense and clearly above threshold limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\nTo summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. The minimal effect on dream content might be explained by the lack of arousals in poststimulation EEG, indicating clearly that pure olfactory stimuli are processed differently to stimuli of other sensory modalities. We hypothesized that the strong effect on dream emotions is due to the direct connectivity of the olfactory bulb (and not for other sensory modalities) to the amygdala processing emotional memory during REM sleep. Whether olfactory stimuli are presented directly in dreams is a question which has not yet been answered; it might be speculated that declarative material which is associated with the specific odour might be found more often. Studies with presleep learning sessions in which odour cues are associated with specific cues might shed light on memory processing and consolidation during sleep. In addition, it would be interesting to study nightmare sufferers, i.e. whether positively toned olfactory stimuli yield a significant shift in the emotional tone of nightmares.',
            ),
          ],
        ),
      ),
    );
  }
}

class CreateYourScriptReading extends StatefulWidget {
  const CreateYourScriptReading({Key? key}) : super(key: key);

  @override
  State<CreateYourScriptReading> createState() =>
      _CreateYourScriptReadingState();
}

class _CreateYourScriptReadingState extends State<CreateYourScriptReading> {
  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<VisualizationController>().history.value.value == 25) {
      debugPrint('disposing');
      Get.find<VisualizationController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title: 'V101- Creating your script',
              ontap: () => Get.off(
                () => const V101CreateScript(),
                arguments: [false],
              ),
            ).marginOnly(bottom: 20),
            const TextWidget(text: 'Abstract'),
            const TextWidget(text: 'Purpose'),
            const TextWidget(
                text:
                    'Research has indicated that olfactory stimuli presented during sleep might reactivate memories that are associated with this odor. The present study is the first to examine whether learned associations between odor and images can be reactivated during sleep.'),
            const TextWidget(text: 'Methods'),
            const TextWidget(
                text:
                    'Sixteen healthy, normosmic volunteers underwent a balanced learning task in which pictures of rural scenes and pictures of city scenes were associated with hydrogen sulfide (smell of rotten eggs) or phenyl ethyl alcohol (smell of roses) in the evening in a crossover design. During the subsequent night, they were stimulated with olfactory stimuli (hydrogen sulfide, phenyl ethyl alcohol, and neutral) during REM periods. Participants were awakened 1 min after the stimulation and dream reports were elicited.'),
            const TextWidget(text: 'Results'),
            const TextWidget(
                text:
                    'The olfactory congruent stimuli significantly increased the probability of dreams about rural scenes, whereas the same effect was not found for city scenes.'),
            const TextWidget(
              text:
                  'That the lack of incorporated olfactory stimuli is explained by methodological issues (e.g. forgetting this part of the dream because it happened 1 min prior to awakening) is unlikely, because the procedure of the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that it is unlikely that an increase of stimulus intensity will produce.\n\nThe differences of our findings in comparison to the earlier study by Trotter et al. (1988) indicated clearly that sophisticated technology in presenting olfactory stimuli is necessary, i.e. a technique without affecting the mechanical and thermal condition of the nasal mucosa, and that ensures that the odour is not detectable at the time of the awakening. With regard to these shortcomings, the results of the Trotter et al. (1988) study have limited generalizability.\n\nThat the lack of incorporated olfactory stimuli is explained by methodological issues (e.g. forgetting this part of the dream because it happened 1 min prior to awakening) is unlikely, because the procedure of the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that it is unlikely that an increase of stimulus intensity will produce stronger effects. In addition, the concentrations applied in the present study have been intense and clearly above threshold limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\nTo summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. The minimal effect on dream content might be explained by the lack of arousals in poststimulation EEG, indicating clearly that pure olfactory stimuli are processed differently to stimuli of other sensory modalities. We hypothesized that the strong effect on dream emotions is due to the direct connectivity of the olfactory bulb (and not for other sensory modalities) to the amygdala processing emotional memory during REM sleep. Whether olfactory stimuli are presented directly in dreams is a question which has not yet been answered; it might be speculated that declarative material which is associated with the specific odour might be found more often. Studies with presleep learning sessions in which odour cues are associated with specific cues might shed light on memory processing and consolidation during sleep. In addition, it would be interesting to study nightmare sufferers, i.e. whether positively toned olfactory stimuli yield a significant shift in the emotional tone of nightmares.',
            ),
          ],
        ),
      ),
    );
  }
}

class GuidedVisualizationReading extends StatefulWidget {
  const GuidedVisualizationReading({Key? key}) : super(key: key);

  @override
  State<GuidedVisualizationReading> createState() =>
      _GuidedVisualizationReadingState();
}

class _GuidedVisualizationReadingState
    extends State<GuidedVisualizationReading> {
  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<VisualizationController>().history.value.value == 26) {
      debugPrint('disposing');
      Get.find<VisualizationController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title:
                  'Guided Visualization for Improving Physical Strength - Workout (Reading)',
              ontap: () {
                Get.to(
                  () => GuidedVisualization(
                    fromExercise: true,
                    entity: visualizationList[visualizationIndex(27)],
                    connectedReading: () => Get.back(),
                    onfinished: () => Get.back(),
                  ),
                );
              },
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'The differences of our findings in comparison to the earlier study by Trotter et al. (1988) indicated clearly that sophisticated technology in presenting olfactory stimuli is necessary, i.e. a technique without affecting the mechanical and thermal condition of the nasal mucosa, and that ensures that the odour is not detectable at the time of the awakening. With regard to these shortcomings, the results of the Trotter et al. (1988) study have limited generalizability.\n\nThat the lack of incorporated olfactory stimuli is explained by methodological issues (e.g. forgetting this part of the dream because it happened 1 min prior to awakening) is unlikely, because the procedure of the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that it is unlikely that an increase of stimulus intensity will produce stronger effects. In addition, the concentrations applied in the present study have been intense and clearly above threshold limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\nTo summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. The minimal effect on dream content might be explained by the lack of arousals in poststimulation EEG, indicating clearly that pure olfactory stimuli are processed differently to stimuli of other sensory modalities. We hypothesized that the strong effect on dream emotions is due to the direct connectivity of the olfactory bulb (and not for other sensory modalities) to the amygdala processing emotional memory during REM sleep. Whether olfactory stimuli are presented directly in dreams is a question which has not yet been answered; it might be speculated that declarative material which is associated with the specific odour might be found more often. Studies with presleep learning sessions in which odour cues are associated with specific cues might shed light on memory processing and consolidation during sleep. In addition, it would be interesting to study nightmare sufferers, i.e. whether positively toned olfactory stimuli yield a significant shift in the emotional tone of nightmares.',
            ),
          ],
        ),
      ),
    );
  }
}

class VisualizationImprovementsReading extends StatefulWidget {
  const VisualizationImprovementsReading({Key? key}) : super(key: key);

  @override
  State<VisualizationImprovementsReading> createState() =>
      _VisualizationImprovementsReadingState();
}

class _VisualizationImprovementsReadingState
    extends State<VisualizationImprovementsReading> {
  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<VisualizationController>().history.value.value == 29) {
      debugPrint('disposing');
      Get.find<VisualizationController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title: 'V102- Visualization Improvement',
              ontap: () => Get.off(() => const LSRT(), arguments: [false]),
            ).marginOnly(bottom: 20),
            const TextWidget(text: 'Abstract'),
            const TextWidget(text: 'Purpose'),
            const TextWidget(
                text:
                    'Research has indicated that olfactory stimuli presented during sleep might reactivate memories that are associated with this odor. The present study is the first to examine whether learned associations between odor and images can be reactivated during sleep.'),
            const TextWidget(text: 'Methods'),
            const TextWidget(
                text:
                    'Sixteen healthy, normosmic volunteers underwent a balanced learning task in which pictures of rural scenes and pictures of city scenes were associated with hydrogen sulfide (smell of rotten eggs) or phenyl ethyl alcohol (smell of roses) in the evening in a crossover design. During the subsequent night, they were stimulated with olfactory stimuli (hydrogen sulfide, phenyl ethyl alcohol, and neutral) during REM periods. Participants were awakened 1 min after the stimulation and dream reports were elicited.'),
            const TextWidget(text: 'Results'),
            const TextWidget(
                text:
                    'The olfactory congruent stimuli significantly increased the probability of dreams about rural scenes, whereas the same effect was not found for city scenes.'),
            const TextWidget(
              text:
                  'That the lack of incorporated olfactory stimuli is explained by methodological issues (e.g. forgetting this part of the dream because it happened 1 min prior to awakening) is unlikely, because the procedure of the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that it is unlikely that an increase of stimulus intensity will produce.\n\nThe differences of our findings in comparison to the earlier study by Trotter et al. (1988) indicated clearly that sophisticated technology in presenting olfactory stimuli is necessary, i.e. a technique without affecting the mechanical and thermal condition of the nasal mucosa, and that ensures that the odour is not detectable at the time of the awakening. With regard to these shortcomings, the results of the Trotter et al. (1988) study have limited generalizability.\n\nThat the lack of incorporated olfactory stimuli is explained by methodological issues (e.g. forgetting this part of the dream because it happened 1 min prior to awakening) is unlikely, because the procedure of the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that it is unlikely that an increase of stimulus intensity will produce stronger effects. In addition, the concentrations applied in the present study have been intense and clearly above threshold limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\nTo summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. The minimal effect on dream content might be explained by the lack of arousals in poststimulation EEG, indicating clearly that pure olfactory stimuli are processed differently to stimuli of other sensory modalities. We hypothesized that the strong effect on dream emotions is due to the direct connectivity of the olfactory bulb (and not for other sensory modalities) to the amygdala processing emotional memory during REM sleep. Whether olfactory stimuli are presented directly in dreams is a question which has not yet been answered; it might be speculated that declarative material which is associated with the specific odour might be found more often. Studies with presleep learning sessions in which odour cues are associated with specific cues might shed light on memory processing and consolidation during sleep. In addition, it would be interesting to study nightmare sufferers, i.e. whether positively toned olfactory stimuli yield a significant shift in the emotional tone of nightmares.',
            ),
          ],
        ),
      ),
    );
  }
}

class HabitsReading extends StatefulWidget {
  const HabitsReading({Key? key}) : super(key: key);

  @override
  State<HabitsReading> createState() => _HabitsReadingState();
}

class _HabitsReadingState extends State<HabitsReading> {
  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<VisualizationController>().history.value.value == 32) {
      debugPrint('disposing');
      Get.find<VisualizationController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title: 'V103- Habits',
              ontap: () => Get.to(() => const V101CreateScript(), arguments: [false]),
            ).marginOnly(bottom: 20),
            const TextWidget(text: 'Abstract'),
            const TextWidget(text: 'Purpose'),
            const TextWidget(
                text:
                    'Research has indicated that olfactory stimuli presented during sleep might reactivate memories that are associated with this odor. The present study is the first to examine whether learned associations between odor and images can be reactivated during sleep.'),
            const TextWidget(text: 'Methods'),
            const TextWidget(
                text:
                    'Sixteen healthy, normosmic volunteers underwent a balanced learning task in which pictures of rural scenes and pictures of city scenes were associated with hydrogen sulfide (smell of rotten eggs) or phenyl ethyl alcohol (smell of roses) in the evening in a crossover design. During the subsequent night, they were stimulated with olfactory stimuli (hydrogen sulfide, phenyl ethyl alcohol, and neutral) during REM periods. Participants were awakened 1 min after the stimulation and dream reports were elicited.'),
            const TextWidget(text: 'Results'),
            const TextWidget(
                text:
                    'The olfactory congruent stimuli significantly increased the probability of dreams about rural scenes, whereas the same effect was not found for city scenes.'),
            const TextWidget(
              text:
                  'That the lack of incorporated olfactory stimuli is explained by methodological issues (e.g. forgetting this part of the dream because it happened 1 min prior to awakening) is unlikely, because the procedure of the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that it is unlikely that an increase of stimulus intensity will produce.\n\nThe differences of our findings in comparison to the earlier study by Trotter et al. (1988) indicated clearly that sophisticated technology in presenting olfactory stimuli is necessary, i.e. a technique without affecting the mechanical and thermal condition of the nasal mucosa, and that ensures that the odour is not detectable at the time of the awakening. With regard to these shortcomings, the results of the Trotter et al. (1988) study have limited generalizability.\n\nThat the lack of incorporated olfactory stimuli is explained by methodological issues (e.g. forgetting this part of the dream because it happened 1 min prior to awakening) is unlikely, because the procedure of the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that it is unlikely that an increase of stimulus intensity will produce stronger effects. In addition, the concentrations applied in the present study have been intense and clearly above threshold limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\nTo summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. The minimal effect on dream content might be explained by the lack of arousals in poststimulation EEG, indicating clearly that pure olfactory stimuli are processed differently to stimuli of other sensory modalities. We hypothesized that the strong effect on dream emotions is due to the direct connectivity of the olfactory bulb (and not for other sensory modalities) to the amygdala processing emotional memory during REM sleep. Whether olfactory stimuli are presented directly in dreams is a question which has not yet been answered; it might be speculated that declarative material which is associated with the specific odour might be found more often. Studies with presleep learning sessions in which odour cues are associated with specific cues might shed light on memory processing and consolidation during sleep. In addition, it would be interesting to study nightmare sufferers, i.e. whether positively toned olfactory stimuli yield a significant shift in the emotional tone of nightmares.',
            ),
          ],
        ),
      ),
    );
  }
}

class IdealLifeReading extends StatefulWidget {
  const IdealLifeReading({Key? key}) : super(key: key);

  @override
  State<IdealLifeReading> createState() => _IdealLifeReadingState();
}

class _IdealLifeReadingState extends State<IdealLifeReading> {
  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<VisualizationController>().history.value.value == 33) {
      debugPrint('disposing');
      Get.find<VisualizationController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title: 'V104- Ideal Life',
              ontap: () => Get.to(() => const V101CreateScript(), arguments: [false]),
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'That the lack of incorporated olfactory stimuli is explained by methodological issues (e.g. forgetting this part of the dream because it happened 1 min prior to awakening) is unlikely, because the procedure of the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that it is unlikely that an increase of stimulus intensity will produce.\n\nThe differences of our findings in comparison to the earlier study by Trotter et al. (1988) indicated clearly that sophisticated technology in presenting olfactory stimuli is necessary, i.e. a technique without affecting the mechanical and thermal condition of the nasal mucosa, and that ensures that the odour is not detectable at the time of the awakening. With regard to these shortcomings, the results of the Trotter et al. (1988) study have limited generalizability.\n\nThat the lack of incorporated olfactory stimuli is explained by methodological issues (e.g. forgetting this part of the dream because it happened 1 min prior to awakening) is unlikely, because the procedure of the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that it is unlikely that an increase of stimulus intensity will produce stronger effects. In addition, the concentrations applied in the present study have been intense and clearly above threshold limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).\n\nTo summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. The minimal effect on dream content might be explained by the lack of arousals in poststimulation EEG, indicating clearly that pure olfactory stimuli are processed differently to stimuli of other sensory modalities. We hypothesized that the strong effect on dream emotions is due to the direct connectivity of the olfactory bulb (and not for other sensory modalities) to the amygdala processing emotional memory during REM sleep. Whether olfactory stimuli are presented directly in dreams is a question which has not yet been answered; it might be speculated that declarative material which is associated with the specific odour might be found more often. Studies with presleep learning sessions in which odour cues are associated with specific cues might shed light on memory processing and consolidation during sleep. In addition, it would be interesting to study nightmare sufferers, i.e. whether positively toned olfactory stimuli yield a significant shift in the emotional tone of nightmares.',
            ),
          ],
        ),
      ),
    );
  }
}

class IdealDayReading extends StatefulWidget {
  const IdealDayReading({Key? key}) : super(key: key);

  @override
  State<IdealDayReading> createState() => _IdealDayReadingState();
}

class _IdealDayReadingState extends State<IdealDayReading> {
  @override
  void dispose() {final end = DateTime.now();
    if (Get.find<VisualizationController>().history.value.value == 34) {
      debugPrint('disposing');
      Get.find<VisualizationController>().updateHistory(end.difference(initial).inSeconds);
      debugPrint('disposed');
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadingTitle(
              title: 'V105- Ideal Day',
              ontap: () => Get.to(() => const V101CreateScript(), arguments: [false]),
            ).marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'That the lack of incorporated olfactory stimuli is explained by methodological issues (e.g. forgetting this part of the dream because it happened 1 min prior to awakening) is unlikely, because the procedure of the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that it is unlikely that an increase of stimulus intensity will produce.\n',
            ),
            const TextWidget(
              text:
                  'The differences of our findings in comparison to the earlier study by Trotter et al. (1988) indicated clearly that sophisticated technology in presenting olfactory stimuli is necessary, i.e. a technique without affecting the mechanical and thermal condition of the nasal mucosa, and that ensures that the odour is not detectable at the time of the awakening. With regard to these shortcomings, the results of the Trotter et al. (1988) study have limited generalizability.\n',
            ),
            const TextWidget(
              text:
                  'That the lack of incorporated olfactory stimuli is explained by methodological issues (e.g. forgetting this part of the dream because it happened 1 min prior to awakening) is unlikely, because the procedure of the present study was comparable with the designs of similar studies in the field that demonstrated an incorporation of stimuli of other sensory modalities (cf. Schredl, 2008). On the other hand, it was necessary to test whether manipulation of presentation length or repetition frequency could increase the possibility of incorporation of the pure olfactory stimuli. However, the Stuck et al. (2007) study indicates clearly that it is unlikely that an increase of stimulus intensity will produce stronger effects. In addition, the concentrations applied in the present study have been intense and clearly above threshold.',
            ),
            const TextWidget(
              text:
                  'limited to stimulation during REM sleep. It would be interesting to study whether stimulation during non‐REM (NREM) sleep is equally effective, even though the cost of these studies would be higher because of lower dream recall rates after NREM awakenings (cf. Nielsen, 2000).',
            ),
            const TextWidget(
                text:
                    'To summarize, it was shown that the hedonic tone of olfactory stimuli are processed during REM sleep and affect dream content. In extension to previous work in the field, we showed the special status of pure olfactory stimuli in this context in contrast to other sensory modalities, i.e. a minimal effect on dream content and a strong effect on dream emotions. The minimal effect on dream content might be explained by the lack of arousals in poststimulation EEG, indicating clearly that pure olfactory stimuli are processed differently to stimuli of other sensory modalities. We hypothesized that the strong effect on dream emotions is due to the direct connectivity of the olfactory bulb (and not for other sensory modalities) to the amygdala processing emotional memory during REM sleep. Whether olfactory stimuli are presented directly in dreams is a question which has not yet been answered; it might be speculated that declarative material which is associated with the specific odour might be found more often. Studies with presleep learning sessions in which odour cues are associated with specific cues might shed light on memory processing and consolidation during sleep. In addition, it would be interesting to study nightmare sufferers, i.e. whether positively toned olfactory stimuli yield a significant shift in the emotional tone of nightmares.'),
            // const TextWidget(text: '')
          ],
        ),
      ),
    );
  }
}
