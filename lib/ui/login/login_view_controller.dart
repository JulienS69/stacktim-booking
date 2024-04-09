import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/logic/repository/login_repository.dart';
import 'package:stacktim_booking/navigation/route.dart';
import 'package:stacktim_booking/ui/login/widgets/microsoft_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../helper/snackbar.dart';

class LoginViewController extends GetxController with StateMixin {
  //STRING
  RxString microsoftUrl = "".obs;
  //REPOSITORY
  LoginRepository loginRepository;
  //BOOL
  RxBool isShowingVersion = false.obs;
  //OTHER
  WebViewController webViewController = WebViewController();

  LoginViewController({
    required this.loginRepository,
  });

//This allows retrieving the Microsoft URL, subsequently enabling launching into the web app view.
  Future<void> getMicrosftUrl() async {
    return await loginRepository.getMicrosoftUrl().then(
          (value) => value.fold(
            (l) {
              showSnackbar("Le service est momentanément indisponible",
                  SnackStatusEnum.error);
            },
            (r) async {
              microsoftUrl.value = r;
            },
          ),
        );
  }

  /// To initialize the web view with the retrieved Microsoft URL.
  void initialWebView() async {
    webViewController
      ..loadRequest(Uri.parse(
        microsoftUrl.value,
      ))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageFinished: (url) async {
            final cookies = await webViewController
                .runJavaScriptReturningResult('document.cookie');
            // If the JWT is successfully retrieved from the cookies of the webAppView, then redirect to the login page with the JWT.
            if (cookies.toString().contains('access_token')) {
              String cookiesResult = cookies.toString();
              List<String> jwtList = cookiesResult.split("access_token=");
              if (jwtList.isNotEmpty) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String currentJwt = "";
                currentJwt = jwtList.last.replaceAll('"', '');
                if (currentJwt.isNotEmpty) {
                  int endIndex = currentJwt.indexOf("; XSRF-");
                  String accessToken = currentJwt.substring(0, endIndex);
                  await prefs.setString(LocalStorageKey.jwt.name, accessToken);
                  Get.offAllNamed(Routes.welcome);
                }
              }
            }
          },
          onPageStarted: (String url) {},
          onWebResourceError: (error) {
            Sentry.captureMessage(
                "Error when displaying the web page in the web app view. Error : ${error.toString()} initialWebView() -> XLogicForLogin / LOGIN_KIT_DAILYAPPS");
            Get.offAllNamed(Routes.login);
          },
        ),
      );
    microsoftUrl.value.isNotEmpty
        ? await Get.to(
            () => MicrosoftView(webViewController: webViewController),
          )
        : showSnackbar("cannotConnectWithMicrosoft", SnackStatusEnum.error);
  }

  /// Displays the version number of the app based on the pubspec.yaml file.
  Widget buildVersionNumber() {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: ((context, snapshot) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              '${snapshot.data?.version ?? '-'}+${snapshot.data?.buildNumber ?? ''}',
            ),
          ),
        );
      }),
    );
  }

  @override
  void onInit() async {
    change(null, status: RxStatus.success());
    super.onInit();
  }
}
