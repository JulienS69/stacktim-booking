import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/strings.dart';
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
                  style: arvoStyle,
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
                          style: arvoStyle.copyWith(
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
              ? SfDateRangePicker(
                  controller: controller.dateController,
                  selectionMode: DateRangePickerSelectionMode.single,
                  monthViewSettings: const DateRangePickerMonthViewSettings(
                    weekendDays: [
                      DateTime.sunday,
                      DateTime.saturday,
                    ],
                  ),
                  monthCellStyle: const DateRangePickerMonthCellStyle(
                    weekendTextStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  selectionColor: Colors.red,
                  selectionTextStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  onSelectionChanged: (date) async {
                    await controller.checkDateAvalaible(
                      datePicked: date.value,
                      context: context,
                      pageIndexNotifier: pageIndexNotifier,
                    );
                  },
                  showNavigationArrow: true,
                )
              : const SizedBox.shrink(),
        ),
        Visibility(
          visible: !controller.isDatePicked.value,
          child: const SizedBox(
            height: 25,
          ),
        ),
        Obx(
          () => SizedBox(
            height: 50,
            width: 200,
            child: controller.isShowLoading.value ||
                    !controller.isDatePicked.value
                ? ElevatedButton(
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
                      textStyle: MaterialStatePropertyAll(arvoStyle),
                    ),
                    child: !controller.isDatePicked.value &&
                            !controller.isShowLoading.value
                        ? const Text(
                            'Selectionner une date',
                            style: TextStyle(color: Colors.white),
                          )
                        : controller.isShowLoading.value
                            ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  const CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  ),
                                  Image.asset(
                                    logo,
                                    height: 15,
                                  )
                                ],
                              )
                            : const SizedBox.shrink(),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
