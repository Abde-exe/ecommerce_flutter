import 'package:ecommerce_flutter/domain/usecases/user/sign_in_usecase.dart';
import 'package:ecommerce_flutter/presentation/blocs/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MainView"),),
      body: Center(
        child: Row(
            children: [
            BlocBuilder<UserBloc, UserState > (builder: (context, state) {
          if (state is UserLogged) {
            print("state");
            return Text(state.user.firstName);
          }
          else {
            return const Text("non");
          }
        }),
        ElevatedButton(onPressed: () {
          context.read<UserBloc>().add(SignInUser(SignInParams(
              username: 'kminchelle',
              password: '0lelplR'
          )));
          print('tests');
        }, child: const Text('Login'))
        ],

      ),
    ),);
  }
}
