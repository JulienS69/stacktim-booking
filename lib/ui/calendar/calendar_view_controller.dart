import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/icons.dart';
import 'package:stacktim_booking/helper/local_storage.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/logic/models/user/user.dart';
import 'package:stacktim_booking/logic/repository/holliday_repository.dart';
import 'package:stacktim_booking/logic/repository/user_repository.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../logic/models/booking/booking.dart';
import '../../logic/repository/booking_repository.dart';

class CalendarViewController extends GetxController with StateMixin {
  final BookingRepository bookingRepository;
  UserRepository userRepository;
  HolidayRepository holidayRepository = HolidayRepository();
  List<Booking> bookingList = [];
  List<DateTime>? holidaysList;
  //TUTORIAL VARIABLES
  List<TargetFocus> tutorialList = [];
  RxBool isShowTutorial = false.obs;
  SharedPreferences? sharedPreferences;
  final calendardButtonKey =
      GlobalKey<FormState>(debugLabel: 'calendardButtonKey');
  final stackCreditButtonKey =
      GlobalKey<FormState>(debugLabel: 'stackCreditButtonKey');
  RxInt userCreditAvailable = 0.obs;
  User currentUser = const User();

  CalendarViewController({
    required this.bookingRepository,
    required this.userRepository,
  });

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      getDataTutorial();
      await Future.wait([
        getCurrentUser(),
        fetchHolidays(),
        getMonthlyBookings(
          DateTime.now().month,
        ),
      ]).then((res) async {
        change(null, status: RxStatus.success());
      });
    } catch (e) {
      await Sentry.captureMessage(
          "Erreur lors de l'initialisation des requêtes. - CalendarViewController");
      await Sentry.captureException(e);
      change(null, status: RxStatus.error());
    }

    super.onInit();
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

  Future<void> getMonthlyBookings(int month) async {
    await bookingRepository.getCalendarMonthlyBooking(monthNumber: month).then(
          (value) => value.fold(
            (l) {
              Sentry.captureException(l);
              bookingList = [];
            },
            (r) {
              bookingList = r;
            },
          ),
        );
  }

  Future<void> fetchHolidays() async {
    try {
      final holidays = await holidayRepository.fetchFrenchHolidays(2024);
      holidaysList = holidays
          .map((holiday) => DateTime.parse(holiday.dateHoliday ?? ""))
          .toList();
    } catch (e) {
      Sentry.captureException(e);
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
      getTutoBool = sharedPreferences
              ?.getBool(LocalStorageKeyEnum.isShowTutorialCalendar.name) ??
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
        LocalStorageKeyEnum.isShowTutorialCalendar.name, false);
  }

  fillTutorialList() {
    tutorialList.add(
      TargetFocus(
        identify: "Calendar",
        enableOverlayTab: true,
        keyTarget: calendardButtonKey,
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
                        calendarIcon,
                        size: 40,
                        color: Colors.white,
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Calendrier",
                    style: titleText1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Explore le pour découvrir toutes les sessions de jeu de la communauté !",
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
}
