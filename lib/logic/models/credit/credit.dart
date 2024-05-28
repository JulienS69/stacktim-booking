import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit.freezed.dart';
part 'credit.g.dart';

@freezed
class Credit with _$Credit {
  const factory Credit({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'available') int? creditAvailable,
    @JsonKey(name: 'used') int? creditUsed,
    @JsonKey(name: 'not_yet_used') int? notYetUsed,
    @JsonKey(name: 'penalties') int? penalties,
  }) = _Credit;

  factory Credit.fromJson(Map<String, dynamic> json) => _$CreditFromJson(json);
}

extension OnUserJson on Map<String, dynamic> {
  Credit get toJwt {
    return Credit.fromJson(this);
  }
}
