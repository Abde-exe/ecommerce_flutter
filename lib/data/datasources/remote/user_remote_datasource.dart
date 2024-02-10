import 'dart:convert';

import 'package:ecommerce_flutter/core/constants/strings.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_flutter/domain/usecases/user/sign_in_usecase.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/usecases/user/sign_up_usecase.dart';
import '../../models/user/authentication_response_model.dart';

abstract class UserRemoteDatasource {
  Future<AuthenticationResponseModel> signIn(SignInParams params);
  Future<AuthenticationResponseModel> signUp(SignUpParams params);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final http.Client client;
  UserRemoteDatasourceImpl({required this.client});

  @override
  Future<AuthenticationResponseModel> signUp(SignUpParams params) async {
    final response = await client.post(Uri.parse('$baseUrl/users/add'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'firstName': params.firstName,
          'lastName': params.lastName,
          'email': params.email,
          'password': params.password
        })
    );
    if (response.statusCode == 200) {
      return authenticationResponseModelFromJson(response.body);
    }
    else if (response.statusCode == 400 ||  response.statusCode == 401) {
      throw CredentialsFailure();
    }
    else {
      throw ServerException();
    }
  }

  @override
  Future<AuthenticationResponseModel> signIn(SignInParams params) async {
    final response = await client.post(Uri.parse('$baseUrl/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': params.username,
          'password': params.password
        })
    );
    if (response.statusCode == 200) {
      return authenticationResponseModelFromJson(response.body);
    }
    else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialsFailure();
    }
    else {
      throw ServerException();
    }
  }
}