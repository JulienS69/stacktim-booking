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
          return left(l['message']);
        },
        (r) async {
          return right(
              r['data'].map<Computer>((e) => Computer.fromJson(e)).toList());
        },
      ),
    );
  }
}
