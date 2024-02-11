import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'helper/style.dart';
import 'navigation/navigation.dart';
import 'navigation/route.dart';

void main() {
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
      debugShowCheckedModeBanner: false,
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
