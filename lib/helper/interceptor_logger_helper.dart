import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

showLogOnRequest({required RequestOptions requestOptions}) {
  String method = requestOptions.method;
  String baseUrl = requestOptions.baseUrl;
  String route = requestOptions.path;
  log(
    name: '-',
    "\x1B[37m----------------------------------------------------------------------------",
  );
  log(
    name: 'API',
    "🌐 \x1B[37m$method \x1B[36m=> \x1B[37mURL: \x1B[36m$baseUrl => \x1B[37mRoute: \x1B[36m$route",
  );
  if (requestOptions.queryParameters.isNotEmpty) {
    log(
        name: 'API',
        '📤\x1B[37m QUERYPARAMS \x1B[36m=> \x1B[35m${requestOptions.queryParameters}');
  }
  if (requestOptions.data != null) {
    if (requestOptions.data is FormData) {
      log(
          name: 'API',
          '📝\x1B[37m FORMDATA BODY \x1B[36m=> \x1B[33m${requestOptions.data.fields.toString()}');
    } else {
      log(
          name: 'API',
          '📝 \x1B[37mBODY \x1B[36m=> \x1B[33m${requestOptions.data}');
    }
  }
}

showLogOnResponse({
  required Response<dynamic> response,
}) {
  if (response.statusCode != null) {
    log(
      name: "-",
      "\x1B[37m----------------------------------------------------------------------------",
    );
    if (response.statusCode! >= 200 && response.statusCode! <= 299) {
      log(
          name: 'API',
          '\x1B[37m RESPONSE \x1B[32m${response.statusCode} ✅ \x1B[36m=> \x1B[37mURL : \x1B[92m${response.requestOptions.baseUrl} \x1B[37mRoute : \x1B[92m${response.requestOptions.path}');
    } else {
      log(
          name: 'API',
          '\x1B[37m  RESPONSE \x1B[31m${response.statusCode} ❌ \x1B[36m=> \x1B[37mURL : \x1B[31m${response.requestOptions.baseUrl} \x1B[37mRoute : \x1B[31m${response.requestOptions.path}');
    }
  }
}

showLogOnError({
  required DioException error,
}) {
  log(
    name: '-',
    "\x1B[37m----------------------------------------------------------------------------",
  );
  Sentry.captureMessage(
      "ERREUR API FAILURE : ${error.response?.statusCode} ❌ URL : ${error.requestOptions.baseUrl} Route : ${error.requestOptions.path}");
  log(
      name: 'API',
      '\x1B[37m FAILURE \x1B[31m${error.response?.statusCode} ❌ \x1B[36m=> \x1B[37mURL : \x1B[31m${error.requestOptions.baseUrl} \x1B[37mRoute : \x1B[31m${error.requestOptions.path}');

  if (error.response?.data is Map &&
      error.response?.data.containsKey('message')) {
    if (error.response?.data['message'] != null) {
      log(
          name: 'API',
          '\x1B[37m FAILURE RESPONSE \x1B[31m${error.response?.statusCode} ❌ \x1B[36m=> \x1B[37mMessage : \x1B[31m${error.response?.data['message']} \x1B[37mRoute : \x1B[31m${error.requestOptions.path}');
    } else {
      log(
          name: 'API',
          '\x1B[37m FAILURE RESPONSE \x1B[31m${error.response?.statusCode} ❌ \x1B[36m=> \x1B[37mMessage : \x1B[31m${error.response?.data}');
    }
    log(
      '-'
      "\x1B[37m----------------------------------------------------------------------------",
    );
  }
}
