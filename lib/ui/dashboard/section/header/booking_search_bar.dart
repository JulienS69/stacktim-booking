import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';

class BookingSearchBar extends StatelessWidget {
  const BookingSearchBar({
    super.key,
    required this.controller,
  });

  final DashboardViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
      Obx(
        () => controller.isInProgress.value
            ? const Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "Une session est actuellement en cours",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                ],
              )
            : Row(
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
                          hintStyle: antaStyle,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: cardColor, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: cardColor, width: 1.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: cardColor, width: 1.0),
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
      ),
      const SizedBox(
        height: 10,
      ),
    ]);
  }
}
