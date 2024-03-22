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
      style: titleArvo.copyWith(fontSize: 18),
    ),
    leadingNavBarWidget: IconButton(
      padding: const EdgeInsets.all(pagePadding),
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: () {
        HapticFeedback.vibrate();
        pageIndexNotifier.value = pageIndexNotifier.value - 1;
      },
    ),
    backgroundColor: backgroundColorSheet,
    hasSabGradient: false,
    isTopBarLayerAlwaysVisible: true,
    trailingNavBarWidget: IconButton(
      padding: const EdgeInsets.all(pagePadding),
      icon: const Icon(Icons.check),
      onPressed: Navigator.of(modalSheetContext).pop,
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
                  style: arvoStyle,
                ),
                Text(
                  controller.dateSelected.value.capitalizeFirst!,
                  style: arvoStyle.copyWith(
                    decoration: TextDecoration.underline,
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
                  "Crénau choisie : ",
                  style: arvoStyle,
                ),
                Text(
                  "De ${controller.beginingHourSelected.value.capitalizeFirst!} à ${controller.endingHourSelected.value.capitalizeFirst!} heures",
                  style: arvoStyle.copyWith(
                    decoration: TextDecoration.underline,
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
                  "Siège choisie : ",
                  style: arvoStyle,
                ),
                Text(
                  "Siège numéro ${controller.seatSelected.value}",
                  style: arvoStyle.copyWith(
                    decoration: TextDecoration.underline,
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
          onPressed: () {},
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            foregroundColor: MaterialStatePropertyAll(Colors.red),
            textStyle: MaterialStatePropertyAll(arvoStyle),
          ),
          child: const SizedBox(
            height: 30,
            width: double.infinity,
            child: Center(
              child: Text(
                "Je valide ma place",
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        ElevatedButton(
          onPressed: () {},
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.black),
            foregroundColor: MaterialStatePropertyAll(Colors.white),
            textStyle: MaterialStatePropertyAll(arvoStyle),
          ),
          child: const SizedBox(
            height: 30,
            width: 250,
            child: Center(
              child: Text(
                "J'annule ma place'",
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
