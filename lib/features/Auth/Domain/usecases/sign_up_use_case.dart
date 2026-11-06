import 'package:dartz/dartz.dart';
import '../../../../core/error/failer.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
    required String name,
  }) {
    return repository.signUp(email: email, password: password, name: name);
  }
}

