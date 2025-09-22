import 'package:freezed_annotation/freezed_annotation.dart';

part 'club_model.freezed.dart';
part 'club_model.g.dart';

@freezed
class ClubModel with _$ClubModel {
  const factory ClubModel({
    required String id,
    required String name,
    required String description,
    required String type, // 'coffee', 'tea', 'book'
    String? imageUrl,
    @Default([]) List<String> memberIds,
    @Default([]) List<ClubEvent> events,
    @Default([]) List<ClubPost> posts,
    required DateTime createdAt,
    String? createdBy,
    @Default(false) bool isPrivate,
    @Default([]) List<String> tags,
  }) = _ClubModel;

  factory ClubModel.fromJson(Map<String, dynamic> json) =>
      _$ClubModelFromJson(json);
}

@freezed
class ClubEvent with _$ClubEvent {
  const factory ClubEvent({
    required String id,
    required String clubId,
    required String title,
    required String description,
    required DateTime scheduledAt,
    String? location,
    @Default([]) List<String> attendeeIds,
    required String createdBy,
    required DateTime createdAt,
    @Default('upcoming') String status, // 'upcoming', 'ongoing', 'completed', 'cancelled'
  }) = _ClubEvent;

  factory ClubEvent.fromJson(Map<String, dynamic> json) =>
      _$ClubEventFromJson(json);
}

@freezed
class ClubPost with _$ClubPost {
  const factory ClubPost({
    required String id,
    required String clubId,
    required String authorId,
    required String authorName,
    required String content,
    @Default([]) List<String> imageUrls,
    @Default([]) List<ClubComment> comments,
    @Default(0) int likesCount,
    @Default([]) List<String> likedBy,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _ClubPost;

  factory ClubPost.fromJson(Map<String, dynamic> json) =>
      _$ClubPostFromJson(json);
}

@freezed
class ClubComment with _$ClubComment {
  const factory ClubComment({
    required String id,
    required String authorId,
    required String authorName,
    required String content,
    required DateTime createdAt,
  }) = _ClubComment;

  factory ClubComment.fromJson(Map<String, dynamic> json) =>
      _$ClubCommentFromJson(json);
}

@freezed
class Subscription with _$Subscription {
  const factory Subscription({
    required String id,
    required String userId,
    required String type, // 'coffee_monthly', 'tea_weekly', etc.
    required String name,
    required double price,
    required String frequency, // 'weekly', 'monthly'
    @Default('active') String status, // 'active', 'paused', 'cancelled'
    required DateTime startDate,
    DateTime? endDate,
    DateTime? nextDelivery,
    @Default([]) List<String> productIds,
    Map<String, dynamic>? preferences,
  }) = _Subscription;

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);
}
