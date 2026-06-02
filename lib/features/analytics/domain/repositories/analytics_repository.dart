import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/analytics_entity.dart';

abstract class AnalyticsRepository {
  Future<Either<Failure, SalesAnalyticsEntity>> getSalesAnalytics(
    String restaurantId, {
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<Either<Failure, RiderEarningsEntity>> getRiderEarnings(
    String riderId, {
    DateTime? startDate,
    DateTime? endDate,
  });
  Stream<SalesAnalyticsEntity> watchSalesAnalytics(String restaurantId);
}
