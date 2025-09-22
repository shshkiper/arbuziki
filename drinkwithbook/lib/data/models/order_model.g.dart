// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderModelImpl _$$OrderModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      items:
          (json['items'] as List<dynamic>)
              .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
              .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      readyAt:
          json['readyAt'] == null
              ? null
              : DateTime.parse(json['readyAt'] as String),
      completedAt:
          json['completedAt'] == null
              ? null
              : DateTime.parse(json['completedAt'] as String),
      notes: json['notes'] as String?,
      orderType: json['orderType'] as String? ?? 'pickup',
      estimatedTime: (json['estimatedTime'] as num?)?.toInt(),
      loyaltyPointsEarned: (json['loyaltyPointsEarned'] as num?)?.toInt() ?? 0,
      loyaltyPointsUsed: (json['loyaltyPointsUsed'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$OrderModelImplToJson(_$OrderModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'items': instance.items,
      'totalAmount': instance.totalAmount,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'readyAt': instance.readyAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'notes': instance.notes,
      'orderType': instance.orderType,
      'estimatedTime': instance.estimatedTime,
      'loyaltyPointsEarned': instance.loyaltyPointsEarned,
      'loyaltyPointsUsed': instance.loyaltyPointsUsed,
    };

_$OrderItemImpl _$$OrderItemImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemImpl(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      customizations: json['customizations'] as Map<String, dynamic>?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$OrderItemImplToJson(_$OrderItemImpl instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'quantity': instance.quantity,
      'price': instance.price,
      'customizations': instance.customizations,
      'notes': instance.notes,
    };
