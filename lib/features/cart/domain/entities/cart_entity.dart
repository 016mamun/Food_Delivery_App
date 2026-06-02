import 'package:equatable/equatable.dart';
import '../../../../features/food/domain/entities/food_entity.dart';

class CartItemEntity extends Equatable {
  final FoodEntity food;
  final int quantity;
  final String? specialInstructions;

  const CartItemEntity({
    required this.food,
    this.quantity = 1,
    this.specialInstructions,
  });

  double get totalPrice => food.effectivePrice * quantity;

  @override
  List<Object?> get props => [food.id, quantity];
}

class CartEntity extends Equatable {
  final List<CartItemEntity> items;
  final String? promoCode;
  final double promoDiscount;

  const CartEntity({
    this.items = const [],
    this.promoCode,
    this.promoDiscount = 0,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  double get deliveryFee => items.isEmpty ? 0 : 2.99;
  double get tax => subtotal * 0.08;
  double get total => subtotal + deliveryFee + tax - promoDiscount;
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
  bool get isEmpty => items.isEmpty;

  CartEntity copyWith({
    List<CartItemEntity>? items,
    String? promoCode,
    double? promoDiscount,
  }) {
    return CartEntity(
      items: items ?? this.items,
      promoCode: promoCode ?? this.promoCode,
      promoDiscount: promoDiscount ?? this.promoDiscount,
    );
  }

  @override
  List<Object?> get props => [items, promoCode];
}
