import 'package:ecommerce_flutter/data/models/user/user_model.dart';
import 'package:ecommerce_flutter/domain/usecases/user/sign_in_usecase.dart';

const tUserModel = UserModel(
  id: '1',
  firstName: 'firstName',
  lastName: 'lastName',
  email: 'email',
  image: 'image',
);

const tSignInParams = SignInParams(username: 'username', password: 'password');
