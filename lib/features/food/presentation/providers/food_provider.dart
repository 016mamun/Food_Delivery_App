import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/food_entity.dart';
import '../../../../core/constants/dummy_data.dart';

class FoodState {
  final List<FoodEntity> foods;
  final List<FoodEntity> popularFoods;
  final List<FoodEntity> newFoods;
  final List<FoodEntity> searchResults;
  final String? restaurantId;
  final bool isLoading;
  final String? error;

  const FoodState({
    this.foods = const [],
    this.popularFoods = const [],
    this.newFoods = const [],
    this.searchResults = const [],
    this.restaurantId,
    this.isLoading = false,
    this.error,
  });

  FoodState copyWith({
    List<FoodEntity>? foods,
    List<FoodEntity>? popularFoods,
    List<FoodEntity>? newFoods,
    List<FoodEntity>? searchResults,
    String? restaurantId,
    bool? isLoading,
    String? error,
  }) {
    return FoodState(
      foods: foods ?? this.foods,
      popularFoods: popularFoods ?? this.popularFoods,
      newFoods: newFoods ?? this.newFoods,
      searchResults: searchResults ?? this.searchResults,
      restaurantId: restaurantId ?? this.restaurantId,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class FoodNotifier extends StateNotifier<FoodState> {
  FoodNotifier() : super(const FoodState()) {
    loadFoods();
  }

  Future<void> loadFoods() async {
    state = state.copyWith(isLoading: true);
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final foods = DummyData.foods;
      state = state.copyWith(
        foods: foods,
        popularFoods: DummyData.getPopularFoods(),
        newFoods: DummyData.getNewFoods(),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadFoodsByRestaurant(String restaurantId) async {
    state = state.copyWith(isLoading: true, restaurantId: restaurantId);
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final foods = DummyData.getFoodsByRestaurant(restaurantId);
      state = state.copyWith(foods: foods, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void searchFoods(String query) {
    if (query.isEmpty) {
      state = state.copyWith(searchResults: []);
      return;
    }
    final results = DummyData.searchFoods(query);
    state = state.copyWith(searchResults: results);
  }

  FoodEntity? getFoodById(String foodId) {
    try {
      return DummyData.foods.firstWhere((f) => f.id == foodId);
    } catch (_) {
      return null;
    }
  }
}

final foodProvider = StateNotifierProvider<FoodNotifier, FoodState>(
  (ref) => FoodNotifier(),
);
