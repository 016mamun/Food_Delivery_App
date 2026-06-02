import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/food_entity.dart';

abstract class FoodRepository {
  Future<Either<Failure, List<FoodEntity>>> getFoods({
    String? categoryId,
    String? restaurantId,
  });
  Future<Either<Failure, FoodEntity>> getFoodById(String id);
  Future<Either<Failure, List<FoodEntity>>> getPopularFoods();
  Future<Either<Failure, List<FoodEntity>>> getNewFoods();
  Future<Either<Failure, List<FoodEntity>>> searchFoods(String query);
  Future<Either<Failure, List<FoodEntity>>> getFoodsByRestaurant(
    String restaurantId,
  );
  Future<Either<Failure, void>> addFood(FoodEntity food);
  Future<Either<Failure, void>> updateFood(FoodEntity food);
  Future<Either<Failure, void>> deleteFood(String foodId);
  Stream<List<FoodEntity>> watchFoodsByRestaurant(String restaurantId);
}
