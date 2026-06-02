import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../address/domain/entities/address_entity.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../order/domain/entities/order_entity.dart';
import '../../../order/presentation/providers/order_provider.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  final AddressEntity address;
  final String instructions;
  final String paymentMethod;

  const PaymentScreen({
    super.key,
    required this.address,
    this.instructions = '',
    this.paymentMethod = 'card',
  });

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  String _selectedMethod = 'card';
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address
            Text(
              'Delivery To',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Card(
              color: AppColors.primary.withValues(alpha: 0.05),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    widget.address.label.toLowerCase() == 'home'
                        ? Icons.home
                        : widget.address.label.toLowerCase() == 'office'
                        ? Icons.work
                        : Icons.location_on,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  widget.address.label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(widget.address.fullAddress),
                    if (widget.address.phone != null)
                      Text('Phone: ${widget.address.phone}'),
                    if (widget.instructions.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Instructions: ${widget.instructions}',
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Order Summary',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _summaryRow(
                      'Subtotal',
                      '\$${cart.subtotal.toStringAsFixed(2)}',
                    ),
                    _summaryRow(
                      'Delivery Fee',
                      cart.deliveryFee == 0
                          ? 'Free'
                          : '\$${cart.deliveryFee.toStringAsFixed(2)}',
                    ),
                    _summaryRow('Tax', '\$${cart.tax.toStringAsFixed(2)}'),
                    const Divider(),
                    _summaryRow(
                      'Total',
                      '\$${cart.total.toStringAsFixed(2)}',
                      isBold: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Payment Method',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            _paymentOption(
              'card',
              Icons.credit_card,
              'Credit/Debit Card',
              '**** 4242',
            ),
            _paymentOption('apple_pay', Icons.apple, 'Apple Pay', ''),
            _paymentOption('google_pay', Icons.g_mobiledata, 'Google Pay', ''),
            _paymentOption('cash', Icons.money, 'Cash on Delivery', ''),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _processPayment,
                child: _isProcessing
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text('Pay \$${cart.total.toStringAsFixed(2)}'),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                '🔒 Your payment is secure and encrypted',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentOption(
    String key,
    IconData icon,
    String title,
    String subtitle,
  ) {
    final isSelected = _selectedMethod == key;
    return Card(
      color: isSelected ? AppColors.primary.withValues(alpha: 0.05) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? AppColors.primary : Colors.grey.shade300,
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        subtitle: subtitle.isNotEmpty
            ? Text(subtitle, style: const TextStyle(fontSize: 12))
            : null,
        trailing: RadioGroup<String>(
          groupValue: _selectedMethod,
          onChanged: (v) {
            if (v != null) setState(() => _selectedMethod = v);
          },
          child: Radio<String>(value: key, activeColor: AppColors.primary),
        ),
        onTap: () => setState(() => _selectedMethod = key),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              color: isBold ? AppColors.primary : AppColors.textPrimary,
              fontSize: isBold ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _processPayment() async {
    setState(() => _isProcessing = true);

    // Create order
    final cart = ref.read(cartProvider);
    final authState = ref.read(authProvider);
    final userId = authState.user?.id;

    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('User not authenticated')));
      setState(() => _isProcessing = false);
      return;
    }

    // Get restaurant ID from first cart item
    final restaurantId = cart.items.isNotEmpty
        ? cart.items.first.food.restaurantId
        : '';
    final restaurantName = cart.items.isNotEmpty
        ? cart.items.first.food.restaurantName
        : '';

    final order = OrderEntity(
      id: 'order_${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      restaurantId: restaurantId,
      restaurantName: restaurantName,
      items: cart.items
          .map(
            (item) => OrderItemEntity(
              foodId: item.food.id,
              foodName: item.food.name,
              foodImage: item.food.image,
              price: item.food.effectivePrice,
              quantity: item.quantity,
            ),
          )
          .toList(),
      subtotal: cart.subtotal,
      deliveryFee: cart.deliveryFee,
      tax: cart.tax,
      total: cart.total,
      status: OrderStatus.pending,
      deliveryAddress: widget.address.fullAddress,
      deliveryLat: widget.address.lat,
      deliveryLng: widget.address.lng,
      specialInstructions: widget.instructions.isEmpty
          ? null
          : widget.instructions,
      paymentMethod: widget.paymentMethod,
      createdAt: DateTime.now(),
    );

    // Save order
    await ref.read(orderProvider.notifier).createOrder(order);

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() => _isProcessing = false);
    ref.read(cartProvider.notifier).clearCart();

    // Navigate to order tracking
    context.go('/user/order-tracking/${order.id}');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Payment successful! Order placed.')),
    );
  }
}
