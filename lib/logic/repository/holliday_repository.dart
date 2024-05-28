import 'package:dio/dio.dart';

import '../models/holiday/holiday.dart';

class HolidayRepository {
  final Dio _dio = Dio();

  Future<List<Holiday>> fetchFrenchHolidays(int year) async {
    try {
      Response response = await _dio
          .get('https://jours-feries-france.antoine-augusti.fr/api/$year');
      if (response.statusCode == 200) {
        var data = response.data;
        return data.map<Holiday>((e) => Holiday.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load holidays: $e');
    }
  }
}
