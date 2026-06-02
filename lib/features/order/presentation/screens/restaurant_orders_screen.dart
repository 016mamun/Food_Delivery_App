import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/dummy_data.dart';
import '../providers/order_provider.dart';
import '../../domain/entities/order_entity.dart';

class RestaurantOrdersScreen extends ConsumerWidget {
  const RestaurantOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'New'),
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _orderList(
              ref,
              DummyData.orders
                  .where((o) => o.status == OrderStatus.pending)
                  .toList(),
              'No new orders',
            ),
            _orderList(
              ref,
              DummyData.orders
                  .where(
                    (o) =>
                        o.status != OrderStatus.pending &&
                        o.status != OrderStatus.delivered &&
                        o.status != OrderStatus.cancelled,
                  )
                  .toList(),
              'No active orders',
            ),
            _orderList(
              ref,
              DummyData.orders
                  .where(
                    (o) =>
                        o.status == OrderStatus.delivered ||
                        o.status == OrderStatus.cancelled,
                  )
                  .toList(),
              'No completed orders',
            ),
          ],
        ),
      ),
    );
  }

  Widget _orderList(WidgetRef ref, List<OrderEntity> orders, String emptyText) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          emptyText,
          style: const TextStyle(color: AppColors.textSecondary),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order #${order.id.substring(6)}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '\$${order.total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...order.items.map(
                  (item) => Text(
                    '${item.quantity}x ${item.foodName}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text('Reject'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.error,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          ref
                              .read(orderProvider.notifier)
                              .updateOrderStatus(
                                order.id,
                                OrderStatus.confirmed,
                              );
                        },
                        child: const Text('Accept'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
