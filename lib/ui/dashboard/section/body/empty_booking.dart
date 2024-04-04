import 'package:flutter/material.dart';
import 'package:stacktim_booking/helper/strings.dart';

import '../../../../helper/style.dart';

class EmptyBooking extends StatelessWidget {
  final void Function() onPressed;
  const EmptyBooking({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              seat,
              width: 350,
              height: 350,
            ),
            const Text("Tu n'as encore pas réservé de session ce mois-ci"),
            const Text(
              "Je t'invite à réserver ta première session",
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: ElevatedButton(
                      onPressed: () {
                        onPressed();
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.black),
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
                        textStyle: MaterialStatePropertyAll(arvoStyle),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Prend ta réservation ! "),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            logo,
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
