import 'package:json_annotation/json_annotation.dart';

/// JSON converter for ISO 8601 date-time values used by the Actito API.
class ActitoIsoDateTimeConverter implements JsonConverter<DateTime, String> {
  /// Creates an [ActitoIsoDateTimeConverter].
  const ActitoIsoDateTimeConverter();

  /// Converts an ISO 8601 string to a local [DateTime].
  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json).toLocal();
  }

  /// Converts a [DateTime] to an ISO 8601 UTC string.
  @override
  String toJson(DateTime json) => json.toUtc().toIso8601String();
}
