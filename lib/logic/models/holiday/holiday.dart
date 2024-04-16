import 'package:freezed_annotation/freezed_annotation.dart';

part 'holiday.freezed.dart';
part 'holiday.g.dart';

@freezed
class Holiday with _$Holiday {
  const factory Holiday({
    @JsonKey(name: 'date') String? dateHoliday,
    @JsonKey(name: 'nom_jour_ferie') String? nameHoliday,
  }) = _Holiday;

  factory Holiday.fromJson(Map<String, dynamic> json) =>
      _$HolidayFromJson(json);
}

extension OnHolidayJson on Map<String, dynamic> {
  Holiday get toJwt {
    return Holiday.fromJson(this);
  }
}
