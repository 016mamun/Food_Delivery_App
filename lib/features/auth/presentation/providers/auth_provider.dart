import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_entity.dart';

enum AuthStatus { initial, authenticated, unauthenticated, loading, error }

class AuthState {
  final AuthStatus status;
  final UserEntity? user;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  Future<void> signInWithEmail(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading);
    await Future.delayed(const Duration(seconds: 1));

    // Dummy login: any email/password works
    // Role is determined by email prefix
    UserRole role = UserRole.customer;
    String name = 'Mamun';
    if (email.contains('restaurant')) {
      role = UserRole.restaurant;
      name = 'Restaurant Owner';
    } else if (email.contains('rider')) {
      role = UserRole.rider;
      name = 'Karim Uddin';
    }

    state = state.copyWith(
      status: AuthStatus.authenticated,
      user: UserEntity(
        id: 'user_1',
        email: email,
        displayName: name,
        role: role,
        phone: '+8801712345678',
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> signUpWithEmail(
    String email,
    String password,
    String name,
    UserRole role,
  ) async {
    state = state.copyWith(status: AuthStatus.loading);
    await Future.delayed(const Duration(seconds: 1));

    state = state.copyWith(
      status: AuthStatus.authenticated,
      user: UserEntity(
        id: 'user_new_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        displayName: name,
        role: role,
        phone: '',
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(status: AuthStatus.loading);
    await Future.delayed(const Duration(seconds: 1));

    state = state.copyWith(
      status: AuthStatus.authenticated,
      user: UserEntity(
        id: 'user_google_1',
        email: 'user@gmail.com',
        displayName: 'Mamun Ahmed',
        role: UserRole.customer,
        phone: '',
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> signInWithApple() async {
    state = state.copyWith(status: AuthStatus.loading);
    await Future.delayed(const Duration(seconds: 1));

    state = state.copyWith(
      status: AuthStatus.authenticated,
      user: UserEntity(
        id: 'user_apple_1',
        email: 'user@icloud.com',
        displayName: 'Mamun Ahmed',
        role: UserRole.customer,
        phone: '',
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> signInWithPhone(String phoneNumber) async {
    state = state.copyWith(status: AuthStatus.loading);
    await Future.delayed(const Duration(seconds: 1));

    state = state.copyWith(
      status: AuthStatus.authenticated,
      user: UserEntity(
        id: 'user_phone_1',
        email: '',
        displayName: 'Phone User',
        role: UserRole.customer,
        phone: phoneNumber,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> signOut() async {
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  void checkAuth() {
    // No persistent auth in dummy mode - always start fresh
    if (state.status == AuthStatus.initial) {
      state = const AuthState(status: AuthStatus.unauthenticated);
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
