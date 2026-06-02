import 'package:dartz/dartz.dart';
import '../../../../core/constants/dummy_data.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/repositories/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  // In-memory storage for dummy data
  final List<AddressEntity> _addresses = List.from(DummyData.addresses);

  @override
  Future<Either<Failure, List<AddressEntity>>> getUserAddresses(
    String userId,
  ) async {
    try {
      final userAddresses = _addresses
          .where((addr) => addr.userId == userId)
          .toList();
      return Right(userAddresses);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch addresses'));
    }
  }

  @override
  Future<Either<Failure, AddressEntity>> addAddress(
    AddressEntity address,
  ) async {
    try {
      _addresses.add(address);
      return Right(address);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to add address'));
    }
  }

  @override
  Future<Either<Failure, AddressEntity>> updateAddress(
    AddressEntity address,
  ) async {
    try {
      final index = _addresses.indexWhere((a) => a.id == address.id);
      if (index == -1) {
        return Left(ServerFailure(message: 'Address not found'));
      }
      _addresses[index] = address;
      return Right(address);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to update address'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAddress(String addressId) async {
    try {
      final index = _addresses.indexWhere((a) => a.id == addressId);
      if (index == -1) {
        return Left(ServerFailure(message: 'Address not found'));
      }
      _addresses.removeAt(index);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to delete address'));
    }
  }

  @override
  Future<Either<Failure, void>> setDefaultAddress(
    String userId,
    String addressId,
  ) async {
    try {
      // Remove default from all user addresses
      for (int i = 0; i < _addresses.length; i++) {
        if (_addresses[i].userId == userId) {
          _addresses[i] = _addresses[i].copyWith(isDefault: false);
        }
      }
      // Set the selected address as default
      final index = _addresses.indexWhere((a) => a.id == addressId);
      if (index == -1) {
        return Left(ServerFailure(message: 'Address not found'));
      }
      _addresses[index] = _addresses[index].copyWith(isDefault: true);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to set default address'));
    }
  }

  @override
  Future<Either<Failure, AddressEntity?>> getDefaultAddress(
    String userId,
  ) async {
    try {
      final defaultAddress = _addresses
          .where((addr) => addr.userId == userId && addr.isDefault)
          .firstOrNull;
      return Right(defaultAddress);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get default address'));
    }
  }
}
