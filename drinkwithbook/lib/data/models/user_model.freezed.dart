// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  int get loyaltyPoints => throw _privateConstructorUsedError;
  String get loyaltyLevel => throw _privateConstructorUsedError;
  List<String> get clubMemberships => throw _privateConstructorUsedError;
  List<String> get subscriptions => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastVisit => throw _privateConstructorUsedError;
  bool get isOwner => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call({
    String id,
    String email,
    String? name,
    String? avatarUrl,
    int loyaltyPoints,
    String loyaltyLevel,
    List<String> clubMemberships,
    List<String> subscriptions,
    DateTime? createdAt,
    DateTime? lastVisit,
    bool isOwner,
  });
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = freezed,
    Object? avatarUrl = freezed,
    Object? loyaltyPoints = null,
    Object? loyaltyLevel = null,
    Object? clubMemberships = null,
    Object? subscriptions = null,
    Object? createdAt = freezed,
    Object? lastVisit = freezed,
    Object? isOwner = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            email:
                null == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                freezed == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String?,
            avatarUrl:
                freezed == avatarUrl
                    ? _value.avatarUrl
                    : avatarUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            loyaltyPoints:
                null == loyaltyPoints
                    ? _value.loyaltyPoints
                    : loyaltyPoints // ignore: cast_nullable_to_non_nullable
                        as int,
            loyaltyLevel:
                null == loyaltyLevel
                    ? _value.loyaltyLevel
                    : loyaltyLevel // ignore: cast_nullable_to_non_nullable
                        as String,
            clubMemberships:
                null == clubMemberships
                    ? _value.clubMemberships
                    : clubMemberships // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            subscriptions:
                null == subscriptions
                    ? _value.subscriptions
                    : subscriptions // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            lastVisit:
                freezed == lastVisit
                    ? _value.lastVisit
                    : lastVisit // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            isOwner:
                null == isOwner
                    ? _value.isOwner
                    : isOwner // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
    _$UserModelImpl value,
    $Res Function(_$UserModelImpl) then,
  ) = __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String email,
    String? name,
    String? avatarUrl,
    int loyaltyPoints,
    String loyaltyLevel,
    List<String> clubMemberships,
    List<String> subscriptions,
    DateTime? createdAt,
    DateTime? lastVisit,
    bool isOwner,
  });
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
    _$UserModelImpl _value,
    $Res Function(_$UserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = freezed,
    Object? avatarUrl = freezed,
    Object? loyaltyPoints = null,
    Object? loyaltyLevel = null,
    Object? clubMemberships = null,
    Object? subscriptions = null,
    Object? createdAt = freezed,
    Object? lastVisit = freezed,
    Object? isOwner = null,
  }) {
    return _then(
      _$UserModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String?,
        avatarUrl:
            freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        loyaltyPoints:
            null == loyaltyPoints
                ? _value.loyaltyPoints
                : loyaltyPoints // ignore: cast_nullable_to_non_nullable
                    as int,
        loyaltyLevel:
            null == loyaltyLevel
                ? _value.loyaltyLevel
                : loyaltyLevel // ignore: cast_nullable_to_non_nullable
                    as String,
        clubMemberships:
            null == clubMemberships
                ? _value._clubMemberships
                : clubMemberships // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        subscriptions:
            null == subscriptions
                ? _value._subscriptions
                : subscriptions // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        lastVisit:
            freezed == lastVisit
                ? _value.lastVisit
                : lastVisit // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        isOwner:
            null == isOwner
                ? _value.isOwner
                : isOwner // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl({
    required this.id,
    required this.email,
    this.name,
    this.avatarUrl,
    this.loyaltyPoints = 0,
    this.loyaltyLevel = 'bronze',
    final List<String> clubMemberships = const [],
    final List<String> subscriptions = const [],
    this.createdAt,
    this.lastVisit,
    this.isOwner = false,
  }) : _clubMemberships = clubMemberships,
       _subscriptions = subscriptions;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String? name;
  @override
  final String? avatarUrl;
  @override
  @JsonKey()
  final int loyaltyPoints;
  @override
  @JsonKey()
  final String loyaltyLevel;
  final List<String> _clubMemberships;
  @override
  @JsonKey()
  List<String> get clubMemberships {
    if (_clubMemberships is EqualUnmodifiableListView) return _clubMemberships;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_clubMemberships);
  }

  final List<String> _subscriptions;
  @override
  @JsonKey()
  List<String> get subscriptions {
    if (_subscriptions is EqualUnmodifiableListView) return _subscriptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subscriptions);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? lastVisit;
  @override
  @JsonKey()
  final bool isOwner;

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, avatarUrl: $avatarUrl, loyaltyPoints: $loyaltyPoints, loyaltyLevel: $loyaltyLevel, clubMemberships: $clubMemberships, subscriptions: $subscriptions, createdAt: $createdAt, lastVisit: $lastVisit, isOwner: $isOwner)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.loyaltyPoints, loyaltyPoints) ||
                other.loyaltyPoints == loyaltyPoints) &&
            (identical(other.loyaltyLevel, loyaltyLevel) ||
                other.loyaltyLevel == loyaltyLevel) &&
            const DeepCollectionEquality().equals(
              other._clubMemberships,
              _clubMemberships,
            ) &&
            const DeepCollectionEquality().equals(
              other._subscriptions,
              _subscriptions,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastVisit, lastVisit) ||
                other.lastVisit == lastVisit) &&
            (identical(other.isOwner, isOwner) || other.isOwner == isOwner));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    name,
    avatarUrl,
    loyaltyPoints,
    loyaltyLevel,
    const DeepCollectionEquality().hash(_clubMemberships),
    const DeepCollectionEquality().hash(_subscriptions),
    createdAt,
    lastVisit,
    isOwner,
  );

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(this);
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel({
    required final String id,
    required final String email,
    final String? name,
    final String? avatarUrl,
    final int loyaltyPoints,
    final String loyaltyLevel,
    final List<String> clubMemberships,
    final List<String> subscriptions,
    final DateTime? createdAt,
    final DateTime? lastVisit,
    final bool isOwner,
  }) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String? get name;
  @override
  String? get avatarUrl;
  @override
  int get loyaltyPoints;
  @override
  String get loyaltyLevel;
  @override
  List<String> get clubMemberships;
  @override
  List<String> get subscriptions;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get lastVisit;
  @override
  bool get isOwner;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoyaltyCard _$LoyaltyCardFromJson(Map<String, dynamic> json) {
  return _LoyaltyCard.fromJson(json);
}

/// @nodoc
mixin _$LoyaltyCard {
  String get userId => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  String get level => throw _privateConstructorUsedError;
  int get totalSpent => throw _privateConstructorUsedError;
  int get visitsCount => throw _privateConstructorUsedError;
  DateTime? get lastVisit => throw _privateConstructorUsedError;
  List<LoyaltyTransaction> get transactions =>
      throw _privateConstructorUsedError;

  /// Serializes this LoyaltyCard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoyaltyCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoyaltyCardCopyWith<LoyaltyCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoyaltyCardCopyWith<$Res> {
  factory $LoyaltyCardCopyWith(
    LoyaltyCard value,
    $Res Function(LoyaltyCard) then,
  ) = _$LoyaltyCardCopyWithImpl<$Res, LoyaltyCard>;
  @useResult
  $Res call({
    String userId,
    int points,
    String level,
    int totalSpent,
    int visitsCount,
    DateTime? lastVisit,
    List<LoyaltyTransaction> transactions,
  });
}

/// @nodoc
class _$LoyaltyCardCopyWithImpl<$Res, $Val extends LoyaltyCard>
    implements $LoyaltyCardCopyWith<$Res> {
  _$LoyaltyCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoyaltyCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? points = null,
    Object? level = null,
    Object? totalSpent = null,
    Object? visitsCount = null,
    Object? lastVisit = freezed,
    Object? transactions = null,
  }) {
    return _then(
      _value.copyWith(
            userId:
                null == userId
                    ? _value.userId
                    : userId // ignore: cast_nullable_to_non_nullable
                        as String,
            points:
                null == points
                    ? _value.points
                    : points // ignore: cast_nullable_to_non_nullable
                        as int,
            level:
                null == level
                    ? _value.level
                    : level // ignore: cast_nullable_to_non_nullable
                        as String,
            totalSpent:
                null == totalSpent
                    ? _value.totalSpent
                    : totalSpent // ignore: cast_nullable_to_non_nullable
                        as int,
            visitsCount:
                null == visitsCount
                    ? _value.visitsCount
                    : visitsCount // ignore: cast_nullable_to_non_nullable
                        as int,
            lastVisit:
                freezed == lastVisit
                    ? _value.lastVisit
                    : lastVisit // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            transactions:
                null == transactions
                    ? _value.transactions
                    : transactions // ignore: cast_nullable_to_non_nullable
                        as List<LoyaltyTransaction>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoyaltyCardImplCopyWith<$Res>
    implements $LoyaltyCardCopyWith<$Res> {
  factory _$$LoyaltyCardImplCopyWith(
    _$LoyaltyCardImpl value,
    $Res Function(_$LoyaltyCardImpl) then,
  ) = __$$LoyaltyCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    int points,
    String level,
    int totalSpent,
    int visitsCount,
    DateTime? lastVisit,
    List<LoyaltyTransaction> transactions,
  });
}

/// @nodoc
class __$$LoyaltyCardImplCopyWithImpl<$Res>
    extends _$LoyaltyCardCopyWithImpl<$Res, _$LoyaltyCardImpl>
    implements _$$LoyaltyCardImplCopyWith<$Res> {
  __$$LoyaltyCardImplCopyWithImpl(
    _$LoyaltyCardImpl _value,
    $Res Function(_$LoyaltyCardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoyaltyCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? points = null,
    Object? level = null,
    Object? totalSpent = null,
    Object? visitsCount = null,
    Object? lastVisit = freezed,
    Object? transactions = null,
  }) {
    return _then(
      _$LoyaltyCardImpl(
        userId:
            null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as String,
        points:
            null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                    as int,
        level:
            null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                    as String,
        totalSpent:
            null == totalSpent
                ? _value.totalSpent
                : totalSpent // ignore: cast_nullable_to_non_nullable
                    as int,
        visitsCount:
            null == visitsCount
                ? _value.visitsCount
                : visitsCount // ignore: cast_nullable_to_non_nullable
                    as int,
        lastVisit:
            freezed == lastVisit
                ? _value.lastVisit
                : lastVisit // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        transactions:
            null == transactions
                ? _value._transactions
                : transactions // ignore: cast_nullable_to_non_nullable
                    as List<LoyaltyTransaction>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoyaltyCardImpl implements _LoyaltyCard {
  const _$LoyaltyCardImpl({
    required this.userId,
    this.points = 0,
    this.level = 'bronze',
    this.totalSpent = 0,
    this.visitsCount = 0,
    this.lastVisit,
    final List<LoyaltyTransaction> transactions = const [],
  }) : _transactions = transactions;

  factory _$LoyaltyCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoyaltyCardImplFromJson(json);

  @override
  final String userId;
  @override
  @JsonKey()
  final int points;
  @override
  @JsonKey()
  final String level;
  @override
  @JsonKey()
  final int totalSpent;
  @override
  @JsonKey()
  final int visitsCount;
  @override
  final DateTime? lastVisit;
  final List<LoyaltyTransaction> _transactions;
  @override
  @JsonKey()
  List<LoyaltyTransaction> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  String toString() {
    return 'LoyaltyCard(userId: $userId, points: $points, level: $level, totalSpent: $totalSpent, visitsCount: $visitsCount, lastVisit: $lastVisit, transactions: $transactions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoyaltyCardImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.totalSpent, totalSpent) ||
                other.totalSpent == totalSpent) &&
            (identical(other.visitsCount, visitsCount) ||
                other.visitsCount == visitsCount) &&
            (identical(other.lastVisit, lastVisit) ||
                other.lastVisit == lastVisit) &&
            const DeepCollectionEquality().equals(
              other._transactions,
              _transactions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    points,
    level,
    totalSpent,
    visitsCount,
    lastVisit,
    const DeepCollectionEquality().hash(_transactions),
  );

  /// Create a copy of LoyaltyCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoyaltyCardImplCopyWith<_$LoyaltyCardImpl> get copyWith =>
      __$$LoyaltyCardImplCopyWithImpl<_$LoyaltyCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoyaltyCardImplToJson(this);
  }
}

abstract class _LoyaltyCard implements LoyaltyCard {
  const factory _LoyaltyCard({
    required final String userId,
    final int points,
    final String level,
    final int totalSpent,
    final int visitsCount,
    final DateTime? lastVisit,
    final List<LoyaltyTransaction> transactions,
  }) = _$LoyaltyCardImpl;

  factory _LoyaltyCard.fromJson(Map<String, dynamic> json) =
      _$LoyaltyCardImpl.fromJson;

  @override
  String get userId;
  @override
  int get points;
  @override
  String get level;
  @override
  int get totalSpent;
  @override
  int get visitsCount;
  @override
  DateTime? get lastVisit;
  @override
  List<LoyaltyTransaction> get transactions;

  /// Create a copy of LoyaltyCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoyaltyCardImplCopyWith<_$LoyaltyCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoyaltyTransaction _$LoyaltyTransactionFromJson(Map<String, dynamic> json) {
  return _LoyaltyTransaction.fromJson(json);
}

/// @nodoc
mixin _$LoyaltyTransaction {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError; // 'earned' or 'spent'
  int get points => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get orderId => throw _privateConstructorUsedError;

  /// Serializes this LoyaltyTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoyaltyTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoyaltyTransactionCopyWith<LoyaltyTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoyaltyTransactionCopyWith<$Res> {
  factory $LoyaltyTransactionCopyWith(
    LoyaltyTransaction value,
    $Res Function(LoyaltyTransaction) then,
  ) = _$LoyaltyTransactionCopyWithImpl<$Res, LoyaltyTransaction>;
  @useResult
  $Res call({
    String id,
    String type,
    int points,
    String description,
    DateTime createdAt,
    String? orderId,
  });
}

/// @nodoc
class _$LoyaltyTransactionCopyWithImpl<$Res, $Val extends LoyaltyTransaction>
    implements $LoyaltyTransactionCopyWith<$Res> {
  _$LoyaltyTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoyaltyTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? points = null,
    Object? description = null,
    Object? createdAt = null,
    Object? orderId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
            points:
                null == points
                    ? _value.points
                    : points // ignore: cast_nullable_to_non_nullable
                        as int,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            orderId:
                freezed == orderId
                    ? _value.orderId
                    : orderId // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoyaltyTransactionImplCopyWith<$Res>
    implements $LoyaltyTransactionCopyWith<$Res> {
  factory _$$LoyaltyTransactionImplCopyWith(
    _$LoyaltyTransactionImpl value,
    $Res Function(_$LoyaltyTransactionImpl) then,
  ) = __$$LoyaltyTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    int points,
    String description,
    DateTime createdAt,
    String? orderId,
  });
}

/// @nodoc
class __$$LoyaltyTransactionImplCopyWithImpl<$Res>
    extends _$LoyaltyTransactionCopyWithImpl<$Res, _$LoyaltyTransactionImpl>
    implements _$$LoyaltyTransactionImplCopyWith<$Res> {
  __$$LoyaltyTransactionImplCopyWithImpl(
    _$LoyaltyTransactionImpl _value,
    $Res Function(_$LoyaltyTransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoyaltyTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? points = null,
    Object? description = null,
    Object? createdAt = null,
    Object? orderId = freezed,
  }) {
    return _then(
      _$LoyaltyTransactionImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        points:
            null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                    as int,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        orderId:
            freezed == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoyaltyTransactionImpl implements _LoyaltyTransaction {
  const _$LoyaltyTransactionImpl({
    required this.id,
    required this.type,
    required this.points,
    required this.description,
    required this.createdAt,
    this.orderId,
  });

  factory _$LoyaltyTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoyaltyTransactionImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  // 'earned' or 'spent'
  @override
  final int points;
  @override
  final String description;
  @override
  final DateTime createdAt;
  @override
  final String? orderId;

  @override
  String toString() {
    return 'LoyaltyTransaction(id: $id, type: $type, points: $points, description: $description, createdAt: $createdAt, orderId: $orderId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoyaltyTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.orderId, orderId) || other.orderId == orderId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    points,
    description,
    createdAt,
    orderId,
  );

  /// Create a copy of LoyaltyTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoyaltyTransactionImplCopyWith<_$LoyaltyTransactionImpl> get copyWith =>
      __$$LoyaltyTransactionImplCopyWithImpl<_$LoyaltyTransactionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LoyaltyTransactionImplToJson(this);
  }
}

abstract class _LoyaltyTransaction implements LoyaltyTransaction {
  const factory _LoyaltyTransaction({
    required final String id,
    required final String type,
    required final int points,
    required final String description,
    required final DateTime createdAt,
    final String? orderId,
  }) = _$LoyaltyTransactionImpl;

  factory _LoyaltyTransaction.fromJson(Map<String, dynamic> json) =
      _$LoyaltyTransactionImpl.fromJson;

  @override
  String get id;
  @override
  String get type; // 'earned' or 'spent'
  @override
  int get points;
  @override
  String get description;
  @override
  DateTime get createdAt;
  @override
  String? get orderId;

  /// Create a copy of LoyaltyTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoyaltyTransactionImplCopyWith<_$LoyaltyTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
