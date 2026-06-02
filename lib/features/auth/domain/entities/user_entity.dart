import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String? phone;
  final String? address;
  final double? lat;
  final double? lng;
  final UserRole role;
  final DateTime createdAt;

  const UserEntity({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.phone,
    this.address,
    this.lat,
    this.lng,
    this.role = UserRole.customer,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, email, role];
}

enum UserRole { customer, restaurant, rider }

class RestaurantUserEntity extends Equatable {
  final String userId;
  final String restaurantName;
  final String restaurantId;
  final String? description;
  final List<String> branches;

  const RestaurantUserEntity({
    required this.userId,
    required this.restaurantName,
    required this.restaurantId,
    this.description,
    this.branches = const [],
  });

  @override
  List<Object?> get props => [userId, restaurantId];
}

class RiderUserEntity extends Equatable {
  final String userId;
  final String vehicleType;
  final String vehicleNumber;
  final String? drivingLicense;
  final bool isOnline;
  final double? currentLat;
  final double? currentLng;
  final double totalEarnings;
  final int totalDeliveries;

  const RiderUserEntity({
    required this.userId,
    required this.vehicleType,
    required this.vehicleNumber,
    this.drivingLicense,
    this.isOnline = false,
    this.currentLat,
    this.currentLng,
    this.totalEarnings = 0,
    this.totalDeliveries = 0,
  });

  @override
  List<Object?> get props => [userId];
}
