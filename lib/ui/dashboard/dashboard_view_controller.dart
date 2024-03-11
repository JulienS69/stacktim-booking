import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/local_storage.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/logic/status/status.dart';
import 'package:stacktim_booking/logic/user/user.dart';
import 'package:stacktim_booking/widget/x_chip.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class DashboardViewController extends GetxController with StateMixin {
  List<Status> statusList = const [
    Status(id: 0, statusName: "inProgress"),
    Status(id: 1, statusName: "Passed"),
    Status(id: 2, statusName: "inComming"),
  ];
  List<TargetFocus> tutorialList = [];

  RxBool isNotFree = false.obs;

  User currentUser = const User(firstname: "Julien", pseudo: "Virtuor");
  RxBool isShowingDatePicker = false.obs;
  RxBool isDatePicked = false.obs;
  RxBool isShowLoading = false.obs;
  RxBool isShowTutorial = false.obs;

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

  //KEY FOR TUTORIAL
  final fabButtonKey = GlobalKey<FormState>(debugLabel: 'fabButtonKey');
  final dashboardButtonKey =
      GlobalKey<FormState>(debugLabel: 'dashboardButtonKey');
  final calendardButtonKey =
      GlobalKey<FormState>(debugLabel: 'calendardButtonKey');
  final profilButtonKey = GlobalKey<FormState>(debugLabel: 'profilButtonKey');
  final stackCreditButtonKey =
      GlobalKey<FormState>(debugLabel: 'stackCreditButtonKey');

  DashboardViewController();

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    try {
      await getDataTutorial();
      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error());
    }
    super.onInit();
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
        okStyle: const TextStyle(fontFamily: "Anta", color: Colors.white60),
        hourLabel: 'Heures',
        iosStylePicker: true,
        cancelStyle: const TextStyle(
          fontFamily: "Anta",
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

  //SECTION TUTORIAL
  void showTutorial(BuildContext context, List<TargetFocus> targets) {
    TutorialCoachMark(
      targets: targets,
      colorShadow: const Color.fromARGB(255, 22, 22, 22),
      paddingFocus: 0,
      hideSkip: false,
      alignSkip: AlignmentDirectional.topStart,
      textSkip: 'Passer le tutoriel',
      textStyleSkip: const TextStyle(decoration: TextDecoration.underline),
      onFinish: () async {
        await closeTutorial();
      },
    ).show(context: context);
  }

  void showTutorialOnDashboard(context) async {
    if (tutorialList.isNotEmpty && isShowTutorial.value == true) {
      showTutorial(context, tutorialList);
    }
  }

  Future<void> getDataTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? getTutoBool = prefs.getBool(LocalStorageKeyEnum.isShowTutorial.name);
    if (getTutoBool == null || getTutoBool == true) {
      fillTutorialList();
      isShowTutorial.value = true;
    }
  }

  Future<void> closeTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isShowTutorial.value = false;
    await prefs.setBool(LocalStorageKeyEnum.isShowTutorial.name, false);
  }

  fillTutorialList() {
    //FAB
    tutorialList.add(
      TargetFocus(
        identify: "FAB",
        keyTarget: fabButtonKey,
        enableOverlayTab: true,
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              child: const Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Prend ta réservation ici',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    overflow: TextOverflow.clip,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ))
        ],
      ),
    );
    //STACKCREDITS
    tutorialList.add(
      TargetFocus(
        identify: "Stack Crédit",
        keyTarget: stackCreditButtonKey,
        enableOverlayTab: true,
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    coinLogo,
                    height: 50,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "Stack Crédits",
                style: titleText1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Retrouve ton nombre de crédits restant',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  overflow: TextOverflow.clip,
                  color: Colors.white,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
