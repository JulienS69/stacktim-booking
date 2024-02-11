import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller.dart';

class DashboardView extends GetView<DashboardViewController> {
  const DashboardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("fdeffe"),
            ],
          ),
        ],
      ),
    );
  }
}
