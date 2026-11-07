import 'package:dartz/dartz.dart';
import '../../../../core/error/failer.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class EditProfileUseCase {
  final AuthRepository repository;

  EditProfileUseCase({required this.repository});

  Future<Either<Failure, void>> call({required UserEntity user}) {
    return repository.editProfile(user: user);
  }
}
