import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_visit.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
@ActitoIsoDateTimeConverter()
class ActitoVisit {
  final DateTime departureDate;
  final DateTime arrivalDate;
  final double latitude;
  final double longitude;

  ActitoVisit({
    required this.departureDate,
    required this.arrivalDate,
    required this.latitude,
    required this.longitude,
  });

  factory ActitoVisit.fromJson(Map<String, dynamic> json) =>
      _$ActitoVisitFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoVisitToJson(this);
}
