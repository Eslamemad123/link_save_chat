import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class WatchAuthStateUseCase {
  final AuthRepository repository;

  WatchAuthStateUseCase({required this.repository});

  Stream<UserEntity?> call() {
    return repository.watchAuthState();
  }
}

