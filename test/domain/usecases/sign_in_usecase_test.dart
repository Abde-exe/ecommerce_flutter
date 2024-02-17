import 'package:dartz/dartz.dart';
import 'package:ecommerce_flutter/core/errors/failures.dart';
import 'package:ecommerce_flutter/domain/entities/user/user.dart';
import 'package:ecommerce_flutter/domain/repositories/user_repository.dart';
import 'package:ecommerce_flutter/domain/usecases/user/sign_in_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_repository.mocks.dart';


void main() {
  late SignInUseCase usecase;
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
    usecase = SignInUseCase(mockRepository);
  });

  const tUserModel = User(
      id: "1", firstName: "username", lastName: "username", email: "email");
  final tParams = SignInParams(username: "username", password: "password");

  test('should get user from repository when success', () async {
    //arrange
    when(mockRepository.signIn(tParams))
        .thenAnswer((_) async => const Right(tUserModel));

    //act
    final result = await usecase(tParams);

    //assert
    expect(result, const Right(tUserModel));
    verify(mockRepository.signIn(tParams));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return a failure from the repository', () async {
    final failure = NetworkFailure();
    //arrange
    when(mockRepository.signIn(tParams)).thenAnswer((_) async => Left(failure));
    //act
    final result = await usecase(tParams);
    //assert
    expect(result, Left(failure));
    verify(mockRepository.signIn(tParams));
    verifyNoMoreInteractions(mockRepository);
  });
}
