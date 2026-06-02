import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/cart_entity.dart';
import '../../../../features/food/domain/entities/food_entity.dart';

abstract class CartRepository {
  CartEntity getCart();
  Future<void> addToCart(
    FoodEntity food, {
    int quantity = 1,
    String? specialInstructions,
  });
  Future<void> removeFromCart(String foodId);
  Future<void> updateQuantity(String foodId, int quantity);
  Future<void> clearCart();
  Future<Either<Failure, double>> applyPromoCode(String code);
  int getQuantityForFood(String foodId);
}
