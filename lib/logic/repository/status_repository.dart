import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/logic/models/status/status.dart';

import '../../core/rest_api_repository.dart';

class StatusRepository extends RestApiRepository {
  StatusRepository()
      : super(
            client: Get.find<Dio>(tag: 'stacktimApi'), controller: '/statuses');

  Future<Either<dynamic, List<Status>>> getStatusList() async {
    return await handlingPostResponse(
      queryRoute: "$controller/search",
      showError: false,
      showSuccess: false,
      isCustomResponse: true,
    ).then(
      (value) => value.fold(
        (l) async {
          return left(l['message']);
        },
        (r) async {
          return right(
            r['data'].map<Status>((e) => Status.fromJson(e)).toList(),
          );
        },
      ),
    );
  }
}
