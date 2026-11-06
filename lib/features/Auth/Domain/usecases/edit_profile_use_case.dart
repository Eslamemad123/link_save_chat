import 'package:dartz/dartz.dart';
import '../../../../core/error/failer.dart';
import '../../Data/models/user_model.dart';
import '../repositories/auth_repository.dart';

class EditProfileUseCase {
  final AuthRepository repository;

  EditProfileUseCase({required this.repository});

  Future<Either<Failure, void>> call({required UserModel user}) {
    return repository.editProfile(user: user);
  }
}

