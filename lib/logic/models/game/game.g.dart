// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameImpl _$$GameImplFromJson(Map<String, dynamic> json) => _$GameImpl(
      id: json['id'] as String?,
      label: json['label'] as String?,
      order: (json['order'] as num?)?.toInt(),
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList(),
      isSelected: json['isSelected'] as bool?,
    );

Map<String, dynamic> _$$GameImplToJson(_$GameImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'order': instance.order,
      'media': instance.media,
      'isSelected': instance.isSelected,
    };
