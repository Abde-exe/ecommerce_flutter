import 'dart:convert';

import 'package:ecommerce_flutter/domain/entities/user/user.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends User {
  const UserModel({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required String image,
  }) : super(id: id, firstName: firstName, lastName: lastName, email: email, image: image);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'].toString(),
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      image: json['image'] ?? '');

  Map<String, dynamic> toJson() =>
      {'id': id, 'firstName': firstName, 'lastName': lastName, 'email': email};
}
