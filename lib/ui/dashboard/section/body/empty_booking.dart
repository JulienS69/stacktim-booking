import 'package:flutter/material.dart';
import 'package:stacktim_booking/helper/strings.dart';

import '../../../../helper/style.dart';

class EmptyBooking extends StatefulWidget {
  final void Function() onPressed;

  const EmptyBooking({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  _EmptyBookingState createState() => _EmptyBookingState();
}

class _EmptyBookingState extends State<EmptyBooking> {
  double rotationAngle = 0.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Transform.rotate(
              angle: rotationAngle,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    rotationAngle += details.delta.dx / 150;
                  });
                },
                child: Image.asset(
                  seat,
                  width: 350,
                  height: 350,
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Tu n'as encore pas réservé de session ce mois-ci",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Je t'invite à réserver ta première session",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
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
                        widget.onPressed();
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.black),
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
                        textStyle: MaterialStatePropertyAll(antaStyle),
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
