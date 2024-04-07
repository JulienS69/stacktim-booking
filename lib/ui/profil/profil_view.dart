import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/logic/models/user/user.dart';
import 'package:stacktim_booking/ui/profil/widgets/discord_logo.dart';
import 'package:stacktim_booking/ui/splash_screen/custom_page/agreement_view.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../navigation/route.dart';
import 'profil_view_controller.dart';

class ProfilView extends GetView<ProfilViewController> {
  const ProfilView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
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
                ))
            : FloatingActionButton(
                onPressed: () {
                  Get.offAndToNamed(Routes.dashboard, arguments: {
                    'openSheet': true,
                  });
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 35.0),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: 'https://picsum.photos/1000',
                                  height: 90,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 90.0,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                          20,
                                        ),
                                      ),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //SECTION - EDIT PROFIL PICTURE
                              // Positioned(
                              //   bottom: 0,
                              //   right: 0,
                              //   child: Container(
                              //     width: 30,
                              //     height: 30,
                              //     decoration: const BoxDecoration(
                              //       color: backgroundColor,
                              //       shape: BoxShape.circle,
                              //     ),
                              //     child: const Icon(
                              //       Icons.edit,
                              //       color: Colors.white,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              controller.currentUser.fullName,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Obx(() => controller.isEditing.value
                        ? Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    HapticFeedback.vibrate();
                                    controller.isEditing.value = false;
                                  },
                                  child: const Icon(
                                    Icons.cancel_outlined,
                                    color: backgroundColorSheet,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: TextField(
                                    cursorColor: grey13,
                                    textAlign: TextAlign.center,
                                    autofocus: true,
                                    onTapOutside: (d) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    },
                                    decoration: InputDecoration(
                                      hintText:
                                          controller.currentUser.nickName ??
                                              "Nouveau pseudo",
                                      hintStyle: arvoStyle,
                                      border: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1.0),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1.0),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1.0),
                                      ),
                                      errorBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1.0),
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white60,
                                      fontFamily: 'Anta',
                                      decoration: TextDecoration.none,
                                    ),
                                    onChanged: (newNickname) {
                                      controller.nickName.value = newNickname;
                                    },
                                    controller: controller.nickNameController,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                InkWell(
                                  onTap: () async {
                                    HapticFeedback.vibrate();

                                    controller.isEditing.value = false;
                                    await controller.updateCurrentUser();
                                  },
                                  child: const Icon(
                                    Icons.check_circle_outline_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              controller.isEditing.value =
                                  !controller.isEditing.value;
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            child: Row(
                              key: controller.nickNameButtonKey,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                  () => controller.nickName.value.isNotEmpty
                                      ? Text(
                                          controller.nickName.value,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                255, 98, 105, 109),
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                      : Text(
                                          controller.currentUser.nickName ??
                                              "Pseudo",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                255, 98, 105, 109),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 15,
                                )
                              ],
                            ),
                          )),
                    const SizedBox(
                      height: 50,
                    ),
                    //STACKCREDITS
                    Row(
                      children: [
                        const Text("Stack crédits restant :"),
                        const Spacer(),
                        Text(
                          controller.currentUser.credit?.creditAvailable
                                  .toString() ??
                              "0",
                          style:
                              const TextStyle(color: Colors.red, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            coinLogo,
                            height: 15,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Hours played
                    Row(
                      children: [
                        const Text(
                          "Nombre d'heures jouées :",
                        ),
                        const Spacer(),
                        Text(
                          controller.currentUser.credit?.creditUsed
                                  .toString() ??
                              "0",
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //RELOAD TUTORIAL
                    InkWell(
                      onTap: () async {
                        await controller.reloadTutorial();
                      },
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Row(
                        children: [
                          const Text(
                            "Relancer le tuto",
                          ),
                          const Spacer(),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xffF2F2F2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Image.asset(
                                height: 25,
                                reload,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // DOUMENTATION
                    InkWell(
                      onTap: () {
                        Get.to(() => const AgreementView());
                      },
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Row(
                        children: [
                          const Text(
                            "Règlement de la salle",
                          ),
                          const Spacer(),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xffF2F2F2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Image.asset(
                                height: 25,
                                document,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Discord
                    InkWell(
                      onTap: () async {
                        await launchUrl(
                          mode: LaunchMode.externalApplication,
                          Uri.parse(
                            stacktimDiscordUrl,
                          ),
                        );
                      },
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: const Row(
                        children: [
                          Text(
                            "Rejoindre le serveur Discord",
                          ),
                          Spacer(),
                          DiscordRotating(),
                        ],
                      ),
                    ),
                    SizedBox(height: 60),
                    ElevatedButton(
                      onPressed: () async {
                        HapticFeedback.vibrate();
                        await controller.logout();
                        Get.offAllNamed(Routes.login);
                      },
                      child: const Text("Se déconnecter"),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onDoubleTap: () {
                        controller.isShowingVersion.value = true;
                      },
                      child: Obx(
                        () => controller.isShowingVersion.value
                            ? Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: controller.buildVersionNumber(),
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
