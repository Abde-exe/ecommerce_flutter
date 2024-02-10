import 'package:ecommerce_flutter/domain/usecases/user/sign_in_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/errors/failures.dart';
import '../../domain/entities/user/user.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SignInUseCase _signInUseCase;

  UserBloc(this._signInUseCase) :super(UserInitial()) {
    on<SignInUser>(_onSignIn);
  }

  void _onSignIn(SignInUser event, Emitter<UserState>emit) async {
    try {
      emit(UserLoading());
      final result = await _signInUseCase(event.params);
      result.fold(
            (failure) => emit(UserLoggedFail(failure)),
            (user) => emit(UserLogged(user)),
      );
    }
    catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }
}