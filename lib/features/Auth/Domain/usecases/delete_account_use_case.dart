import 'package:dartz/dartz.dart';
import '../../../../core/error/failer.dart';
import '../repositories/auth_repository.dart';

class DeleteAccountUseCase {
  final AuthRepository repository;

  DeleteAccountUseCase({required this.repository});

  Future<Either<Failure, void>> call() {
    return repository.deleteAccount();
  }
}

