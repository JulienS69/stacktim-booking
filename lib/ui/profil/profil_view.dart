import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/ui/profil/section/header/available_credit.dart';
import 'package:stacktim_booking/ui/profil/section/header/edit_nickname.dart';
import 'package:stacktim_booking/ui/profil/section/header/hours_played.dart';
import 'package:stacktim_booking/ui/profil/section/header/nickname.dart';
import 'package:stacktim_booking/ui/profil/section/header/profil_header.dart';
import 'package:stacktim_booking/ui/profil/widgets/discord_logo.dart';
import 'package:stacktim_booking/ui/splash_screen/custom_page/agreement_view.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_error_page.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';
import 'package:stacktim_booking/widget/x_profil_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../navigation/route.dart';
import 'profil_view_controller.dart';

class ProfilView extends GetView<ProfilViewController> {
  const ProfilView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        onError: (error) => XErrorPage(
              contentTitle:
                  "Une erreur s'est produite lors de la récupération de tes informations",
              onPressedRetry: () {
                //TODO RETRY LES REQUÊTES
              },
              withBottomBar: true,
              withAppBar: true,
              bottomNavIndex: 2,
            ), (state) {
      controller.showTutorialOnDashboard(context);
      return XMobileScaffold(
        appBar: const XPageHeader(
          title: '',
          imagePath: logoOverSlug,
        ),
        gapLocation: GapLocation.end,
        floatingActionButton: Obx(() => controller.isEditing.value
            ? FloatingActionButton(
                onPressed: () async {
                  controller.isEditing.value = false;
                  await controller.updateCurrentUser();
                },
                backgroundColor: Colors.black,
                child: const Icon(
                  Icons.check,
                  color: Colors.red,
                ),
              )
            : FloatingActionButton(
                onPressed: () {
                  Get.offAndToNamed(
                    Routes.dashboard,
                    arguments: {
                      'openSheet': true,
                    },
                  );
                },
                backgroundColor: Colors.black,
                child: Image.asset(
                  logo,
                  height: 35,
                ),
              )),
        bottomNavIndex: 2,
        body: Obx(
          () => Skeletonizer(
            enabled: controller.isSkeletonLoading.value,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Column(
                  children: [
                    //STUB - Profil Picture, fullName
                    ProfilHeader(
                      controller: controller,
                    ),
                    //STUB -  NICKNAME
                    Obx(() => controller.isEditing.value
                        ? EditNickName(controller: controller)
                        : NickName(controller: controller)),
                    const SizedBox(
                      height: 50,
                    ),
                    //STUB -  Credits Available
                    AvailableCredits(controller: controller),
                    const SizedBox(
                      height: 10,
                    ),
                    //STUB -  Hours Played
                    HoursPlayed(controller: controller),
                    const SizedBox(
                      height: 25,
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //STUB -  RELOAD TUTORIAL
                    XProfilWidget(
                      title: "Relancer le tuto",
                      onTap: () async {
                        await controller.reloadTutorial();
                      },
                      imageAsset: reload,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //STUB -  DOUMENTATION
                    XProfilWidget(
                      title: "Règlement de la salle",
                      onTap: () {
                        Get.to(() => const AgreementView());
                      },
                      imageAsset: document,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //STUB -  Discord
                    XProfilWidget(
                      title: "Rejoindre le serveur Discord",
                      onTap: () async {
                        await launchUrl(
                          mode: LaunchMode.externalApplication,
                          Uri.parse(
                            stacktimDiscordUrl,
                          ),
                        );
                      },
                      widget: const DiscordRotating(),
                    ),
                    const SizedBox(height: 60),
                    //STUB -  LOGOUT
                    ElevatedButton(
                      onPressed: () async {
                        HapticFeedback.vibrate();
                        await controller.logout();
                        Get.offAllNamed(Routes.login);
                      },
                      child: const Text("Se déconnecter"),
                    ),
                    //STUB -  APP VERSION
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onDoubleTap: () {
                        controller.isShowingVersion.value = true;
                      },
                      child: Obx(
                        () => controller.isShowingVersion.value
                            ? InkWell(
                                onTap: () {
                                  controller.incrementCounterFordDevelopers();
                                },
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      '${controller.version}+${controller.buildNumber}',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Container(
                                  height: 20,
                                  width: 150,
                                  color: Colors.transparent,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
