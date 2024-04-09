import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/local_storage.dart';
import 'package:stacktim_booking/helper/snackbar.dart';
import 'package:stacktim_booking/logic/models/user/user.dart';
import 'package:stacktim_booking/logic/repository/user_repository.dart';
import 'package:stacktim_booking/navigation/route.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class ProfilViewController extends GetxController with StateMixin {
  //REPOSITORY
  UserRepository userRepository = UserRepository();
  //OBJECT
  User currentUser = const User();
  //BOOL
  RxBool isShowTutorial = false.obs;
  RxBool isShowingVersion = false.obs;
  RxBool isSkeletonLoading = true.obs;
  RxBool isEditing = false.obs;
  //TEXT EDITING CONTROLLER
  TextEditingController nickNameController = TextEditingController();
  //STRING
  RxString nickName = "".obs;
  //LIST
  List<TargetFocus> tutorialList = [];
  //OTHER
  SharedPreferences? sharedPreferences;
  final nickNameButtonKey =
      GlobalKey<FormState>(debugLabel: 'nickNameButtonKey');

//This allows retrieving the logged-in user.
  Future<void> getCurrentUser() async {
    return await userRepository.getCurrentUser().then(
          (value) => value.fold(
            (l) {
              showSnackbar(
                  "Un problème est survenue lors de la récupération de vos informations",
                  SnackStatusEnum.error);
              // change(null, status: RxStatus.error());
            },
            (r) {
              currentUser = r;
            },
          ),
        );
  }

//This allows updating the user's nickname
  Future<void> updateCurrentUser() async {
    await userRepository
        .updateNickName(
            nickName: nickName.value, userUuid: currentUser.id ?? "0")
        .then(
          (value) => value.fold(
            (l) {
              showSnackbar("Un problème est survenue !", SnackStatusEnum.error);
            },
            (r) {
              showSnackbar(
                  "Ton pseudo a bien été modifié !", SnackStatusEnum.success);
            },
          ),
        );
  }

//This allows disconnecting the user by removing items stored in their local storage.
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(LocalStorageKey.jwt.name);
  }

//This allows restarting the tutorial on the dashboard page.
  reloadTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(LocalStorageKeyEnum.isShowTutorial.name, true);
    Get.offAllNamed(Routes.dashboard);
  }

  /// Displays the version number of the app based on the pubspec.yaml file.
  Widget buildVersionNumber() {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: ((context, snapshot) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              '${snapshot.data?.version ?? '-'}+${snapshot.data?.buildNumber ?? ''}',
            ),
          ),
        );
      }),
    );
  }

  //SECTION TUTORIAL
  void showTutorial(BuildContext context, List<TargetFocus> targets) {
    TutorialCoachMark(
      targets: targets,
      colorShadow: const Color.fromARGB(255, 22, 22, 22),
      paddingFocus: 0,
      hideSkip: true,
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
    bool? getTutoBool =
        prefs.getBool(LocalStorageKeyEnum.isShowTutorialProfil.name);
    if (getTutoBool == null || getTutoBool == true) {
      fillTutorialList();
      isShowTutorial.value = true;
    }
  }

  Future<void> closeTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isShowTutorial.value = false;
    await prefs.setBool(LocalStorageKeyEnum.isShowTutorialProfil.name, false);
  }

  fillTutorialList() {
    //FAB
    tutorialList.add(
      TargetFocus(
        identify: "NICKNAME",
        keyTarget: nickNameButtonKey,
        enableOverlayTab: true,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
              align: ContentAlign.bottom,
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  'Tu peux modifier ton pseudo, juste là',
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
  Future<void> onReady() async {
    change(null, status: RxStatus.success());
    sharedPreferences = await SharedPreferences.getInstance();
    await getDataTutorial();
    await getCurrentUser();
    isSkeletonLoading.value = false;
    super.onReady();
  }
}
