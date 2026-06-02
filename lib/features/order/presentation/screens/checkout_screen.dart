import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../address/domain/entities/address_entity.dart';
import '../../../address/presentation/providers/address_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../cart/presentation/providers/cart_provider.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  AddressEntity? _selectedAddress;
  final _instructionsController = TextEditingController();
  String _selectedPaymentMethod = 'card';

  @override
  void initState() {
    super.initState();
    // Load addresses
    final authState = ref.read(authProvider);
    final userId = authState.user?.id;
    if (userId != null) {
      ref.read(addressProvider.notifier).loadAddresses(userId);
    }
  }

  @override
  void dispose() {
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final addressState = ref.watch(addressProvider);

    // Auto-select default address
    if (_selectedAddress == null && addressState.defaultAddress != null) {
      _selectedAddress = addressState.defaultAddress;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Delivery Address Section
                  Text(
                    'Delivery Address',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 12),
                  if (_selectedAddress != null)
                    _buildSelectedAddressCard()
                  else
                    _buildNoAddressCard(),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () => context.push('/user/addresses'),
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('Add New'),
                      ),
                      TextButton.icon(
                        onPressed: () =>
                            context.push('/user/addresses/pick-location'),
                        icon: const Icon(Icons.map, size: 18),
                        label: const Text('Pick from Map'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Delivery Instructions
                  Text(
                    'Delivery Instructions (Optional)',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _instructionsController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'e.g., Ring doorbell, 3rd floor',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: AppColors.surface,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Order Summary
                  Text(
                    'Order Summary',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ...cart.items.map(
                            (item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  Text(
                                    '${item.quantity}x',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(item.food.name)),
                                  Text(
                                    '\$${item.totalPrice.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(height: 24),
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
                          _summaryRow(
                            'Tax',
                            '\$${cart.tax.toStringAsFixed(2)}',
                          ),
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

                  // Payment Method
                  Text(
                    'Payment Method',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 12),
                  _paymentOption('card', Icons.credit_card, 'Card'),
                  _paymentOption('cash', Icons.money, 'Cash on Delivery'),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // Bottom Button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 10)],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _selectedAddress != null ? _placeOrder : null,
                  child: Text(
                    'Place Order • \$${cart.total.toStringAsFixed(2)}',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedAddressCard() {
    return Card(
      color: AppColors.primary.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.primary, width: 2),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Icon(
            _selectedAddress!.label.toLowerCase() == 'home'
                ? Icons.home
                : _selectedAddress!.label.toLowerCase() == 'office'
                ? Icons.work
                : Icons.location_on,
            color: Colors.white,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                _selectedAddress!.label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            if (_selectedAddress!.isDefault)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Default',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(_selectedAddress!.fullAddress),
            if (_selectedAddress!.phone != null)
              Text(
                'Phone: ${_selectedAddress!.phone}',
                style: const TextStyle(fontSize: 12),
              ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.swap_horiz),
          onPressed: () => _showAddressSelectionDialog(),
          tooltip: 'Change Address',
        ),
      ),
    );
  }

  Widget _buildNoAddressCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 48,
              color: AppColors.textHint,
            ),
            const SizedBox(height: 8),
            const Text(
              'No delivery address selected',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: () => context.push('/user/addresses'),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Address'),
                ),
                OutlinedButton.icon(
                  onPressed: () =>
                      context.push('/user/addresses/pick-location'),
                  icon: const Icon(Icons.map, size: 18),
                  label: const Text('Pick Map'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentOption(String key, IconData icon, String title) {
    final isSelected = _selectedPaymentMethod == key;
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
        trailing: Radio<String>(
          value: key,
          groupValue: _selectedPaymentMethod,
          onChanged: (value) {
            setState(() => _selectedPaymentMethod = value!);
          },
          activeColor: AppColors.primary,
        ),
        onTap: () => setState(() => _selectedPaymentMethod = key),
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

  void _showAddressSelectionDialog() {
    final addressState = ref.read(addressProvider);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Address'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: addressState.addresses.length,
            itemBuilder: (context, index) {
              final address = addressState.addresses[index];
              return RadioListTile<AddressEntity>(
                value: address,
                groupValue: _selectedAddress,
                onChanged: (value) {
                  setState(() => _selectedAddress = value);
                  Navigator.pop(context);
                },
                title: Text(address.label),
                subtitle: Text(address.fullAddress),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _placeOrder() {
    if (_selectedAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a delivery address')),
      );
      return;
    }

    // Navigate to payment with address and instructions
    context.push(
      '/user/payment',
      extra: {
        'address': _selectedAddress,
        'instructions': _instructionsController.text,
        'paymentMethod': _selectedPaymentMethod,
      },
    );
  }
}
