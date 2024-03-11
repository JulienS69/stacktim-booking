import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/x_app_bar.dart';
import '../../../widget/x_mobile_scaffold.dart';
import '../calendar_view_controller.dart';

class CalendarDetailView extends GetView<CalendarViewController> {
  const CalendarDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return XMobileScaffold(
      appBar: const XPageHeader(
        title: '23 Janvier 2023',
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
