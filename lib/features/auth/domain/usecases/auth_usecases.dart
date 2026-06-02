import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignInWithEmailUseCase implements UseCase<UserEntity, SignInParams> {
  final AuthRepository repository;
  SignInWithEmailUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignInParams params) {
    return repository.signInWithEmail(params.email, params.password);
  }
}

class SignUpWithEmailUseCase implements UseCase<UserEntity, SignUpParams> {
  final AuthRepository repository;
  SignUpWithEmailUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) {
    return repository.signUpWithEmail(
      params.email,
      params.password,
      params.name,
      params.role,
    );
  }
}

class SignInWithGoogleUseCase implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;
  SignInWithGoogleUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return repository.signInWithGoogle();
  }
}

class SignInWithAppleUseCase implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;
  SignInWithAppleUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return repository.signInWithApple();
  }
}

class SignInWithPhoneUseCase implements UseCase<void, PhoneParams> {
  final AuthRepository repository;
  SignInWithPhoneUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(PhoneParams params) {
    return repository.signInWithPhone(params.phoneNumber);
  }
}

class VerifyPhoneOtpUseCase implements UseCase<void, OtpParams> {
  final AuthRepository repository;
  VerifyPhoneOtpUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(OtpParams params) {
    return repository.verifyPhoneOtp(params.verificationId, params.otp);
  }
}

class GetCurrentUserUseCase implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;
  GetCurrentUserUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return repository.getCurrentUser();
  }
}

class SignOutUseCase implements UseCase<void, NoParams> {
  final AuthRepository repository;
  SignOutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.signOut();
  }
}

class ResetPasswordUseCase implements UseCase<void, String> {
  final AuthRepository repository;
  ResetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String email) {
    return repository.resetPassword(email);
  }
}

class UpdateProfileUseCase implements UseCase<void, UpdateProfileParams> {
  final AuthRepository repository;
  UpdateProfileUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateProfileParams params) {
    return repository.updateProfile(
      displayName: params.displayName,
      phone: params.phone,
      address: params.address,
      photoUrl: params.photoUrl,
    );
  }
}

class SignInParams {
  final String email;
  final String password;
  const SignInParams({required this.email, required this.password});
}

class SignUpParams {
  final String email;
  final String password;
  final String name;
  final UserRole role;
  const SignUpParams({
    required this.email,
    required this.password,
    required this.name,
    required this.role,
  });
}

class PhoneParams {
  final String phoneNumber;
  const PhoneParams({required this.phoneNumber});
}

class OtpParams {
  final String verificationId;
  final String otp;
  const OtpParams({required this.verificationId, required this.otp});
}

class UpdateProfileParams {
  final String? displayName;
  final String? phone;
  final String? address;
  final String? photoUrl;
  const UpdateProfileParams({
    this.displayName,
    this.phone,
    this.address,
    this.photoUrl,
  });
}
