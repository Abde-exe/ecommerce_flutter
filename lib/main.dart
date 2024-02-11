import 'package:ecommerce_flutter/domain/usecases/user/sign_in_usecase.dart';
import 'package:ecommerce_flutter/presentation/blocs/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/router/app_router.dart';
import 'core/services/services_locator.dart' as di;

void main()  async {
  runApp(const MyApp());
  await di.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> di.sl<UserBloc>()..add(CheckUser()),child: const MaterialApp(
      title: "title",
    ),);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return BlocListener<UserBloc, UserState>(listener: (context,state) {
      if(state is UserLoading){
        print('UserLoading');
      }
      else if (state is UserLogged){
        print('Userlogged');
        Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.home, ModalRoute.withName(''));
      }
      else if (state is UserLoggedFail){
        print('Userlog failed');
      }
    },
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: Theme.of(context).colorScheme.inversePrimary,

          title: Text(widget.title),
        ),
        body: Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),

              ElevatedButton(onPressed:(){
                context.read<UserBloc>().add(SignInUser(SignInParams(
                    username: 'username',
                    password: 'password'
                )
                ));
              }, child:const Text(
                  'test'
              ))
            ],
          ),
        ),
      )
    );
    }
}
