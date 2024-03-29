import 'package:dartz/dartz.dart';
import 'package:ecommerce_flutter/core/errors/failures.dart';
import 'package:ecommerce_flutter/core/usecases/usecase.dart';
import 'package:ecommerce_flutter/data/datasources/remote/user_remote_datasource.dart';
import 'package:ecommerce_flutter/data/models/user/authentication_response_model.dart';
import 'package:ecommerce_flutter/domain/entities/user/user.dart';
import 'package:ecommerce_flutter/domain/repositories/user_repository.dart';
import 'package:ecommerce_flutter/domain/usecases/user/sign_in_usecase.dart';
import 'package:ecommerce_flutter/domain/usecases/user/sign_up_usecase.dart';

import '../../core/network/network_info.dart';

typedef _DataSourceChooser = Future<AuthenticationResponseModel> Function();

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource remoteDatasource;

  //final UserLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl(
      {required this.remoteDatasource,
      //required this.localDatasource,
      required this.networkInfo});

  @override
  Future<Either<Failure, User>> getCachedUser() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NoParams>> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUp(SignUpParams params) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signIn(SignInParams params) async {
    final result =  await _authenticate(() {
      return remoteDatasource.signIn(params);
    });
    return result;
  }

  Future<Either<Failure, User>> _authenticate(
      _DataSourceChooser getDataSource,
      ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResponse = await getDataSource();
        //localDataSource.saveToken(remoteResponse.token);
        //localDataSource.saveUser(remoteResponse.user);
        return Right(remoteResponse.user);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NetworkFailure());
    }
  }


}
