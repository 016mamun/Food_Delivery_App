import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithEmail(
    String email,
    String password,
  );
  Future<Either<Failure, UserEntity>> signUpWithEmail(
    String email,
    String password,
    String name,
    UserRole role,
  );
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, UserEntity>> signInWithApple();
  Future<Either<Failure, UserEntity>> signInWithPhone(String phoneNumber);
  Future<Either<Failure, void>> verifyPhoneOtp(
    String verificationId,
    String otp,
  );
  Future<Either<Failure, UserEntity>> getCurrentUser();
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, void>> resetPassword(String email);
  Future<Either<Failure, void>> updateProfile({
    String? displayName,
    String? phone,
    String? address,
    String? photoUrl,
  });
  Stream<UserEntity?> get authStateChanges;
}
