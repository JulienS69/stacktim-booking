import 'package:freezed_annotation/freezed_annotation.dart';

part 'pivot.freezed.dart';
part 'pivot.g.dart';

@freezed
class Pivot with _$Pivot {
  const factory Pivot({
    @JsonKey(name: 'model_id') String? modelId,
    @JsonKey(name: 'model_type') String? modelType,
    @JsonKey(name: 'role_id') int? roleId,
  }) = _Pivot;

  factory Pivot.fromJson(Map<String, dynamic> json) => _$PivotFromJson(json);
}

extension OnUserJson on Map<String, dynamic> {
  Pivot get toJwt {
    return Pivot.fromJson(this);
  }
}
