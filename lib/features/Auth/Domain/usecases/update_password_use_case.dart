import 'package:dartz/dartz.dart';
import '../../../../core/error/failer.dart';
import '../repositories/auth_repository.dart';

class UpdatePasswordUseCase {
  final AuthRepository repository;

  UpdatePasswordUseCase({required this.repository});

  Future<Either<Failure, void>> call({required String newPassword}) {
    return repository.updatePassword(newPassword: newPassword);
  }
}

