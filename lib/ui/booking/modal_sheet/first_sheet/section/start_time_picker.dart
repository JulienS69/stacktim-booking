import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';

class BookingBeginningTime extends StatelessWidget {
  final BuildContext modalSheetContext;
  final DashboardViewController controller;
  final ValueNotifier pageIndexNotifier;

  const BookingBeginningTime({
    super.key,
    required this.modalSheetContext,
    required this.controller,
    required this.pageIndexNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.timeSelected.isNotEmpty ||
              controller.dateSelected.isNotEmpty
          ? InkWell(
              onTap: () {
                controller.showTimePicker(
                    context: modalSheetContext,
                    isEndingTime: false,
                    pageIndexNotifier: pageIndexNotifier);
              },
              child: Row(
                children: [
                  const Text(
                    "Heure de début choisie : ",
                    style: arvoStyle,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                      controller.timeSelected.isEmpty
                          ? "Aucunes"
                          : "${controller.beginingHourSelected} heures"
                              "${controller.minutesSelected != "0" ? "et ${controller.minutesSelected} minutes" : ""}",
                      style: arvoStyle.copyWith(
                        color: controller.timeSelected.isEmpty
                            ? Colors.red
                            : Colors.white60,
                        decoration: TextDecoration.underline,
                      )),
                  const Spacer(),
                  const Icon(
                    Icons.schedule,
                    color: Colors.white,
                  )
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
