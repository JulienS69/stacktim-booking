import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'core/api_client/stacktim_api_client.dart';
import 'helper/style.dart';
import 'navigation/navigation.dart';
import 'navigation/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Get.putAsync<Dio>(() => StacktimHttpClient().init(),
      tag: 'stacktimApi');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: xMyTheme,
      initialRoute: Routes.initialRoute,
      getPages: Nav.routes,
      defaultTransition: Transition.circularReveal,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr'),
        Locale('en'),
      ],
      logWriterCallback: (text, {bool isError = false}) {
        log(
          name: '-',
          "\x1B[37m----------------------------------------------------------------------------",
        );
        log(
            name: '\u001b[1m\u001b[5m\u001b[40m\u001b[37mGETX NAVIGATION',
            text);
      },
    );
  }
}
