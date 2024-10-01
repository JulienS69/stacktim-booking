import 'package:flutter/material.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';

class BookingBeginningTime extends StatelessWidget {
  final BuildContext modalSheetContext;
  final DashboardViewController controller;
  final ValueNotifier pageIndexNotifier;

  const BookingBeginningTime({
    super.key,
    required this.modalSheetContext,
    required this.controller,
    required this.pageIndexNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Plage horaire choisie : ",
          style: antaStyle.copyWith(fontSize: 15),
        ),
        const Spacer(),
        const Icon(
          Icons.schedule,
          color: Colors.white,
        )
      ],
    );
  }
}
