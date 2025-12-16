import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_pass.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
@ActitoIsoDateTimeConverter()
class ActitoPass {
  final String id;
  final String? type;
  final int version;
  final String? passbook;
  final String? template;
  final String serial;
  final String barcode;
  final String redeem;
  final List<ActitoPassRedemption> redeemHistory;
  final int limit;
  final String token;
  final Map<String, dynamic> data;
  final DateTime date;
  final String? googlePaySaveLink;

  ActitoPass({
    required this.id,
    required this.type,
    required this.version,
    required this.passbook,
    required this.template,
    required this.serial,
    required this.barcode,
    required this.redeem,
    required this.redeemHistory,
    required this.limit,
    required this.token,
    required this.data,
    required this.date,
    required this.googlePaySaveLink,
  });

  factory ActitoPass.fromJson(Map<String, dynamic> json) =>
      _$ActitoPassFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoPassToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
@ActitoIsoDateTimeConverter()
class ActitoPassRedemption {
  final String? comments;
  final DateTime date;

  ActitoPassRedemption({
    required this.comments,
    required this.date,
  });

  factory ActitoPassRedemption.fromJson(Map<String, dynamic> json) =>
      _$ActitoPassRedemptionFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoPassRedemptionToJson(this);
}
