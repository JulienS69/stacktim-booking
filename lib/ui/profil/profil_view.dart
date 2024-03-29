import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/strings.dart';
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
        (state) => SingleChildScrollView(
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
                          CachedNetworkImage(
                            height: 90,
                            fadeInCurve: Curves.ease,
                            imageBuilder: (context, imageProvider) => Container(
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
                            imageUrl:
                                'https://media.licdn.com/dms/image/D4E03AQFbosD6aw_S0Q/profile-displayphoto-shrink_200_200/0/1701246992314?e=2147483647&v=beta&t=IG7V0oXYBKE6aPrXoVb202d2Lvr7tpcbh9on147kfDc',
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                color: backgroundColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text("Julien SEUX",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          )),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Virtuor",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 98, 105, 109),
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    //TODO EDITION du pseudonyme
                    InkWell(
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
                //SECTION BODY
                //STACKCREDITS
                Row(
                  children: [
                    const Text("Stack crédits restant :"),
                    const Spacer(),
                    const Text(
                      "6",
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      coinLogo,
                      height: 15,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // Hours played
                const Row(
                  children: [
                    Text(
                      "Nombre d'heures jouées :",
                    ),
                    Spacer(),
                    Text(
                      "3",
                      style: TextStyle(color: Colors.red),
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
                  onTap: () {
                    //TODO - RELOAD TUTORIAL
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
                    //TODO - REDIRECT IN DOCUMENTATION RULES
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () async {
                      HapticFeedback.vibrate();
                      await controller.logout();
                      Get.offAllNamed(Routes.login);
                    },
                    child: const Text("Se déconnecter"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
