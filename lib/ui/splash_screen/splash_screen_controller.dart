import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/local_storage.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../navigation/route.dart';

class SplashScreenController extends GetxController with StateMixin {
  List<TargetFocus> tutorialList = [];
  RxBool isShowTutorial = false.obs;
  SharedPreferences? sharedPreferences;

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

  acceptAgreement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LocalStorageKey.agreement.name, "true");
    Get.offAllNamed(Routes.login);
  }

  //SECTION TUTORIAL
  void showTutorial(BuildContext context, List<TargetFocus> targets) {
    TutorialCoachMark(
      targets: targets,
      colorShadow: const Color.fromARGB(255, 22, 22, 22),
      paddingFocus: 0,
      hideSkip: false,
      alignSkip: AlignmentDirectional.topStart,
      skipWidget: const Text(
        "Passer le tutoriel",
        style: TextStyle(decoration: TextDecoration.underline),
      ),
      onSkip: () {
        if (sharedPreferences != null) {
          isShowTutorial.value = false;
          sharedPreferences?.setBool(
              LocalStorageKeyEnum.isShowTutorial.name, false);
        }
        return true;
      },
      onFinish: () async {
        await closeTutorial();
      },
    ).show(context: context);
  }

  void showTutorialOnDashboard(context) async {
    if (tutorialList.isNotEmpty && isShowTutorial.value == true) {
      showTutorial(context, tutorialList);
    }
  }

  Future<void> getDataTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool? getTutoBool = prefs.getBool(LocalStorageKeyEnum.isShowTutorial.name);
    // if (getTutoBool == null || getTutoBool == true) {
    isShowTutorial.value = true;
    // }
  }

  Future<void> closeTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isShowTutorial.value = false;
    // await prefs.setBool(LocalStorageKeyEnum.isShowTutorial.name, false);
  }

  fillTutorialList({required GlobalKey<State<StatefulWidget>>? keyTarget}) {
    //FAB
    tutorialList.add(
      TargetFocus(
        identify: "FAB",
        keyTarget: keyTarget,
        enableOverlayTab: true,
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              child: const Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Prend ta réservation ici',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    overflow: TextOverflow.clip,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  @override
  void onInit() async {
    change(null, status: RxStatus.success());
    await Future.delayed(const Duration(seconds: 1));
    await checkToken();
    super.onInit();
  }
}
