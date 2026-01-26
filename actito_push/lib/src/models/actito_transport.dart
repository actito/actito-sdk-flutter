import 'package:json_annotation/json_annotation.dart';

part 'actito_transport.g.dart';

/// Identifies the transport mechanism used to deliver a notification.
///
/// This value indicates the underlying push delivery service used by Actito,
/// such as APNS for iOS or GCM for Android.
@JsonEnum(alwaysCreate: true)
enum ActitoTransport {
  /// Indicates a temporarily registered device without remote notifications enabled,
  /// before a push transport (APNS or GCM) is available.
  @JsonValue('Notificare')
  notificare,

  /// Google Cloud Messaging.
  @JsonValue('GCM')
  gcm,

  /// Apple Push Notification Service
  @JsonValue('APNS')
  apns;

  /// Converts this option to its JSON string representation.
  factory ActitoTransport.fromJson(String json) =>
      _$ActitoTransportEnumMap.entries
          .firstWhere((element) => element.value == json)
          .key;
}
