import 'package:ecommerce_flutter/data/datasources/remote/user_remote_datasource.dart';
import 'package:ecommerce_flutter/data/repositories/user_repository_impl.dart';
import 'package:ecommerce_flutter/domain/repositories/user_repository.dart';
import 'package:ecommerce_flutter/presentation/blocs/user_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async{
  
  //User
  //Bloc
  sl.registerFactory(() => UserBloc(sl()));
  //Use cases
  sl.registerLazySingleton(() => SignInUser(sl()));
  //Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(remoteDatasource: sl(), networkInfo: sl()));
  //Datasource
  sl.registerLazySingleton<UserRemoteDatasource>(() => UserRemoteDatasourceImpl(client: sl()));
}