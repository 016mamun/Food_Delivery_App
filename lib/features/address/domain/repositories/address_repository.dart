import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/address_entity.dart';

abstract class AddressRepository {
  Future<Either<Failure, List<AddressEntity>>> getUserAddresses(String userId);
  Future<Either<Failure, AddressEntity>> addAddress(AddressEntity address);
  Future<Either<Failure, AddressEntity>> updateAddress(AddressEntity address);
  Future<Either<Failure, void>> deleteAddress(String addressId);
  Future<Either<Failure, void>> setDefaultAddress(
    String userId,
    String addressId,
  );
  Future<Either<Failure, AddressEntity?>> getDefaultAddress(String userId);
}
