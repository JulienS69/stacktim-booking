import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';

class BookingEndingTime extends StatelessWidget {
  final BuildContext modalSheetContext;
  final DashboardViewController controller;
  final ValueNotifier pageIndexNotifier;

  const BookingEndingTime({
    super.key,
    required this.modalSheetContext,
    required this.controller,
    required this.pageIndexNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.startingtimeSelected.isNotEmpty
          ? InkWell(
              onTap: () {
                controller.showTimePicker(
                    context: modalSheetContext,
                    isEndingTime: true,
                    pageIndexNotifier: pageIndexNotifier);
              },
              child: Row(
                children: [
                  Text(
                    "Heure de fin choisie : ",
                    style: antaStyle.copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                        controller.endingHourSelected.isEmpty
                            ? "Aucunes"
                            : "${controller.endingHourSelected.value} h "
                                "${controller.endingMinutesSelected != "0" ? controller.endingMinutesSelected : ""}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: antaStyle.copyWith(
                          fontSize: 16,
                          color: controller.endingHourSelected.isEmpty
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
