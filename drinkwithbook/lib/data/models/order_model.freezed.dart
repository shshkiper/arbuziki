// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return _OrderModel.fromJson(json);
}

/// @nodoc
mixin _$OrderModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  List<OrderItem> get items => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // 'pending', 'preparing', 'ready', 'completed', 'cancelled'
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get readyAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String get orderType =>
      throw _privateConstructorUsedError; // 'pickup', 'delivery'
  int? get estimatedTime => throw _privateConstructorUsedError;
  int get loyaltyPointsEarned => throw _privateConstructorUsedError;
  int get loyaltyPointsUsed => throw _privateConstructorUsedError;

  /// Serializes this OrderModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderModelCopyWith<OrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderModelCopyWith<$Res> {
  factory $OrderModelCopyWith(
    OrderModel value,
    $Res Function(OrderModel) then,
  ) = _$OrderModelCopyWithImpl<$Res, OrderModel>;
  @useResult
  $Res call({
    String id,
    String userId,
    List<OrderItem> items,
    double totalAmount,
    String status,
    DateTime createdAt,
    DateTime? readyAt,
    DateTime? completedAt,
    String? notes,
    String orderType,
    int? estimatedTime,
    int loyaltyPointsEarned,
    int loyaltyPointsUsed,
  });
}

/// @nodoc
class _$OrderModelCopyWithImpl<$Res, $Val extends OrderModel>
    implements $OrderModelCopyWith<$Res> {
  _$OrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? items = null,
    Object? totalAmount = null,
    Object? status = null,
    Object? createdAt = null,
    Object? readyAt = freezed,
    Object? completedAt = freezed,
    Object? notes = freezed,
    Object? orderType = null,
    Object? estimatedTime = freezed,
    Object? loyaltyPointsEarned = null,
    Object? loyaltyPointsUsed = null,
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
            items:
                null == items
                    ? _value.items
                    : items // ignore: cast_nullable_to_non_nullable
                        as List<OrderItem>,
            totalAmount:
                null == totalAmount
                    ? _value.totalAmount
                    : totalAmount // ignore: cast_nullable_to_non_nullable
                        as double,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            readyAt:
                freezed == readyAt
                    ? _value.readyAt
                    : readyAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            completedAt:
                freezed == completedAt
                    ? _value.completedAt
                    : completedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            notes:
                freezed == notes
                    ? _value.notes
                    : notes // ignore: cast_nullable_to_non_nullable
                        as String?,
            orderType:
                null == orderType
                    ? _value.orderType
                    : orderType // ignore: cast_nullable_to_non_nullable
                        as String,
            estimatedTime:
                freezed == estimatedTime
                    ? _value.estimatedTime
                    : estimatedTime // ignore: cast_nullable_to_non_nullable
                        as int?,
            loyaltyPointsEarned:
                null == loyaltyPointsEarned
                    ? _value.loyaltyPointsEarned
                    : loyaltyPointsEarned // ignore: cast_nullable_to_non_nullable
                        as int,
            loyaltyPointsUsed:
                null == loyaltyPointsUsed
                    ? _value.loyaltyPointsUsed
                    : loyaltyPointsUsed // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderModelImplCopyWith<$Res>
    implements $OrderModelCopyWith<$Res> {
  factory _$$OrderModelImplCopyWith(
    _$OrderModelImpl value,
    $Res Function(_$OrderModelImpl) then,
  ) = __$$OrderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    List<OrderItem> items,
    double totalAmount,
    String status,
    DateTime createdAt,
    DateTime? readyAt,
    DateTime? completedAt,
    String? notes,
    String orderType,
    int? estimatedTime,
    int loyaltyPointsEarned,
    int loyaltyPointsUsed,
  });
}

/// @nodoc
class __$$OrderModelImplCopyWithImpl<$Res>
    extends _$OrderModelCopyWithImpl<$Res, _$OrderModelImpl>
    implements _$$OrderModelImplCopyWith<$Res> {
  __$$OrderModelImplCopyWithImpl(
    _$OrderModelImpl _value,
    $Res Function(_$OrderModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? items = null,
    Object? totalAmount = null,
    Object? status = null,
    Object? createdAt = null,
    Object? readyAt = freezed,
    Object? completedAt = freezed,
    Object? notes = freezed,
    Object? orderType = null,
    Object? estimatedTime = freezed,
    Object? loyaltyPointsEarned = null,
    Object? loyaltyPointsUsed = null,
  }) {
    return _then(
      _$OrderModelImpl(
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
        items:
            null == items
                ? _value._items
                : items // ignore: cast_nullable_to_non_nullable
                    as List<OrderItem>,
        totalAmount:
            null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                    as double,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        readyAt:
            freezed == readyAt
                ? _value.readyAt
                : readyAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        completedAt:
            freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        notes:
            freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                    as String?,
        orderType:
            null == orderType
                ? _value.orderType
                : orderType // ignore: cast_nullable_to_non_nullable
                    as String,
        estimatedTime:
            freezed == estimatedTime
                ? _value.estimatedTime
                : estimatedTime // ignore: cast_nullable_to_non_nullable
                    as int?,
        loyaltyPointsEarned:
            null == loyaltyPointsEarned
                ? _value.loyaltyPointsEarned
                : loyaltyPointsEarned // ignore: cast_nullable_to_non_nullable
                    as int,
        loyaltyPointsUsed:
            null == loyaltyPointsUsed
                ? _value.loyaltyPointsUsed
                : loyaltyPointsUsed // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderModelImpl implements _OrderModel {
  const _$OrderModelImpl({
    required this.id,
    required this.userId,
    required final List<OrderItem> items,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    this.readyAt,
    this.completedAt,
    this.notes,
    this.orderType = 'pickup',
    this.estimatedTime,
    this.loyaltyPointsEarned = 0,
    this.loyaltyPointsUsed = 0,
  }) : _items = items;

  factory _$OrderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  final List<OrderItem> _items;
  @override
  List<OrderItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final double totalAmount;
  @override
  final String status;
  // 'pending', 'preparing', 'ready', 'completed', 'cancelled'
  @override
  final DateTime createdAt;
  @override
  final DateTime? readyAt;
  @override
  final DateTime? completedAt;
  @override
  final String? notes;
  @override
  @JsonKey()
  final String orderType;
  // 'pickup', 'delivery'
  @override
  final int? estimatedTime;
  @override
  @JsonKey()
  final int loyaltyPointsEarned;
  @override
  @JsonKey()
  final int loyaltyPointsUsed;

  @override
  String toString() {
    return 'OrderModel(id: $id, userId: $userId, items: $items, totalAmount: $totalAmount, status: $status, createdAt: $createdAt, readyAt: $readyAt, completedAt: $completedAt, notes: $notes, orderType: $orderType, estimatedTime: $estimatedTime, loyaltyPointsEarned: $loyaltyPointsEarned, loyaltyPointsUsed: $loyaltyPointsUsed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.readyAt, readyAt) || other.readyAt == readyAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.orderType, orderType) ||
                other.orderType == orderType) &&
            (identical(other.estimatedTime, estimatedTime) ||
                other.estimatedTime == estimatedTime) &&
            (identical(other.loyaltyPointsEarned, loyaltyPointsEarned) ||
                other.loyaltyPointsEarned == loyaltyPointsEarned) &&
            (identical(other.loyaltyPointsUsed, loyaltyPointsUsed) ||
                other.loyaltyPointsUsed == loyaltyPointsUsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    const DeepCollectionEquality().hash(_items),
    totalAmount,
    status,
    createdAt,
    readyAt,
    completedAt,
    notes,
    orderType,
    estimatedTime,
    loyaltyPointsEarned,
    loyaltyPointsUsed,
  );

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderModelImplCopyWith<_$OrderModelImpl> get copyWith =>
      __$$OrderModelImplCopyWithImpl<_$OrderModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderModelImplToJson(this);
  }
}

abstract class _OrderModel implements OrderModel {
  const factory _OrderModel({
    required final String id,
    required final String userId,
    required final List<OrderItem> items,
    required final double totalAmount,
    required final String status,
    required final DateTime createdAt,
    final DateTime? readyAt,
    final DateTime? completedAt,
    final String? notes,
    final String orderType,
    final int? estimatedTime,
    final int loyaltyPointsEarned,
    final int loyaltyPointsUsed,
  }) = _$OrderModelImpl;

  factory _OrderModel.fromJson(Map<String, dynamic> json) =
      _$OrderModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  List<OrderItem> get items;
  @override
  double get totalAmount;
  @override
  String get status; // 'pending', 'preparing', 'ready', 'completed', 'cancelled'
  @override
  DateTime get createdAt;
  @override
  DateTime? get readyAt;
  @override
  DateTime? get completedAt;
  @override
  String? get notes;
  @override
  String get orderType; // 'pickup', 'delivery'
  @override
  int? get estimatedTime;
  @override
  int get loyaltyPointsEarned;
  @override
  int get loyaltyPointsUsed;

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderModelImplCopyWith<_$OrderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return _OrderItem.fromJson(json);
}

/// @nodoc
mixin _$OrderItem {
  String get productId => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  Map<String, dynamic>? get customizations =>
      throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this OrderItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderItemCopyWith<OrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemCopyWith<$Res> {
  factory $OrderItemCopyWith(OrderItem value, $Res Function(OrderItem) then) =
      _$OrderItemCopyWithImpl<$Res, OrderItem>;
  @useResult
  $Res call({
    String productId,
    String productName,
    int quantity,
    double price,
    Map<String, dynamic>? customizations,
    String? notes,
  });
}

/// @nodoc
class _$OrderItemCopyWithImpl<$Res, $Val extends OrderItem>
    implements $OrderItemCopyWith<$Res> {
  _$OrderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? productName = null,
    Object? quantity = null,
    Object? price = null,
    Object? customizations = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            productId:
                null == productId
                    ? _value.productId
                    : productId // ignore: cast_nullable_to_non_nullable
                        as String,
            productName:
                null == productName
                    ? _value.productName
                    : productName // ignore: cast_nullable_to_non_nullable
                        as String,
            quantity:
                null == quantity
                    ? _value.quantity
                    : quantity // ignore: cast_nullable_to_non_nullable
                        as int,
            price:
                null == price
                    ? _value.price
                    : price // ignore: cast_nullable_to_non_nullable
                        as double,
            customizations:
                freezed == customizations
                    ? _value.customizations
                    : customizations // ignore: cast_nullable_to_non_nullable
                        as Map<String, dynamic>?,
            notes:
                freezed == notes
                    ? _value.notes
                    : notes // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderItemImplCopyWith<$Res>
    implements $OrderItemCopyWith<$Res> {
  factory _$$OrderItemImplCopyWith(
    _$OrderItemImpl value,
    $Res Function(_$OrderItemImpl) then,
  ) = __$$OrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String productId,
    String productName,
    int quantity,
    double price,
    Map<String, dynamic>? customizations,
    String? notes,
  });
}

/// @nodoc
class __$$OrderItemImplCopyWithImpl<$Res>
    extends _$OrderItemCopyWithImpl<$Res, _$OrderItemImpl>
    implements _$$OrderItemImplCopyWith<$Res> {
  __$$OrderItemImplCopyWithImpl(
    _$OrderItemImpl _value,
    $Res Function(_$OrderItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? productName = null,
    Object? quantity = null,
    Object? price = null,
    Object? customizations = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _$OrderItemImpl(
        productId:
            null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                    as String,
        productName:
            null == productName
                ? _value.productName
                : productName // ignore: cast_nullable_to_non_nullable
                    as String,
        quantity:
            null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                    as int,
        price:
            null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                    as double,
        customizations:
            freezed == customizations
                ? _value._customizations
                : customizations // ignore: cast_nullable_to_non_nullable
                    as Map<String, dynamic>?,
        notes:
            freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderItemImpl implements _OrderItem {
  const _$OrderItemImpl({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    final Map<String, dynamic>? customizations,
    this.notes,
  }) : _customizations = customizations;

  factory _$OrderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderItemImplFromJson(json);

  @override
  final String productId;
  @override
  final String productName;
  @override
  final int quantity;
  @override
  final double price;
  final Map<String, dynamic>? _customizations;
  @override
  Map<String, dynamic>? get customizations {
    final value = _customizations;
    if (value == null) return null;
    if (_customizations is EqualUnmodifiableMapView) return _customizations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? notes;

  @override
  String toString() {
    return 'OrderItem(productId: $productId, productName: $productName, quantity: $quantity, price: $price, customizations: $customizations, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderItemImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality().equals(
              other._customizations,
              _customizations,
            ) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    productId,
    productName,
    quantity,
    price,
    const DeepCollectionEquality().hash(_customizations),
    notes,
  );

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      __$$OrderItemImplCopyWithImpl<_$OrderItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderItemImplToJson(this);
  }
}

abstract class _OrderItem implements OrderItem {
  const factory _OrderItem({
    required final String productId,
    required final String productName,
    required final int quantity,
    required final double price,
    final Map<String, dynamic>? customizations,
    final String? notes,
  }) = _$OrderItemImpl;

  factory _OrderItem.fromJson(Map<String, dynamic> json) =
      _$OrderItemImpl.fromJson;

  @override
  String get productId;
  @override
  String get productName;
  @override
  int get quantity;
  @override
  double get price;
  @override
  Map<String, dynamic>? get customizations;
  @override
  String? get notes;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
