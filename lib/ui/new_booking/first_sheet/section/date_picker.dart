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
                Text(
                  "Date choisie : ",
                  style: antaStyle.copyWith(fontSize: 15),
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
                            fontSize: 15,
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
                            const WidgetStatePropertyAll(Colors.transparent),
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
                    } else if (date.value.weekday == DateTime.friday) {
                      controller.isFriday.value = true;
                    } else {
                      controller.isFriday.value = false;
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
                      style: ButtonStyle(
                        backgroundColor:
                            const WidgetStatePropertyAll(Colors.black),
                        foregroundColor:
                            const WidgetStatePropertyAll(Colors.white),
                        textStyle: WidgetStatePropertyAll(
                          antaStyle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Sélectionner une date',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
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
