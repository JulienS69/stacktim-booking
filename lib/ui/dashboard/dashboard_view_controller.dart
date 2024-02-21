import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/logic/status/status.dart';

class DashboardViewController extends GetxController with StateMixin {
  List<Status> statusList = const [
    Status(id: 0, statusName: "inProgress"),
    Status(id: 1, statusName: "Passed"),
    Status(id: 2, statusName: "inComming"),
  ];

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
}
