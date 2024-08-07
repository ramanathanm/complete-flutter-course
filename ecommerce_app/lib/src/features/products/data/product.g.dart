// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      availableQuantity: (json['availableQuantity'] as num).toInt(),
      avgRating: (json['avgRating'] as num?)?.toDouble() ?? 0,
      numRatings: (json['numRatings'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'availableQuantity': instance.availableQuantity,
      'avgRating': instance.avgRating,
      'numRatings': instance.numRatings,
    };
