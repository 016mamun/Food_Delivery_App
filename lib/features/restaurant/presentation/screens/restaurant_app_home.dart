import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/dummy_data.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../order/domain/entities/order_entity.dart';

class RestaurantAppHome extends ConsumerWidget {
  const RestaurantAppHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analytics = DummyData.salesAnalytics;
    final activeOrders = DummyData.orders
        .where(
          (o) =>
              o.status != OrderStatus.delivered &&
              o.status != OrderStatus.cancelled,
        )
        .toList();
    final restaurant = DummyData.restaurants.first;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.store, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          restaurant.address,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: restaurant.isOpen,
                    onChanged: (v) {},
                    activeThumbColor: AppColors.success,
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => _showSignOutDialog(context, ref),
                    icon: const Icon(Icons.logout, color: AppColors.error),
                    tooltip: 'Sign Out',
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Quick stats
              Row(
                children: [
                  Expanded(
                    child: _quickStat(
                      'Today',
                      '\$${analytics.dailySales.last.revenue.toStringAsFixed(0)}',
                      Icons.today,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _quickStat(
                      'Orders',
                      '${analytics.dailySales.last.orders}',
                      Icons.receipt,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _quickStat(
                      'Active',
                      '${activeOrders.length}',
                      Icons.pending_actions,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Active orders
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Active Orders',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  TextButton(
                    onPressed: () => context.findAncestorWidgetOfExactType(),
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (activeOrders.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(
                      child: Text(
                        'No active orders',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                  ),
                )
              else
                ...activeOrders.map(
                  (order) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.receipt_long,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order #${order.id.substring(6)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${order.items.length} items • \$${order.total.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _statusDot(order.status),
                        ],
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              // Popular items
              Text(
                'Popular Items',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: DummyData.getFoodsByRestaurant(
                    'res_1',
                  ).take(5).length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final food = DummyData.getFoodsByRestaurant('res_1')[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.fastfood,
                              color: AppColors.primary,
                              size: 28,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              food.name,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '\$${food.effectivePrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickStat(String label, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusDot(dynamic status) {
    Color color;
    switch (status) {
      case OrderStatus.preparing:
        color = AppColors.warning;
      case OrderStatus.onTheWay:
        color = AppColors.info;
      default:
        color = AppColors.success;
    }
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  void _showSignOutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(authProvider.notifier).signOut();
              Navigator.pop(context);
              context.go('/auth/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
