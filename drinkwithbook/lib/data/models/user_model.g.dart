// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      loyaltyPoints: (json['loyaltyPoints'] as num?)?.toInt() ?? 0,
      loyaltyLevel: json['loyaltyLevel'] as String? ?? 'bronze',
      clubMemberships:
          (json['clubMemberships'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      subscriptions:
          (json['subscriptions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      lastVisit:
          json['lastVisit'] == null
              ? null
              : DateTime.parse(json['lastVisit'] as String),
      isOwner: json['isOwner'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'loyaltyPoints': instance.loyaltyPoints,
      'loyaltyLevel': instance.loyaltyLevel,
      'clubMemberships': instance.clubMemberships,
      'subscriptions': instance.subscriptions,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastVisit': instance.lastVisit?.toIso8601String(),
      'isOwner': instance.isOwner,
    };

_$LoyaltyCardImpl _$$LoyaltyCardImplFromJson(Map<String, dynamic> json) =>
    _$LoyaltyCardImpl(
      userId: json['userId'] as String,
      points: (json['points'] as num?)?.toInt() ?? 0,
      level: json['level'] as String? ?? 'bronze',
      totalSpent: (json['totalSpent'] as num?)?.toInt() ?? 0,
      visitsCount: (json['visitsCount'] as num?)?.toInt() ?? 0,
      lastVisit:
          json['lastVisit'] == null
              ? null
              : DateTime.parse(json['lastVisit'] as String),
      transactions:
          (json['transactions'] as List<dynamic>?)
              ?.map(
                (e) => LoyaltyTransaction.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$LoyaltyCardImplToJson(_$LoyaltyCardImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'points': instance.points,
      'level': instance.level,
      'totalSpent': instance.totalSpent,
      'visitsCount': instance.visitsCount,
      'lastVisit': instance.lastVisit?.toIso8601String(),
      'transactions': instance.transactions,
    };

_$LoyaltyTransactionImpl _$$LoyaltyTransactionImplFromJson(
  Map<String, dynamic> json,
) => _$LoyaltyTransactionImpl(
  id: json['id'] as String,
  type: json['type'] as String,
  points: (json['points'] as num).toInt(),
  description: json['description'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  orderId: json['orderId'] as String?,
);

Map<String, dynamic> _$$LoyaltyTransactionImplToJson(
  _$LoyaltyTransactionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'points': instance.points,
  'description': instance.description,
  'createdAt': instance.createdAt.toIso8601String(),
  'orderId': instance.orderId,
};
