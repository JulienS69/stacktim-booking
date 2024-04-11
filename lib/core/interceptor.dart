import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacktim_booking/helper/functions.dart';

class RestApiInterceptor extends Interceptor {
  bool withAuth;
  RestApiInterceptor({required this.withAuth});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint(
        '\x1B[36mREQUEST[${options.method}] => PATH: ${options.path}\x1B[0m');
    if (options.queryParameters.isNotEmpty) {
      debugPrint('\x1B[34mQUERYPARAMS => ${options.queryParameters}\x1B[0m');
    }
    if (options.data != null) {
      if (options.data is FormData) {
        debugPrint(
            '\x1B[33mREQUEST FORMDATA BODY FIELDS => ${options.data.fields.toList().toString()}\x1B[0m');
      } else {
        debugPrint('\x1B[33mREQUEST BODY => ${options.data}\x1B[0m');
      }
    }

    if (withAuth) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      log(prefs.getString(LocalStorageKey.jwt.name).toString());
      options.headers["Authorization"] =
          'Bearer ${prefs.getString(LocalStorageKey.jwt.name)}';
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        '\x1B[36mRESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.baseUrl} -- ${response.requestOptions.path}\x1B[0m');
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
  }

  kickoutUser(String message) async {}
}
