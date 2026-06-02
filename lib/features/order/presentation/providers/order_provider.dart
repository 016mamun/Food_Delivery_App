import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order_entity.dart';
import '../../../../core/constants/dummy_data.dart';

class OrderState {
  final List<OrderEntity> orders;
  final OrderEntity? activeOrder;
  final bool isLoading;
  final String? error;

  const OrderState({
    this.orders = const [],
    this.activeOrder,
    this.isLoading = false,
    this.error,
  });

  OrderState copyWith({
    List<OrderEntity>? orders,
    OrderEntity? activeOrder,
    bool? isLoading,
    String? error,
  }) => OrderState(
    orders: orders ?? this.orders,
    activeOrder: activeOrder ?? this.activeOrder,
    isLoading: isLoading ?? this.isLoading,
    error: error,
  );
}

class OrderNotifier extends StateNotifier<OrderState> {
  OrderNotifier() : super(const OrderState()) {
    loadOrders();
  }

  Future<void> loadOrders() async {
    state = state.copyWith(isLoading: true);
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      state = state.copyWith(orders: DummyData.orders, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  OrderEntity? getOrderById(String orderId) {
    try {
      return DummyData.orders.firstWhere((o) => o.id == orderId);
    } catch (_) {
      return null;
    }
  }

  List<OrderEntity> getActiveOrders() {
    return DummyData.orders
        .where(
          (o) =>
              o.status != OrderStatus.delivered &&
              o.status != OrderStatus.cancelled,
        )
        .toList();
  }

  List<OrderEntity> getPastOrders() {
    return DummyData.orders
        .where(
          (o) =>
              o.status == OrderStatus.delivered ||
              o.status == OrderStatus.cancelled,
        )
        .toList();
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    final idx = state.orders.indexWhere((o) => o.id == orderId);
    if (idx >= 0) {
      final updated = List<OrderEntity>.from(state.orders);
      updated[idx] = OrderEntity(
        id: updated[idx].id,
        userId: updated[idx].userId,
        restaurantId: updated[idx].restaurantId,
        restaurantName: updated[idx].restaurantName,
        riderId: updated[idx].riderId,
        riderName: updated[idx].riderName,
        items: updated[idx].items,
        subtotal: updated[idx].subtotal,
        deliveryFee: updated[idx].deliveryFee,
        tax: updated[idx].tax,
        total: updated[idx].total,
        status: status,
        deliveryAddress: updated[idx].deliveryAddress,
        deliveryLat: updated[idx].deliveryLat,
        deliveryLng: updated[idx].deliveryLng,
        restaurantLat: updated[idx].restaurantLat,
        restaurantLng: updated[idx].restaurantLng,
        specialInstructions: updated[idx].specialInstructions,
        paymentMethod: updated[idx].paymentMethod,
        paymentId: updated[idx].paymentId,
        createdAt: updated[idx].createdAt,
        confirmedAt: status == OrderStatus.confirmed
            ? DateTime.now()
            : updated[idx].confirmedAt,
        deliveredAt: status == OrderStatus.delivered
            ? DateTime.now()
            : updated[idx].deliveredAt,
        cancelledAt: status == OrderStatus.cancelled
            ? DateTime.now()
            : updated[idx].cancelledAt,
        cancelReason: updated[idx].cancelReason,
      );
      state = state.copyWith(orders: updated);
    }
  }

  Future<void> createOrder(OrderEntity order) async {
    final updated = [order, ...state.orders];
    state = state.copyWith(orders: updated, activeOrder: order);
    // Also add to dummy data for persistence
    DummyData.orders.insert(0, order);
  }
}

final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>(
  (ref) => OrderNotifier(),
);
