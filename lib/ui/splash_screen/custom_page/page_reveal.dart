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
import 'package:stacktim_booking/ui/splash_screen/splash_screen_controller.dart';

class PageReveal extends GetView<SplashScreenController> {
  late LiquidController liquidController;

  PageReveal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => Scaffold(
        body: LiquidSwipe.builder(
          itemCount: liquidSwipeData.length,
          itemBuilder: (context, index) {
            return Container(
              width: double.infinity,
              color: liquidSwipeData[index].color,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(
                    liquidSwipeData[index].image,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                  index == 0
                      ? Column(
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
                        )
                      : const SizedBox.shrink(),
                  index == 1 ? Image.asset(seat) : const SizedBox.shrink(),
                  index == 4
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            fit: BoxFit.scaleDown,
                            salle,
                            height: 300,
                          ),
                        )
                      : const SizedBox.shrink(),
                  index == 2
                      ? CarouselSlider(
                          items: gameListGenerate,
                          options: CarouselOptions(
                            height: 150,
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
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                          ))
                      : const SizedBox.shrink(),
                  index == 3
                      ? CarouselSlider(
                          items: esportListGenerate,
                          options: CarouselOptions(
                            height: 200,
                            aspectRatio: 16 / 9,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 2),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.decelerate,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                          ))
                      : const SizedBox.shrink(),
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
                                Get.to(const AgreementView());
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
                                    "Vous devez faire un appuie long pour accepter le règlement",
                                    SnackStatusEnum.warning);
                              },
                              onLongPress: () {
                                HapticFeedback.vibrate();
                                controller.acceptAgreement();
                              },
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white),
                                foregroundColor:
                                    MaterialStatePropertyAll(Colors.green),
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
            );
          },
          positionSlideIcon: 0.8,
          slideIconWidget: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          waveType: WaveType.liquidReveal,
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
