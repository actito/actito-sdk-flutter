import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_pass.g.dart';

/// Represents a digital pass issued by Actito.
///
/// An [ActitoPass] can be used for loyalty programs, coupons, tickets, or other
/// redeemable items. It includes metadata, redemption history, and optional
/// integrations with mobile wallets like Apple Wallet or Google Pay.
@JsonSerializable(anyMap: true, explicitToJson: true)
@ActitoIsoDateTimeConverter()
class ActitoPass {
  /// Unique identifier of the pass.
  final String id;

  /// Optional type of the pass.
  ///
  /// Supported pass types:
  ///
  /// - `boarding`
  /// - `coupon`
  /// - `ticket`
  /// - `generic`
  /// - `card`
  final String? type;

  /// Version of the pass.
  final int version;

  /// Optional Apple Wallet passbook URL or identifier.
  final String? passbook;

  /// Optional template identifier used to generate the pass.
  final String? template;

  /// Serial number of the pass.
  final String serial;

  /// Barcode value associated with the pass.
  final String barcode;

  /// Redemption behavior of the pass.
  ///
  /// Supported redemption modes:
  ///
  /// - `once` — the pass can be redeemed a single time
  /// - `limit` — the pass can be redeemed a limited number of times
  /// - `always` — the pass can be redeemed an unlimited number of times
  final String redeem;

  /// History of past redemptions for this pass.
  final List<ActitoPassRedemption> redeemHistory;

  /// Maximum number of times the pass can be redeemed.
  final int limit;

  /// Token associated with the pass for secure validation.
  final String token;

  /// Additional custom data associated with the pass.
  final Map<String, dynamic> data;

  /// Timestamp indicating when the pass was created or issued.
  final DateTime date;

  /// Optional link to save the pass to Google Pay.
  final String? googlePaySaveLink;

  /// Constructor for [ActitoPass].
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

  /// Creates an [ActitoPass] from a JSON map.
  factory ActitoPass.fromJson(Map<String, dynamic> json) =>
      _$ActitoPassFromJson(json);

  /// Converts this [ActitoPass] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoPassToJson(this);
}

/// Represents a single redemption record for an Actito pass.
///
/// Each [ActitoPassRedemption] records the time and optional comments
/// when a pass was redeemed.
@JsonSerializable(anyMap: true, explicitToJson: true)
@ActitoIsoDateTimeConverter()
class ActitoPassRedemption {
  /// Optional comments associated with the redemption.
  final String? comments;

  /// Timestamp when the pass was redeemed.
  final DateTime date;

  /// Creates an [ActitoPassRedemption].
  ActitoPassRedemption({
    required this.comments,
    required this.date,
  });

  /// Constructor for [ActitoPassRedemption] from a JSON map.
  factory ActitoPassRedemption.fromJson(Map<String, dynamic> json) =>
      _$ActitoPassRedemptionFromJson(json);

  /// Converts this [ActitoPassRedemption] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoPassRedemptionToJson(this);
}
