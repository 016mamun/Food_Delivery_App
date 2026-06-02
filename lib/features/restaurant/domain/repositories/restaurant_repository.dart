import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/restaurant_entity.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, List<RestaurantEntity>>> getRestaurants({
    double? lat,
    double? lng,
    String? cuisine,
    String? query,
  });
  Future<Either<Failure, RestaurantEntity>> getRestaurantById(String id);
  Future<Either<Failure, List<RestaurantEntity>>> getFeaturedRestaurants();
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, List<RestaurantEntity>>> searchRestaurants(
    String query,
  );
  Stream<List<RestaurantEntity>> watchRestaurants();
}
