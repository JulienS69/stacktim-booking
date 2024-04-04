import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/navigation/route.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class LiquidSwipeViewController extends GetxController with StateMixin {
  List<TargetFocus> tutorialList = [];
  RxBool isShowTutorial = false.obs;
  SharedPreferences? sharedPreferences;
  GlobalKey fabButtondKey = GlobalKey();
  final GlobalKey one = GlobalKey();
  // final fabButtonKey = GlobalKey<FormState>(debugLabel: 'fabButtonKey');

  acceptAgreement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LocalStorageKey.agreement.name, "true");
    Get.offAllNamed(Routes.login);
  }

  someEvent() {
    ShowCaseWidget.of(Get.context!).startShowCase([
      fabButtondKey,
    ]);
  }

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());

    change(null, status: RxStatus.success());
    super.onInit();
  }
}
