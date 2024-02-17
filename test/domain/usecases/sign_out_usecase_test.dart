import 'package:dartz/dartz.dart';
import 'package:ecommerce_flutter/core/errors/failures.dart';
import 'package:ecommerce_flutter/core/usecases/usecase.dart';
import 'package:ecommerce_flutter/domain/repositories/user_repository.dart';
import 'package:ecommerce_flutter/domain/usecases/user/sign_out_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_repository.mocks.dart';


void main() {
  late SignOutUseCase usecase;
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
    usecase = SignOutUseCase(mockRepository);
  });

  test("should call signout method successfully", () async {
    when(mockRepository.signOut()).thenAnswer((_) async => Right(NoParams()));
    final result = await usecase(NoParams());
    expect(result, Right(NoParams()));
    verify(mockRepository.signOut());
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return a failure from repository", () async {
    final failure = NetworkFailure();
    when(mockRepository.signOut()).thenAnswer((_) async => Left(failure));
    final result = await usecase(NoParams());
    expect(result, Left(failure));
    verify(mockRepository.signOut());
    verifyNoMoreInteractions(mockRepository);
  });
}
