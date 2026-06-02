import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';

class AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSource({
    firebase_auth.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance,
       _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<UserEntity> signInWithEmail(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _getUserEntity(credential.user!);
  }

  Future<UserEntity> signUpWithEmail(
    String email,
    String password,
    String name,
    UserRole role,
  ) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await credential.user!.updateDisplayName(name);
    await _saveUserToFirestore(credential.user!, name, role);
    return _getUserEntity(credential.user!, name: name, role: role);
  }

  Future<UserEntity> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null)
      throw AuthFailure(message: 'Google sign in cancelled');
    final googleAuth = await googleUser.authentication;
    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    await _saveUserToFirestore(
      userCredential.user!,
      userCredential.user!.displayName,
      UserRole.customer,
    );
    return _getUserEntity(userCredential.user!);
  }

  Future<UserEntity> signInWithApple() async {
    final rawNonce = _generateNonce();
    final nonce = sha256OfString(rawNonce);
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );
    final oauthCredential = firebase_auth.OAuthProvider(
      'apple.com',
    ).credential(idToken: appleCredential.identityToken, rawNonce: rawNonce);
    final userCredential = await _firebaseAuth.signInWithCredential(
      oauthCredential,
    );
    await _saveUserToFirestore(
      userCredential.user!,
      userCredential.user!.displayName,
      UserRole.customer,
    );
    return _getUserEntity(userCredential.user!);
  }

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(String, int?) verificationCompleted,
    required Function(String) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) {
        verificationCompleted(
          credential.verificationId ?? '',
          credential.smsCode != null ? int.tryParse(credential.smsCode!) : null,
        );
      },
      verificationFailed: (e) =>
          verificationFailed(e.message ?? 'Verification failed'),
      codeSent: (verificationId, resendToken) =>
          codeSent(verificationId, resendToken),
      codeAutoRetrievalTimeout: (verificationId) =>
          codeAutoRetrievalTimeout(verificationId),
    );
  }

  Future<UserEntity> verifyOtp(String verificationId, String otp) async {
    final credential = firebase_auth.PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return _getUserEntity(userCredential.user!);
  }

  Future<UserEntity?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return _getUserEntity(user);
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Stream<UserEntity?> get authStateChanges {
    return _firebaseAuth.authStateChanges().asyncMap((user) {
      if (user == null) return null;
      return _getUserEntity(user);
    });
  }

  Future<void> _saveUserToFirestore(
    firebase_auth.User user,
    String? name,
    UserRole role,
  ) async {
    await _firestore.collection('users').doc(user.uid).set({
      'email': user.email,
      'displayName': name ?? user.displayName,
      'photoUrl': user.photoURL,
      'phone': user.phoneNumber,
      'role': role.name,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<UserEntity> _getUserEntity(
    firebase_auth.User user, {
    String? name,
    UserRole? role,
  }) async {
    final doc = await _firestore.collection('users').doc(user.uid).get();
    final data = doc.data();
    return UserEntity(
      id: user.uid,
      email: user.email ?? '',
      displayName: name ?? data?['displayName'] ?? user.displayName,
      photoUrl: user.photoURL ?? data?['photoUrl'],
      phone: user.phoneNumber ?? data?['phone'],
      address: data?['address'],
      lat: (data?['lat'] as num?)?.toDouble(),
      lng: (data?['lng'] as num?)?.toDouble(),
      role:
          role ??
          UserRole.values.firstWhere(
            (r) => r.name == (data?['role'] ?? 'customer'),
          ),
      createdAt: (data?['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  String _generateNonce([int length = 32]) {
    final random = DateTime.now().millisecondsSinceEpoch;
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    return List.generate(
      length,
      (_) => charset[random % charset.length],
    ).join();
  }

  String sha256OfString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
