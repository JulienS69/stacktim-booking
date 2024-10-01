// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';
import 'package:stacktim_booking/ui/new_booking/first_sheet/section/booking_title.dart';
import 'package:stacktim_booking/ui/new_booking/first_sheet/section/date_picker.dart';
import 'package:stacktim_booking/ui/new_booking/first_sheet/section/game_picker.dart';
import 'package:stacktim_booking/ui/new_booking/first_sheet/section/start_time_picker.dart';
import 'package:stacktim_booking/ui/new_booking/first_sheet/section/time_slot_widget.dart';
import 'package:stacktim_booking/widget/x_bouncing_button.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

SliverWoltModalSheetPage bookingSchedule({
  required BuildContext modalSheetContext,
  required ValueNotifier pageIndexNotifier,
}) {
  DashboardViewController controller = Get.find<DashboardViewController>();

  return WoltModalSheetPage(
    topBarTitle: Text(
      "Réservation de la salle",
      style: titleStyle.copyWith(fontSize: 18),
    ),
    backgroundColor: sheetColor,
    hasSabGradient: false,
    isTopBarLayerAlwaysVisible: true,
    leadingNavBarWidget: IconButton(
      padding: const EdgeInsets.all(pagePadding),
      icon: const Icon(Icons.close),
      onPressed: () {
        if (!controller.checkFormIsEmpty()) {
          AwesomeDialog(
            context: modalSheetContext,
            dialogType: DialogType.question,
            dialogBackgroundColor: backgroundColor,
            animType: AnimType.rightSlide,
            title: 'Attention',
            desc:
                'Veux-tu vraiment supprimer les informations que tu as saisies ?',
            btnOkText: 'Oui',
            btnCancelText: 'Annuler',
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              Get.back();
              controller.clearForm();
            },
          ).show();
        } else {
          Navigator.of(modalSheetContext).pop();
        }
      },
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(
        pagePadding,
        pagePadding,
        pagePadding,
        bottomPaddingForButton,
      ),
      child: Column(
        children: [
          BookingTitle(
            controller: controller,
            modalSheetContext: modalSheetContext,
          ),
          GamePicker(controller: controller),
          BookingDatePicker(
            controller: controller,
            pageIndexNotifier: pageIndexNotifier,
          ),
          BookingBeginningTime(
            controller: controller,
            modalSheetContext: modalSheetContext,
            pageIndexNotifier: pageIndexNotifier,
          ),
          TimeSlotWidget(
            controller: controller,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Divider(
              color: Color(0xffFF0808),
              thickness: 3,
            ),
          ),
        ],
      ),
    ),
    stickyActionBar: Obx(
      () => controller.gameSelected.value.id != null &&
              controller.isDatePicked.value &&
              controller.currentTimeSlotSelected.value.name != "Choisir"
          ? Padding(
              padding: const EdgeInsets.all(pagePadding),
              child: Column(
                children: [
                  Obx(() => XBouncingButton(
                        onPressed: () {},
                        child: ElevatedButton(
                          onPressed: () async {
                            HapticFeedback.vibrate();
                            await controller.checkAvailbilityComputer();
                          },
                          style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.black),
                            foregroundColor:
                                WidgetStatePropertyAll(Colors.white),
                            textStyle: WidgetStatePropertyAll(antaStyle),
                          ),
                          child: SizedBox(
                            height: buttonHeight,
                            width: double.infinity,
                            child: controller.isShowLoading.value
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
                                : Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Choisir ma place dans la salle",
                                          style: antaStyle.copyWith(
                                            fontFamily: 'anta',
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Icon(
                                          Icons.arrow_circle_right_outlined,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      )),
                ],
              ),
            )
          : const SizedBox.shrink(),
    ),
  );
}
