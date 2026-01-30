import 'package:json_annotation/json_annotation.dart';

import 'actito_time.dart';

part 'actito_do_not_disturb.g.dart';

/// Defines a do-not-disturb time window for an Actito device.
///
/// During this period, notifications or communications may be suppressed
/// according to Actito configuration.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoDoNotDisturb {
  /// Start time of the do-not-disturb period.
  final ActitoTime start;

  /// End time of the do-not-disturb period.
  final ActitoTime end;

  /// Constructor for [ActitoDoNotDisturb].
  ActitoDoNotDisturb({
    required this.start,
    required this.end,
  });

  /// Creates an [ActitoDoNotDisturb] from a JSON map.
  factory ActitoDoNotDisturb.fromJson(Map<String, dynamic> json) =>
      _$ActitoDoNotDisturbFromJson(json);

  /// Converts this [ActitoDoNotDisturb] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoDoNotDisturbToJson(this);
}
