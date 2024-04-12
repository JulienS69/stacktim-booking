import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../core/rest_api_repository.dart';

class LoginRepository extends RestApiRepository {
  LoginRepository()
      : super(client: Get.find<Dio>(tag: 'stacktimApi'), controller: '');

  Future<Either<dynamic, dynamic>> getMicrosoftUrl() async {
    return await handlingGetResponse(
      queryRoute: "/azure/auth/redirect",
      showError: false,
      showSuccess: false,
    ).then(
      (value) => value.fold(
        (l) async {
          if (l is Map && l.containsKey("message")) {
            return left(l["message"]);
          }
          return left(l);
        },
        (r) async {
          return right(r);
        },
      ),
    );
  }
}
