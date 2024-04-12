import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';

class StackCredit extends StatelessWidget {
  const StackCredit({
    super.key,
    required this.controller,
  });

  final DashboardViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 15.0, right: 20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Bonjour ${controller.currentUser.nickName ?? controller.currentUser.firstname} 👋",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                key: controller.stackCreditButtonKey,
                children: [
                  Obx(() => Text(
                        controller.userCreditAvailable.value.toString(),
                        style: titleStyle.copyWith(
                          color: primary,
                        ),
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    coinLogo,
                    height: 15,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Stack crédits \nrestant",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
