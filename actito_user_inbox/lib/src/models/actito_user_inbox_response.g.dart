// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_user_inbox_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoUserInboxResponse _$ActitoUserInboxResponseFromJson(Map json) =>
    ActitoUserInboxResponse(
      count: json['count'] as int,
      unread: json['unread'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) =>
              ActitoUserInboxItem.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$ActitoUserInboxResponseToJson(
        ActitoUserInboxResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'unread': instance.unread,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
