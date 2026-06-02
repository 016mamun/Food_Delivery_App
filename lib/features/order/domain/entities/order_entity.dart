import 'package:equatable/equatable.dart';

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  pickedUp,
  onTheWay,
  delivered,
  cancelled,
}

class OrderEntity extends Equatable {
  final String id;
  final String userId;
  final String restaurantId;
  final String restaurantName;
  final String? riderId;
  final String? riderName;
  final List<OrderItemEntity> items;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double total;
  final OrderStatus status;
  final String deliveryAddress;
  final double deliveryLat;
  final double deliveryLng;
  final double? restaurantLat;
  final double? restaurantLng;
  final String? specialInstructions;
  final String paymentMethod;
  final String? paymentId;
  final DateTime createdAt;
  final DateTime? confirmedAt;
  final DateTime? deliveredAt;
  final DateTime? cancelledAt;
  final String? cancelReason;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.restaurantName,
    this.riderId,
    this.riderName,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.total,
    this.status = OrderStatus.pending,
    required this.deliveryAddress,
    required this.deliveryLat,
    required this.deliveryLng,
    this.restaurantLat,
    this.restaurantLng,
    this.specialInstructions,
    this.paymentMethod = 'card',
    this.paymentId,
    required this.createdAt,
    this.confirmedAt,
    this.deliveredAt,
    this.cancelledAt,
    this.cancelReason,
  });

  @override
  List<Object?> get props => [id];
}

class OrderItemEntity extends Equatable {
  final String foodId;
  final String foodName;
  final String foodImage;
  final double price;
  final int quantity;
  final String? specialInstructions;

  const OrderItemEntity({
    required this.foodId,
    required this.foodName,
    required this.foodImage,
    required this.price,
    required this.quantity,
    this.specialInstructions,
  });

  double get totalPrice => price * quantity;

  @override
  List<Object?> get props => [foodId, quantity];
}
