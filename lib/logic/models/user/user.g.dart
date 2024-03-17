// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String?,
      firstname: json['fistname'] as String?,
      lastName: json['lastname'] as String?,
      nickName: json['nickname'] as String?,
      email: json['email'] as String?,
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
      credit: json['credit'] == null
          ? null
          : Credit.fromJson(json['credit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fistname': instance.firstname,
      'lastname': instance.lastName,
      'nickname': instance.nickName,
      'email': instance.email,
      'roles': instance.roles,
      'credit': instance.credit,
    };
