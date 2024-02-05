import 'package:dartz/dartz.dart';
import 'package:ecommerce_flutter/core/errors/failures.dart';
import 'package:ecommerce_flutter/domain/entities/user/user.dart';
import 'package:ecommerce_flutter/domain/repositories/user_repository.dart';
import 'package:ecommerce_flutter/domain/usecases/user/sign_up_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_repository.mocks.dart';


@GenerateNiceMocks([MockSpec<UserRepository>()])
void main() {
  late SignUpUseCase usecase;
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
    usecase = SignUpUseCase(mockRepository);
  });

  const tUserModel = User(
      id: "1", firstName: "username", lastName: "username", email: "email");
  final tParams = SignUpParams(
      firstName: "username",
      lastName: "lastname",
      email: "email",
      password: "password");

  test("should get user from repository when successful", () async {
    when(mockRepository.signUp(tParams))
        .thenAnswer((_) async => const Right(tUserModel));

    final result = await usecase(tParams);
    expect(result, const Right(tUserModel));
    verify(mockRepository.signUp(tParams));
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return a failure from repository", () async {
    final failure = NetworkFailure();
    when(mockRepository.signUp(tParams)).thenAnswer((_) async => Left(failure));
    final result = await usecase(tParams);
    expect(result, Left(failure));
    verify(mockRepository.signUp(tParams));
    verifyNoMoreInteractions(mockRepository);
  });
}
