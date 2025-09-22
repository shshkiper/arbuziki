// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubModelImpl _$$ClubModelImplFromJson(Map<String, dynamic> json) =>
    _$ClubModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      imageUrl: json['imageUrl'] as String?,
      memberIds:
          (json['memberIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      events:
          (json['events'] as List<dynamic>?)
              ?.map((e) => ClubEvent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      posts:
          (json['posts'] as List<dynamic>?)
              ?.map((e) => ClubPost.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      createdBy: json['createdBy'] as String?,
      isPrivate: json['isPrivate'] as bool? ?? false,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
    );

Map<String, dynamic> _$$ClubModelImplToJson(_$ClubModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'imageUrl': instance.imageUrl,
      'memberIds': instance.memberIds,
      'events': instance.events,
      'posts': instance.posts,
      'createdAt': instance.createdAt.toIso8601String(),
      'createdBy': instance.createdBy,
      'isPrivate': instance.isPrivate,
      'tags': instance.tags,
    };

_$ClubEventImpl _$$ClubEventImplFromJson(Map<String, dynamic> json) =>
    _$ClubEventImpl(
      id: json['id'] as String,
      clubId: json['clubId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      location: json['location'] as String?,
      attendeeIds:
          (json['attendeeIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdBy: json['createdBy'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String? ?? 'upcoming',
    );

Map<String, dynamic> _$$ClubEventImplToJson(_$ClubEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clubId': instance.clubId,
      'title': instance.title,
      'description': instance.description,
      'scheduledAt': instance.scheduledAt.toIso8601String(),
      'location': instance.location,
      'attendeeIds': instance.attendeeIds,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt.toIso8601String(),
      'status': instance.status,
    };

_$ClubPostImpl _$$ClubPostImplFromJson(
  Map<String, dynamic> json,
) => _$ClubPostImpl(
  id: json['id'] as String,
  clubId: json['clubId'] as String,
  authorId: json['authorId'] as String,
  authorName: json['authorName'] as String,
  content: json['content'] as String,
  imageUrls:
      (json['imageUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  comments:
      (json['comments'] as List<dynamic>?)
          ?.map((e) => ClubComment.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
  likedBy:
      (json['likedBy'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$ClubPostImplToJson(_$ClubPostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clubId': instance.clubId,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'content': instance.content,
      'imageUrls': instance.imageUrls,
      'comments': instance.comments,
      'likesCount': instance.likesCount,
      'likedBy': instance.likedBy,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$ClubCommentImpl _$$ClubCommentImplFromJson(Map<String, dynamic> json) =>
    _$ClubCommentImpl(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ClubCommentImplToJson(_$ClubCommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$SubscriptionImpl _$$SubscriptionImplFromJson(Map<String, dynamic> json) =>
    _$SubscriptionImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      frequency: json['frequency'] as String,
      status: json['status'] as String? ?? 'active',
      startDate: DateTime.parse(json['startDate'] as String),
      endDate:
          json['endDate'] == null
              ? null
              : DateTime.parse(json['endDate'] as String),
      nextDelivery:
          json['nextDelivery'] == null
              ? null
              : DateTime.parse(json['nextDelivery'] as String),
      productIds:
          (json['productIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      preferences: json['preferences'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$SubscriptionImplToJson(_$SubscriptionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': instance.type,
      'name': instance.name,
      'price': instance.price,
      'frequency': instance.frequency,
      'status': instance.status,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'nextDelivery': instance.nextDelivery?.toIso8601String(),
      'productIds': instance.productIds,
      'preferences': instance.preferences,
    };
