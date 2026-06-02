import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../address/domain/entities/address_entity.dart';
import '../../../address/presentation/providers/address_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class LocationPickerScreen extends ConsumerStatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  ConsumerState<LocationPickerScreen> createState() =>
      _LocationPickerScreenState();
}

class _LocationPickerScreenState extends ConsumerState<LocationPickerScreen> {
  final _latController = TextEditingController(text: '23.7935');
  final _lngController = TextEditingController(text: '90.4066');
  final _addressController = TextEditingController(
    text: 'Gulshan Avenue, Dhaka 1212',
  );
  final _labelController = TextEditingController(text: 'Home');
  final _phoneController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _uuid = const Uuid();

  final List<Map<String, dynamic>> _quickLocations = [
    {
      'name': 'Gulshan',
      'lat': 23.7935,
      'lng': 90.4066,
      'address': 'Gulshan Avenue, Dhaka 1212',
    },
    {
      'name': 'Banani',
      'lat': 23.7925,
      'lng': 90.4011,
      'address': 'Banani Main Road, Dhaka 1213',
    },
    {
      'name': 'Dhanmondi',
      'lat': 23.7461,
      'lng': 90.3742,
      'address': 'Dhanmondi R/A, Dhaka 1205',
    },
    {
      'name': 'Uttara',
      'lat': 23.8759,
      'lng': 90.3795,
      'address': 'Uttara Sector 7, Dhaka 1230',
    },
    {
      'name': 'Mirpur',
      'lat': 23.8103,
      'lng': 90.3615,
      'address': 'Mirpur 10, Dhaka 1216',
    },
  ];

  @override
  void dispose() {
    _latController.dispose();
    _lngController.dispose();
    _addressController.dispose();
    _labelController.dispose();
    _phoneController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _selectQuickLocation(Map<String, dynamic> location) {
    setState(() {
      _latController.text = location['lat'].toString();
      _lngController.text = location['lng'].toString();
      _addressController.text = location['address'];
    });
  }

  Future<void> _saveAddress() async {
    final lat = double.tryParse(_latController.text);
    final lng = double.tryParse(_lngController.text);

    if (lat == null || lng == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid coordinates')));
      return;
    }

    final authState = ref.read(authProvider);
    final userId = authState.user?.id;
    if (userId == null) return;

    final address = AddressEntity(
      id: _uuid.v4(),
      userId: userId,
      label: _labelController.text.trim(),
      fullAddress: _addressController.text.trim(),
      lat: lat,
      lng: lng,
      isDefault: true,
      phone: _phoneController.text.trim().isEmpty
          ? null
          : _phoneController.text.trim(),
      instructions: _instructionsController.text.trim().isEmpty
          ? null
          : _instructionsController.text.trim(),
    );

    final notifier = ref.read(addressProvider.notifier);
    final success = await notifier.addAddress(address);

    if (success && mounted) {
      await notifier.setDefaultAddress(userId, address.id);
      Navigator.pop(context, address);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Address saved successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Location'),
        actions: [
          TextButton(onPressed: _saveAddress, child: const Text('Save')),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.primary.withValues(alpha: 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Quick Select:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _quickLocations.map((loc) {
                    return ElevatedButton(
                      onPressed: () => _selectQuickLocation(loc),
                      child: Text(loc['name']),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _latController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Latitude',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: AppColors.surface,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _lngController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Longitude',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: AppColors.surface,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _addressController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: 'Full Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: AppColors.surface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _labelController,
                    decoration: InputDecoration(
                      labelText: 'Label',
                      prefixIcon: const Icon(Icons.label),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: AppColors.surface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone (Optional)',
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: AppColors.surface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _instructionsController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: 'Instructions (Optional)',
                      prefixIcon: const Icon(Icons.note),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: AppColors.surface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
