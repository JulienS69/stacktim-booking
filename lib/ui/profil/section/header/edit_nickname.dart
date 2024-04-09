import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/ui/profil/profil_view_controller.dart';

class EditNickName extends StatelessWidget {
  const EditNickName({
    super.key,
    required this.controller,
  });

  final ProfilViewController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              HapticFeedback.vibrate();
              controller.isEditing.value = false;
            },
            child: const Icon(
              Icons.cancel_outlined,
              color: backgroundColorSheet,
            ),
          ),
          const SizedBox(
            width: 25,
          ),
          SizedBox(
            width: 200,
            child: TextField(
              cursorColor: grey13,
              textAlign: TextAlign.center,
              onSubmitted: (nickName) async {
                HapticFeedback.vibrate();
                controller.isEditing.value = false;
                await controller.updateCurrentUser();
              },
              autofocus: true,
              onTapOutside: (d) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              decoration: InputDecoration(
                hintText: controller.currentUser.nickName ?? "Nouveau pseudo",
                hintStyle: arvoStyle,
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
              ),
              style: const TextStyle(
                color: Colors.white60,
                fontFamily: 'Anta',
                decoration: TextDecoration.none,
              ),
              onChanged: (newNickname) {
                controller.nickName.value = newNickname;
              },
              controller: controller.nickNameController,
            ),
          ),
          const SizedBox(
            width: 25,
          ),
          InkWell(
            onTap: () async {
              HapticFeedback.vibrate();
              controller.isEditing.value = false;
              await controller.updateCurrentUser();
            },
            child: const Icon(
              Icons.check_circle_outline_outlined,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
