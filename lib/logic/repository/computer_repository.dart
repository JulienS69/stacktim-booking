import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/logic/models/computer/computer.dart';

import '../../core/rest_api_repository.dart';

class ComputerRepository extends RestApiRepository {
  ComputerRepository()
      : super(
            client: Get.find<Dio>(tag: 'stacktimApi'),
            controller: '/computers');

  Future<Either<dynamic, List<Computer>>> getComputersList() async {
    return await handlingPostResponse(
      queryRoute: "$controller/search",
      showError: false,
      showSuccess: false,
      isCustomResponse: true,
    ).then(
      (value) => value.fold(
        (l) async {
          if (l is Map && l.containsKey("message")) {
            return l["message"];
          } else {
            return left(l);
          }
        },
        (r) async {
          return right(
              r['data'].map<Computer>((e) => Computer.fromJson(e)).toList());
        },
      ),
    );
  }

  Future<Either<dynamic, List<Computer>>> checkComputerAvailable({
    required String datePicked,
    required String beginHourPicked,
    required String endHourPicked,
  }) async {
    return await handlingGetResponse(
        queryRoute: "$controller/availableBetweenDates",
        showError: false,
        showSuccess: false,
        isCustomResponse: true,
        queryParameters: {
          'booked_at': datePicked,
          'begin_at': beginHourPicked,
          'end_at': endHourPicked,
        }).then(
      (value) => value.fold(
        (l) async {
          if (l is Map && l.containsKey("message")) {
            return l["message"];
          } else {
            return left(l);
          }
        },
        (r) async {
          return right(
              r['data'].map<Computer>((e) => Computer.fromJson(e)).toList());
        },
      ),
    );
  }
}
