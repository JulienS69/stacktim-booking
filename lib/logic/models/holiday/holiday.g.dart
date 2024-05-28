// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HolidayImpl _$$HolidayImplFromJson(Map<String, dynamic> json) =>
    _$HolidayImpl(
      dateHoliday: json['date'] as String?,
      nameHoliday: json['nom_jour_ferie'] as String?,
    );

Map<String, dynamic> _$$HolidayImplToJson(_$HolidayImpl instance) =>
    <String, dynamic>{
      'date': instance.dateHoliday,
      'nom_jour_ferie': instance.nameHoliday,
    };
