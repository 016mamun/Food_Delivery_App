import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/map_entity.dart';

abstract class MapRepository {
  Future<Either<Failure, LocationEntity>> getCurrentLocation();
  Future<Either<Failure, String>> getAddressFromCoordinates(
    double lat,
    double lng,
  );
  Future<Either<Failure, LocationEntity>> getCoordinatesFromAddress(
    String address,
  );
  Future<Either<Failure, DeliveryRouteEntity>> getDeliveryRoute(
    LocationEntity origin,
    LocationEntity destination,
  );
  Stream<LocationEntity> trackRiderLocation(String riderId);
  Future<Either<Failure, void>> updateRiderLocation(
    String riderId,
    double lat,
    double lng,
  );
}
