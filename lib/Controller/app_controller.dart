import 'package:get/get.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/er_models.dart';

import '../Model/app_modal.dart';

class AppController extends GetxController {
  final Rx<ThoughtModel> answerkey = ThoughtModel().obs;

  Future fetchAnswerkey() async {
    await utilRef.doc('answerkey').get().then((value) {
      answerkey.value = ThoughtModel.fromMap(value.data());
    });
  }

  final Rx<AzureModel> azureModel = AzureModel().obs;
  Future fetchAzureData() async {
    await utilRef.doc('azure').get().then((value) {
      azureModel.value = AzureModel.fromMap(value.data());
    });
  }

  Future bulkwrite() async {
    scriptRef.get().then((value) {
      for (var doc in value.docs) {
        scriptRef.doc(doc.id).update({'duration': 0});
      }
    });
    lsrtRef.get().then((value) {
      for (var doc in value.docs) {
        lsrtRef.doc(doc.id).update({'duration': 0});
      }
    });
    erRef.get().then((value) {
      for (var doc in value.docs) {
        erRef.doc(doc.id).update({'duration': 0});
      }
    });
    connectionRef.get().then((value) {
      for (var doc in value.docs) {
        connectionRef.doc(doc.id).update({'duration': 0});
      }
    });
    gratitudeRef.get().then((value) {
      for (var doc in value.docs) {
        gratitudeRef.doc(doc.id).update({'duration': 0});
      }
    });
    coldRef.get().then((value) {
      for (var doc in value.docs) {
        coldRef.doc(doc.id).update({'duration': 0});
      }
    });
    dietRef.get().then((value) {
      for (var doc in value.docs) {
        dietRef.doc(doc.id).update({'duration': 0});
      }
    });
    sexualRef.get().then((value) {
      for (var doc in value.docs) {
        sexualRef.doc(doc.id).update({'duration': 0});
      }
    });
    movementRef.get().then((value) {
      for (var doc in value.docs) {
        movementRef.doc(doc.id).update({'duration': 0});
      }
    });
    goalsRef.get().then((value) {
      for (var doc in value.docs) {
        goalsRef.doc(doc.id).update({'duration': 0});
      }
    });
    bdRef.get().then((value) {
      for (var doc in value.docs) {
        bdRef.doc(doc.id).update({'duration': 0});
      }
    });
    actionRef.get().then((value) {
      for (var doc in value.docs) {
        actionRef.doc(doc.id).update({'duration': 0});
      }
    });
  }
}
