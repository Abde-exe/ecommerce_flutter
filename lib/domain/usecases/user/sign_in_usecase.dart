import 'package:ecommerce_flutter/domain/entities/user/user.dart';
import 'package:ecommerce_flutter/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';

class SignInUseCase implements UseCase<User, SignInParams> {
  final UserRepository repository;

  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignInParams params) async {
    final result =  await repository.signIn(params);
    return result;
  }
}

class SignInParams {
  final String username;
  final String password;

 const SignInParams({required this.username, required this.password});
}
