import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/logic/status/status.dart';
import 'package:stacktim_booking/logic/user/user.dart';
import 'package:stacktim_booking/widget/x_chip.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DashboardViewController extends GetxController with StateMixin {
  List<Status> statusList = const [
    Status(id: 0, statusName: "inProgress"),
    Status(id: 1, statusName: "Passed"),
    Status(id: 2, statusName: "inComming"),
  ];

  RxBool isNotFree = false.obs;

  User currentUser = const User(firstname: "Julien", pseudo: "Virtuor");
  RxBool isShowingDatePicker = false.obs;
  RxBool isDatePicked = false.obs;
  RxBool isShowLoading = false.obs;
  TextEditingController searchController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  FixedExtentScrollController fixedScrollController =
      FixedExtentScrollController();

  DateRangePickerController? dateController = DateRangePickerController();
  RxString titleSelected = "".obs;
  RxString dateSelected = "".obs;
  RxString beginingHourSelected = "".obs;
  RxString endingHourSelected = "".obs;
  String minutesSelected = "";
  RxString timeSelected = "".obs;
  RxInt seatSelected = 0.obs;
  DashboardViewController();

  @override
  Future<void> onReady() async {
    change(null, status: RxStatus.loading());
    change(null, status: RxStatus.success());
    super.onReady();
  }

  bool checkFormIsEmpty() {
    if (dateSelected.isNotEmpty || titleController.text.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }

  checkDateAvalaible(DateTime datePicked, BuildContext context) async {
    isShowLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isShowingDatePicker.value = false;
    isDatePicked.value = true;
    HapticFeedback.heavyImpact();
    dateSelected.value =
        DateFormat('EEEE d MMMM yyyy', 'fr_FR').format(datePicked);
    isShowLoading.value = false;
    if (timeSelected.isEmpty) {
      showTimePicker(context: context, isEndingTime: false);
    }
  }

  showTimePicker({
    required BuildContext context,
    required bool isEndingTime,
  }) {
    Navigator.of(context).push(
      showPicker(
        context: context,
        dialogInsetPadding: const EdgeInsets.all(5),
        value: Time.fromTimeOfDay(
            TimeOfDay(
                hour: beginingHourSelected.isNotEmpty
                    ? int.parse(beginingHourSelected.value)
                    : endingHourSelected.value.isNotEmpty
                        ? int.parse(endingHourSelected.value)
                        : TimeOfDay.now().hour,
                minute: minutesSelected == "30" ? 30 : 0),
            0),
        sunrise: const TimeOfDay(hour: 6, minute: 0),
        sunset: const TimeOfDay(hour: 18, minute: 0),
        is24HrFormat: true,
        minuteInterval: TimePickerInterval.THIRTY,
        themeData: ThemeData.dark(),
        blurredBackground: true,
        duskSpanInMinutes: 120,
        disableMinute: isEndingTime ? true : false,
        disableAutoFocusToNextInput: isEndingTime ? true : false,
        okText: isEndingTime
            ? "Je confirme l'heure de fin"
            : "Je confirme l'heure de début",
        okStyle: const TextStyle(fontFamily: "ArvoBold", color: Colors.white60),
        hourLabel: 'Heures',
        iosStylePicker: true,
        cancelStyle: const TextStyle(
          fontFamily: "ArvoBold",
          color: Colors.red,
        ),
        cancelText: 'Retour',
        isOnChangeValueMode: false,
        onChangeDateTime: (time) {
          HapticFeedback.heavyImpact();
        },
        onCancel: () {
          Navigator.pop(context);
          HapticFeedback.heavyImpact();
        },
        onChange: (time) {
          HapticFeedback.vibrate();
          if (!isEndingTime) {
            beginingHourSelected.value = time.hour.toString();
            if (time.minute.toString() == "59") {
              minutesSelected = "30";
            } else {
              minutesSelected = time.minute.toString();
            }
            timeSelected.value = time.format(Get.context!);
          } else {
            endingHourSelected.value = time.hour.toString();
          }
        },
      ),
    );
  }

  Color getColorsByStatusTag({
    required String statusTag,
  }) {
    if (statusTag == "inProgress") {
      return greenChip;
    } else if (statusTag == "Passed") {
      return redChip;
    } else {
      return blueChip;
    }
  }

  XChip getChipByStatusTag(String? tag) {
    switch (tag) {
      case "Passed":
        return XChip.chipStatus(
          label: "Passée".tr.capitalizeFirst!,
          chipColor: XChipColor.red,
        );
      case "inComming":
        return XChip.chipStatus(
          label: "A venir".tr.capitalizeFirst!,
          chipColor: XChipColor.blue,
        );
      case "inProgress":
        return XChip.chipStatus(
          label: "En cours".tr.capitalizeFirst!,
          chipColor: XChipColor.green,
        );
      default:
        return XChip.chipStatus(
          label: "Aucun status".tr.capitalizeFirst!,
          chipColor: XChipColor.red,
        );
    }
  }

  XChipColor getColorChipByStatusTag(String tag) {
    switch (tag) {
      case "Passed":
        return XChipColor.red;
      case "inComming":
        return XChipColor.blue;
      case "inProgress":
        return XChipColor.green;

      default:
        return XChipColor.red;
    }
  }

  String getStringByStatusTag(String tag) {
    switch (tag) {
      case "Passed":
        return 'Passée';
      case "inComming":
        return 'A venir';
      case "inProgress":
        return 'En cours';

      default:
        return '';
    }
  }

  checkIsFree(String date) {
    if (date == "2024-02-01 00:00:00.000") {
      isNotFree.value = true;
    } else {
      isNotFree.value = false;
    }
  }
}
