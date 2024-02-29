import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/logic/status/status.dart';
import 'package:stacktim_booking/logic/user/user.dart';
import 'package:stacktim_booking/widget/x_chip.dart';

class DashboardViewController extends GetxController with StateMixin {
  List<Status> statusList = const [
    Status(id: 0, statusName: "inProgress"),
    Status(id: 1, statusName: "Passed"),
    Status(id: 2, statusName: "inComming"),
  ];

  RxBool isNotFree = false.obs;

  User currentUser = const User(firstname: "Julien", pseudo: "Virtuor");
  TextEditingController searchController = TextEditingController();

  DashboardViewController();

  @override
  Future<void> onReady() async {
    change(null, status: RxStatus.loading());
    change(null, status: RxStatus.success());
    super.onReady();
  }

  Color getColorsByStatusTag({
    required String statusTag,
  }) {
    if (statusTag == "inProgress") {
      return const Color(0xFF4fc3f7);
    } else if (statusTag == "Passed") {
      return const Color(0xFFFFEB3B);
    } else {
      return const Color(0xFFE53935);
    }
  }

  XChip getChipByStatusTag(String? tag) {
    switch (tag) {
      case "Passed":
        return XChip.chipStatus(
          label: "Passée".tr.capitalizeFirst!,
          chipColor: XChipColor.yellow,
        );
      case "inComming":
        return XChip.chipStatus(
          label: "A venir".tr.capitalizeFirst!,
          chipColor: XChipColor.red,
        );
      case "inProgress":
        return XChip.chipStatus(
          label: "En cours".tr.capitalizeFirst!,
          chipColor: XChipColor.blue,
        );
      default:
        return XChip.chipStatus(
          label: "Aucun status".tr.capitalizeFirst!,
          chipColor: XChipColor.red,
        );
    }
  }

  XChipColor getColorChipByStatusTag(String tag) {
    switch (tag) {
      case "Passed":
        return XChipColor.yellow;
      case "inComming":
        return XChipColor.red;
      case "inProgress":
        return XChipColor.blue;

      default:
        return XChipColor.red;
    }
  }

  String getStringByStatusTag(String tag) {
    switch (tag) {
      case "Passed":
        return 'Passée';
      case "inComming":
        return 'A venir';
      case "inProgress":
        return 'En cours';

      default:
        return '';
    }
  }

  checkIsFree(String date) {
    if (date == "2024-02-01 00:00:00.000") {
      isNotFree.value = true;
    } else {
      isNotFree.value = false;
    }
  }
}
