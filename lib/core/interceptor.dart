import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/interceptor_logger_helper.dart';

class RestApiInterceptor extends Interceptor {
  bool withAuth;
  RestApiInterceptor({required this.withAuth});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    showLogOnRequest(requestOptions: options);
    if (withAuth) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      options.headers["Authorization"] =
          'Bearer ${prefs.getString(LocalStorageKey.jwt.name)}';
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    showLogOnResponse(response: response);
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log(prefs.getString(LocalStorageKey.jwt.name).toString());
    showLogOnError(error: err);
    super.onError(err, handler);
  }
}
