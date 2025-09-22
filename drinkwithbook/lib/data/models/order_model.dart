import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  const factory OrderModel({
    required String id,
    required String userId,
    required List<OrderItem> items,
    required double totalAmount,
    required String status, // 'pending', 'preparing', 'ready', 'completed', 'cancelled'
    required DateTime createdAt,
    DateTime? readyAt,
    DateTime? completedAt,
    String? notes,
    @Default('pickup') String orderType, // 'pickup', 'delivery'
    int? estimatedTime,
    @Default(0) int loyaltyPointsEarned,
    @Default(0) int loyaltyPointsUsed,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}

@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    required String productId,
    required String productName,
    required int quantity,
    required double price,
    Map<String, dynamic>? customizations,
    String? notes,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}
