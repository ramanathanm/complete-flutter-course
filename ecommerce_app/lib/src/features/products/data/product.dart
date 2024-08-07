import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

/// * The product identifier is an important concept and can have its own type.
typedef ProductID = String;

/// Class representing a product.
@freezed
class Product with _$Product {
  // Constructor for a product.
  const factory Product({
    required ProductID id,
    required String imageUrl,
    required String title,
    required String description,
    required double price,
    required int availableQuantity,
    @Default(0) double avgRating,
    @Default(0) int numRatings,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
