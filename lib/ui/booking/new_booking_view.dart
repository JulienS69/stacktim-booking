import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/ui/booking/new_booking_view_controller.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';

class NewBookingView extends GetView<NewBookingViewController> {
  const NewBookingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return XMobileScaffold(
      isShowBottomNavigationBar: false,
      appBar: const XPageHeader(
        title: 'Prendre une réservation',
      ),
      body: controller.obx(
        (state) => SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
