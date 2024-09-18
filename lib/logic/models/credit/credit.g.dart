// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreditImpl _$$CreditImplFromJson(Map<String, dynamic> json) => _$CreditImpl(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      creditAvailable: (json['available'] as num?)?.toInt(),
      creditUsed: (json['used'] as num?)?.toInt(),
      notYetUsed: (json['not_yet_used'] as num?)?.toInt(),
      penalties: (json['penalties'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CreditImplToJson(_$CreditImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'available': instance.creditAvailable,
      'used': instance.creditUsed,
      'not_yet_used': instance.notYetUsed,
      'penalties': instance.penalties,
    };
