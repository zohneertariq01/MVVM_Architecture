import 'package:clear_view_model/utils/routes/routes.dart';
import 'package:clear_view_model/view/home_screen.dart';
import 'package:clear_view_model/view/login_view.dart';
import 'package:clear_view_model/view/signup_screen.dart';
import 'package:clear_view_model/view/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => LoginView());
      case RoutesName.signup:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case RoutesName.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No route defined'),
              ),
            );
          },
        );
    }
  }
}
