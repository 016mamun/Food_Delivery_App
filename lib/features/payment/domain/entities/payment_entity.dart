import 'package:equatable/equatable.dart';

class PaymentEntity extends Equatable {
  final String id;
  final String orderId;
  final double amount;
  final String currency;
  final String status;
  final String method;
  final String? stripePaymentIntentId;
  final DateTime createdAt;

  const PaymentEntity({
    required this.id,
    required this.orderId,
    required this.amount,
    this.currency = 'usd',
    required this.status,
    required this.method,
    this.stripePaymentIntentId,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id];
}

class PaymentMethodEntity extends Equatable {
  final String id;
  final String type;
  final String? last4;
  final String? brand;
  final bool isDefault;

  const PaymentMethodEntity({
    required this.id,
    required this.type,
    this.last4,
    this.brand,
    this.isDefault = false,
  });

  @override
  List<Object?> get props => [id];
}
