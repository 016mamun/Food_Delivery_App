import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/repositories/address_repository.dart';
import '../../data/repositories/address_repository_impl.dart';

// Repository provider
final addressRepositoryProvider = Provider<AddressRepository>((ref) {
  return AddressRepositoryImpl();
});

// State class
class AddressState {
  final List<AddressEntity> addresses;
  final AddressEntity? defaultAddress;
  final bool isLoading;
  final String? error;

  const AddressState({
    this.addresses = const [],
    this.defaultAddress,
    this.isLoading = false,
    this.error,
  });

  AddressState copyWith({
    List<AddressEntity>? addresses,
    AddressEntity? defaultAddress,
    bool? isLoading,
    String? error,
  }) {
    return AddressState(
      addresses: addresses ?? this.addresses,
      defaultAddress: defaultAddress ?? this.defaultAddress,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Notifier
class AddressNotifier extends StateNotifier<AddressState> {
  final AddressRepository _repository;

  AddressNotifier(this._repository) : super(const AddressState());

  Future<void> loadAddresses(String userId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.getUserAddresses(userId);
      result.fold(
        (failure) =>
            state = state.copyWith(isLoading: false, error: failure.message),
        (addresses) {
          final defaultAddr = addresses.where((a) => a.isDefault).firstOrNull;
          state = state.copyWith(
            addresses: addresses,
            defaultAddress: defaultAddr,
            isLoading: false,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load addresses',
      );
    }
  }

  Future<bool> addAddress(AddressEntity address) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.addAddress(address);
      return result.fold(
        (failure) {
          state = state.copyWith(isLoading: false, error: failure.message);
          return false;
        },
        (newAddress) {
          loadAddresses(address.userId);
          return true;
        },
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to add address');
      return false;
    }
  }

  Future<bool> updateAddress(AddressEntity address) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.updateAddress(address);
      return result.fold(
        (failure) {
          state = state.copyWith(isLoading: false, error: failure.message);
          return false;
        },
        (_) {
          loadAddresses(address.userId);
          return true;
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to update address',
      );
      return false;
    }
  }

  Future<bool> deleteAddress(String addressId, String userId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.deleteAddress(addressId);
      return result.fold(
        (failure) {
          state = state.copyWith(isLoading: false, error: failure.message);
          return false;
        },
        (_) {
          loadAddresses(userId);
          return true;
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to delete address',
      );
      return false;
    }
  }

  Future<bool> setDefaultAddress(String userId, String addressId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.setDefaultAddress(userId, addressId);
      return result.fold(
        (failure) {
          state = state.copyWith(isLoading: false, error: failure.message);
          return false;
        },
        (_) {
          loadAddresses(userId);
          return true;
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to set default address',
      );
      return false;
    }
  }
}

// Provider
final addressProvider = StateNotifierProvider<AddressNotifier, AddressState>((
  ref,
) {
  final repository = ref.watch(addressRepositoryProvider);
  return AddressNotifier(repository);
});

// Auto-load provider
final addressInitializerProvider = Provider<void>((ref) {
  final authState = ref.watch(authProvider);
  final userId = authState.user?.id;
  if (userId != null) {
    ref.watch(addressProvider.notifier).loadAddresses(userId);
  }
});
