import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stacktim_booking/logic/models/media/media.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
class Game with _$Game {
  const factory Game({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'label') String? label,
    @JsonKey(name: 'order') int? order,
    @JsonKey(name: 'media') List<Media>? media,
    bool? isSelected,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}

extension OnGameJson on Map<String, dynamic> {
  Game get toJwt {
    return Game.fromJson(this);
  }
}
