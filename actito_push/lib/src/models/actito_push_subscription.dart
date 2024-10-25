import 'package:json_annotation/json_annotation.dart';

part 'actito_push_subscription.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoPushSubscription {
  final String? token;

  ActitoPushSubscription({required this.token});

  factory ActitoPushSubscription.fromJson(Map<String, dynamic> json) =>
      _$ActitoPushSubscriptionFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoPushSubscriptionToJson(this);
}
