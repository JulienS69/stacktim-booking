import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stacktim_booking/logic/models/pivot/pivot.dart';

part 'role.freezed.dart';
part 'role.g.dart';

@freezed
class Role with _$Role {
  const factory Role({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? roleName,
    @JsonKey(name: 'guard_name') String? guardName,
    // @JsonKey(name: 'pivot') Pivot? pivot,
  }) = _Role;

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);
}

extension OnUserJson on Map<String, dynamic> {
  Role get toJwt {
    return Role.fromJson(this);
  }
}
