import 'package:dartz/dartz.dart';
import 'package:ecommerce_flutter/core/errors/failures.dart';
import 'package:ecommerce_flutter/core/usecases/usecase.dart';
import 'package:ecommerce_flutter/domain/entities/user/user.dart';
import 'package:ecommerce_flutter/domain/usecases/user/get_cached_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'user_repository.mocks.dart';

void main() {
  late MockUserRepository mockRepository;
  late GetCachedUserUseCase usecase;

  setUp(() {
    mockRepository = MockUserRepository();
    usecase = GetCachedUserUseCase(mockRepository);
  });

  const tUserModel = User(
      id: "1", firstName: "username", lastName: "username", email: "email");

  test('should get user from cache when successful', () async {
    when(mockRepository.getCachedUser())
        .thenAnswer((_) async => Right(tUserModel));
    final result = await usecase(NoParams());
    expect(result, Right(tUserModel));
    verify(mockRepository.getCachedUser());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return a Failure from the repository',()async {
    final failure = NetworkFailure();
    when(mockRepository.getCachedUser()).thenAnswer((_) async =>Left(failure));
    final result = await usecase(NoParams());
    expect(result, Left(failure));
    verify(mockRepository.getCachedUser());
    verifyNoMoreInteractions(mockRepository);
  });
}
