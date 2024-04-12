import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/ui/profil/profil_view_controller.dart';

class NickName extends StatelessWidget {
  const NickName({
    super.key,
    required this.controller,
  });

  final ProfilViewController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.isEditing.value = !controller.isEditing.value;
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Row(
          key: controller.nickNameButtonKey,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => controller.nickName.value.isNotEmpty
                  ? Text(
                      controller.nickName.value,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 98, 105, 109),
                      ),
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      controller.currentUser.nickName ?? "Pseudo",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 98, 105, 109),
                      ),
                      textAlign: TextAlign.center,
                    ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.edit,
              color: Colors.white,
              size: 15,
            )
          ],
        ),
      ),
    );
  }
}
