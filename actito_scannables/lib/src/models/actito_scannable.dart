import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_scannable.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoScannable {
  final String id;
  final String name;
  final String tag;
  final String type;
  final ActitoNotification? notification;

  ActitoScannable({
    required this.id,
    required this.name,
    required this.tag,
    required this.type,
    required this.notification,
  });

  factory ActitoScannable.fromJson(Map<String, dynamic> json) =>
      _$ActitoScannableFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoScannableToJson(this);
}
