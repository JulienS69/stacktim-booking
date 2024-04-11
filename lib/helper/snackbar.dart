// Snackbar
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/widget/x_snackbar.dart';

enum SnackStatusEnum {
  success,
  error,
  simple,
  update,
  warning,
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbar(
    String message, SnackStatusEnum snackStatusEnum) {
  switch (snackStatusEnum) {
    case SnackStatusEnum.success:
      return XSnackbar.showSnackBar(
        context: Get.context!,
        snackBar: XSnackbar.success(message: message.tr, context: Get.context!),
      );
    case SnackStatusEnum.error:
      return XSnackbar.showSnackBar(
        context: Get.context!,
        snackBar: XSnackbar.error(message: message.tr, context: Get.context!),
      );
    case SnackStatusEnum.update:
      return XSnackbar.showSnackBar(
        context: Get.context!,
        snackBar: XSnackbar.error(message: message.tr, context: Get.context!),
      );
    case SnackStatusEnum.warning:
      return XSnackbar.showSnackBar(
        context: Get.context!,
        snackBar: XSnackbar.warning(message: message.tr, context: Get.context!),
      );
    case SnackStatusEnum.simple:
      return XSnackbar.showSnackBar(
        context: Get.context!,
        snackBar: XSnackbar.simple(message: message.tr, context: Get.context!),
      );
    default:
      return XSnackbar.showSnackBar(
        context: Get.context!,
        snackBar: XSnackbar.simple(message: message.tr, context: Get.context!),
      );
  }
}
