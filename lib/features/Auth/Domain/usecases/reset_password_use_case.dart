import 'package:dartz/dartz.dart';
import '../../../../core/error/failer.dart';
import '../repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase({required this.repository});

  Future<Either<Failure, void>> call({required String email}) {
    return repository.resetPassword(email: email);
  }
}

