import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

SliverWoltModalSheetPage bookingSummary({
  required BuildContext modalSheetContext,
  required ValueNotifier pageIndexNotifier,
  required DashboardViewController controller,
}) {
  controller.startIncrementing();
  return WoltModalSheetPage(
    topBarTitle: Text(
      "Récapitulatif de ta réservation",
      style: titleStyle.copyWith(fontSize: 16),
    ),
    leadingNavBarWidget: IconButton(
      padding: const EdgeInsets.all(pagePadding),
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: () {
        HapticFeedback.vibrate();
        pageIndexNotifier.value = pageIndexNotifier.value - 1;
      },
    ),
    enableDrag: false,
    backgroundColor: sheetColor,
    hasSabGradient: false,
    isTopBarLayerAlwaysVisible: true,
    trailingNavBarWidget: IconButton(
      padding: const EdgeInsets.all(pagePadding),
      icon: const Icon(Icons.check),
      onPressed: () async {
        await controller.createBooking();
      },
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(
        pagePadding,
        pagePadding,
        pagePadding,
        bottomPaddingForButton,
      ),
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  "Date choisie : ",
                  style: antaStyle,
                ),
                Expanded(
                  child: Text(
                    controller.bookedAt.value.capitalizeFirst!,
                    style: antaStyle.copyWith(
                      decoration: TextDecoration.underline,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text(
                  "Crénau choisi : ",
                  style: antaStyle,
                ),
                Expanded(
                  child: Text(
                    controller.minutesSelected == "0"
                        ? "De ${controller.beginingHourSelected.value.capitalizeFirst!} à ${controller.endingHourSelected.value.capitalizeFirst!} heures"
                        : "De ${controller.beginingHourSelected.value.capitalizeFirst!}h${controller.minutesSelected} à ${controller.endingHourSelected.value.capitalizeFirst!}h${controller.minutesSelected}",
                    style: antaStyle.copyWith(
                      decoration: TextDecoration.underline,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text(
                  "Siège choisi : ",
                  style: antaStyle,
                ),
                Expanded(
                  child: Text(
                    "Siège numéro ${controller.computerSelected.value}",
                    style: antaStyle.copyWith(
                      decoration: TextDecoration.underline,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    ),
    stickyActionBar: Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            await controller.createBooking();
          },
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            foregroundColor: MaterialStatePropertyAll(Colors.red),
            textStyle: MaterialStatePropertyAll(antaStyle),
          ),
          child: const SizedBox(
            height: 30,
            width: double.infinity,
            child: Center(
              child: Text(
                "Je valide ma réservation",
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        ElevatedButton(
          onPressed: () async {
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
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.black),
            foregroundColor: MaterialStatePropertyAll(Colors.white),
            textStyle: MaterialStatePropertyAll(antaStyle),
          ),
          child: const SizedBox(
            height: 30,
            width: 250,
            child: Center(
              child: Text(
                "J'annule ma réservation",
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: FAProgressBar(
                  currentValue: controller.progressValue.value,
                  size: 15,
                  maxValue: 100,
                  animatedDuration: const Duration(seconds: 5),
                  direction: Axis.horizontal,
                  verticalDirection: VerticalDirection.up,
                  formatValueFixed: 0,
                  progressGradient: const LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.purple,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
