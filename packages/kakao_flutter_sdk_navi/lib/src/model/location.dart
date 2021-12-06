import 'package:kakao_flutter_sdk_common/common.dart';

part 'location.g.dart';

/// 카카오내비에서 장소를 표현합니다.
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class Location {
  /// name 장소 이름. 예) 우리집, 회사
  final String name;

  /// 경도 좌표
  final String x;

  /// 위도 좌표
  final String y;
  @JsonKey(name: "rpflag")
  final String? rpFlag;

  /// @nodoc
  Location(this.name, this.x, this.y, {this.rpFlag});

  /// @nodoc
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  /// @nodoc
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}