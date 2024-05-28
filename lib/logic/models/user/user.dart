import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/logic/models/credit/credit.dart';
import 'package:stacktim_booking/logic/models/role/role.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'firstname') String? firstname,
    @JsonKey(name: 'lastname') String? lastName,
    @JsonKey(name: 'nickname') String? nickName,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'roles') List<Role>? roles,
    @JsonKey(name: 'credit') Credit? credit,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

extension OnUserJson on Map<String, dynamic> {
  User get toJwt {
    return User.fromJson(this);
  }
}

extension OnUser on User {
  String get fullName =>
      '${firstname?.capitalizeFirst ?? "[Prénom]"} ${lastName?.toUpperCase() ?? "[NOM]"}';
}
