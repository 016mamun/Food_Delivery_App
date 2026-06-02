import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/cart_entity.dart';
import '../../../../features/food/domain/entities/food_entity.dart';

class CartNotifier extends StateNotifier<CartEntity> {
  CartNotifier() : super(const CartEntity());

  void addToCart(
    FoodEntity food, {
    int quantity = 1,
    String? specialInstructions,
  }) {
    final existingIndex = state.items.indexWhere(
      (item) => item.food.id == food.id,
    );
    if (existingIndex >= 0) {
      final updatedItems = List<CartItemEntity>.from(state.items);
      updatedItems[existingIndex] = CartItemEntity(
        food: food,
        quantity: updatedItems[existingIndex].quantity + quantity,
        specialInstructions: specialInstructions,
      );
      state = state.copyWith(items: updatedItems);
    } else {
      state = state.copyWith(
        items: [
          ...state.items,
          CartItemEntity(
            food: food,
            quantity: quantity,
            specialInstructions: specialInstructions,
          ),
        ],
      );
    }
  }

  void removeFromCart(String foodId) {
    state = state.copyWith(
      items: state.items.where((item) => item.food.id != foodId).toList(),
    );
  }

  void updateQuantity(String foodId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(foodId);
      return;
    }
    final updatedItems = state.items
        .map(
          (item) => item.food.id == foodId
              ? CartItemEntity(
                  food: item.food,
                  quantity: quantity,
                  specialInstructions: item.specialInstructions,
                )
              : item,
        )
        .toList();
    state = state.copyWith(items: updatedItems);
  }

  void incrementQuantity(String foodId) {
    final index = state.items.indexWhere((item) => item.food.id == foodId);
    if (index >= 0) updateQuantity(foodId, state.items[index].quantity + 1);
  }

  void decrementQuantity(String foodId) {
    final index = state.items.indexWhere((item) => item.food.id == foodId);
    if (index >= 0) updateQuantity(foodId, state.items[index].quantity - 1);
  }

  void clearCart() {
    state = const CartEntity();
  }

  int getQuantityForFood(String foodId) {
    final item = state.items
        .where((item) => item.food.id == foodId)
        .firstOrNull;
    return item?.quantity ?? 0;
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, CartEntity>(
  (ref) => CartNotifier(),
);
