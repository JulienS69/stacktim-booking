import 'dart:async';

import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/local_storage.dart';
import 'package:stacktim_booking/helper/snackbar.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/logic/models/booking/booking.dart';
import 'package:stacktim_booking/logic/models/computer/computer.dart';
import 'package:stacktim_booking/logic/models/status/status.dart';
import 'package:stacktim_booking/logic/models/user/user.dart';
import 'package:stacktim_booking/logic/repository/booking_repository.dart';
import 'package:stacktim_booking/logic/repository/status_repository.dart';
import 'package:stacktim_booking/logic/repository/user_repository.dart';
import 'package:stacktim_booking/ui/booking/new_booking_view.dart';
import 'package:stacktim_booking/widget/x_chip.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../logic/repository/computer_repository.dart';

class DashboardViewController extends GetxController with StateMixin {
  BookingRepository bookingRepository = BookingRepository();
  StatusRepository statusRepository = StatusRepository();
  UserRepository userRepository = UserRepository();
  ComputerRepository computerRepository = ComputerRepository();

  RxList<Status> statusList = <Status>[].obs;
  RxList<Booking> bookingList = <Booking>[].obs;
  RxList<Computer> computersList = <Computer>[].obs;
  User currentUser = const User();

  List<TargetFocus> tutorialList = [];

  RxBool isNotFree = false.obs;

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
  //DATE SELECTED
  RxString bookedAt = "".obs;
  RxString selectedDate = "".obs;
  RxString beginingHourSelected = "".obs;
  RxString endingHourSelected = "".obs;
  String minutesSelected = "";
  RxString startingtimeSelected = "".obs;
  RxString endingtimeSelected = "".obs;
  RxInt seatSelected = 0.obs;
  Rx<double> progressValue = 0.0.obs;
  Rx<bool> isConfirmed = false.obs;
  final pageIndexNotifier = ValueNotifier(0);

  //KEY FOR TUTORIAL
  final fabButtonKey = GlobalKey<FormState>(debugLabel: 'fabButtonKey');
  final dashboardButtonKey =
      GlobalKey<FormState>(debugLabel: 'dashboardButtonKey');
  final calendardButtonKey =
      GlobalKey<FormState>(debugLabel: 'calendardButtonKey');
  final profilButtonKey = GlobalKey<FormState>(debugLabel: 'profilButtonKey');
  final stackCreditButtonKey =
      GlobalKey<FormState>(debugLabel: 'stackCreditButtonKey');
  Booking currentBooking = const Booking();
  SharedPreferences? sharedPreferences;

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    sharedPreferences = await SharedPreferences.getInstance();
    await getDataTutorial();
    try {
      await getCurrentUser();
      // await getMyBookings();
      await getStatusList();
      await checkArgument();
      change(null, status: RxStatus.success());
    } catch (e) {
      Sentry.captureException(e);
      change(null, status: RxStatus.success());
    }
    super.onInit();
  }

  checkArgument() {
    if (Get.arguments != null) {
      if (Get.arguments['openSheet'] != null) {
        return NewBookingSheet(controller: this)
            .showModalSheet(Get.context!, pageIndexNotifier);
      }
    }
  }

  Future<void> getMyBookings() async {
    return await bookingRepository.getMyBookings().then(
          (value) => value.fold(
            (l) {},
            (r) {
              bookingList.value = r;
            },
          ),
        );
  }

  Future<void> getStatusList() async {
    return await statusRepository.getStatusList().then(
          (value) => value.fold(
            (l) {},
            (r) {
              statusList.value = r;
            },
          ),
        );
  }

  Future<void> getCurrentUser() async {
    return await userRepository.getCurrentUser().then(
          (value) => value.fold(
            (l) {},
            (r) {
              currentUser = r;
            },
          ),
        );
  }

  createBooking() async {
    currentBooking = currentBooking.copyWith(
      userId: currentUser.id,
      statusId: "9ba62f76-6e59-4b40-a014-bafa1f01121d",
      bookedAt: selectedDate.value,
      computerId: '9ba62f77-1ace-4d31-be28-a75de3e79c2a',
      title: titleSelected.value,
      endAt: endingtimeSelected.value,
      beginAt: startingtimeSelected.value,
      duration: 1,
    );

    return await bookingRepository
        .createBooking(currentBooking: currentBooking)
        .then(
          (value) => value.fold(
            (l) {
              //FIXME POUVOIR PUB GET AWESOME DIALOG
              // AwesomeDialog(
              //   context: Get.context!,
              //   dialogType: DialogType.error,
              //   dialogBackgroundColor: backgroundColor,
              //   animType: AnimType.rightSlide,
              //   title: 'Oups !',
              //   desc:
              //       "Quelque chose c'est mal passé pendant l'enregistrement de ta session",
              //   btnCancelText: 'Retour',
              //   btnCancelOnPress: () {},
              // ).show();
            },
            (r) async {
              await getMyBookings();
              bookingList.refresh();
              Get.back();
              clearForm();
              showSnackbar(
                  "Réservation prise avec succès !", SnackStatusEnum.success);
            },
          ),
        );
  }

  clearForm() {
    isNotFree.value = false;
    isShowingDatePicker.value = false;
    isDatePicked.value = false;
    isShowLoading.value = false;
    isShowTutorial.value = false;
    searchController.clear();
    titleController.clear();
    dateController = DateRangePickerController();
    titleSelected.value = "";
    bookedAt.value = "";
    selectedDate.value = "";
    beginingHourSelected.value = "";
    endingHourSelected.value = "";
    minutesSelected = "";
    startingtimeSelected.value = "";
    endingtimeSelected.value = "";
    seatSelected.value = 0;
    progressValue.value = 0.0;
    isConfirmed.value = false;
  }

  bool checkFormIsEmpty() {
    if (bookedAt.isNotEmpty || titleController.text.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void startIncrementing() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (progressValue.value < 100) {
        progressValue.value += 1;
      } else {
        timer.cancel();
        isConfirmed.value = true;
      }
    });
  }

  checkDateAvalaible({
    required DateTime datePicked,
    required BuildContext context,
    required ValueNotifier pageIndexNotifier,
  }) async {
    isShowLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isShowingDatePicker.value = false;
    isDatePicked.value = true;
    HapticFeedback.heavyImpact();
    // String formattedDate = DateFormat('yyyy-MM-dd').format(datePicked);
    selectedDate.value = DateFormat('yyyy-MM-dd').format(datePicked);
    bookedAt.value = DateFormat('EEEE d MMMM yyyy', 'fr_FR').format(datePicked);
    isShowLoading.value = false;
    if (startingtimeSelected.isEmpty) {
      showTimePicker(
          context: context,
          isEndingTime: false,
          pageIndexNotifier: pageIndexNotifier);
    }
  }

  showTimePicker({
    required BuildContext context,
    required bool isEndingTime,
    required ValueNotifier pageIndexNotifier,
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
        themeData: xMyTheme,
        backgroundColor: Colors.black,
        accentColor: Colors.white,
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
            startingtimeSelected.value = time.format(Get.context!);
          } else {
            endingtimeSelected.value = time.format(Get.context!);
            endingHourSelected.value = time.hour.toString();
            pageIndexNotifier.value = pageIndexNotifier.value + 1;
          }
        },
      ),
    );
  }

  Color getColorsByStatusTag({
    required String statusTag,
  }) {
    if (statusTag == StatusSlugs.inProgress) {
      return greenChip;
    } else if (statusTag == StatusSlugs.passee) {
      return redChip;
    } else {
      return blueChip;
    }
  }

  XChip getChipByStatusTag(String? tag) {
    switch (tag) {
      case StatusSlugs.passee:
        return XChip.chipStatus(
          label: "Passée".tr.capitalizeFirst!,
          chipColor: XChipColor.red,
        );
      case StatusSlugs.inComming:
        return XChip.chipStatus(
          label: "A venir".tr.capitalizeFirst!,
          chipColor: XChipColor.blue,
        );
      case StatusSlugs.inProgress:
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
      case StatusSlugs.passee:
        return XChipColor.red;
      case StatusSlugs.inComming:
        return XChipColor.blue;
      case StatusSlugs.inProgress:
        return XChipColor.green;

      default:
        return XChipColor.red;
    }
  }

  String getStringByStatusTag(String tag) {
    switch (tag) {
      case StatusSlugs.passee:
        return 'Passée';
      case StatusSlugs.inComming:
        return "A venir";
      case StatusSlugs.inProgress:
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
      skipWidget: const Text(
        "Passer le tutoriel",
        style: TextStyle(decoration: TextDecoration.underline),
      ),
      onSkip: () {
        if (sharedPreferences != null) {
          isShowTutorial.value = false;
          sharedPreferences?.setBool(
              LocalStorageKeyEnum.isShowTutorial.name, false);
        }
        return true;
      },
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
