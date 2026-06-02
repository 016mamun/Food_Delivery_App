import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/payment_entity.dart';

abstract class PaymentRepository {
  Future<Either<Failure, String>> createPaymentIntent(
    double amount,
    String currency,
  );
  Future<Either<Failure, PaymentEntity>> confirmPayment(
    String paymentIntentId,
    String paymentMethodId,
  );
  Future<Either<Failure, List<PaymentMethodEntity>>> getPaymentMethods();
  Future<Either<Failure, PaymentEntity>> getPaymentByOrderId(String orderId);
  Future<Either<Failure, void>> savePaymentMethod(PaymentMethodEntity method);
}
