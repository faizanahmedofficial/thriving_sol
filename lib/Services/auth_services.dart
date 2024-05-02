import 'package:get/get.dart';
import 'package:schedular_project/Controller/user_controller.dart';
import 'package:schedular_project/Model/app_user.dart';

class AuthServices extends GetxService {
  final UserController _controller = Get.put(UserController());

  Future<AuthServices> init() async {
    await _controller.checkUserLoginStatus().then((value) async {
      if (value) await _controller.fetchData(userid);
    });
    return this;
  }

  String get link => _controller.link.value;

  String get userid => user.id ?? '';
  bool get isLogin => _controller.isUserLoggedIn.value;
  AppUser get user => _controller.user.value;

  UserReadings get readings => _controller.userreadings.value;
  int get category => readings.value!;
  int get element => readings.element!;

  set setCategory(int val) => _controller.userreadings.value.value = val;
  set setElement(int val) => _controller.userreadings.value.element = val;

  List<TodayRoutines> get todaysList => _controller.todaysList;

  SettingModel get settings => _controller.settings.value;

  List<AccomplishmentModel> get accomplishments => _controller.accomplishments;
}
