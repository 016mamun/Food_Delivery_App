import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../../../../core/constants/dummy_data.dart';

class RestaurantState {
  final List<RestaurantEntity> restaurants;
  final List<RestaurantEntity> featuredRestaurants;
  final List<CategoryEntity> categories;
  final RestaurantEntity? selectedRestaurant;
  final String? selectedCategory;
  final String searchQuery;
  final bool isLoading;
  final String? error;

  const RestaurantState({
    this.restaurants = const [],
    this.featuredRestaurants = const [],
    this.categories = const [],
    this.selectedRestaurant,
    this.selectedCategory,
    this.searchQuery = '',
    this.isLoading = false,
    this.error,
  });

  RestaurantState copyWith({
    List<RestaurantEntity>? restaurants,
    List<RestaurantEntity>? featuredRestaurants,
    List<CategoryEntity>? categories,
    RestaurantEntity? selectedRestaurant,
    String? selectedCategory,
    String? searchQuery,
    bool? isLoading,
    String? error,
  }) {
    return RestaurantState(
      restaurants: restaurants ?? this.restaurants,
      featuredRestaurants: featuredRestaurants ?? this.featuredRestaurants,
      categories: categories ?? this.categories,
      selectedRestaurant: selectedRestaurant ?? this.selectedRestaurant,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class RestaurantNotifier extends StateNotifier<RestaurantState> {
  RestaurantNotifier() : super(const RestaurantState()) {
    loadRestaurants();
  }

  Future<void> loadRestaurants() async {
    state = state.copyWith(isLoading: true);
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      final restaurants = DummyData.restaurants;
      final featured = DummyData.getFeaturedRestaurants();
      final categories = DummyData.categories;
      state = state.copyWith(
        restaurants: restaurants,
        featuredRestaurants: featured,
        categories: categories,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void selectCategory(String categoryId) {
    state = state.copyWith(selectedCategory: categoryId);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void selectRestaurant(RestaurantEntity restaurant) {
    state = state.copyWith(selectedRestaurant: restaurant);
  }

  List<RestaurantEntity> getFilteredRestaurants() {
    var result = state.restaurants;
    if (state.selectedCategory != null) {
      final catName = DummyData.categories
          .firstWhere((c) => c.id == state.selectedCategory)
          .name;
      result = result.where((r) => r.categories.contains(catName)).toList();
    }
    if (state.searchQuery.isNotEmpty) {
      result = DummyData.searchRestaurants(
        state.searchQuery,
      ).where((r) => result.any((rr) => rr.id == r.id)).toList();
    }
    return result;
  }
}

final restaurantProvider =
    StateNotifierProvider<RestaurantNotifier, RestaurantState>((ref) {
      return RestaurantNotifier();
    });
