import '../repositories/user_repository.dart';

class GetUserUseCase {
  final UserRepository repo;
  GetUserUseCase(this.repo);

  Future call() => repo.getUser();
}
