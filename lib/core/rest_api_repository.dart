import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stacktim_booking/helper/snackbar.dart';

import '../navigation/route.dart';

abstract class RestApiRepository {
  final dio.Dio client;
  @protected
  final String _controller;

  String get controller => _controller;

  RestApiRepository({
    required String controller,
    required this.client,
  }) : _controller = controller;

  Future<Either<dynamic, dynamic>> handlingGetResponse({
    required String queryRoute,
    Map<String, dynamic>? queryParameters,
    bool? showError = true,
    bool? showSuccess = true,
    bool? isCustomResponse = false,
    String? overrideSuccessMessage,
    String? overrideErrorMessage,
    dio.ResponseType? responseType,
    dio.Options? options,
    Map<String, String>? header,
    String? contentType,
  }) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none ||
        queryRoute == '/translations') {
      try {
        dio.Response response = await client.get(queryRoute,
            queryParameters: queryParameters,
            options: options ??
                dio.Options(
                    headers: header,
                    responseType: responseType ?? dio.ResponseType.json,
                    contentType: contentType));
        return _verifError(
          response: response,
          showError: showError!,
          showSuccess: showSuccess!,
          isCustomResponse: isCustomResponse!,
          overrideSuccessMessage: overrideSuccessMessage,
          overrideErrorMessage: overrideErrorMessage,
        );
      } on DioException catch (exception, stackTrace) {
        Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );

        if (exception.response != null) {
          return _verifError(
            response: exception.response!,
            showError: showError!,
            showSuccess: showSuccess!,
            isCustomResponse: isCustomResponse!,
            overrideSuccessMessage: overrideSuccessMessage,
            overrideErrorMessage: overrideErrorMessage,
          );
        } else {
          String failure = 'restApiRequestException'.tr;
          if (showError!) {
            _flushToast(
              method: exception.requestOptions.method,
              isSuccess: false,
              isError: true,
              showSuccess: showSuccess!,
              showError: showError,
              customErrorMessage: failure,
            );
          }
        }
        return left(stackTrace.toString());
      } catch (exception, stackTrace) {
        Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
        return left(stackTrace.toString());
      }
    } else {
      Get.toNamed(Routes.offline);
      return left('pasdeconnection'.tr);
    }
  }

  Future<Either<dynamic, dynamic>> handlingPutResponse({
    required String queryRoute,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool? showError = true,
    bool? showSuccess = true,
    bool? isCustomResponse = false,
    String? overrideSuccessMessage,
    String? overrideErrorMessage,
    String? contentType,
  }) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none ||
        queryRoute == '/translations') {
      try {
        dio.Response response = await client.put(
          queryRoute,
          queryParameters: queryParameters,
          data: body,
          options: Options(headers: headers, contentType: contentType),
        );

        return _verifError(
          response: response,
          showError: showError!,
          showSuccess: showSuccess!,
          isCustomResponse: isCustomResponse!,
          overrideSuccessMessage: overrideSuccessMessage,
          overrideErrorMessage: overrideErrorMessage,
        );
      } on DioException catch (exception, stackTrace) {
        Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
        return _verifError(
          response: exception.response!,
          showError: showError!,
          showSuccess: showSuccess!,
          isCustomResponse: isCustomResponse!,
          overrideSuccessMessage: overrideSuccessMessage,
          overrideErrorMessage: overrideErrorMessage,
        );
      } catch (exception, stackTrace) {
        Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
        return left(stackTrace.toString());
      }
    } else {
      Get.toNamed(Routes.offline);
      return left('pasdeconnection'.tr);
    }
  }

  Future<Either<dynamic, dynamic>> handlingPatchResponse({
    required String queryRoute,
    required dynamic body,
    Map<String, dynamic>? queryParameters,
    bool? showError = true,
    bool? showSuccess = true,
    bool? isCustomResponse = false,
    String? overrideSuccessMessage,
    String? overrideErrorMessage,
  }) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none ||
        queryRoute == '/translations') {
      try {
        dio.Response response = await client.patch(
          queryRoute,
          queryParameters: queryParameters,
          data: body,
        );

        return _verifError(
          response: response,
          showError: showError!,
          showSuccess: showSuccess!,
          isCustomResponse: isCustomResponse!,
          overrideSuccessMessage: overrideSuccessMessage,
          overrideErrorMessage: overrideErrorMessage,
        );
      } on DioException catch (exception, stackTrace) {
        Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
        return _verifError(
          response: exception.response!,
          showError: showError!,
          showSuccess: showSuccess!,
          isCustomResponse: isCustomResponse!,
          overrideSuccessMessage: overrideSuccessMessage,
          overrideErrorMessage: overrideErrorMessage,
        );
      } catch (exception, stackTrace) {
        Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
        return left(stackTrace.toString());
      }
    } else {
      Get.toNamed(Routes.offline);
      return left('pasdeconnection'.tr);
    }
  }

  Future<Either<dynamic, dynamic>> handlingPostResponse({
    required String queryRoute,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? header,
    bool? showError = true,
    bool? showSuccess = true,
    bool? isCustomResponse = false,
    String? overrideSuccessMessage,
    String? overrideErrorMessage,
  }) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none ||
        queryRoute == '/translations') {
      try {
        dio.Response response = await client.post(
          queryRoute,
          options: Options(
            headers: header,
            validateStatus: (status) =>
                status != null && (status >= 200 && status < 300) ||
                status == 422,
          ),
          queryParameters: queryParameters,
          data: body,
        );

        return _verifError(
          response: response,
          showError: showError!,
          showSuccess: showSuccess!,
          isCustomResponse: isCustomResponse!,
          overrideSuccessMessage: overrideSuccessMessage,
          overrideErrorMessage: overrideErrorMessage,
        );
      } on DioException catch (exception, stackTrace) {
        debugPrint("\x1B[31mDIO EXCEPTION : $exception");
        Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
        if (exception.response == null) {
          return left("Response is null");
        }
        return _verifError(
          response: exception.response!,
          showError: showError!,
          showSuccess: showSuccess!,
          isCustomResponse: isCustomResponse!,
          overrideSuccessMessage: overrideSuccessMessage,
          overrideErrorMessage: overrideErrorMessage,
        );
      } catch (exception, stackTrace) {
        Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
        return left(stackTrace.toString());
      }
    } else {
      Get.toNamed(Routes.offline);
      return left('pasdeconnection'.tr);
    }
  }

  Future<Either<dynamic, dynamic>> handlingDeleteResponse({
    required String queryRoute,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    dynamic body,
    Options? options,
    bool? showError = true,
    bool? showSuccess = true,
    bool? isCustomResponse = false,
    String? overrideSuccessMessage,
    String? overrideErrorMessage,
  }) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none &&
        queryRoute != '/translations') {
      try {
        dio.Response response = await client.delete(
          queryRoute,
          queryParameters: queryParameters,
          data: body,
          options: options,
        );
        return _verifError(
          response: response,
          showError: showError!,
          showSuccess: showSuccess!,
          isCustomResponse: isCustomResponse!,
          overrideSuccessMessage: overrideSuccessMessage,
          overrideErrorMessage: overrideErrorMessage,
        );
      } on DioException catch (exception, stackTrace) {
        Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
        return _verifError(
          response: exception.response!,
          showError: showError!,
          showSuccess: showSuccess!,
          isCustomResponse: isCustomResponse!,
          overrideSuccessMessage: overrideSuccessMessage,
          overrideErrorMessage: overrideErrorMessage,
        );
      } catch (exception, stackTrace) {
        Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
        _flushToast(
          showError: true,
          method: 'EXCEPTION',
          showSuccess: false,
          isSuccess: false,
          isError: true,
        );
        return left(stackTrace.toString());
      }
    } else {
      Get.toNamed(Routes.offline);
      return left('pasdeconnection'.tr);
    }
  }

  /// Vérifie si la réponse contient des erreurs, renvoie un Either en fonction
  Either<dynamic, dynamic> _verifError({
    required dio.Response response,
    required bool showError,
    required bool showSuccess,
    required bool isCustomResponse,
    String? overrideSuccessMessage,
    String? overrideErrorMessage,
  }) {
    bool isSuccess = (response.statusCode ?? 520) >= 200 &&
        (response.statusCode ?? 520) <= 206;
    try {
      if (isSuccess) {
        if (isCustomResponse) {
          _flushToast(
            method: response.requestOptions.method,
            isSuccess: isSuccess,
            isError: false,
            showSuccess: showSuccess,
            showError: showError,
            customSuccessMessage:
                overrideSuccessMessage ?? response.data['message'],
          );
          return right(response.data);
        } else {
          _flushToast(
            method: response.requestOptions.method,
            isSuccess: isSuccess,
            isError: false,
            showSuccess: showSuccess,
            showError: showError,
            customSuccessMessage: overrideSuccessMessage,
          );
          // if (!response.data.containsKey("data")) {
          //   response.data["data"] = "{}";
          // } else {
          //   response.data;
          // }
          // if (response.data.containsKey('meta')) {
          //   List<dynamic> element = response.data['data'];
          //   for (var value in element) {
          //     value.addAll(
          //       {'meta': response.data['meta']},
          //     );
          //   }
          // }
          return right(response.data);
        }
      } else {
        debugPrint("isCustomResponse: ${response.data}");
        if (isCustomResponse) {
          if (showError) {
            String customMessage = response.data['message'];
            String? details;
            if (response.data.containsKey('details')) {
              details = response.data['details'];
            }
            _flushToast(
              method: response.requestOptions.method,
              isSuccess: isSuccess,
              isError: true,
              showSuccess: showSuccess,
              showError: showError,
              customErrorMessage:
                  overrideErrorMessage ?? details ?? customMessage,
            );
          }
          return left(response.data);
        } else if (showError) {
          String customMessage = response.data['message'];
          _flushToast(
            method: response.requestOptions.method,
            isSuccess: isSuccess,
            isError: true,
            showSuccess: showSuccess,
            showError: showError,
            customErrorMessage: overrideErrorMessage ?? customMessage,
          );
        }
        return left(response.data);
      }
    } catch (exception, stackTrace) {
      Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      String failure = 'restApiRequestException'.tr;
      if (showError) {
        _flushToast(
          method: response.requestOptions.method,
          isSuccess: isSuccess,
          isError: true,
          showSuccess: showSuccess,
          showError: showError,
          customErrorMessage: failure,
        );
      }
      return left(failure);
    }
  }
}

void _flushToast({
  required String method,
  required bool isSuccess,
  required bool isError,
  required bool showSuccess,
  required bool showError,
  String? customSuccessMessage,
  String? customErrorMessage,
}) {
  String message = "";
  switch (method) {
    case "POST":
      message = isSuccess
          ? customSuccessMessage ?? "storeSuccess".tr
          : customErrorMessage ?? "storeError".tr;
      break;
    case "PUT":
      message = isSuccess
          ? customErrorMessage ?? "successUpdate".tr.capitalizeFirst!
          : customErrorMessage ?? "updateError".tr;
      break;
    case "DELETE":
      message = isSuccess
          ? customErrorMessage ?? "successDelete".tr
          : customErrorMessage ?? "deleteError".tr;
      break;
    case "PATCH":
      message = isSuccess
          ? customErrorMessage ?? "successUpdate".tr.capitalizeFirst!
          : customErrorMessage ?? "updateError".tr;
      break;
    case "EXCEPTION":
      message = "unexpectedError".tr;
      break;
  }
  if (method != "GET") {
    if (Get.context != null) {
      if (isSuccess && showSuccess) {
        showSnackbar(message, SnackStatusEnum.success);
      } else if (showError && isError) {
        showSnackbar(message, SnackStatusEnum.error);
      }
    }
  }
}
