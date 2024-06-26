import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/snackbar.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingDatePicker extends StatelessWidget {
  final ValueNotifier pageIndexNotifier;
  const BookingDatePicker({
    super.key,
    required this.controller,
    required this.pageIndexNotifier,
  });

  final DashboardViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Obx(() => Row(
              children: [
                const Text(
                  "Date choisie : ",
                  style: antaStyle,
                ),
                const SizedBox(
                  width: 5,
                ),
                controller.bookedAt.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          if (controller.isShowingDatePicker.value) {
                            controller.isShowingDatePicker.value = false;
                          } else {
                            controller.isShowingDatePicker.value = true;
                          }
                        },
                        child: Text(
                          controller.bookedAt.value.capitalizeFirst!,
                          style: antaStyle.copyWith(
                            color: Colors.white60,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                controller.bookedAt.isNotEmpty
                    ? const Spacer()
                    : const SizedBox.shrink(),
                controller.bookedAt.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          if (controller.isShowingDatePicker.value) {
                            controller.isShowingDatePicker.value = false;
                          } else {
                            controller.isShowingDatePicker.value = true;
                          }
                        },
                        overlayColor:
                            const MaterialStatePropertyAll(Colors.transparent),
                        child: const Icon(
                          Icons.date_range,
                          color: Colors.white,
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            )),
        Obx(
          () => controller.isShowingDatePicker.value
              ? const SizedBox(
                  height: 25,
                )
              : const SizedBox.shrink(),
        ),
        Obx(
          () => controller.isShowingDatePicker.value
              ? const Divider(
                  color: Colors.white,
                )
              : const SizedBox.shrink(),
        ),
        Obx(
          () => controller.isShowingDatePicker.value
              ? const SizedBox(
                  height: 15,
                )
              : const SizedBox.shrink(),
        ),
        Obx(
          () => controller.isShowingDatePicker.value
              ? SfDateRangePicker(
                  controller: controller.dateController,
                  backgroundColor: Colors.transparent,
                  headerStyle: const DateRangePickerHeaderStyle(
                      backgroundColor: Colors.transparent),
                  selectionMode: DateRangePickerSelectionMode.single,
                  monthViewSettings: DateRangePickerMonthViewSettings(
                    weekendDays: const [
                      DateTime.sunday,
                      DateTime.saturday,
                    ],
                    blackoutDates: controller.holidaysList,
                  ),
                  monthCellStyle: const DateRangePickerMonthCellStyle(
                    blackoutDateTextStyle: TextStyle(
                      color: Color.fromARGB(255, 83, 83, 83),
                    ),
                    weekendTextStyle: TextStyle(
                      color: Color.fromARGB(255, 83, 83, 83),
                    ),
                    disabledDatesTextStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Color.fromARGB(255, 83, 83, 83),
                    ),
                  ),
                  enablePastDates: false,
                  minDate: DateTime.now(),
                  selectionColor: Colors.red,
                  selectionTextStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  onSelectionChanged: (date) async {
                    // Check if date picked is in week-end
                    if (date.value.weekday == DateTime.saturday ||
                        date.value.weekday == DateTime.sunday) {
                      // Week-end, annuler la sélection
                      showSnackbar(
                          "Vous ne pouvez pas sélectionner une date le week-end.",
                          SnackStatusEnum.warning);

                      return;
                    }
                    // if picked date is ok, launch time picker
                    await controller.launchTimePicker(
                      datePicked: date.value,
                      context: context,
                      pageIndexNotifier: pageIndexNotifier,
                    );
                  },
                  showNavigationArrow: true,
                )
              : const SizedBox.shrink(),
        ),
        Obx(
          () => controller.isShowingDatePicker.value
              ? const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Divider(
                    color: Colors.white,
                  ))
              : const SizedBox.shrink(),
        ),
        Obx(
          () => !controller.isDatePicked.value
              ? Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.isShowingDatePicker.value) {
                          controller.isShowingDatePicker.value = false;
                        } else {
                          controller.isShowingDatePicker.value = true;
                        }
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.black),
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
                        textStyle: MaterialStatePropertyAll(antaStyle),
                      ),
                      child: const Text(
                        'Selectionner une date',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
