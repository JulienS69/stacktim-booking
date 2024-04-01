import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/ui/splash_screen/splash_screen_controller.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AgreementView extends GetView<SplashScreenController> {
  const AgreementView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => XMobileScaffold(
        isShowBottomNavigationBar: false,
        appBar: const XPageHeader(
          title: 'Règlement de la salle E-Sport',
          style: TextStyle(fontSize: 12),
          centerTitle: true,
          imagePath: logoOverSlug,
        ),
        body: SfPdfViewer.asset(pdfAgreement),
      ),
    );
  }
}
