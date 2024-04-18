import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
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
import 'package:stacktim_booking/logic/models/status/status.dart';
import 'package:stacktim_booking/logic/models/user/user.dart';
import 'package:stacktim_booking/logic/repository/booking_repository.dart';
import 'package:stacktim_booking/logic/repository/holliday_repository.dart';
import 'package:stacktim_booking/logic/repository/status_repository.dart';
import 'package:stacktim_booking/logic/repository/user_repository.dart';
import 'package:stacktim_booking/ui/new_booking/new_booking_view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../logic/repository/computer_repository.dart';

class DashboardViewController extends GetxController with StateMixin {
  //REPOSTIORY
  BookingRepository bookingRepository = BookingRepository();
  StatusRepository statusRepository = StatusRepository();
  UserRepository userRepository = UserRepository();
  ComputerRepository computerRepository = ComputerRepository();
  HolidayRepository holidayRepository = HolidayRepository();
  //LIST
  RxList<Status> statusList = <Status>[].obs;
  RxList<Booking> bookingList = <Booking>[].obs;
  RxList<Booking> filteredBookingList = <Booking>[].obs;
  RxList<Computer> computersList = <Computer>[].obs;
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
  //STRING
  RxString titleSelected = "".obs;
  RxString bookedAt = "".obs;
  RxString selectedDate = "".obs;
  RxString beginingHourSelected = "".obs;
  RxString endingHourSelected = "".obs;
  String minutesSelected = "";
  RxString startingtimeSelected = "".obs;
  RxString endingtimeSelected = "".obs;
  String computerUuidSelected = "";
  String statusIdSelected = '';
  //INT
  RxInt computerSelected = 0.obs;
  RxInt userCreditAvailable = 0.obs;
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

//This allows checking if the request to create a reservation has been made from another page.
  checkArgument() {
    if (Get.arguments != null) {
      if (Get.arguments['openSheet'] != null) {
        checkCreditBeforeCreateBooking();
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

//This allows checking the remaining number of credits before being able to recreate a session.
  checkCreditBeforeCreateBooking() async {
    if (await ConnectionHelper.hasNoConnection()) {
      showSnackbar(
          "Impossible de réserver une séance, aucune connexion internet n'a été trouvée",
          SnackStatusEnum.error);
    } else if (userCreditAvailable.value != 0) {
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
              Sentry.configureScope(
                (v) => v.setUser(
                  SentryUser(
                    email: r.email,
                    data: {
                      'Token utilisateur':
                          sharedPreferences?.getString(LocalStorageKey.jwt.name)
                    },
                    username: r.fullName,
                  ),
                ),
              );
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
    //  Convert time strings into hours and minutes
    List<int> startTimeParts =
        startingtimeSelected.value.split(':').map(int.parse).toList();
    List<int> endTimeParts =
        endingtimeSelected.value.split(':').map(int.parse).toList();
    // Retrieve the start and end hours and minutes.
    int startHours = startTimeParts[0];
    int endHours = endTimeParts[0];
    // Calculate the duration in hours and half-hours.
    int durationHours = endHours - startHours;
    // Check if the user has enough credits to make a reservation.
    bool heCanReserve = false;
    int creditAvailable = 0;
    if (currentUser.credit != null) {
      if (currentUser.credit!.creditAvailable != null) {
        int creditNotYetUsed = 0;
        if (currentUser.credit!.notYetUsed != null) {
          creditNotYetUsed = currentUser.credit!.notYetUsed!;
        }
        int creditAvailable =
            currentUser.credit!.creditAvailable! - creditNotYetUsed;
        heCanReserve = (creditAvailable >= durationHours);
      }
    }
    if (heCanReserve) {
      currentBooking = currentBooking.copyWith(
        userId: currentUser.id,
        statusId: statusIdSelected,
        bookedAt: selectedDate.value,
        computerId: computerUuidSelected,
        title: titleSelected.value,
        endAt: endingtimeSelected.value,
        beginAt: startingtimeSelected.value,
        duration: durationHours,
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
                  desc:
                      "Quelque chose c'est mal passé pendant l'enregistrement de ta session",
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
    } else {
      Sentry.captureMessage(
          "L'utilisateur ne possède pas assez de crédits pour pouvoir réserver la session sélectionnée");
      showSnackbar(
          "Tu ne possèdes pas assez de crédits. Crédits restant : $creditAvailable",
          SnackStatusEnum.warning);
    }
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
    minutesSelected = "";
    startingtimeSelected.value = "";
    endingtimeSelected.value = "";
    computerSelected.value = 0;
    progressValue.value = 0.0;
    isConfirmed.value = false;
    pageIndexNotifier.value = pageIndexNotifier.value - 3;
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
                      : TimeOfDay.now().hour,
              minute: minutesSelected == "30" ? 30 : 0,
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
        minHour: 12,
        maxHour: 21,
        maxMinute: 30,
        onChange: (time) async {
          HapticFeedback.vibrate();
          if (!isEndingTime) {
            // Vérifier si l'heure est dans les créneaux horaires valides
            if ((time.hour >= 12 && time.hour <= 13 && time.minute != 59) ||
                (time.hour >= 17 && time.hour <= 21 && time.minute != 59)) {
              beginingHourSelected.value = time.hour.toString();
              minutesSelected = time.minute.toString();
              Time beginHourSelect = Time(hour: time.hour, minute: time.minute);
              startingtimeSelected.value = beginHourSelect.format(Get.context!);
              if (minutesSelected != "0") {
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
                  "Impossible de choisir une heure en dehors des horaires définis",
                  SnackStatusEnum.error);
            }
          } else {
            // Vérifier si l'heure est dans les créneaux horaires valides
            if ((time.hour >= 12 && time.hour <= 13 && time.minute != 59) ||
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
                minutesSelected = time.minute.toString();
                Time endedTime = Time(hour: time.hour, minute: time.minute);
                endingtimeSelected.value = endedTime.format(Get.context!);
                if (selectedDate.value.isNotEmpty &&
                    startingtimeSelected.value.isNotEmpty &&
                    titleSelected.value.isNotEmpty) {
                  await checkAvailbilityComputer();
                }
              }
            } else {
              showSnackbar(
                  "Impossible de choisir une heure en dehors des horaires définis",
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
          const Duration(seconds: 6),
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
                  repeat: false,
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
      filteredBookingList.assignAll(bookingList.where((booking) =>
          booking.title != null &&
          booking.title!.toLowerCase().contains(title.toLowerCase())));
    }
  }

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    sharedPreferences = await SharedPreferences.getInstance();
    // Gettting memory size of camera
    WidgetsFlutterBinding.ensureInitialized();
    await getDataTutorial();
    await fetchHolidays();
    try {
      await getCurrentUser();
      await getMyBookings();
      await getStatusList();
      await checkArgument();
      change(null, status: RxStatus.success());
    } catch (e) {
      Sentry.captureMessage(
          "Erreur lors de l'initialisation des requêtes. - DashboardViewController");
      await Sentry.captureException(e);
      change(null, status: RxStatus.error());
    }
    super.onInit();
  }
}
