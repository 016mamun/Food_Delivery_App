import 'package:equatable/equatable.dart';

class RestaurantEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String image;
  final String logo;
  final double rating;
  final int reviewCount;
  final List<String> categories;
  final String deliveryTime;
  final double deliveryFee;
  final double minOrder;
  final String address;
  final double lat;
  final double lng;
  final bool isOpen;
  final bool isFeatured;
  final double distance;
  final List<String> tags;
  final String ownerId;

  const RestaurantEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.logo,
    required this.rating,
    required this.reviewCount,
    required this.categories,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.minOrder,
    required this.address,
    required this.lat,
    required this.lng,
    this.isOpen = true,
    this.isFeatured = false,
    this.distance = 0.0,
    this.tags = const [],
    required this.ownerId,
  });

  @override
  List<Object?> get props => [id];
}

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String icon;
  final String color;
  final int itemCount;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.itemCount,
  });

  @override
  List<Object?> get props => [id];
}
