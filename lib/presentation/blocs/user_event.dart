part of 'user_bloc.dart';

@immutable
abstract class UserEvent{}

class SignInUser extends UserEvent{
  final SignInParams params;
  SignInUser(this.params);
}