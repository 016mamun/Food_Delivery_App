import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/order_entity.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrderEntity>> createOrder(OrderEntity order);
  Future<Either<Failure, OrderEntity>> getOrderById(String id);
  Future<Either<Failure, List<OrderEntity>>> getUserOrders({int? limit});
  Future<Either<Failure, List<OrderEntity>>> getRestaurantOrders(
    String restaurantId,
  );
  Future<Either<Failure, List<OrderEntity>>> getAvailableOrdersForRider();
  Future<Either<Failure, void>> updateOrderStatus(
    String orderId,
    OrderStatus status, {
    String? cancelReason,
  });
  Future<Either<Failure, void>> assignRider(String orderId, String riderId);
  Stream<OrderEntity> watchOrder(String orderId);
  Stream<List<OrderEntity>> watchUserOrders();
  Stream<List<OrderEntity>> watchRestaurantOrders(String restaurantId);
}
