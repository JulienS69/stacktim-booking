import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacktim_booking/helper/icons.dart';
import 'package:stacktim_booking/helper/local_storage.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/logic/repository/holliday_repository.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../logic/models/booking/booking.dart';
import '../../logic/repository/booking_repository.dart';

class CalendarViewController extends GetxController with StateMixin {
  final BookingRepository bookingRepository;
  HolidayRepository holidayRepository = HolidayRepository();
  List<Booking> bookingList = [];
  List<DateTime>? holidaysList;
  //TUTORIAL VARIABLES
  List<TargetFocus> tutorialList = [];
  RxBool isShowTutorial = false.obs;
  SharedPreferences? sharedPreferences;
  final calendardButtonKey =
      GlobalKey<FormState>(debugLabel: 'calendardButtonKey');

  CalendarViewController({
    required this.bookingRepository,
  });

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      await getDataTutorial();
      await fetchHolidays();
      await getMonthlyBookings(DateTime.now().month);
      change(null, status: RxStatus.success());
    } catch (e) {
      await Sentry.captureMessage(
          "Erreur lors de l'initialisation des requêtes. - CalendarViewController");
      await Sentry.captureException(e);
      change(null, status: RxStatus.error());
    }

    super.onInit();
  }

  getMonthlyBookings(int month) async {
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
      hideSkip: true,
      onSkip: () {
        if (sharedPreferences != null) {
          isShowTutorial.value = false;
          sharedPreferences?.setBool(
              LocalStorageKeyEnum.isShowTutorialCalendar.name, false);
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
    bool? getTutoBool =
        prefs.getBool(LocalStorageKeyEnum.isShowTutorialCalendar.name);
    if (getTutoBool == null || getTutoBool == true) {
      fillTutorialList();
      isShowTutorial.value = true;
    }
  }

  Future<void> closeTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isShowTutorial.value = false;
    await prefs.setBool(LocalStorageKeyEnum.isShowTutorialCalendar.name, false);
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
