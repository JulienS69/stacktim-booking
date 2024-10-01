import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/logic/models/time_slot/time_slot.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';
import 'package:stacktim_booking/widget/x_bouncing_button.dart';
import 'package:stacktim_booking/widget/x_dropdown_simple.dart';

class TimeSlotWidget extends StatelessWidget {
  const TimeSlotWidget({
    super.key,
    required this.controller,
  });

  final DashboardViewController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: XBouncingButton(
        onPressed: () {},
        child: SizedBox(
          width: Get.width,
          child: XDropDownSimple<TimeSlot>(
            value: controller.currentTimeSlotSelected.value,
            color: Colors.black,
            borderColor: Colors.white,
            items: List.generate(
              controller.timeSlotList.length,
              (index) => DropdownMenuItem(
                value: controller.timeSlotList[index],
                child: Text(
                  controller.timeSlotList[index].name ?? "",
                  style: antaStyle.copyWith(fontSize: 15),
                ),
              ),
            ),
            onChanged: (timeSlotSelected) async {
              controller.currentTimeSlotSelected.value = timeSlotSelected;
              if (controller.gameSelected.value.id != null &&
                  controller.currentTimeSlotSelected.value.name != 'Choisir') {
                await controller.checkAvailbilityComputer();
              }
            },
          ),
        ),
      ),
    );
  }
}
