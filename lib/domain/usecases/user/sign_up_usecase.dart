import 'package:dartz/dartz.dart';
import 'package:ecommerce_flutter/core/errors/failures.dart';
import 'package:ecommerce_flutter/core/usecases/usecase.dart';
import 'package:ecommerce_flutter/domain/repositories/user_repository.dart';

import '../../entities/user/user.dart';

class SignUpUseCase implements UseCase<User, SignUpParams> {
  final UserRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) {
    return repository.signUp(params);
  }
}

class SignUpParams {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  SignUpParams(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password});
}
