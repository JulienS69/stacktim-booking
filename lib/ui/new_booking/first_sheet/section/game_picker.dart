import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';

class GamePicker extends StatelessWidget {
  const GamePicker({
    super.key,
    required this.controller,
  });

  final DashboardViewController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Choix du jeu : ",
                style: antaStyle.copyWith(
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              height: controller.isExpanded.value
                  ? 400
                  : controller.gameSelected.value.id != null
                      ? 120
                      : 0,
              child: controller.isExpanded.value
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(right: 2.0, left: 2.0),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: Get.size.width / 3,
                        childAspectRatio: 1,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: controller.gameList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            controller.isExpanded.value = false;
                            controller.gameSelected.value =
                                controller.gameList[index];
                          },
                          borderRadius: BorderRadius.circular(5),
                          overlayColor:
                              WidgetStateProperty.all(const Color(0xffFF0808)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 130,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: CachedNetworkImage(
                                  imageUrl: controller.gameList[index].media
                                          ?.first.originalUrl ??
                                      "",
                                  height: 20,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : controller.gameSelected.value.id != null
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 130,
                          width: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: CachedNetworkImage(
                                imageUrl: controller.gameSelected.value.media
                                        ?.first.originalUrl ??
                                    "",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
            ),
          ),
          Visibility(
            visible: controller.gameSelected.value.label != null &&
                !controller.isExpanded.value,
            child: Text(
              controller.gameSelected.value.label ?? "",
              style: antaStyle.copyWith(
                fontSize: 15,
                color: Colors.white60,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () async {
                await HapticFeedback.heavyImpact();
                controller.isExpanded.value = !controller.isExpanded.value;
              },
              child: Image.asset(
                controller.isExpanded.value
                    ? littleReduceVector
                    : controller.gameSelected.value.label != null
                        ? littleChangeVector
                        : littleAddVector,
                height: 35,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Divider(
              color: Color(0xffFF0808),
              thickness: 3,
            ),
          ),
        ],
      ),
    );
  }
}
