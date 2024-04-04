import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/logic/models/user/user.dart';
import 'package:stacktim_booking/ui/splash_screen/custom_page/agreement_view.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';

import '../../navigation/route.dart';
import 'profil_view_controller.dart';

class ProfilView extends GetView<ProfilViewController> {
  const ProfilView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return XMobileScaffold(
      appBar: const XPageHeader(
        title: '',
        imagePath: logoOverSlug,
      ),
      gapLocation: GapLocation.end,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: Image.asset(
          logo,
          height: 35,
        ),
      ),
      bottomNavIndex: 2,
      body: controller.obx(
        (state) => Obx(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.currentUser.nickName ?? "Pseudo",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 98, 105, 109),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        InkWell(
                          //TODO EDITION du pseudonyme
                          onTap: () {},
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 15,
                          ),
                        )
                      ],
                    ),
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
                            child: Stack(
                              children: [
                                Center(
                                  child: Image.asset(
                                    height: 25,
                                    reload,
                                  ),
                                ),
                              ],
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
                            "Documentation d’utilisation",
                          ),
                          const Spacer(),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xffF2F2F2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Image.asset(
                                    height: 25,
                                    document,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        HapticFeedback.vibrate();
                        await controller.logout();
                        Get.offAllNamed(Routes.login);
                      },
                      child: const Text("Se déconnecter"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
