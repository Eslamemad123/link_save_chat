import 'package:dartz/dartz.dart';
import '../../../../core/error/failer.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository repository;

  SignInWithGoogleUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call() {
    return repository.signInWithGoogle();
  }
}

