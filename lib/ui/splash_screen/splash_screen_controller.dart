import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/ui/splash_screen/custom_page/page_reveal.dart';

import '../../navigation/route.dart';

class SplashScreenController extends GetxController with StateMixin {
  Future<void> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(LocalStorageKey.jwt.name) ?? "";
    String isAgree = prefs.getString(LocalStorageKey.agreement.name) ?? "";
    if (isAgree.isEmpty) {
      Get.to(PageReveal(), fullscreenDialog: true);
    } else if (token.isNotEmpty) {
      Get.offAllNamed(Routes.welcome);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }

  acceptAgreement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LocalStorageKey.agreement.name, "true");
    Get.offAllNamed(Routes.login);
  }

  @override
  void onInit() async {
    change(null, status: RxStatus.success());
    await Future.delayed(const Duration(seconds: 1));
    await checkToken();
    super.onInit();
  }
}
