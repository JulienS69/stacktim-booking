import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

Widget showLottieEmptyBooking({
  double? size,
  String? lottie,
  BoxFit? boxfit,
}) {
  return Lottie.asset(
    lottie ?? 'assets/lotties/next.json',
    fit: boxfit ?? BoxFit.fill,
    height: size ?? 150,
  );
}
