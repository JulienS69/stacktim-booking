import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';
import 'package:stacktim_booking/widget/x_input_text_field.dart';

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
                child: XInputTextField.basic(
                  hintText: "Rechercher".tr.capitalizeFirst!,
                  hintStyle: xMyTheme.textTheme.bodyMedium!
                      .copyWith(color: Colors.black),
                  controller: controller.searchController,
                  onChanged: (value) {},
                  prefixIcon: const Icon(
                    Icons.search,
                    color: grey6,
                  ),
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
