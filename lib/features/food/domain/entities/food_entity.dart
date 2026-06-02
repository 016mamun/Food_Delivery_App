import 'package:equatable/equatable.dart';

class FoodEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? discountPrice;
  final String image;
  final double rating;
  final int reviewCount;
  final String restaurantId;
  final String restaurantName;
  final String categoryId;
  final List<String> tags;
  final bool isAvailable;
  final int preparationTime;
  final bool isPopular;
  final bool isNew;

  const FoodEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discountPrice,
    required this.image,
    required this.rating,
    required this.reviewCount,
    required this.restaurantId,
    required this.restaurantName,
    required this.categoryId,
    this.tags = const [],
    this.isAvailable = true,
    this.preparationTime = 20,
    this.isPopular = false,
    this.isNew = false,
  });

  bool get hasDiscount => discountPrice != null && discountPrice! < price;
  double get effectivePrice => hasDiscount ? discountPrice! : price;

  @override
  List<Object?> get props => [id];
}
