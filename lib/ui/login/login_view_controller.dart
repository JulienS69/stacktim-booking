import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/logic/repository/login_repository.dart';
import 'package:stacktim_booking/navigation/route.dart';
import 'package:stacktim_booking/ui/login/widgets/microsoft_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../helper/snackbar.dart';

class LoginViewController extends GetxController with StateMixin {
  //STRING
  RxString microsoftUrl = "".obs;
  String version = "";
  String buildNumber = "";
  //REPOSITORY
  LoginRepository loginRepository;
  //BOOL
  RxBool isShowingVersion = false.obs;
  //INT
  int counter = 0;
  //OTHER
  WebViewController webViewController = WebViewController();
  PackageInfo? packageInfo;

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

  void incrementCounterFordDevelopers() async {
    counter++;
    log(counter.toString());
    if (counter % 5 == 0) {
      HapticFeedback.vibrate();
      await showEasterEggDialog();
    }
  }

  Future showEasterEggDialog() async {
    return await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            height: 360,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LottieBuilder.asset(
                  teamWork,
                  fit: BoxFit.fill,
                  height: 200,
                  repeat: false,
                ),
                const Text(
                  'Application développé par :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Julien SEUX, \nDheeraj TILHOO, Corentin COUSSE",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Retour'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void onInit() async {
    packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo?.version ?? "1.0.0";
    buildNumber = packageInfo?.buildNumber ?? "1";
    change(null, status: RxStatus.success());
    super.onInit();
  }
}
