import 'package:json_annotation/json_annotation.dart';

import 'actito_time.dart';

part 'actito_do_not_disturb.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoDoNotDisturb {
  final ActitoTime start;
  final ActitoTime end;

  ActitoDoNotDisturb({
    required this.start,
    required this.end,
  });

  factory ActitoDoNotDisturb.fromJson(Map<String, dynamic> json) => _$ActitoDoNotDisturbFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoDoNotDisturbToJson(this);
}
