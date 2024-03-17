import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'fistname') String? firstname,
    @JsonKey(name: 'pseudo') String? pseudo,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

extension OnUserJson on Map<String, dynamic> {
  User get toJwt {
    return User.fromJson(this);
  }
}
