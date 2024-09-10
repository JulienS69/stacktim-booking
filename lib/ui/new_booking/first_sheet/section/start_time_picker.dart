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
      () => controller.startingtimeSelected.isNotEmpty ||
              controller.bookedAt.isNotEmpty
          ? InkWell(
              onTap: () {
                controller.showTimePicker(
                    context: modalSheetContext,
                    isEndingTime: false,
                    pageIndexNotifier: pageIndexNotifier);
              },
              child: Row(
                children: [
                  Text(
                    "Heure de début choisie : ",
                    style: antaStyle.copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                        controller.startingtimeSelected.isEmpty
                            ? "Aucunes"
                            : "${controller.beginingHourSelected} h "
                                "${controller.startingMinutesSelected != "0" ? controller.startingMinutesSelected : ""}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: antaStyle.copyWith(
                          fontSize: 16,
                          color: controller.startingtimeSelected.isEmpty
                              ? Colors.red
                              : Colors.white60,
                          decoration: TextDecoration.underline,
                        )),
                  ),
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
