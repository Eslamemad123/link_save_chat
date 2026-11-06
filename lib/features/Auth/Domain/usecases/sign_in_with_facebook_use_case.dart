import 'package:dartz/dartz.dart';
import '../../../../core/error/failer.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignInWithFacebookUseCase {
  final AuthRepository repository;

  SignInWithFacebookUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call() {
    return repository.signInWithFacebook();
  }
}

