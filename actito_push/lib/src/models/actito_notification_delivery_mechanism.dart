import 'package:json_annotation/json_annotation.dart';

enum ActitoNotificationDeliveryMechanism {
  @JsonValue("standard")
  standard,

  @JsonValue("silent")
  silent,
}
