import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

Widget showLottieEmptyBooking() {
  return Lottie.asset(
    'assets/lotties/next.json',
    fit: BoxFit.fill,
    height: 150,
  );
}
