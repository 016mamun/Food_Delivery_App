import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final double lat;
  final double lng;
  final String? address;
  final String? name;

  const LocationEntity({
    required this.lat,
    required this.lng,
    this.address,
    this.name,
  });

  @override
  List<Object?> get props => [lat, lng];
}

class DeliveryRouteEntity extends Equatable {
  final LocationEntity restaurant;
  final LocationEntity customer;
  final LocationEntity? riderCurrent;
  final double distanceKm;
  final int estimatedMinutes;

  const DeliveryRouteEntity({
    required this.restaurant,
    required this.customer,
    this.riderCurrent,
    required this.distanceKm,
    required this.estimatedMinutes,
  });

  @override
  List<Object?> get props => [restaurant, customer];
}
