import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/ui/login/login_view_controller.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MicrosoftView extends GetView<LoginViewController> {
  final WebViewController webViewController;
  const MicrosoftView({
    required this.webViewController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: XMobileScaffold(
        isShowBottomNavigationBar: false,
        appBar: const XPageHeader(
          title: 'Connexion Microsoft',
        ),
        body: WebViewWidget(
          controller: webViewController,
        ),
      ),
    );
  }
}
