import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failer.dart';
import '../../Domain/entities/user_entity.dart';
import '../../Domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<UserEntity?> watchAuthState() {
    return remoteDataSource.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;
      try {
        final firestoreUser = await remoteDataSource.getUserData(
          userId: firebaseUser.uid,
        );
        if (firestoreUser != null && firestoreUser.isDeleted) {
          await remoteDataSource.logout();
          return null;
        }
        return firestoreUser ??
            UserEntity(
              id: firebaseUser.uid,
              name: firebaseUser.displayName ?? '',
              email: firebaseUser.email ?? '',
              photoUrl: firebaseUser.photoURL,
              phoneNumber: firebaseUser.phoneNumber,
              accountStatus: 'active',
              createdAt: firebaseUser.metadata.creationTime,
            );
      } catch (_) {
        return UserEntity(
          id: firebaseUser.uid,
          name: firebaseUser.displayName ?? '',
          email: firebaseUser.email ?? '',
          photoUrl: firebaseUser.photoURL,
          phoneNumber: firebaseUser.phoneNumber,
          accountStatus: 'active',
          createdAt: firebaseUser.metadata.creationTime,
        );
      }
    });
  }

  @override
  UserEntity? getCurrentUser() {
    final firebaseUser = remoteDataSource.getCurrentUser();
    if (firebaseUser == null) return null;
    return UserEntity(
      id: firebaseUser.uid,
      name: firebaseUser.displayName ?? '',
      email: firebaseUser.email ?? '',
      photoUrl: firebaseUser.photoURL,
      phoneNumber: firebaseUser.phoneNumber,
      accountStatus: 'active',
      createdAt: firebaseUser.metadata.creationTime,
    );
  }

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await remoteDataSource.login(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) {
        return Left(Failure(message: 'Authentication failed.'));
      }

      final existingData = await remoteDataSource.getUserData(userId: user.uid);
      if (existingData != null && existingData.isDeleted) {
        await remoteDataSource.logout();
        return Left(Failure(message: 'This account has been deleted.'));
      }

      final userEntity =
          existingData ??
          UserEntity(
            id: user.uid,
            name: user.displayName ?? '',
            email: user.email ?? '',
            photoUrl: user.photoURL,
            phoneNumber: user.phoneNumber,
            accountStatus: 'active',
            createdAt: user.metadata.creationTime,
          );

      return Right(userEntity);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: _mapFirebaseAuthError(e.code)));
    } catch (_) {
      return Left(Failure(message: 'An unexpected error occurred.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await remoteDataSource.signUp(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) {
        return Left(Failure(message: 'Sign up failed.'));
      }

      await user.updateDisplayName(name);

      final userModel = UserModel(
        id: user.uid,
        name: name,
        email: email,
        accountStatus: 'active',
        createdAt: DateTime.now(),
      );

      await remoteDataSource.saveUserData(user: userModel);

      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: _mapFirebaseAuthError(e.code)));
    } catch (_) {
      return Left(Failure(message: 'An unexpected error occurred.'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(null);
    } catch (_) {
      return Left(Failure(message: 'Failed to sign out.'));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      await remoteDataSource.resetPassword(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: _mapFirebaseAuthError(e.code)));
    } catch (_) {
      return Left(Failure(message: 'Failed to send password reset email.'));
    }
  }

  @override
  Future<Either<Failure, void>> updatePassword({
    required String newPassword,
  }) async {
    try {
      await remoteDataSource.updatePassword(newPassword: newPassword);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: _mapFirebaseAuthError(e.code)));
    } catch (_) {
      return Left(Failure(message: 'Failed to update password.'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await remoteDataSource.deleteAccount();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: _mapFirebaseAuthError(e.code)));
    } catch (_) {
      return Left(Failure(message: 'Failed to delete account.'));
    }
  }

  @override
  Future<Either<Failure, void>> editProfile({required UserEntity user}) async {
    try {
      final userModel = UserModel.fromEntity(user);
      await remoteDataSource.updateUserData(user: userModel);
      final currentUser = remoteDataSource.getCurrentUser();
      if (currentUser != null) {
        if (user.name.isNotEmpty && currentUser.displayName != user.name) {
          await currentUser.updateDisplayName(user.name);
        }
        if (user.photoUrl != null && currentUser.photoURL != user.photoUrl) {
          await currentUser.updatePhotoURL(user.photoUrl);
        }
      }
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: _mapFirebaseAuthError(e.code)));
    } on FirebaseException catch (e) {
      return Left(Failure(message: e.message ?? 'Firestore operation failed.'));
    } catch (_) {
      return Left(Failure(message: 'Failed to update profile.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      debugPrint('1. Starting Google Sign In');

      final credential = await remoteDataSource.signInWithGoogle();
      debugPrint('2. Google Sign In completed');

      final user = credential.user;

      if (user == null) {
        debugPrint('3. User is NULL');
        return Left(Failure(message: 'Google sign in failed.'));
      }

      debugPrint('3. User ID: ${user.uid}');

      final result = await _syncSocialUserDocument(user);

      debugPrint('4. User document synced');

      return result;
    } on FirebaseAuthException catch (e, stackTrace) {
      debugPrint('Firebase Auth Error: ${e.code}');
      debugPrint('Message: ${e.message}');
      debugPrintStack(stackTrace: stackTrace);

      return Left(Failure(message: _mapFirebaseAuthError(e.code)));
    } catch (e, stackTrace) {
      debugPrint('Unknown Error: $e');
      debugPrintStack(stackTrace: stackTrace);

      return Left(Failure(message: 'Google sign-in failed.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    try {
      final credential = await remoteDataSource.signInWithFacebook();
      final user = credential.user;
      if (user == null) {
        return Left(Failure(message: 'Facebook sign in failed.'));
      }
      return await _syncSocialUserDocument(user);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: _mapFirebaseAuthError(e.code)));
    } catch (e) {
      return Left(Failure(message: e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<Either<Failure, UserEntity>> _syncSocialUserDocument(User user) async {
    final existingDoc = await remoteDataSource.getUserData(userId: user.uid);
    if (existingDoc != null && existingDoc.isDeleted) {
      await remoteDataSource.logout();
      return Left(Failure(message: 'This account has been deleted.'));
    }

    if (existingDoc != null) {
      return Right(existingDoc);
    }

    final newUser = UserModel(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      photoUrl: user.photoURL,
      phoneNumber: user.phoneNumber,
      accountStatus: 'active',
      createdAt: user.metadata.creationTime ?? DateTime.now(),
    );

    await remoteDataSource.saveUserData(user: newUser);
    return Right(newUser);
  }

  String _mapFirebaseAuthError(String code) {
    switch (code) {
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-not-found':
        return 'No user found corresponding to this email address.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'email-already-in-use':
        return 'An account already exists for this email address.';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled in Firebase Console.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication. Please log in again before retrying.';
      case 'no-current-user':
        return 'No user currently logged in.';
      case 'too-many-requests':
        return 'Access to this account has been temporarily disabled due to many failed login attempts.';
      case 'facebook-sign-in-canceled':
      case 'google-sign-in-canceled':
        return 'Sign-in was canceled by user.';
      case 'facebook-sign-in-failed':
        return 'Facebook authentication failed. Please try again.';
      default:
        return 'An authentication error occurred. Please try again.';
    }
  }
}
