// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Screens/main_screen.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/constants.dart';
import '../Model/app_user.dart';

class UserController extends GetxController {
  RxBool isUserLoggedIn = false.obs;
  RxString userid = ''.obs;
  Rx<AppUser> user = AppUser().obs;
  RxString link = ''.obs;
  RxString file = ''.obs;

  Rx<UserReadings> userreadings = UserReadings(element: 0, value: 0).obs;

  Future fetchUser(String userid) async {
    await usersRef.doc(userid).get().then((value) {
      user.value = AppUser.fromMap(value.data());
    });
  }

  Future fetchUserReadings(String userid) async {
    await userReadings(userid).get().then((value) {
      if (value.data() == null) {
        userReadings(userid).set({
          'intro': {'value': 0, 'element': 0, 'id': intro},
          'breathing': {'value': 1, 'element': 7, 'id': breathing},
          'visualization': {'value': 2, 'element': 19, 'id': visualization},
          'mindfulness': {'value': 3, 'element': 35, 'id': mindfulness},
          'emotional regulation': {'value': 4, 'element': 67, 'id': er},
          'connection': {'value': 5, 'element': 94, 'id': connection},
          'gratitude': {'value': 6, 'element': 60, 'id': gratitude},
          'goals': {'value': 7, 'element': 102, 'id': goals},
          'productivity': {'value': 8, 'element': 0, 'id': 'productivity'},
          'behavioral design': {'value': 9, 'element': 116, 'id': bd},
          'movement': {'value': 10, 'element': 148, 'id': movement},
          'eating': {'value': 11, 'element': 143, 'id': 'eating'},
          'cold': {'value': 12, 'element': 134, 'id': cold},
          'reading': {'value': 13, 'element': 65, 'id': reading},
          'sexual': {'value': 14, 'element': 139, 'id': sexual},
        });
      }
    });
  }

  Future fetchData(String userid) async {
    await fetchSettings(userid);
    await fetchUserReadings(userid);
    await fetchTodays(userid);
    await fetchAccomplishments(userid);
  }

  /// user login status
  Future<bool> checkUserLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isUserLoggedIn.value = (prefs.getBool('isUserLoggedIn') ?? false);
    print('Login Cache: ${prefs.getBool('isUserLoggedIn').toString()}');
    if (isUserLoggedIn.value) {
      userid.value = prefs.getString('userid')!;
      print(userid.value);
      await fetchUser(userid.value);
      return true;
    } else {
      return false;
    }
  }

  Future setPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isUserLoggedIn', isUserLoggedIn.value);
    prefs.setString('userid', user.value.id!);
  }

  /// user logout
  userLogout() async {
    loadingDialog(Get.context!);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    /// auth sign out
    FirebaseAuth.instance.signOut();

    /// clear preferences
    prefs.setBool('isUserLoggedIn', false);
    prefs.setString('userid', '');
    prefs.clear();

    ///
    Get.log('--- User Logout ---');
    isUserLoggedIn.value = false;
    await usersRef.doc(user.value.id).update({'deviceToken': ''});
    clearData();

    ///
    Get.offAll(() => const MainScreen());
  }

  RxList<TodayRoutines> todaysList = <TodayRoutines>[].obs;
  fetchTodays(String userid) async {
    todaysList.clear();
    print('todays');
    await todayRoutines(userid).get().then((value) {
      if (value.docs.isNotEmpty) {
        print('fetching');
        for (var doc in value.docs) {
          todaysList.add(TodayRoutines.fromMap(doc));
        }
      }
    });
  }

  clearData() {
    todaysList.clear();
    userreadings.value = UserReadings(element: 0, value: 0);
    userid.value = '';
    user.value = AppUser();
    isUserLoggedIn.value = false;
    link.value = '';
    accomplishments.clear();
    file.value = '';
    settings.value = SettingModel();
  }

  Rx<SettingModel> settings = SettingModel().obs;
  Future fetchSettings(String userid) async {
    await settingRef.doc(userid).get().then((value) async {
      if (value.data() != null) {
        settings.value = SettingModel.fromMap(value.data());
      } else {
        settings.value = SettingModel(
          userid: userid,
          start: false,
          open: false,
          autoContinue: 0,
        );
        await settingRef.doc(userid).set(settings.value.toMap());
      }
    });
  }

  RxList<AccomplishmentModel> accomplishments = <AccomplishmentModel>[].obs;
  Future<bool> fetchAccomplishments(String userid) async {
    accomplishments.clear();
    await accomplsihmentRef(userid).get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          accomplishments.add(AccomplishmentModel.fromMap(doc));
        }
      } else if (value.docs.isEmpty) {
        accomplishments = [
          AccomplishmentModel(
            id: breathing,
            category: 0,
            total: 0,
            max: 0,
            routines: <ARoutines>[],
          ),
          AccomplishmentModel(
            id: visualization,
            category: 1,
            total: 0,
            max: 0,
            routines: <ARoutines>[],
          ),
          AccomplishmentModel(
            id: mindfulness,
            category: 2,
            total: 0,
            max: 0,
            routines: <ARoutines>[],
          ),
          AccomplishmentModel(
            id: er,
            category: 3,
            total: 0,
            max: 0,
            routines: <ARoutines>[],
          ),
          AccomplishmentModel(
            id: connection,
            category: 4,
            total: 0,
            max: 0,
            routines: <ARoutines>[],
          ),
          AccomplishmentModel(
            id: gratitude,
            category: 5,
            total: 0,
            max: 0,
            routines: <ARoutines>[],
          ),
          AccomplishmentModel(
            id: goals,
            category: 6,
            total: 0,
            max: 0,
            routines: <ARoutines>[],
          ),
          AccomplishmentModel(
            id: bd,
            category: 7,
            total: 0,
            max: 0,
            routines: <ARoutines>[],
          ),
          AccomplishmentModel(
            id: movement,
            category: 8,
            total: 0,
            max: 0,
            routines: <ARoutines>[],
          ),
          AccomplishmentModel(
            id: diet,
            category: 9,
            total: 0,
            max: 0,
            routines: <ARoutines>[],
          ),
          AccomplishmentModel(
            id: cold,
            category: 10,
            total: 0,
            max: 0,
            routines: <ARoutines>[],
          ),
          AccomplishmentModel(
            id: sexual,
            category: 11,
            total: 0,
            max: 0,
            routines: <ARoutines>[],
          ),
          AccomplishmentModel(
            id: reading,
            category: 12,
            total: 0,
            max: 0,
            routines: <ARoutines>[],
          ),
        ].obs;
        for (int i = 0; i < accomplishments.length; i++) {
          accomplsihmentRef(userid)
              .doc(accomplishments[i].id)
              .set(accomplishments[i].toMap());
        }
      }
      print('fetched');
      return true;
    });
    return false;
  }
}
