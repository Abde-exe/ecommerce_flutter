import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class NetworkFailure extends Failure {}
class CredentialsFailure extends Failure {}
class ExceptionFailure extends Failure {}

