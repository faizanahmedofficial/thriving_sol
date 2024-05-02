// ignore_for_file: unused_import, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedular_project/Controller/user_controller.dart';
import 'package:schedular_project/Global/firebase_collections.dart';

final UserController _app = Get.find();


Stream<QuerySnapshot> fetchroutines(String userid, [bool completed = false]) => routineRef
    .where('userid', isEqualTo: userid)
    // .where('completed', isEqualTo: completed)
    .orderBy('created', descending: true)
    .snapshots();
