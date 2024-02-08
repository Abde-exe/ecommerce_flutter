import 'dart:convert';

import 'package:ecommerce_flutter/data/models/user/user_model.dart';

AuthenticationResponseModel authenticationResponseModelFromJson(String str)=> AuthenticationResponseModel.fromJson(json.decode(str));

String authenticationResponseModelToJson(AuthenticationResponseModel data)=>json.encode(data.toJson());

class AuthenticationResponseModel {
  final String token;
  final UserModel user;

  AuthenticationResponseModel({required this.token, required this.user});

  factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthenticationResponseModel(
          token: json['token'], user: UserModel.fromJson(json));

  Map<String, dynamic> toJson() =>
      {
        "token": token,
        "user": user.toJson()
      };
}
