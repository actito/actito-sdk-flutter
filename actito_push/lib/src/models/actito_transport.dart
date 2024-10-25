import 'package:json_annotation/json_annotation.dart';

part 'actito_transport.g.dart';

@JsonEnum(alwaysCreate: true)
enum ActitoTransport {
  @JsonValue('Notificare')
  notificare,

  @JsonValue('GCM')
  gcm,

  @JsonValue('APNS')
  apns;

  factory ActitoTransport.fromJson(String json) =>
      _$ActitoTransportEnumMap.entries
          .firstWhere((element) => element.value == json)
          .key;
}
