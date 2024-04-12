import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacktim_booking/game/launcher.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/connection_helper.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/local_storage.dart';
import 'package:stacktim_booking/helper/snackbar.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/helper/style.dart';
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
  TextEditingController stackCreditController = TextEditingController();
  TextEditingController passwordCreditController = TextEditingController();
  //STRING
  RxString nickName = "".obs;
  String version = "";
  String buildNumber = "";
  String currentUserRole = "";
  //INT
  int counter = 0;
  int counterTeam = 0;
  int counterGame = 0;
  int userCreditAvailable = 0;
  //LIST
  List<TargetFocus> tutorialList = [];
  List<User> administratorList = [];
  //OTHER
  PackageInfo? packageInfo;
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
              change(null, status: RxStatus.error());
            },
            (r) {
              if (r.credit != null) {
                userCreditAvailable = (r.credit!.creditAvailable ?? 0) -
                    (r.credit!.notYetUsed ?? 0);
              }
              currentUser = r;
            },
          ),
        );
  }

  //This allows retrieving the logged-in user.
  Future<void> getAdministratorUser() async {
    return await userRepository.getAdministrators().then(
          (value) => value.fold(
            (l) {},
            (r) {
              administratorList = r;
            },
          ),
        );
  }

  String getUserRole() {
    currentUserRole = "Membre Stacktim Esport";
    if (currentUser.roles != null) {
      if (currentUser.roles!.first.roleName == "Stacktim Admin") {
        currentUserRole = "Membre de l’organisation Stacktim Esport";
      } else {
        currentUserRole = "Membre Stacktim Esport";
      }
    }
    return currentUserRole;
  }

  void incrementCounter() async {
    counter++;
    if (counter == 15) {
      await showSuccesDialog();
    }
  }

  void incrementCounterForGame(BuildContext context) async {
    counterGame++;
    if (counterGame % 30 == 0) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.to(
        () => GameSurprise().build(context),
        transition: Transition.circularReveal,
      );
    }
  }

  Future showSuccesDialog() async {
    return await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            height: 450,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LottieBuilder.asset(
                  coinSettings,
                  fit: BoxFit.fill,
                  height: 150,
                  repeat: false,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Tu veux plus de crédit ?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Un admin peux t'aider",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                //ANCHOR - CREDITS INPUT
                TextField(
                  cursorColor: grey13,
                  textAlign: TextAlign.center,
                  onTapOutside: (outside) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  decoration: const InputDecoration(
                    hintText: "Nombre de crédits supplémentaires",
                    hintStyle: antaStyle,
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white60,
                    fontFamily: 'Anta',
                    decoration: TextDecoration.none,
                  ),
                  keyboardType: TextInputType.number,
                  controller: stackCreditController,
                ),
                //ANCHOR - PASSWORD INPUT
                TextField(
                  cursorColor: grey13,
                  textAlign: TextAlign.center,
                  onTapOutside: (outside) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  decoration: const InputDecoration(
                    hintText: "Mot de passe",
                    hintStyle: antaStyle,
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white60,
                    fontFamily: 'Anta',
                    decoration: TextDecoration.none,
                  ),
                  obscureText: true,
                  controller: passwordCreditController,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Retour'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (passwordCreditController.text == "jdc24") {
                          Get.back();
                          showSnackbar("Rechargement des crédits en cours",
                              SnackStatusEnum.simple);
                          //TODO REQUEST PERMETTANT DE RECHARGER LES CRÉDITS
                          passwordCreditController.clear();
                          stackCreditController.clear();
                        } else {
                          Get.back();
                          showSnackbar("Mauvais mot de passe saisi",
                              SnackStatusEnum.simple);
                        }
                      },
                      child: const Text('Valider'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void incrementCounterFordDevelopers() async {
    counterTeam++;
    if (counterTeam % 5 == 0) {
      await showEasterEggDialog();
    }
  }

  Future showEasterEggDialog() async {
    return await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            height: 360,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LottieBuilder.asset(
                  teamWork,
                  fit: BoxFit.fill,
                  height: 200,
                  repeat: false,
                ),
                const Text(
                  'Application développé par :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Julien SEUX, \nDheeraj TILHOO, Corentin COUSSE",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Retour'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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
    if (await ConnectionHelper.hasNoConnection()) {
      change(null, status: RxStatus.error());
    } else {
      change(null, status: RxStatus.success());
      packageInfo = await PackageInfo.fromPlatform();
      version = packageInfo?.version ?? "1.0.0";
      buildNumber = packageInfo?.buildNumber ?? "1";
      sharedPreferences = await SharedPreferences.getInstance();
      await getAdministratorUser();
      try {
        await getDataTutorial();
        await getCurrentUser();
        getUserRole();
        isSkeletonLoading.value = false;
      } catch (e) {
        change(null, status: RxStatus.error());
      }
    }
    super.onReady();
  }
}
