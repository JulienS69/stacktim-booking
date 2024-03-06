import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  return WoltModalSheetPage(
    topBarTitle: Text(
      "Valide ta réservation",
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
    forceMaxHeight: true,
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
                  controller.timeSelected.value.capitalizeFirst!,
                  style: arvoStyle.copyWith(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const Spacer()
              ],
            )
          ],
        ),
      ),
    ),
  );
}
