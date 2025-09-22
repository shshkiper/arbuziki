import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String id,
    required String name,
    required String description,
    required double price,
    required String category, // 'coffee', 'tea', 'food', 'book'
    String? imageUrl,
    @Default([]) List<String> ingredients,
    @Default(true) bool isAvailable,
    @Default(0) int preparationTime, // в минутах
    @Default(0.0) double rating,
    @Default(0) int reviewsCount,
    Map<String, dynamic>? customizations, // размеры, добавки и т.д.
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

@freezed
class MenuCategory with _$MenuCategory {
  const factory MenuCategory({
    required String id,
    required String name,
    String? description,
    String? iconUrl,
    @Default([]) List<ProductModel> products,
  }) = _MenuCategory;

  factory MenuCategory.fromJson(Map<String, dynamic> json) =>
      _$MenuCategoryFromJson(json);
}
