import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';
import 'package:stacktim_booking/widget/x_selection_seat.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

SliverWoltModalSheetPage seatPicker({
  required BuildContext modalSheetContext,
  required ValueNotifier pageIndexNotifier,
  required DashboardViewController controller,
}) {
  return WoltModalSheetPage(
    topBarTitle: Text(
      "Choisi ton siège",
      style: titleStyle.copyWith(fontSize: 18),
    ),
    leadingNavBarWidget: IconButton(
      padding: const EdgeInsets.all(pagePadding),
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: () {
        HapticFeedback.vibrate();
        pageIndexNotifier.value = pageIndexNotifier.value - 1;
      },
    ),
    backgroundColor: sheetColor,
    hasSabGradient: false,
    enableDrag: false,
    forceMaxHeight: true,
    isTopBarLayerAlwaysVisible: true,
    trailingNavBarWidget: IconButton(
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
    child: Column(
      children: [
        SizedBox(
          height: modalSheetContext.height * 0.8,
          child: SeatSelectionScreen(
            pageIndexNotifier: pageIndexNotifier,
            dashboardViewController: controller,
          ),
        ),
      ],
    ),
  );
}
