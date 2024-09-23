import 'dart:async';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/connection_helper.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/icons.dart';
import 'package:stacktim_booking/helper/local_storage.dart';
import 'package:stacktim_booking/helper/snackbar.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/logic/models/booking/booking.dart';
import 'package:stacktim_booking/logic/models/computer/computer.dart';
import 'package:stacktim_booking/logic/models/game/game.dart';
import 'package:stacktim_booking/logic/models/status/status.dart';
import 'package:stacktim_booking/logic/models/user/user.dart';
import 'package:stacktim_booking/logic/repository/booking_repository.dart';
import 'package:stacktim_booking/logic/repository/game_repository.dart';
import 'package:stacktim_booking/logic/repository/holliday_repository.dart';
import 'package:stacktim_booking/logic/repository/status_repository.dart';
import 'package:stacktim_booking/logic/repository/user_repository.dart';
import 'package:stacktim_booking/ui/new_booking/new_booking_view.dart';
import 'package:stacktim_booking/widget/x_booking_card.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../logic/repository/computer_repository.dart';

class DashboardViewController extends GetxController
    with StateMixin, GetSingleTickerProviderStateMixin {
  //REPOSTIORY
  BookingRepository bookingRepository = BookingRepository();
  StatusRepository statusRepository = StatusRepository();
  UserRepository userRepository = UserRepository();
  ComputerRepository computerRepository = ComputerRepository();
  HolidayRepository holidayRepository = HolidayRepository();
  GameRepository gameRepository = GameRepository();
  //LIST
  RxList<Status> statusList = <Status>[].obs;
  RxList<Booking> bookingList = <Booking>[].obs;
  RxList<Booking> filteredBookingList = <Booking>[].obs;
  RxList<Computer> computersList = <Computer>[].obs;
  RxList<Game> gameList = <Game>[].obs;
  List<TargetFocus> tutorialList = [];
  List<DateTime>? holidaysList;
  //OBJECT
  User currentUser = const User();
  Booking bookingInProgress = const Booking();
  Booking currentBooking = const Booking();
  //BOOL
  RxBool isNotFree = false.obs;
  RxBool isShowingDatePicker = false.obs;
  RxBool isDatePicked = false.obs;
  RxBool isShowLoading = false.obs;
  RxBool isShowTutorial = false.obs;
  RxBool isInProgress = false.obs;
  Rx<double> progressValue = 0.0.obs;
  RxBool isConfirmed = false.obs;
  bool isCheckInTime = false;
  RxBool isExpanded = false.obs;

  //STRING
  RxString titleSelected = "".obs;
  RxString bookedAt = "".obs;
  RxString selectedDate = "".obs;
  RxString beginingHourSelected = "".obs;
  RxString endingHourSelected = "".obs;
  String startingMinutesSelected = "";
  String endingMinutesSelected = "";
  RxString startingtimeSelected = "".obs;
  RxString endingtimeSelected = "".obs;
  String computerUuidSelected = "";
  String statusIdSelected = '';
  String bookingIdToChecking = '';
  //INT
  RxInt computerSelected = 0.obs;
  RxInt userCreditAvailable = 0.obs;
  int durationHours = 1;
  int creditAvailable = 0;
  //TEXT EDITING CONTROLLER
  TextEditingController searchController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  FixedExtentScrollController fixedScrollController =
      FixedExtentScrollController();
  //KEY FOR TUTORIAL
  final fabButtonKey = GlobalKey<FormState>(debugLabel: 'fabButtonKey');
  final dashboardButtonKey =
      GlobalKey<FormState>(debugLabel: 'dashboardButtonKey');
  final stackCreditButtonKey =
      GlobalKey<FormState>(debugLabel: 'stackCreditButtonKey');
  //OTHER
  DateRangePickerController? dateController = DateRangePickerController();
  final pageIndexNotifier = ValueNotifier(0);
  SharedPreferences? sharedPreferences;
  late AnimationController controller;
  Rx<File> imageFile = File("").obs;
  RxString attachmentPath = "".obs;
  RxString attachmentName = "".obs;
  RxString imageName = ''.obs;
  Rx<Game> gameSelected = const Game().obs;

//This allows checking if the request to create a reservation has been made from another page.
  checkArgument() {
    if (Get.arguments != null) {
      if (Get.arguments['openSheet'] != null) {
        checkCreditBeforeCreateBooking();
      }
      if (Get.arguments['datePickedFromCalendar'] != null) {
        dateController?.selectedDate =
            Get.arguments['datePickedFromCalendar'] ?? DateTime.now();
        isDatePicked.value = true;
        isShowingDatePicker.value = false;
        selectedDate.value = DateFormat('yyyy-MM-dd')
            .format(dateController?.selectedDate ?? DateTime.now());
        bookedAt.value = DateFormat('EEEE d MMMM yyyy', 'fr_FR')
            .format(dateController?.selectedDate ?? DateTime.now());
      }
    }
  }

  Future<void> fetchHolidays() async {
    try {
      final holidays = await holidayRepository.fetchFrenchHolidays(2024);
      holidaysList = holidays
          .map((holiday) => DateTime.parse(holiday.dateHoliday ?? ""))
          .toList();
    } catch (e) {
      Sentry.captureMessage(
          "Impossible de récupérer les jours fériés. - DashBoardViewController");
      await Sentry.captureException(e);
    }
  }

  isActionFromCalendar() {
    if (Get.arguments != null) {
      if (Get.arguments['datePickedFromCalendar'] != null) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

//This allows checking the remaining number of credits before being able to recreate a session.
  checkCreditBeforeCreateBooking() async {
    if (await ConnectionHelper.hasNoConnection()) {
      showSnackbar(
          "Impossible de réserver une séance, aucune connexion internet n'a été trouvée",
          SnackStatusEnum.error);
    } else if (userCreditAvailable.value != 0) {
      if (!isActionFromCalendar()) {
        isDatePicked.value = true;
        isShowingDatePicker.value = false;
        selectedDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
        bookedAt.value =
            DateFormat('EEEE d MMMM yyyy', 'fr_FR').format(DateTime.now());
      }
      NewBookingSheet(controller: this)
          .showModalSheet(Get.context!, pageIndexNotifier);
    } else {
      showSnackbar(
          "Impossible de réserver une séance, tu n'as plus assez de crédits",
          SnackStatusEnum.error);
    }
  }

//This allows retrieving the list of user boooking.
  Future<void> getMyBookings() async {
    return await bookingRepository.getMyBookings().then(
          (value) => value.fold(
            (l) async {
              await Sentry.captureException(l);
            },
            (r) {
              //If a reservation has the status 'in progress', we need to move it to the top of the list and
              //set a boolean to 'true' to adjust the display.
              bookingList.value = r;
              isInProgress.value = false;
              // Liste temporaire pour stocker les réservations en cours
              List<Booking> inProgressBookings = [];
              for (var booking in bookingList) {
                if (booking.status?.slug == StatusSlugs.inProgress) {
                  inProgressBookings.add(booking);
                  isInProgress.value = true;
                }
                // FOR SHOWING DIALOG TO TAKING A PICTURE FOR CHECKIN
                if (booking.status?.slug == StatusSlugs.inProgress &&
                        booking.isCheckinComplete != true ||
                    booking.status?.slug == StatusSlugs.passee &&
                        booking.isCheckinComplete != true) {
                  isCheckInTime = true;
                  bookingIdToChecking = booking.id ?? "";
                }
              }
              // Supprimer les réservations en cours de la liste principale
              bookingList.removeWhere(
                  (booking) => booking.status?.slug == StatusSlugs.inProgress);
              // Insérer les réservations en cours au début de la liste principale
              bookingList.insertAll(0, inProgressBookings);
            },
          ),
        );
  }

//This allows retrieving the list of statuses.
  Future<void> getStatusList() async {
    return await statusRepository.getStatusList().then(
          (value) => value.fold(
            (l) async {
              await Sentry.captureException(l);
            },
            (r) {
              statusList.value = r;
              for (var status in statusList) {
                if (status.slug == StatusSlugs.inComming) {
                  statusIdSelected = status.id ?? "";
                }
              }
            },
          ),
        );
  }

//This allows retrieving the logged-in user.
  Future<void> getCurrentUser() async {
    return await userRepository.getCurrentUser().then(
          (value) => value.fold(
            (l) async {
              await Sentry.captureException(l);
            },
            (r) {
              if (r.credit != null) {
                userCreditAvailable.value = 0;
                userCreditAvailable.value = (r.credit!.creditAvailable ?? 0) -
                    (r.credit!.notYetUsed ?? 0);
              }
              currentUser = r;
            },
          ),
        );
  }

//This allows checking if all computers are not taken by other players and retrieving the list of available computers.
  Future<void> checkAvailbilityComputer() async {
    isShowLoading.value = true;
    return await computerRepository
        .checkComputerAvailable(
          beginHourPicked: startingtimeSelected.value,
          datePicked: selectedDate.value,
          endHourPicked: endingtimeSelected.value,
        )
        .then(
          (value) => value.fold(
            (l) async {
              await Sentry.captureException(l);
              //TODO A TESTER CE CAS
              showSnackbar('Plus de places disponible à cette date',
                  SnackStatusEnum.error);
              isShowLoading.value = false;
            },
            (r) {
              pageIndexNotifier.value = pageIndexNotifier.value + 1;
              computersList.value = r;
              isShowLoading.value = false;
            },
          ),
        );
  }

//This allows creating the reservation.
  createBooking() async {
    HapticFeedback.vibrate();
    currentBooking = currentBooking.copyWith(
      userId: currentUser.id,
      statusId: statusIdSelected,
      bookedAt: selectedDate.value,
      computerId: computerUuidSelected,
      title: titleSelected.value,
      endAt: endingtimeSelected.value,
      beginAt: startingtimeSelected.value,
      duration: durationHours,
      gameId: gameSelected.value.id,
    );
    return await bookingRepository
        .createBooking(currentBooking: currentBooking)
        .then(
          (value) => value.fold(
            (l) async {
              await Sentry.captureException(l);
              AwesomeDialog(
                context: Get.context!,
                dialogType: DialogType.error,
                dialogBackgroundColor: backgroundColor,
                animType: AnimType.rightSlide,
                title: 'Oups !',
                //TODO CHECK WITH BACK IF MESSAGE STATUS CHANGE
                desc: l ==
                        "Vous avez déjà une réservation qui se chevauche sur ce créneau."
                    ? "Tu ne peux pas réserver deux fois le même jour pour le même créneau"
                    : "Quelque chose c'est mal passé pendant l'enregistrement de ta session",
                btnCancelText: 'Retour',
                btnCancelOnPress: () {},
              ).show();
            },
            (r) async {
              getCurrentUser();
              getMyBookings();
              // No await in getMyBookings() because 6 seconds duration of dialog after that
              await showSuccesDialog();
              bookingList.refresh();
              Get.back();
              clearForm();
              showSnackbar(
                  "Réservation prise avec succès !", SnackStatusEnum.success);
            },
          ),
        );
  }

//This allows clearing all variables."
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
    startingMinutesSelected = "";
    endingMinutesSelected = "";
    startingtimeSelected.value = "";
    endingtimeSelected.value = "";
    computerSelected.value = 0;
    progressValue.value = 0.0;
    isConfirmed.value = false;
    gameSelected.value = const Game();
    isExpanded.value = false;
    pageIndexNotifier.value = pageIndexNotifier.value - 3;
  }

  bool checkFormIsEmpty() {
    if (bookedAt.isNotEmpty ||
        titleController.text.isNotEmpty ||
        gameSelected.value.id != null) {
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

  launchTimePicker({
    required DateTime datePicked,
    required BuildContext context,
    required ValueNotifier pageIndexNotifier,
  }) async {
    HapticFeedback.heavyImpact();
    isDatePicked.value = true;
    isShowingDatePicker.value = false;
    selectedDate.value = DateFormat('yyyy-MM-dd').format(datePicked);
    bookedAt.value = DateFormat('EEEE d MMMM yyyy', 'fr_FR').format(datePicked);

    if (startingtimeSelected.isEmpty) {
      showTimePicker(
          context: context,
          isEndingTime: false,
          pageIndexNotifier: pageIndexNotifier);
    }
  }

  bool isAfternoon() {
    DateTime now = DateTime.now();
    int currentHour = now.hour;
    // Get today's date in yyyy-MM-dd format
    DateTime today = DateTime(now.year, now.month, now.day);
    // Convert the selected date to DateTime format
    DateTime selectedDateTime = DateTime.parse(selectedDate.value.toString());
    // Compare if the selected date is today and if the current hour is after 1 PM (13:00)
    if (selectedDateTime.isAtSameMomentAs(today) && currentHour > 13) {
      return true;
    }
    // If the selected date is not today or if the current hour is before 1 PM (13:00), return false
    return false;
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
              hour: beginingHourSelected.isNotEmpty && !isEndingTime
                  ? int.parse(beginingHourSelected.value)
                  : endingHourSelected.value.isNotEmpty
                      ? int.parse(endingHourSelected.value)
                      : beginingHourSelected.isNotEmpty
                          ? int.parse(beginingHourSelected.value) + 1
                          : TimeOfDay.now().hour,
              minute: startingMinutesSelected == "30" ? 30 : 0,
            ),
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
        minHour: isAfternoon() ? 17 : 7,
        maxHour: 21,
        maxMinute: 30,
        onChange: (time) async {
          HapticFeedback.vibrate();
          if (!isEndingTime) {
            // Vérifier si l'heure est dans les créneaux horaires valides
            if ((time.hour >= 7 && time.hour <= 13 && time.minute != 59) ||
                (time.hour >= 17 && time.hour <= 21 && time.minute != 59)) {
              beginingHourSelected.value = time.hour.toString();
              startingMinutesSelected = time.minute.toString();
              Time beginHourSelect = Time(hour: time.hour, minute: time.minute);
              startingtimeSelected.value = beginHourSelect.format(Get.context!);
              if (startingMinutesSelected != "0") {
                DateFormat format = DateFormat('HH:mm');
                DateTime parsedDateTime =
                    format.parse(endingtimeSelected.value);
                Time updatedEndedTime =
                    Time(hour: parsedDateTime.hour, minute: time.minute);
                endingtimeSelected.value =
                    updatedEndedTime.format(Get.context!);
              }
            } else {
              showSnackbar(
                  "Impossible de choisir une heure en dehors des horaires définis - 7h-13h30 / 17h-21h",
                  SnackStatusEnum.error);
            }
          } else {
            // Vérifier si l'heure est dans les créneaux horaires valides
            if ((time.hour >= 7 && time.hour <= 13 && time.minute != 59) ||
                (time.hour >= 17 && time.hour <= 21 && time.minute != 59)) {
              DateFormat format = DateFormat('HH:mm');
              DateTime parsedDateTime =
                  format.parse(startingtimeSelected.value);
              Time beginHourSelect = Time(
                  hour: parsedDateTime.hour, minute: parsedDateTime.minute);

              Time endHourSelect = Time(hour: time.hour, minute: time.minute);
              if (endHourSelect.hour < beginHourSelect.hour) {
                showSnackbar(
                    "Ton heure de fin est inférieur à l'heure de début choisie",
                    SnackStatusEnum.error);
              } else if (beginHourSelect.hour == endHourSelect.hour) {
                showSnackbar(
                    "Les heures choisies ne peuvent pas être les mêmes",
                    SnackStatusEnum.error);
              } else {
                endingHourSelected.value = time.hour.toString();
                endingMinutesSelected = time.minute.toString();
                Time endedTime = Time(hour: time.hour, minute: time.minute);
                endingtimeSelected.value = endedTime.format(Get.context!);
                if (selectedDate.value.isNotEmpty &&
                    startingtimeSelected.value.isNotEmpty &&
                    gameSelected.value.id != null) {
                  await checkAvailbilityComputer();
                }
              }
            } else {
              showSnackbar(
                  "Impossible de choisir une heure en dehors des horaires définis - 12h-13h30 / 17h-21h",
                  SnackStatusEnum.error);
            }
          }
        },
      ),
    );
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
          skipTutorial(sharedPreferences);
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
    bool getTutoBool = false;
    if (!isSkippedTutorial(sharedPreferences)) {
      getTutoBool =
          sharedPreferences?.getBool(LocalStorageKeyEnum.isShowTutorial.name) ??
              true;
    }
    if (getTutoBool != false) {
      fillTutorialList();
      isShowTutorial.value = true;
    }
  }

  Future<void> closeTutorial() async {
    isShowTutorial.value = false;
    await sharedPreferences?.setBool(
        LocalStorageKeyEnum.isShowTutorial.name, false);
  }

  fillTutorialList() {
    tutorialList.add(
      TargetFocus(
        identify: "Dashboard",
        enableOverlayTab: true,
        keyTarget: dashboardButtonKey,
        shape: ShapeLightFocus.RRect,
        color: Colors.transparent,
        contents: [
          TargetContent(
              align: ContentAlign.custom,
              customPosition: CustomTargetContentPosition(top: 300),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        dashboardIcon,
                        size: 40,
                        color: Colors.white,
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Bienvenue dans le Dashboard !",
                    style: titleText1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Découvre toutes tes sessions de jeu sur cette page !",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.clip,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ))
        ],
      ),
    );

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
        color: Colors.transparent,
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
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "Consulte ton solde de stack crédits restants. Chaque semaine, tu recevras 2 stack crédits qui te permettront de réserver tes sessions, non cumulables et réinitialisés chaque semaine.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        overflow: TextOverflow.clip,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }

  Future showSuccesDialog() async {
    await showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(
          const Duration(seconds: 2, milliseconds: 800),
          () async {
            HapticFeedback.vibrate();
            Navigator.of(context).pop();
          },
        );
        return Dialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset(
                  gamingCheck,
                  fit: BoxFit.fill,
                  height: 150,
                  controller: controller,
                  repeat: false,
                  frameRate: FrameRate.max,
                  onLoaded: (composition) {
                    controller
                      ..duration = const Duration(seconds: 3)
                      ..repeat();
                  },
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Chaud devant ! 🔥 \nOn contacte notre serveur...',
                          //Ta session sera traitée dans un instant !
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void searchBooking(String title) {
    if (title.isEmpty) {
      filteredBookingList.assignAll(bookingList);
    } else {
      filteredBookingList.assignAll(
        bookingList.where((booking) {
          final bookingTitle = booking.title?.toLowerCase();
          final gameLabel = booking.game?.label?.toLowerCase();

          return (bookingTitle != null &&
                  bookingTitle.contains(title.toLowerCase())) ||
              (gameLabel != null && gameLabel.contains(title.toLowerCase()));
        }),
      );
    }
  }

// Retrieve the correct text based on the time of day.
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 18 || hour < 6) {
      return 'Bonsoir';
    } else {
      return 'Bonjour';
    }
  }

  void scrollToBottom(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(
        context,
        alignment: 1.0,
        duration: const Duration(milliseconds: 500),
      );
    });
  }

  void scrollToTop(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(
        context,
        alignment: 0.0,
        duration: const Duration(milliseconds: 500),
      );
    });
  }

//FOR CHEKING & CHECKOUT BOOKING
  Future<void> checkBooking() async {
    return await bookingRepository
        .updateBooking(
          currentBookingId: bookingIdToChecking,
          isChecking: isCheckInTime,
          pictureFile: imageFile.value,
          attachmentName: attachmentName.value,
        )
        .then(
          (value) => value.fold(
            (l) async {
              await Sentry.captureException(l);
              AwesomeDialog(
                context: Get.context!,
                dialogType: DialogType.error,
                dialogBackgroundColor: backgroundColor,
                animType: AnimType.rightSlide,
                title: 'Oups !',
                desc:
                    "Quelque chose c'est mal passé pendant l'enregistrement de ta photo",
                btnCancelText: 'Retour',
                btnCancelOnPress: () {},
              ).show();
            },
            (r) async {
              isCheckInTime = false;
              bookingIdToChecking = "";
              if (isCheckInTime == false && isInProgress.value) {
                showSnackbar(
                    "Ta photo a bien été transmise. Tu n'as plus qu'à attendre que l'horaire de fin de ta session soit passé pour que ce bouton disparaisse.",
                    SnackStatusEnum.success);
              } else {
                showSnackbar(
                    "Ta photo a bien été transmise !", SnackStatusEnum.success);
              }
              await getMyBookings();
              Get.back();
              bookingList.refresh();
            },
          ),
        );
  }

  Future<void> takePictureForCheck() async {
    // LAUNCH CAMERA PICKER
    final ImagePicker picker = ImagePicker();
    XFile? result = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    if (result != null) {
      int sizeInBytes = File(result.path).lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb < 10) {
        // File size is within the limit
        imageFile.value = File(result.path);
        imageFile.value = await compressFile(imageFile.value);
        attachmentName.value = getReceiptName(imageFile.value);
        await checkBooking();
      } else {
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          dialogBackgroundColor: backgroundColor,
          animType: AnimType.rightSlide,
          title: 'Oups !',
          desc: "Ta photo est supérieur à 10mo (${sizeInMb.round()} Mo)",
          btnCancelText: 'Retour',
          btnCancelOnPress: () {},
        ).show();
      }
    }
  }

  // Compresse le document scanné sinon erreur de l'api
  Future<File> compressFile(File file) async {
    var temporaryDirectory = await getTemporaryDirectory();
    String fileName = "${file.path.split('/').last}.jpg";
    String path = "${temporaryDirectory.path}/$fileName";
    final File compressedFile = File(path);
    await FlutterImageCompress.compressAndGetFile(
      file.path,
      compressedFile.path,
      quality: 50,
    );

    return compressedFile;
  }

  String getReceiptName(File imageFile) {
    if (isCheckInTime) {
      imageName.value = 'checkin.${getFileExtension(imageFile.path)}';
      return imageName.value;
    } else {
      imageName.value = 'checkout.${getFileExtension(imageFile.path)}';
      return imageName.value;
    }
  }

  String getFileExtension(String filePath) {
    int lastIndex = filePath.lastIndexOf('.');
    // Utilisation de la classe Path pour extraire l'extension
    if (lastIndex != -1 && lastIndex < filePath.length - 1) {
      // Récupérer l'extension en utilisant la sous-chaîne
      String extension = filePath.substring(lastIndex + 1);
      return extension;
    } else {
      // Aucune extension trouvée
      return '';
    }
  }

  Future<void> getGameList() async {
    return await gameRepository.getGameList().then(
          (value) => value.fold(
            (l) {
              Sentry.captureEvent(l);
            },
            (r) {
              gameList.value = r;
            },
          ),
        );
  }

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    sharedPreferences = await SharedPreferences.getInstance();
    controller = AnimationController(
      vsync: this,
    );
    await getDataTutorial();
    await fetchHolidays();
    try {
      await getCurrentUser();
      if (currentUser.id != null) {
        await Future.wait([
          getMyBookings(),
          getStatusList(),
          getGameList(),
        ]);
        checkArgument();
        if (isCheckInTime) {
          showPhotoDialog(Get.context!, takePictureForCheck, isCheckInTime);
        }
        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
      }
    } catch (e) {
      Sentry.captureMessage(
          "Erreur lors de l'initialisation des requêtes. - DashboardViewController");
      await Sentry.captureException(e);
      change(null, status: RxStatus.error());
    }
    super.onInit();
  }
}
