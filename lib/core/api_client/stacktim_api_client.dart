import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/core/interceptor.dart';
import 'package:stacktim_booking/helper/strings.dart';

class StacktimHttpClient extends GetxService {
  Future<Dio> init() async {
    final client = Dio();
    client.options.baseUrl = rdStacktimBookingApi;
    client.options.receiveTimeout = const Duration(seconds: 15);
    client.options.sendTimeout = const Duration(seconds: 15);
    client.options.connectTimeout = const Duration(seconds: 15);
    client.options.headers["Accept"] = "application/json";
    client.options.contentType = 'application/json; charset=utf-8';
    client.interceptors.add(RestApiInterceptor(withAuth: true));
    return client;
  }
}
