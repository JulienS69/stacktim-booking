import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/snackbar.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/ui/splash_screen/custom_page/agreement_view.dart';
import 'package:stacktim_booking/ui/splash_screen/liquid_swipe_view.dart/liquid_swipe_view_controller.dart';

class LiquidSwipeView extends GetView<LiquidSwipeViewController> {
  late LiquidController liquidController;

  LiquidSwipeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Rx<double> rotationAngle = 0.0.obs;
    return controller.obx(
      (state) => Scaffold(
        //TODO TUTO SAME OF DASHBOARD
        body: LiquidSwipe.builder(
          itemCount: liquidSwipeData.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (index == 0) {
                  showSnackbar(
                      "Vous devez slider de droite vers la gauche votre écran pour pouvoir naviguer",
                      SnackStatusEnum.simple);
                }
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: liquidSwipeData[index].color,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      liquidSwipeData[index].image,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                    Visibility(
                        visible: index == 0,
                        replacement: const SizedBox.shrink(),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            Lottie.asset(
                              lottieGamepad,
                              fit: BoxFit.fill,
                              height: 250,
                            ),
                          ],
                        )),
                    Visibility(
                      visible: index == 1,
                      replacement: const SizedBox.shrink(),
                      child: Obx(() => Transform.rotate(
                            angle: rotationAngle.value,
                            child: GestureDetector(
                              onPanUpdate: (details) {
                                rotationAngle += details.delta.dx / 150;
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: Image.asset(
                                  seat,
                                  width: 350,
                                  height: 350,
                                ),
                              ),
                            ),
                          )),
                    ),
                    Visibility(
                      visible: index == 4,
                      replacement: const SizedBox.shrink(),
                      child: CarouselSlider(
                        items: roomPictureListGenerate,
                        options: CarouselOptions(
                            height: 300,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.decelerate,
                            enlargeCenterPage: true,
                            enlargeFactor: 1,
                            scrollDirection: Axis.horizontal,
                            enlargeStrategy: CenterPageEnlargeStrategy.zoom),
                      ),
                    ),
                    Visibility(
                      visible: index == 2,
                      replacement: const SizedBox.shrink(),
                      child: CarouselSlider(
                          items: gameListGenerate,
                          options: CarouselOptions(
                              height: 500,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.8,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              enlargeFactor: 1,
                              scrollDirection: Axis.horizontal,
                              enlargeStrategy: CenterPageEnlargeStrategy.zoom)),
                    ),
                    Visibility(
                      visible: index == 3,
                      replacement: const SizedBox.shrink(),
                      child: CarouselSlider(
                        items: esportListGenerate,
                        options: CarouselOptions(
                            height: 500,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.decelerate,
                            enlargeCenterPage: true,
                            enlargeFactor: 1,
                            scrollDirection: Axis.horizontal,
                            enlargeStrategy: CenterPageEnlargeStrategy.zoom),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          liquidSwipeData[index].text1,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          liquidSwipeData[index].text2,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          liquidSwipeData[index].text3,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        index == 4
                            ? ElevatedButton(
                                onPressed: () {
                                  Get.to(() => const AgreementView());
                                },
                                child: const Text(
                                  "Lire le règlement de la salle",
                                ),
                              )
                            : const SizedBox.shrink(),
                        index == 4
                            ? ElevatedButton(
                                onPressed: () {
                                  showSnackbar(
                                      "Tu dois faire un appuie long pour accepter le règlement",
                                      SnackStatusEnum.warning);
                                },
                                onLongPress: () {
                                  HapticFeedback.vibrate();
                                  controller.acceptAgreement();
                                },
                                style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black),
                                  foregroundColor:
                                      MaterialStatePropertyAll(Colors.white),
                                ),
                                child: const Text(
                                  "Je confirme avoir lu le règlement",
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          positionSlideIcon: 0.8,
          slideIconWidget: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          waveType: WaveType.circularReveal,
          fullTransitionValue: 880,
          enableSideReveal: true,
          preferDragFromRevealedArea: true,
          enableLoop: true,
          ignoreUserGestureWhileAnimating: true,
        ),
      ),
    );
  }
}
