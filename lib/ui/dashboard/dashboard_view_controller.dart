import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  RxString dateSelected = "".obs;
  String hourSelected = "";
  String minutesSelected = "";
  RxString timeSelected = "".obs;
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
      showBeginningTimePicker(context);
    }
  }

  showBeginningTimePicker(BuildContext context) {
    Navigator.of(context).push(
      showPicker(
        context: context,
        value: Time.fromTimeOfDay(
            TimeOfDay(hour: TimeOfDay.now().hour, minute: 0), 0),
        sunrise: const TimeOfDay(hour: 6, minute: 0),
        sunset: const TimeOfDay(hour: 18, minute: 0),
        is24HrFormat: true,
        minuteInterval: TimePickerInterval.THIRTY,
        themeData: ThemeData.dark(),
        blurredBackground: true,
        duskSpanInMinutes: 120,
        okText: "Je confirme l'heure de début",
        okStyle: const TextStyle(fontFamily: "ArvoBold", color: Colors.green),
        hourLabel: 'Heures',
        iosStylePicker: true,
        cancelStyle: const TextStyle(
          fontFamily: "ArvoBold",
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
          hourSelected = time.hour.toString();
          if (time.minute.toString() == "59") {
            minutesSelected = "30";
          } else {
            minutesSelected = time.minute.toString();
          }
          timeSelected.value = time.format(Get.context!);
        },
      ),
    );
  }

  Color getColorsByStatusTag({
    required String statusTag,
  }) {
    if (statusTag == "inProgress") {
      return const Color(0xFF4fc3f7);
    } else if (statusTag == "Passed") {
      return const Color(0xFFFFEB3B);
    } else {
      return const Color(0xFFE53935);
    }
  }

  XChip getChipByStatusTag(String? tag) {
    switch (tag) {
      case "Passed":
        return XChip.chipStatus(
          label: "Passée".tr.capitalizeFirst!,
          chipColor: XChipColor.yellow,
        );
      case "inComming":
        return XChip.chipStatus(
          label: "A venir".tr.capitalizeFirst!,
          chipColor: XChipColor.red,
        );
      case "inProgress":
        return XChip.chipStatus(
          label: "En cours".tr.capitalizeFirst!,
          chipColor: XChipColor.blue,
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
        return XChipColor.yellow;
      case "inComming":
        return XChipColor.red;
      case "inProgress":
        return XChipColor.blue;

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
