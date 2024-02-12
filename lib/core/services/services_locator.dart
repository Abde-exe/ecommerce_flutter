import 'package:ecommerce_flutter/data/datasources/remote/user_remote_datasource.dart';
import 'package:ecommerce_flutter/data/repositories/user_repository_impl.dart';
import 'package:ecommerce_flutter/domain/repositories/user_repository.dart';
import 'package:ecommerce_flutter/domain/usecases/user/sign_in_usecase.dart';
import 'package:ecommerce_flutter/presentation/blocs/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async{
  
  //User
  //Bloc
  sl.registerFactory(() => UserBloc(sl()));
  //Use cases
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  //Repository
  sl.registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(
      remoteDatasource: sl(),
      networkInfo: sl(),
    ),
  );
  //Datasource
  sl.registerLazySingleton<UserRemoteDatasource>(() => UserRemoteDatasourceImpl(client: sl()));
  
  
  
  //external
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
}