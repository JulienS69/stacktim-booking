import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/navigation/route.dart';

class IntroViewController extends GetxController with StateMixin {
  //BOOL
  RxBool isShowTutorial = false.obs;
  //OTHER
  SharedPreferences? sharedPreferences;
  final GlobalKey one = GlobalKey();

//This allows setting a boolean indicating whether the user has accepted the gaming room regulations.
  acceptAgreement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LocalStorageKey.agreement.name, "true");
    Get.offAllNamed(Routes.login);
  }

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    change(null, status: RxStatus.success());
    super.onInit();
  }
}
