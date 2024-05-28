// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'computer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ComputerImpl _$$ComputerImplFromJson(Map<String, dynamic> json) =>
    _$ComputerImpl(
      id: json['id'] as String?,
      number: json['number'] as int?,
      slug: json['slug'] as String?,
      isUnderMaintenance: json['is_under_maintenance'] as bool?,
      isAvailable: json['is_available'] as bool?,
    );

Map<String, dynamic> _$$ComputerImplToJson(_$ComputerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'slug': instance.slug,
      'is_under_maintenance': instance.isUnderMaintenance,
      'is_available': instance.isAvailable,
    };
