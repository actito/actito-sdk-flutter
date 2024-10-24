import 'package:json_annotation/json_annotation.dart';

part 'actito_dynamic_link.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoDynamicLink {
  final String target;

  ActitoDynamicLink({
    required this.target,
  });

  factory ActitoDynamicLink.fromJson(Map<String, dynamic> json) => _$ActitoDynamicLinkFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoDynamicLinkToJson(this);
}
