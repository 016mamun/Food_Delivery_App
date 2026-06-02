import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String id;
  final String userId;
  final String label; // Home, Office, etc.
  final String fullAddress;
  final String? street;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;
  final double lat;
  final double lng;
  final bool isDefault;
  final String? phone;
  final String? instructions; // Delivery instructions

  const AddressEntity({
    required this.id,
    required this.userId,
    required this.label,
    required this.fullAddress,
    this.street,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    required this.lat,
    required this.lng,
    this.isDefault = false,
    this.phone,
    this.instructions,
  });

  AddressEntity copyWith({
    String? id,
    String? userId,
    String? label,
    String? fullAddress,
    String? street,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    double? lat,
    double? lng,
    bool? isDefault,
    String? phone,
    String? instructions,
  }) {
    return AddressEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      label: label ?? this.label,
      fullAddress: fullAddress ?? this.fullAddress,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      isDefault: isDefault ?? this.isDefault,
      phone: phone ?? this.phone,
      instructions: instructions ?? this.instructions,
    );
  }

  @override
  List<Object?> get props => [id];
}
