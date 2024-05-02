import 'package:get/get.dart';
import 'package:schedular_project/Controller/app_controller.dart';
import 'package:schedular_project/Model/er_models.dart';

import '../Model/app_modal.dart';

class AppServices extends GetxService {
  final AppController controller = Get.put(AppController());

  Future<AppServices> init() async {
    await controller.fetchAnswerkey();
    await controller.fetchAzureData();
    // await controller.bulkwrite();
    return this;
  }

  ThoughtModel get answerkey => controller.answerkey.value;
  AzureModel get azure => controller.azureModel.value;
}
