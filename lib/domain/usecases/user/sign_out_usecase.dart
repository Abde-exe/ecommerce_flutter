import 'package:dartz/dartz.dart';
import 'package:ecommerce_flutter/core/errors/failures.dart';
import 'package:ecommerce_flutter/core/usecases/usecase.dart';
import 'package:ecommerce_flutter/domain/repositories/user_repository.dart';

class SignOutUseCase implements UseCase<NoParams, NoParams> {
  final UserRepository repository;

  SignOutUseCase(this.repository);

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await repository.signOut();
  }
}
