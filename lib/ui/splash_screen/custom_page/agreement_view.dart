import 'package:flutter/material.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AgreementView extends StatelessWidget {
  const AgreementView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return XMobileScaffold(
      isShowBottomNavigationBar: false,
      appBar: const XPageHeader(
        title: 'Règlement de la salle E-Sport',
        style: TextStyle(fontSize: 12),
        centerTitle: true,
        imagePath: logoOverSlug,
      ),
      body: SfPdfViewer.asset(
        pdfAgreement,
        canShowPaginationDialog: false,
        canShowScrollStatus: false,
        canShowScrollHead: false,
      ),
    );
  }
}
