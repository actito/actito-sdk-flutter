import 'package:json_annotation/json_annotation.dart';

part 'actito_dynamic_link.g.dart';

/// Represents a dynamic link configuration in Actito.
///
/// A dynamic link defines a target destination that can be resolved or interpreted,
/// such as a deep link, in-app route, or external URL.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoDynamicLink {
  /// The target destination of the dynamic link.
  final String target;

  /// Constructor for [ActitoDynamicLink].
  ActitoDynamicLink({
    required this.target,
  });

  /// Creates an [ActitoDynamicLink] from a JSON map.
  factory ActitoDynamicLink.fromJson(Map<String, dynamic> json) =>
      _$ActitoDynamicLinkFromJson(json);

  /// Converts this [ActitoDynamicLink] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoDynamicLinkToJson(this);
}
