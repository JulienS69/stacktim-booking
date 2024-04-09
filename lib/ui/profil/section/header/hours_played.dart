import 'package:flutter/material.dart';
import 'package:stacktim_booking/ui/profil/profil_view_controller.dart';

class HoursPlayed extends StatelessWidget {
  ProfilViewController controller;
  HoursPlayed({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "Nombre d'heures jouées :",
            ),
            const Spacer(),
            Text(
              controller.currentUser.credit?.creditUsed.toString() ?? "0",
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}
