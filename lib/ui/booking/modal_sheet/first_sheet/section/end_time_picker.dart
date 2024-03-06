import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';

class BookingEndingTime extends StatelessWidget {
  BuildContext modalSheetContext;
  BookingEndingTime({
    super.key,
    required this.modalSheetContext,
    required this.controller,
  });

  DashboardViewController controller = DashboardViewController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.timeSelected.isNotEmpty
          ? InkWell(
              onTap: () {
                controller.showTimePicker(
                    context: modalSheetContext, isEndingTime: true);
              },
              child: Row(
                children: [
                  const Text(
                    "Heure de fin choisie : ",
                    style: arvoStyle,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                      controller.endingHourSelected.isEmpty
                          ? "Aucunes"
                          : "${controller.endingHourSelected.value} heures"
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
