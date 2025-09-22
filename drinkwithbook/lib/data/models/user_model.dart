import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    String? name,
    String? avatarUrl,
    @Default(0) int loyaltyPoints,
    @Default('bronze') String loyaltyLevel,
    @Default([]) List<String> clubMemberships,
    @Default([]) List<String> subscriptions,
    DateTime? createdAt,
    DateTime? lastVisit,
    @Default(false) bool isOwner,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
class LoyaltyCard with _$LoyaltyCard {
  const factory LoyaltyCard({
    required String userId,
    @Default(0) int points,
    @Default('bronze') String level,
    @Default(0) int totalSpent,
    @Default(0) int visitsCount,
    DateTime? lastVisit,
    @Default([]) List<LoyaltyTransaction> transactions,
  }) = _LoyaltyCard;

  factory LoyaltyCard.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyCardFromJson(json);
}

@freezed
class LoyaltyTransaction with _$LoyaltyTransaction {
  const factory LoyaltyTransaction({
    required String id,
    required String type, // 'earned' or 'spent'
    required int points,
    required String description,
    required DateTime createdAt,
    String? orderId,
  }) = _LoyaltyTransaction;

  factory LoyaltyTransaction.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyTransactionFromJson(json);
}
