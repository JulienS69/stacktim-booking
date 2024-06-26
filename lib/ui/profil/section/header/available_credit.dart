import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/dialogHelper.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/ui/profil/profil_view_controller.dart';

class AvailableCredits extends StatelessWidget {
  ProfilViewController controller;
  AvailableCredits({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            showCoinDialog();
          },
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Row(
            children: [
              const Text("Stack crédits restant :"),
              const Spacer(),
              Obx(() => Text(
                    controller.userCreditAvailable.value.toString(),
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  )),
              const SizedBox(
                width: 5,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  coinLogo,
                  height: 15,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
