// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ClubModel _$ClubModelFromJson(Map<String, dynamic> json) {
  return _ClubModel.fromJson(json);
}

/// @nodoc
mixin _$ClubModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // 'coffee', 'tea', 'book'
  String? get imageUrl => throw _privateConstructorUsedError;
  List<String> get memberIds => throw _privateConstructorUsedError;
  List<ClubEvent> get events => throw _privateConstructorUsedError;
  List<ClubPost> get posts => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  bool get isPrivate => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  /// Serializes this ClubModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClubModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClubModelCopyWith<ClubModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubModelCopyWith<$Res> {
  factory $ClubModelCopyWith(ClubModel value, $Res Function(ClubModel) then) =
      _$ClubModelCopyWithImpl<$Res, ClubModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    String type,
    String? imageUrl,
    List<String> memberIds,
    List<ClubEvent> events,
    List<ClubPost> posts,
    DateTime createdAt,
    String? createdBy,
    bool isPrivate,
    List<String> tags,
  });
}

/// @nodoc
class _$ClubModelCopyWithImpl<$Res, $Val extends ClubModel>
    implements $ClubModelCopyWith<$Res> {
  _$ClubModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClubModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? imageUrl = freezed,
    Object? memberIds = null,
    Object? events = null,
    Object? posts = null,
    Object? createdAt = null,
    Object? createdBy = freezed,
    Object? isPrivate = null,
    Object? tags = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
            imageUrl:
                freezed == imageUrl
                    ? _value.imageUrl
                    : imageUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            memberIds:
                null == memberIds
                    ? _value.memberIds
                    : memberIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            events:
                null == events
                    ? _value.events
                    : events // ignore: cast_nullable_to_non_nullable
                        as List<ClubEvent>,
            posts:
                null == posts
                    ? _value.posts
                    : posts // ignore: cast_nullable_to_non_nullable
                        as List<ClubPost>,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            createdBy:
                freezed == createdBy
                    ? _value.createdBy
                    : createdBy // ignore: cast_nullable_to_non_nullable
                        as String?,
            isPrivate:
                null == isPrivate
                    ? _value.isPrivate
                    : isPrivate // ignore: cast_nullable_to_non_nullable
                        as bool,
            tags:
                null == tags
                    ? _value.tags
                    : tags // ignore: cast_nullable_to_non_nullable
                        as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClubModelImplCopyWith<$Res>
    implements $ClubModelCopyWith<$Res> {
  factory _$$ClubModelImplCopyWith(
    _$ClubModelImpl value,
    $Res Function(_$ClubModelImpl) then,
  ) = __$$ClubModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    String type,
    String? imageUrl,
    List<String> memberIds,
    List<ClubEvent> events,
    List<ClubPost> posts,
    DateTime createdAt,
    String? createdBy,
    bool isPrivate,
    List<String> tags,
  });
}

/// @nodoc
class __$$ClubModelImplCopyWithImpl<$Res>
    extends _$ClubModelCopyWithImpl<$Res, _$ClubModelImpl>
    implements _$$ClubModelImplCopyWith<$Res> {
  __$$ClubModelImplCopyWithImpl(
    _$ClubModelImpl _value,
    $Res Function(_$ClubModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClubModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? imageUrl = freezed,
    Object? memberIds = null,
    Object? events = null,
    Object? posts = null,
    Object? createdAt = null,
    Object? createdBy = freezed,
    Object? isPrivate = null,
    Object? tags = null,
  }) {
    return _then(
      _$ClubModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        imageUrl:
            freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        memberIds:
            null == memberIds
                ? _value._memberIds
                : memberIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        events:
            null == events
                ? _value._events
                : events // ignore: cast_nullable_to_non_nullable
                    as List<ClubEvent>,
        posts:
            null == posts
                ? _value._posts
                : posts // ignore: cast_nullable_to_non_nullable
                    as List<ClubPost>,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        createdBy:
            freezed == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                    as String?,
        isPrivate:
            null == isPrivate
                ? _value.isPrivate
                : isPrivate // ignore: cast_nullable_to_non_nullable
                    as bool,
        tags:
            null == tags
                ? _value._tags
                : tags // ignore: cast_nullable_to_non_nullable
                    as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClubModelImpl implements _ClubModel {
  const _$ClubModelImpl({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    this.imageUrl,
    final List<String> memberIds = const [],
    final List<ClubEvent> events = const [],
    final List<ClubPost> posts = const [],
    required this.createdAt,
    this.createdBy,
    this.isPrivate = false,
    final List<String> tags = const [],
  }) : _memberIds = memberIds,
       _events = events,
       _posts = posts,
       _tags = tags;

  factory _$ClubModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String type;
  // 'coffee', 'tea', 'book'
  @override
  final String? imageUrl;
  final List<String> _memberIds;
  @override
  @JsonKey()
  List<String> get memberIds {
    if (_memberIds is EqualUnmodifiableListView) return _memberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memberIds);
  }

  final List<ClubEvent> _events;
  @override
  @JsonKey()
  List<ClubEvent> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  final List<ClubPost> _posts;
  @override
  @JsonKey()
  List<ClubPost> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  @override
  final DateTime createdAt;
  @override
  final String? createdBy;
  @override
  @JsonKey()
  final bool isPrivate;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'ClubModel(id: $id, name: $name, description: $description, type: $type, imageUrl: $imageUrl, memberIds: $memberIds, events: $events, posts: $posts, createdAt: $createdAt, createdBy: $createdBy, isPrivate: $isPrivate, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(
              other._memberIds,
              _memberIds,
            ) &&
            const DeepCollectionEquality().equals(other._events, _events) &&
            const DeepCollectionEquality().equals(other._posts, _posts) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    type,
    imageUrl,
    const DeepCollectionEquality().hash(_memberIds),
    const DeepCollectionEquality().hash(_events),
    const DeepCollectionEquality().hash(_posts),
    createdAt,
    createdBy,
    isPrivate,
    const DeepCollectionEquality().hash(_tags),
  );

  /// Create a copy of ClubModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubModelImplCopyWith<_$ClubModelImpl> get copyWith =>
      __$$ClubModelImplCopyWithImpl<_$ClubModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubModelImplToJson(this);
  }
}

abstract class _ClubModel implements ClubModel {
  const factory _ClubModel({
    required final String id,
    required final String name,
    required final String description,
    required final String type,
    final String? imageUrl,
    final List<String> memberIds,
    final List<ClubEvent> events,
    final List<ClubPost> posts,
    required final DateTime createdAt,
    final String? createdBy,
    final bool isPrivate,
    final List<String> tags,
  }) = _$ClubModelImpl;

  factory _ClubModel.fromJson(Map<String, dynamic> json) =
      _$ClubModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get type; // 'coffee', 'tea', 'book'
  @override
  String? get imageUrl;
  @override
  List<String> get memberIds;
  @override
  List<ClubEvent> get events;
  @override
  List<ClubPost> get posts;
  @override
  DateTime get createdAt;
  @override
  String? get createdBy;
  @override
  bool get isPrivate;
  @override
  List<String> get tags;

  /// Create a copy of ClubModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClubModelImplCopyWith<_$ClubModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClubEvent _$ClubEventFromJson(Map<String, dynamic> json) {
  return _ClubEvent.fromJson(json);
}

/// @nodoc
mixin _$ClubEvent {
  String get id => throw _privateConstructorUsedError;
  String get clubId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get scheduledAt => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  List<String> get attendeeIds => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this ClubEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClubEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClubEventCopyWith<ClubEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubEventCopyWith<$Res> {
  factory $ClubEventCopyWith(ClubEvent value, $Res Function(ClubEvent) then) =
      _$ClubEventCopyWithImpl<$Res, ClubEvent>;
  @useResult
  $Res call({
    String id,
    String clubId,
    String title,
    String description,
    DateTime scheduledAt,
    String? location,
    List<String> attendeeIds,
    String createdBy,
    DateTime createdAt,
    String status,
  });
}

/// @nodoc
class _$ClubEventCopyWithImpl<$Res, $Val extends ClubEvent>
    implements $ClubEventCopyWith<$Res> {
  _$ClubEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClubEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clubId = null,
    Object? title = null,
    Object? description = null,
    Object? scheduledAt = null,
    Object? location = freezed,
    Object? attendeeIds = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            clubId:
                null == clubId
                    ? _value.clubId
                    : clubId // ignore: cast_nullable_to_non_nullable
                        as String,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            scheduledAt:
                null == scheduledAt
                    ? _value.scheduledAt
                    : scheduledAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            location:
                freezed == location
                    ? _value.location
                    : location // ignore: cast_nullable_to_non_nullable
                        as String?,
            attendeeIds:
                null == attendeeIds
                    ? _value.attendeeIds
                    : attendeeIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            createdBy:
                null == createdBy
                    ? _value.createdBy
                    : createdBy // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClubEventImplCopyWith<$Res>
    implements $ClubEventCopyWith<$Res> {
  factory _$$ClubEventImplCopyWith(
    _$ClubEventImpl value,
    $Res Function(_$ClubEventImpl) then,
  ) = __$$ClubEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String clubId,
    String title,
    String description,
    DateTime scheduledAt,
    String? location,
    List<String> attendeeIds,
    String createdBy,
    DateTime createdAt,
    String status,
  });
}

/// @nodoc
class __$$ClubEventImplCopyWithImpl<$Res>
    extends _$ClubEventCopyWithImpl<$Res, _$ClubEventImpl>
    implements _$$ClubEventImplCopyWith<$Res> {
  __$$ClubEventImplCopyWithImpl(
    _$ClubEventImpl _value,
    $Res Function(_$ClubEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClubEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clubId = null,
    Object? title = null,
    Object? description = null,
    Object? scheduledAt = null,
    Object? location = freezed,
    Object? attendeeIds = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? status = null,
  }) {
    return _then(
      _$ClubEventImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        clubId:
            null == clubId
                ? _value.clubId
                : clubId // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        scheduledAt:
            null == scheduledAt
                ? _value.scheduledAt
                : scheduledAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        location:
            freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                    as String?,
        attendeeIds:
            null == attendeeIds
                ? _value._attendeeIds
                : attendeeIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        createdBy:
            null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClubEventImpl implements _ClubEvent {
  const _$ClubEventImpl({
    required this.id,
    required this.clubId,
    required this.title,
    required this.description,
    required this.scheduledAt,
    this.location,
    final List<String> attendeeIds = const [],
    required this.createdBy,
    required this.createdAt,
    this.status = 'upcoming',
  }) : _attendeeIds = attendeeIds;

  factory _$ClubEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubEventImplFromJson(json);

  @override
  final String id;
  @override
  final String clubId;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime scheduledAt;
  @override
  final String? location;
  final List<String> _attendeeIds;
  @override
  @JsonKey()
  List<String> get attendeeIds {
    if (_attendeeIds is EqualUnmodifiableListView) return _attendeeIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attendeeIds);
  }

  @override
  final String createdBy;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final String status;

  @override
  String toString() {
    return 'ClubEvent(id: $id, clubId: $clubId, title: $title, description: $description, scheduledAt: $scheduledAt, location: $location, attendeeIds: $attendeeIds, createdBy: $createdBy, createdAt: $createdAt, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clubId, clubId) || other.clubId == clubId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(
              other._attendeeIds,
              _attendeeIds,
            ) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    clubId,
    title,
    description,
    scheduledAt,
    location,
    const DeepCollectionEquality().hash(_attendeeIds),
    createdBy,
    createdAt,
    status,
  );

  /// Create a copy of ClubEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubEventImplCopyWith<_$ClubEventImpl> get copyWith =>
      __$$ClubEventImplCopyWithImpl<_$ClubEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubEventImplToJson(this);
  }
}

abstract class _ClubEvent implements ClubEvent {
  const factory _ClubEvent({
    required final String id,
    required final String clubId,
    required final String title,
    required final String description,
    required final DateTime scheduledAt,
    final String? location,
    final List<String> attendeeIds,
    required final String createdBy,
    required final DateTime createdAt,
    final String status,
  }) = _$ClubEventImpl;

  factory _ClubEvent.fromJson(Map<String, dynamic> json) =
      _$ClubEventImpl.fromJson;

  @override
  String get id;
  @override
  String get clubId;
  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get scheduledAt;
  @override
  String? get location;
  @override
  List<String> get attendeeIds;
  @override
  String get createdBy;
  @override
  DateTime get createdAt;
  @override
  String get status;

  /// Create a copy of ClubEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClubEventImplCopyWith<_$ClubEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClubPost _$ClubPostFromJson(Map<String, dynamic> json) {
  return _ClubPost.fromJson(json);
}

/// @nodoc
mixin _$ClubPost {
  String get id => throw _privateConstructorUsedError;
  String get clubId => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  String get authorName => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<String> get imageUrls => throw _privateConstructorUsedError;
  List<ClubComment> get comments => throw _privateConstructorUsedError;
  int get likesCount => throw _privateConstructorUsedError;
  List<String> get likedBy => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ClubPost to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClubPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClubPostCopyWith<ClubPost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubPostCopyWith<$Res> {
  factory $ClubPostCopyWith(ClubPost value, $Res Function(ClubPost) then) =
      _$ClubPostCopyWithImpl<$Res, ClubPost>;
  @useResult
  $Res call({
    String id,
    String clubId,
    String authorId,
    String authorName,
    String content,
    List<String> imageUrls,
    List<ClubComment> comments,
    int likesCount,
    List<String> likedBy,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$ClubPostCopyWithImpl<$Res, $Val extends ClubPost>
    implements $ClubPostCopyWith<$Res> {
  _$ClubPostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClubPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clubId = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? content = null,
    Object? imageUrls = null,
    Object? comments = null,
    Object? likesCount = null,
    Object? likedBy = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            clubId:
                null == clubId
                    ? _value.clubId
                    : clubId // ignore: cast_nullable_to_non_nullable
                        as String,
            authorId:
                null == authorId
                    ? _value.authorId
                    : authorId // ignore: cast_nullable_to_non_nullable
                        as String,
            authorName:
                null == authorName
                    ? _value.authorName
                    : authorName // ignore: cast_nullable_to_non_nullable
                        as String,
            content:
                null == content
                    ? _value.content
                    : content // ignore: cast_nullable_to_non_nullable
                        as String,
            imageUrls:
                null == imageUrls
                    ? _value.imageUrls
                    : imageUrls // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            comments:
                null == comments
                    ? _value.comments
                    : comments // ignore: cast_nullable_to_non_nullable
                        as List<ClubComment>,
            likesCount:
                null == likesCount
                    ? _value.likesCount
                    : likesCount // ignore: cast_nullable_to_non_nullable
                        as int,
            likedBy:
                null == likedBy
                    ? _value.likedBy
                    : likedBy // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClubPostImplCopyWith<$Res>
    implements $ClubPostCopyWith<$Res> {
  factory _$$ClubPostImplCopyWith(
    _$ClubPostImpl value,
    $Res Function(_$ClubPostImpl) then,
  ) = __$$ClubPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String clubId,
    String authorId,
    String authorName,
    String content,
    List<String> imageUrls,
    List<ClubComment> comments,
    int likesCount,
    List<String> likedBy,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$ClubPostImplCopyWithImpl<$Res>
    extends _$ClubPostCopyWithImpl<$Res, _$ClubPostImpl>
    implements _$$ClubPostImplCopyWith<$Res> {
  __$$ClubPostImplCopyWithImpl(
    _$ClubPostImpl _value,
    $Res Function(_$ClubPostImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClubPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clubId = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? content = null,
    Object? imageUrls = null,
    Object? comments = null,
    Object? likesCount = null,
    Object? likedBy = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ClubPostImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        clubId:
            null == clubId
                ? _value.clubId
                : clubId // ignore: cast_nullable_to_non_nullable
                    as String,
        authorId:
            null == authorId
                ? _value.authorId
                : authorId // ignore: cast_nullable_to_non_nullable
                    as String,
        authorName:
            null == authorName
                ? _value.authorName
                : authorName // ignore: cast_nullable_to_non_nullable
                    as String,
        content:
            null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                    as String,
        imageUrls:
            null == imageUrls
                ? _value._imageUrls
                : imageUrls // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        comments:
            null == comments
                ? _value._comments
                : comments // ignore: cast_nullable_to_non_nullable
                    as List<ClubComment>,
        likesCount:
            null == likesCount
                ? _value.likesCount
                : likesCount // ignore: cast_nullable_to_non_nullable
                    as int,
        likedBy:
            null == likedBy
                ? _value._likedBy
                : likedBy // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClubPostImpl implements _ClubPost {
  const _$ClubPostImpl({
    required this.id,
    required this.clubId,
    required this.authorId,
    required this.authorName,
    required this.content,
    final List<String> imageUrls = const [],
    final List<ClubComment> comments = const [],
    this.likesCount = 0,
    final List<String> likedBy = const [],
    required this.createdAt,
    this.updatedAt,
  }) : _imageUrls = imageUrls,
       _comments = comments,
       _likedBy = likedBy;

  factory _$ClubPostImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubPostImplFromJson(json);

  @override
  final String id;
  @override
  final String clubId;
  @override
  final String authorId;
  @override
  final String authorName;
  @override
  final String content;
  final List<String> _imageUrls;
  @override
  @JsonKey()
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  final List<ClubComment> _comments;
  @override
  @JsonKey()
  List<ClubComment> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  @override
  @JsonKey()
  final int likesCount;
  final List<String> _likedBy;
  @override
  @JsonKey()
  List<String> get likedBy {
    if (_likedBy is EqualUnmodifiableListView) return _likedBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likedBy);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ClubPost(id: $id, clubId: $clubId, authorId: $authorId, authorName: $authorName, content: $content, imageUrls: $imageUrls, comments: $comments, likesCount: $likesCount, likedBy: $likedBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubPostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clubId, clubId) || other.clubId == clubId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(
              other._imageUrls,
              _imageUrls,
            ) &&
            const DeepCollectionEquality().equals(other._comments, _comments) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            const DeepCollectionEquality().equals(other._likedBy, _likedBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    clubId,
    authorId,
    authorName,
    content,
    const DeepCollectionEquality().hash(_imageUrls),
    const DeepCollectionEquality().hash(_comments),
    likesCount,
    const DeepCollectionEquality().hash(_likedBy),
    createdAt,
    updatedAt,
  );

  /// Create a copy of ClubPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubPostImplCopyWith<_$ClubPostImpl> get copyWith =>
      __$$ClubPostImplCopyWithImpl<_$ClubPostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubPostImplToJson(this);
  }
}

abstract class _ClubPost implements ClubPost {
  const factory _ClubPost({
    required final String id,
    required final String clubId,
    required final String authorId,
    required final String authorName,
    required final String content,
    final List<String> imageUrls,
    final List<ClubComment> comments,
    final int likesCount,
    final List<String> likedBy,
    required final DateTime createdAt,
    final DateTime? updatedAt,
  }) = _$ClubPostImpl;

  factory _ClubPost.fromJson(Map<String, dynamic> json) =
      _$ClubPostImpl.fromJson;

  @override
  String get id;
  @override
  String get clubId;
  @override
  String get authorId;
  @override
  String get authorName;
  @override
  String get content;
  @override
  List<String> get imageUrls;
  @override
  List<ClubComment> get comments;
  @override
  int get likesCount;
  @override
  List<String> get likedBy;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of ClubPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClubPostImplCopyWith<_$ClubPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClubComment _$ClubCommentFromJson(Map<String, dynamic> json) {
  return _ClubComment.fromJson(json);
}

/// @nodoc
mixin _$ClubComment {
  String get id => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  String get authorName => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ClubComment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClubComment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClubCommentCopyWith<ClubComment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubCommentCopyWith<$Res> {
  factory $ClubCommentCopyWith(
    ClubComment value,
    $Res Function(ClubComment) then,
  ) = _$ClubCommentCopyWithImpl<$Res, ClubComment>;
  @useResult
  $Res call({
    String id,
    String authorId,
    String authorName,
    String content,
    DateTime createdAt,
  });
}

/// @nodoc
class _$ClubCommentCopyWithImpl<$Res, $Val extends ClubComment>
    implements $ClubCommentCopyWith<$Res> {
  _$ClubCommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClubComment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? content = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            authorId:
                null == authorId
                    ? _value.authorId
                    : authorId // ignore: cast_nullable_to_non_nullable
                        as String,
            authorName:
                null == authorName
                    ? _value.authorName
                    : authorName // ignore: cast_nullable_to_non_nullable
                        as String,
            content:
                null == content
                    ? _value.content
                    : content // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClubCommentImplCopyWith<$Res>
    implements $ClubCommentCopyWith<$Res> {
  factory _$$ClubCommentImplCopyWith(
    _$ClubCommentImpl value,
    $Res Function(_$ClubCommentImpl) then,
  ) = __$$ClubCommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String authorId,
    String authorName,
    String content,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$ClubCommentImplCopyWithImpl<$Res>
    extends _$ClubCommentCopyWithImpl<$Res, _$ClubCommentImpl>
    implements _$$ClubCommentImplCopyWith<$Res> {
  __$$ClubCommentImplCopyWithImpl(
    _$ClubCommentImpl _value,
    $Res Function(_$ClubCommentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClubComment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? content = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$ClubCommentImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        authorId:
            null == authorId
                ? _value.authorId
                : authorId // ignore: cast_nullable_to_non_nullable
                    as String,
        authorName:
            null == authorName
                ? _value.authorName
                : authorName // ignore: cast_nullable_to_non_nullable
                    as String,
        content:
            null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClubCommentImpl implements _ClubComment {
  const _$ClubCommentImpl({
    required this.id,
    required this.authorId,
    required this.authorName,
    required this.content,
    required this.createdAt,
  });

  factory _$ClubCommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubCommentImplFromJson(json);

  @override
  final String id;
  @override
  final String authorId;
  @override
  final String authorName;
  @override
  final String content;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'ClubComment(id: $id, authorId: $authorId, authorName: $authorName, content: $content, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubCommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, authorId, authorName, content, createdAt);

  /// Create a copy of ClubComment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubCommentImplCopyWith<_$ClubCommentImpl> get copyWith =>
      __$$ClubCommentImplCopyWithImpl<_$ClubCommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubCommentImplToJson(this);
  }
}

abstract class _ClubComment implements ClubComment {
  const factory _ClubComment({
    required final String id,
    required final String authorId,
    required final String authorName,
    required final String content,
    required final DateTime createdAt,
  }) = _$ClubCommentImpl;

  factory _ClubComment.fromJson(Map<String, dynamic> json) =
      _$ClubCommentImpl.fromJson;

  @override
  String get id;
  @override
  String get authorId;
  @override
  String get authorName;
  @override
  String get content;
  @override
  DateTime get createdAt;

  /// Create a copy of ClubComment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClubCommentImplCopyWith<_$ClubCommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) {
  return _Subscription.fromJson(json);
}

/// @nodoc
mixin _$Subscription {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // 'coffee_monthly', 'tea_weekly', etc.
  String get name => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get frequency =>
      throw _privateConstructorUsedError; // 'weekly', 'monthly'
  String get status =>
      throw _privateConstructorUsedError; // 'active', 'paused', 'cancelled'
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  DateTime? get nextDelivery => throw _privateConstructorUsedError;
  List<String> get productIds => throw _privateConstructorUsedError;
  Map<String, dynamic>? get preferences => throw _privateConstructorUsedError;

  /// Serializes this Subscription to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionCopyWith<Subscription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionCopyWith<$Res> {
  factory $SubscriptionCopyWith(
    Subscription value,
    $Res Function(Subscription) then,
  ) = _$SubscriptionCopyWithImpl<$Res, Subscription>;
  @useResult
  $Res call({
    String id,
    String userId,
    String type,
    String name,
    double price,
    String frequency,
    String status,
    DateTime startDate,
    DateTime? endDate,
    DateTime? nextDelivery,
    List<String> productIds,
    Map<String, dynamic>? preferences,
  });
}

/// @nodoc
class _$SubscriptionCopyWithImpl<$Res, $Val extends Subscription>
    implements $SubscriptionCopyWith<$Res> {
  _$SubscriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? name = null,
    Object? price = null,
    Object? frequency = null,
    Object? status = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? nextDelivery = freezed,
    Object? productIds = null,
    Object? preferences = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            userId:
                null == userId
                    ? _value.userId
                    : userId // ignore: cast_nullable_to_non_nullable
                        as String,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            price:
                null == price
                    ? _value.price
                    : price // ignore: cast_nullable_to_non_nullable
                        as double,
            frequency:
                null == frequency
                    ? _value.frequency
                    : frequency // ignore: cast_nullable_to_non_nullable
                        as String,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            startDate:
                null == startDate
                    ? _value.startDate
                    : startDate // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            endDate:
                freezed == endDate
                    ? _value.endDate
                    : endDate // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            nextDelivery:
                freezed == nextDelivery
                    ? _value.nextDelivery
                    : nextDelivery // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            productIds:
                null == productIds
                    ? _value.productIds
                    : productIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            preferences:
                freezed == preferences
                    ? _value.preferences
                    : preferences // ignore: cast_nullable_to_non_nullable
                        as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubscriptionImplCopyWith<$Res>
    implements $SubscriptionCopyWith<$Res> {
  factory _$$SubscriptionImplCopyWith(
    _$SubscriptionImpl value,
    $Res Function(_$SubscriptionImpl) then,
  ) = __$$SubscriptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String type,
    String name,
    double price,
    String frequency,
    String status,
    DateTime startDate,
    DateTime? endDate,
    DateTime? nextDelivery,
    List<String> productIds,
    Map<String, dynamic>? preferences,
  });
}

/// @nodoc
class __$$SubscriptionImplCopyWithImpl<$Res>
    extends _$SubscriptionCopyWithImpl<$Res, _$SubscriptionImpl>
    implements _$$SubscriptionImplCopyWith<$Res> {
  __$$SubscriptionImplCopyWithImpl(
    _$SubscriptionImpl _value,
    $Res Function(_$SubscriptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? name = null,
    Object? price = null,
    Object? frequency = null,
    Object? status = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? nextDelivery = freezed,
    Object? productIds = null,
    Object? preferences = freezed,
  }) {
    return _then(
      _$SubscriptionImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        userId:
            null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        price:
            null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                    as double,
        frequency:
            null == frequency
                ? _value.frequency
                : frequency // ignore: cast_nullable_to_non_nullable
                    as String,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        startDate:
            null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        endDate:
            freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        nextDelivery:
            freezed == nextDelivery
                ? _value.nextDelivery
                : nextDelivery // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        productIds:
            null == productIds
                ? _value._productIds
                : productIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        preferences:
            freezed == preferences
                ? _value._preferences
                : preferences // ignore: cast_nullable_to_non_nullable
                    as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionImpl implements _Subscription {
  const _$SubscriptionImpl({
    required this.id,
    required this.userId,
    required this.type,
    required this.name,
    required this.price,
    required this.frequency,
    this.status = 'active',
    required this.startDate,
    this.endDate,
    this.nextDelivery,
    final List<String> productIds = const [],
    final Map<String, dynamic>? preferences,
  }) : _productIds = productIds,
       _preferences = preferences;

  factory _$SubscriptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String type;
  // 'coffee_monthly', 'tea_weekly', etc.
  @override
  final String name;
  @override
  final double price;
  @override
  final String frequency;
  // 'weekly', 'monthly'
  @override
  @JsonKey()
  final String status;
  // 'active', 'paused', 'cancelled'
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  final DateTime? nextDelivery;
  final List<String> _productIds;
  @override
  @JsonKey()
  List<String> get productIds {
    if (_productIds is EqualUnmodifiableListView) return _productIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productIds);
  }

  final Map<String, dynamic>? _preferences;
  @override
  Map<String, dynamic>? get preferences {
    final value = _preferences;
    if (value == null) return null;
    if (_preferences is EqualUnmodifiableMapView) return _preferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Subscription(id: $id, userId: $userId, type: $type, name: $name, price: $price, frequency: $frequency, status: $status, startDate: $startDate, endDate: $endDate, nextDelivery: $nextDelivery, productIds: $productIds, preferences: $preferences)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.nextDelivery, nextDelivery) ||
                other.nextDelivery == nextDelivery) &&
            const DeepCollectionEquality().equals(
              other._productIds,
              _productIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._preferences,
              _preferences,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    type,
    name,
    price,
    frequency,
    status,
    startDate,
    endDate,
    nextDelivery,
    const DeepCollectionEquality().hash(_productIds),
    const DeepCollectionEquality().hash(_preferences),
  );

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionImplCopyWith<_$SubscriptionImpl> get copyWith =>
      __$$SubscriptionImplCopyWithImpl<_$SubscriptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionImplToJson(this);
  }
}

abstract class _Subscription implements Subscription {
  const factory _Subscription({
    required final String id,
    required final String userId,
    required final String type,
    required final String name,
    required final double price,
    required final String frequency,
    final String status,
    required final DateTime startDate,
    final DateTime? endDate,
    final DateTime? nextDelivery,
    final List<String> productIds,
    final Map<String, dynamic>? preferences,
  }) = _$SubscriptionImpl;

  factory _Subscription.fromJson(Map<String, dynamic> json) =
      _$SubscriptionImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get type; // 'coffee_monthly', 'tea_weekly', etc.
  @override
  String get name;
  @override
  double get price;
  @override
  String get frequency; // 'weekly', 'monthly'
  @override
  String get status; // 'active', 'paused', 'cancelled'
  @override
  DateTime get startDate;
  @override
  DateTime? get endDate;
  @override
  DateTime? get nextDelivery;
  @override
  List<String> get productIds;
  @override
  Map<String, dynamic>? get preferences;

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionImplCopyWith<_$SubscriptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
