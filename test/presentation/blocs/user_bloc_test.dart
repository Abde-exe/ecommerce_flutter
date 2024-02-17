import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_flutter/core/errors/failures.dart';
import 'package:ecommerce_flutter/domain/usecases/user/sign_in_usecase.dart';
import 'package:ecommerce_flutter/presentation/blocs/user_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/constant_objects.dart';

class MockSignInUseCase extends Mock implements SignInUseCase {}

void main() {
  group('UserBloc', () {
    late UserBloc userBloc;
    late MockSignInUseCase mockSignInUseCase;

    setUp(() {
      mockSignInUseCase = MockSignInUseCase();
      userBloc = UserBloc(mockSignInUseCase);
    });

    test('initial state should be UserInitial', () {
      expect(userBloc.state, UserInitial());
    });

    blocTest<UserBloc, UserState>(
        'emits [UserLoading, UserLogged] when SignInUser is added',
        build: () {
          when(mockSignInUseCase(tSignInParams))
              .thenAnswer((_) async => const Right(tUserModel));
          return userBloc;
        },
        act: (bloc) => bloc.add(SignInUser(tSignInParams)),
        expect: () => [UserLoading(), UserLogged(tUserModel)]);

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserLoggedFail] when SignInUser is added',
      build: () {
        when(mockSignInUseCase(tSignInParams))
            .thenAnswer((_) async => Left(NetworkFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(SignInUser(tSignInParams)),
      expect: () => [UserLoading(), UserLoggedFail(NetworkFailure())],
    );
  });
}
