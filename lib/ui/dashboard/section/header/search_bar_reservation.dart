import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';

class SearchBarReservation extends StatelessWidget {
  const SearchBarReservation({
    super.key,
    required this.controller,
  });

  final DashboardViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mes réservations :",
                style: titleText1.copyWith(
                  fontSize: 16,
                  fontFamily: 'Anta',
                  decoration: TextDecoration.underline,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  cursorColor: grey13,
                  textAlign: TextAlign.center,
                  keyboardAppearance: Brightness.dark,
                  maxLengthEnforcement: MaxLengthEnforcement.none,
                  onTapOutside: (d) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  decoration: const InputDecoration(
                    hintText: 'Rechercher une réservation',
                    hintStyle: arvoStyle,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 1.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 1.0),
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
                  controller: controller.searchController,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
