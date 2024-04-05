import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/ui/booking/modal_sheet/first_sheet/section/booking_title.dart';
import 'package:stacktim_booking/ui/booking/modal_sheet/first_sheet/section/date_picker.dart';
import 'package:stacktim_booking/ui/booking/modal_sheet/first_sheet/section/end_time_picker.dart';
import 'package:stacktim_booking/ui/booking/modal_sheet/first_sheet/section/start_time_picker.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

SliverWoltModalSheetPage scrollDatePicker({
  required BuildContext modalSheetContext,
  required ValueNotifier pageIndexNotifier,
}) {
  DashboardViewController controller = Get.find<DashboardViewController>();

  return WoltModalSheetPage(
    topBarTitle: Text(
      "Réservation de la salle",
      style: titleArvo.copyWith(fontSize: 18),
    ),
    backgroundColor: backgroundColorSheet,
    hasSabGradient: false,
    isTopBarLayerAlwaysVisible: true,
    leadingNavBarWidget: IconButton(
      padding: const EdgeInsets.all(pagePadding),
      icon: const Icon(Icons.close),
      onPressed: () {
        if (!controller.checkFormIsEmpty()) {
          //FIXME - PUB GET AWESOME DIALOG
          // AwesomeDialog(
          //   context: modalSheetContext,
          //   dialogType: DialogType.question,
          //   dialogBackgroundColor: backgroundColor,
          //   animType: AnimType.rightSlide,
          //   title: 'Attention',
          //   desc:
          //       'Voulez-vous vraiment supprimer les informations que vous avez saisies ?',
          //   btnOkText: 'Oui',
          //   btnCancelText: 'Annuler',
          //   btnCancelOnPress: () {},
          //   btnOkOnPress: () {
          //     Navigator.of(modalSheetContext).pop();
          //   },
          // ).show();
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
          BookingDatePicker(
            controller: controller,
            pageIndexNotifier: pageIndexNotifier,
          ),
          BookingBeginningTime(
            controller: controller,
            modalSheetContext: modalSheetContext,
            pageIndexNotifier: pageIndexNotifier,
          ),
          const SizedBox(
            height: 25,
          ),
          BookingEndingTime(
            controller: controller,
            modalSheetContext: modalSheetContext,
            pageIndexNotifier: pageIndexNotifier,
          ),
        ],
      ),
    ),
    stickyActionBar: Obx(
      () => controller.titleSelected.value.isNotEmpty &&
              controller.isDatePicked.value &&
              controller.beginingHourSelected.isNotEmpty &&
              controller.endingHourSelected.value.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(pagePadding),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      HapticFeedback.vibrate();
                      await controller.checkAvailbilityComputer();
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                      foregroundColor: MaterialStatePropertyAll(Colors.white),
                      textStyle: MaterialStatePropertyAll(arvoStyle),
                    ),
                    child: const SizedBox(
                      height: buttonHeight,
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        "Choisir ma place dans la salle",
                      )),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    ),
  );
}
