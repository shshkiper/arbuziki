// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return _ProductModel.fromJson(json);
}

/// @nodoc
mixin _$ProductModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get category =>
      throw _privateConstructorUsedError; // 'coffee', 'tea', 'food', 'book'
  String? get imageUrl => throw _privateConstructorUsedError;
  List<String> get ingredients => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  int get preparationTime => throw _privateConstructorUsedError; // в минутах
  double get rating => throw _privateConstructorUsedError;
  int get reviewsCount => throw _privateConstructorUsedError;
  Map<String, dynamic>? get customizations =>
      throw _privateConstructorUsedError;

  /// Serializes this ProductModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductModelCopyWith<ProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductModelCopyWith<$Res> {
  factory $ProductModelCopyWith(
    ProductModel value,
    $Res Function(ProductModel) then,
  ) = _$ProductModelCopyWithImpl<$Res, ProductModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    double price,
    String category,
    String? imageUrl,
    List<String> ingredients,
    bool isAvailable,
    int preparationTime,
    double rating,
    int reviewsCount,
    Map<String, dynamic>? customizations,
  });
}

/// @nodoc
class _$ProductModelCopyWithImpl<$Res, $Val extends ProductModel>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? category = null,
    Object? imageUrl = freezed,
    Object? ingredients = null,
    Object? isAvailable = null,
    Object? preparationTime = null,
    Object? rating = null,
    Object? reviewsCount = null,
    Object? customizations = freezed,
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
            price:
                null == price
                    ? _value.price
                    : price // ignore: cast_nullable_to_non_nullable
                        as double,
            category:
                null == category
                    ? _value.category
                    : category // ignore: cast_nullable_to_non_nullable
                        as String,
            imageUrl:
                freezed == imageUrl
                    ? _value.imageUrl
                    : imageUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            ingredients:
                null == ingredients
                    ? _value.ingredients
                    : ingredients // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            isAvailable:
                null == isAvailable
                    ? _value.isAvailable
                    : isAvailable // ignore: cast_nullable_to_non_nullable
                        as bool,
            preparationTime:
                null == preparationTime
                    ? _value.preparationTime
                    : preparationTime // ignore: cast_nullable_to_non_nullable
                        as int,
            rating:
                null == rating
                    ? _value.rating
                    : rating // ignore: cast_nullable_to_non_nullable
                        as double,
            reviewsCount:
                null == reviewsCount
                    ? _value.reviewsCount
                    : reviewsCount // ignore: cast_nullable_to_non_nullable
                        as int,
            customizations:
                freezed == customizations
                    ? _value.customizations
                    : customizations // ignore: cast_nullable_to_non_nullable
                        as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductModelImplCopyWith<$Res>
    implements $ProductModelCopyWith<$Res> {
  factory _$$ProductModelImplCopyWith(
    _$ProductModelImpl value,
    $Res Function(_$ProductModelImpl) then,
  ) = __$$ProductModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    double price,
    String category,
    String? imageUrl,
    List<String> ingredients,
    bool isAvailable,
    int preparationTime,
    double rating,
    int reviewsCount,
    Map<String, dynamic>? customizations,
  });
}

/// @nodoc
class __$$ProductModelImplCopyWithImpl<$Res>
    extends _$ProductModelCopyWithImpl<$Res, _$ProductModelImpl>
    implements _$$ProductModelImplCopyWith<$Res> {
  __$$ProductModelImplCopyWithImpl(
    _$ProductModelImpl _value,
    $Res Function(_$ProductModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? category = null,
    Object? imageUrl = freezed,
    Object? ingredients = null,
    Object? isAvailable = null,
    Object? preparationTime = null,
    Object? rating = null,
    Object? reviewsCount = null,
    Object? customizations = freezed,
  }) {
    return _then(
      _$ProductModelImpl(
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
        price:
            null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                    as double,
        category:
            null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                    as String,
        imageUrl:
            freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        ingredients:
            null == ingredients
                ? _value._ingredients
                : ingredients // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        isAvailable:
            null == isAvailable
                ? _value.isAvailable
                : isAvailable // ignore: cast_nullable_to_non_nullable
                    as bool,
        preparationTime:
            null == preparationTime
                ? _value.preparationTime
                : preparationTime // ignore: cast_nullable_to_non_nullable
                    as int,
        rating:
            null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                    as double,
        reviewsCount:
            null == reviewsCount
                ? _value.reviewsCount
                : reviewsCount // ignore: cast_nullable_to_non_nullable
                    as int,
        customizations:
            freezed == customizations
                ? _value._customizations
                : customizations // ignore: cast_nullable_to_non_nullable
                    as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductModelImpl implements _ProductModel {
  const _$ProductModelImpl({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.imageUrl,
    final List<String> ingredients = const [],
    this.isAvailable = true,
    this.preparationTime = 0,
    this.rating = 0.0,
    this.reviewsCount = 0,
    final Map<String, dynamic>? customizations,
  }) : _ingredients = ingredients,
       _customizations = customizations;

  factory _$ProductModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final double price;
  @override
  final String category;
  // 'coffee', 'tea', 'food', 'book'
  @override
  final String? imageUrl;
  final List<String> _ingredients;
  @override
  @JsonKey()
  List<String> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  @override
  @JsonKey()
  final bool isAvailable;
  @override
  @JsonKey()
  final int preparationTime;
  // в минутах
  @override
  @JsonKey()
  final double rating;
  @override
  @JsonKey()
  final int reviewsCount;
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
  String toString() {
    return 'ProductModel(id: $id, name: $name, description: $description, price: $price, category: $category, imageUrl: $imageUrl, ingredients: $ingredients, isAvailable: $isAvailable, preparationTime: $preparationTime, rating: $rating, reviewsCount: $reviewsCount, customizations: $customizations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(
              other._ingredients,
              _ingredients,
            ) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.preparationTime, preparationTime) ||
                other.preparationTime == preparationTime) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviewsCount, reviewsCount) ||
                other.reviewsCount == reviewsCount) &&
            const DeepCollectionEquality().equals(
              other._customizations,
              _customizations,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    price,
    category,
    imageUrl,
    const DeepCollectionEquality().hash(_ingredients),
    isAvailable,
    preparationTime,
    rating,
    reviewsCount,
    const DeepCollectionEquality().hash(_customizations),
  );

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      __$$ProductModelImplCopyWithImpl<_$ProductModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductModelImplToJson(this);
  }
}

abstract class _ProductModel implements ProductModel {
  const factory _ProductModel({
    required final String id,
    required final String name,
    required final String description,
    required final double price,
    required final String category,
    final String? imageUrl,
    final List<String> ingredients,
    final bool isAvailable,
    final int preparationTime,
    final double rating,
    final int reviewsCount,
    final Map<String, dynamic>? customizations,
  }) = _$ProductModelImpl;

  factory _ProductModel.fromJson(Map<String, dynamic> json) =
      _$ProductModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  double get price;
  @override
  String get category; // 'coffee', 'tea', 'food', 'book'
  @override
  String? get imageUrl;
  @override
  List<String> get ingredients;
  @override
  bool get isAvailable;
  @override
  int get preparationTime; // в минутах
  @override
  double get rating;
  @override
  int get reviewsCount;
  @override
  Map<String, dynamic>? get customizations;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MenuCategory _$MenuCategoryFromJson(Map<String, dynamic> json) {
  return _MenuCategory.fromJson(json);
}

/// @nodoc
mixin _$MenuCategory {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  List<ProductModel> get products => throw _privateConstructorUsedError;

  /// Serializes this MenuCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MenuCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MenuCategoryCopyWith<MenuCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuCategoryCopyWith<$Res> {
  factory $MenuCategoryCopyWith(
    MenuCategory value,
    $Res Function(MenuCategory) then,
  ) = _$MenuCategoryCopyWithImpl<$Res, MenuCategory>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String? iconUrl,
    List<ProductModel> products,
  });
}

/// @nodoc
class _$MenuCategoryCopyWithImpl<$Res, $Val extends MenuCategory>
    implements $MenuCategoryCopyWith<$Res> {
  _$MenuCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MenuCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? iconUrl = freezed,
    Object? products = null,
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
                freezed == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String?,
            iconUrl:
                freezed == iconUrl
                    ? _value.iconUrl
                    : iconUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            products:
                null == products
                    ? _value.products
                    : products // ignore: cast_nullable_to_non_nullable
                        as List<ProductModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MenuCategoryImplCopyWith<$Res>
    implements $MenuCategoryCopyWith<$Res> {
  factory _$$MenuCategoryImplCopyWith(
    _$MenuCategoryImpl value,
    $Res Function(_$MenuCategoryImpl) then,
  ) = __$$MenuCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String? iconUrl,
    List<ProductModel> products,
  });
}

/// @nodoc
class __$$MenuCategoryImplCopyWithImpl<$Res>
    extends _$MenuCategoryCopyWithImpl<$Res, _$MenuCategoryImpl>
    implements _$$MenuCategoryImplCopyWith<$Res> {
  __$$MenuCategoryImplCopyWithImpl(
    _$MenuCategoryImpl _value,
    $Res Function(_$MenuCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MenuCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? iconUrl = freezed,
    Object? products = null,
  }) {
    return _then(
      _$MenuCategoryImpl(
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
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
        iconUrl:
            freezed == iconUrl
                ? _value.iconUrl
                : iconUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        products:
            null == products
                ? _value._products
                : products // ignore: cast_nullable_to_non_nullable
                    as List<ProductModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MenuCategoryImpl implements _MenuCategory {
  const _$MenuCategoryImpl({
    required this.id,
    required this.name,
    this.description,
    this.iconUrl,
    final List<ProductModel> products = const [],
  }) : _products = products;

  factory _$MenuCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenuCategoryImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? iconUrl;
  final List<ProductModel> _products;
  @override
  @JsonKey()
  List<ProductModel> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString() {
    return 'MenuCategory(id: $id, name: $name, description: $description, iconUrl: $iconUrl, products: $products)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    iconUrl,
    const DeepCollectionEquality().hash(_products),
  );

  /// Create a copy of MenuCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuCategoryImplCopyWith<_$MenuCategoryImpl> get copyWith =>
      __$$MenuCategoryImplCopyWithImpl<_$MenuCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MenuCategoryImplToJson(this);
  }
}

abstract class _MenuCategory implements MenuCategory {
  const factory _MenuCategory({
    required final String id,
    required final String name,
    final String? description,
    final String? iconUrl,
    final List<ProductModel> products,
  }) = _$MenuCategoryImpl;

  factory _MenuCategory.fromJson(Map<String, dynamic> json) =
      _$MenuCategoryImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get iconUrl;
  @override
  List<ProductModel> get products;

  /// Create a copy of MenuCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenuCategoryImplCopyWith<_$MenuCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
