import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/logic/repository/login_repository.dart';
import 'package:stacktim_booking/navigation/route.dart';
import 'package:stacktim_booking/ui/login/widgets/microsoft_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../helper/snackbar.dart';
import '../../helper/strings.dart';

class LoginViewController extends GetxController with StateMixin {
  List<String> imageList = [
    one,
    two,
    three,
    four,
    five,
  ];
  RxString microsoftUrl = "".obs;
  LoginRepository loginRepository;
  WebViewController webViewController = WebViewController();

  LoginViewController({
    required this.loginRepository,
  });

  @override
  void onInit() async {
    try {
      checkToken();
      await getMicrosftUrl();
    } catch (e) {}
    change(null, status: RxStatus.success());
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    change(null, status: RxStatus.loading());
    change(null, status: RxStatus.success());
    super.onReady();
  }

  void checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(LocalStorageKey.jwt.name) ?? "";
    if (token.isNotEmpty) {
      Get.offAllNamed(Routes.welcome);
    }
  }

  Future getMicrosftUrl() async {
    return await loginRepository.getMicrosoftUrl().then(
          (value) => value.fold(
            (l) {},
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
            MicrosoftView(webViewController: webViewController),
          )
        : showSnackbar("cannotConnectWithMicrosoft", SnackStatusEnum.error);
  }
}
