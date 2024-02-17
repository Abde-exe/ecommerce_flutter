import 'package:ecommerce_flutter/core/errors/exceptions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../presentation/views/main_view.dart';

class AppRouter {

  static const String home = '/';
  static const String signIn = '/sign-in';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings){
    switch (routeSettings.name){
      case home:
        return MaterialPageRoute(builder: (_) => MainView());
      default:
        throw const RouteException('Route not found');
    }
  }

}