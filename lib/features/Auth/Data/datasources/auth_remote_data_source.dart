import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Stream<User?> authStateChanges();

  User? getCurrentUser();

  Future<UserCredential> login({
    required String email,
    required String password,
  });

  Future<UserCredential> signUp({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<void> resetPassword({required String email});

  Future<void> updatePassword({required String newPassword});

  Future<void> deleteAccount();

  Future<void> saveUserData({required UserModel user});

  Future<void> updateUserData({required UserModel user});

  Future<UserModel?> getUserData({required String userId});

  Future<UserCredential> signInWithGoogle();

  Future<UserCredential> signInWithFacebook();
}

