import 'package:equatable/equatable.dart';

class SalesAnalyticsEntity extends Equatable {
  final double totalRevenue;
  final int totalOrders;
  final double averageOrderValue;
  final List<DailySalesEntity> dailySales;
  final List<TopItemEntity> topItems;
  final int pendingOrders;
  final int completedOrders;
  final int cancelledOrders;

  const SalesAnalyticsEntity({
    required this.totalRevenue,
    required this.totalOrders,
    required this.averageOrderValue,
    this.dailySales = const [],
    this.topItems = const [],
    this.pendingOrders = 0,
    this.completedOrders = 0,
    this.cancelledOrders = 0,
  });

  @override
  List<Object?> get props => [totalRevenue, totalOrders];
}

class DailySalesEntity extends Equatable {
  final DateTime date;
  final double revenue;
  final int orders;

  const DailySalesEntity({
    required this.date,
    required this.revenue,
    required this.orders,
  });

  @override
  List<Object?> get props => [date];
}

class TopItemEntity extends Equatable {
  final String foodId;
  final String foodName;
  final int quantitySold;
  final double revenue;

  const TopItemEntity({
    required this.foodId,
    required this.foodName,
    required this.quantitySold,
    required this.revenue,
  });

  @override
  List<Object?> get props => [foodId];
}

class RiderEarningsEntity extends Equatable {
  final double todayEarnings;
  final double weeklyEarnings;
  final double monthlyEarnings;
  final int todayDeliveries;
  final int weeklyDeliveries;
  final int monthlyDeliveries;
  final List<DailyEarningEntity> dailyEarnings;

  const RiderEarningsEntity({
    this.todayEarnings = 0,
    this.weeklyEarnings = 0,
    this.monthlyEarnings = 0,
    this.todayDeliveries = 0,
    this.weeklyDeliveries = 0,
    this.monthlyDeliveries = 0,
    this.dailyEarnings = const [],
  });

  @override
  List<Object?> get props => [todayEarnings, weeklyEarnings];
}

class DailyEarningEntity extends Equatable {
  final DateTime date;
  final double earnings;
  final int deliveries;

  const DailyEarningEntity({
    required this.date,
    required this.earnings,
    required this.deliveries,
  });

  @override
  List<Object?> get props => [date];
}
