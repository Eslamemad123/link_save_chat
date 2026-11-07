import 'package:dartz/dartz.dart';
import '../../../../core/error/failer.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Stream<UserEntity?> watchAuthState();

  UserEntity? getCurrentUser();

  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, void>> resetPassword({required String email});

  Future<Either<Failure, void>> updatePassword({required String newPassword});

  Future<Either<Failure, void>> deleteAccount();

  Future<Either<Failure, void>> editProfile({required UserEntity user});

  Future<Either<Failure, UserEntity>> signInWithGoogle();

  Future<Either<Failure, UserEntity>> signInWithFacebook();
}
