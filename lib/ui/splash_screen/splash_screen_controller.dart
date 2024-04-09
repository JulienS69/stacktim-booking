import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacktim_booking/helper/functions.dart';

import '../../navigation/route.dart';

class SplashScreenController extends GetxController with StateMixin {
  //BOOL
  RxBool isShowTutorial = false.obs;
  //OTHER
  SharedPreferences? sharedPreferences;

//This allows checking if the user has a token upon application restart and redirecting them based on the conditions.
  Future<void> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(LocalStorageKey.jwt.name) ?? "";
    String isAgree = prefs.getString(LocalStorageKey.agreement.name) ?? "";
    if (isAgree.isEmpty) {
      Get.offAllNamed(Routes.intro);
    } else if (token.isNotEmpty) {
      Get.offAllNamed(Routes.welcome);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }

  @override
  void onInit() async {
    change(null, status: RxStatus.success());
    await Future.delayed(const Duration(seconds: 1));
    await checkToken();
    super.onInit();
  }
}
