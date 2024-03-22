// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';

class BookingTitle extends StatelessWidget {
  final BuildContext modalSheetContext;
  final DashboardViewController controller;

  const BookingTitle({
    super.key,
    required this.modalSheetContext,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          cursorColor: grey13,
          autofocus: true,
          textAlign: TextAlign.center,
          keyboardAppearance: Brightness.dark,
          maxLength: 32,
          onTapOutside: (d) {
            FocusScope.of(modalSheetContext).requestFocus(FocusNode());
          },
          decoration: const InputDecoration(
            hintText: 'Titre de la réservation',
            hintStyle: arvoStyle,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.0),
            ),
          ),
          style: const TextStyle(
            color: Colors.white60,
            fontFamily: 'Anta',
            decoration: TextDecoration.none,
          ),
          onChanged: (title) {
            controller.titleSelected.value = title;
          },
          controller: controller.titleController,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
