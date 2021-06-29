import 'package:flutter/material.dart';
import 'package:ilminneed/src/screen/author.dart';
import 'package:ilminneed/src/screen/cart.dart';
import 'package:ilminneed/src/screen/category.dart';
import 'package:ilminneed/src/screen/courses/course_detail.dart';
import 'package:ilminneed/src/screen/courses/latest_course.dart';
import 'package:ilminneed/src/screen/forgot_password.dart';
import 'package:ilminneed/src/screen/myaccount.dart';
import 'package:ilminneed/src/screen/reset_link.dart';
import 'package:ilminneed/src/screen/search.dart';
import 'package:ilminneed/src/screen/sign_in.dart';
import 'package:ilminneed/src/screen/sign_up.dart';
import 'package:ilminneed/src/screen/welcome.dart';

import 'src/screen/home_screen.dart';
import 'src/screen/splash.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/welcome':
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case '/signIn':
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case '/signUp':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/forgotPassword':
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case '/resetLink':
        return MaterialPageRoute(builder: (_) => ResetLink(param: args));
      case '/myAccount':
        return MaterialPageRoute(builder: (_) => MyAccountScreen());
      case '/homeScreen':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/category':
        return MaterialPageRoute(builder: (_) => Category());
      case '/search':
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case '/courseDetail':
        return MaterialPageRoute(builder: (_) => CourseDetail());
      case '/latestCourse':
        return MaterialPageRoute(builder: (_) => LatestCourse());
      case '/author':
        return MaterialPageRoute(builder: (_) => AuthorScreen());
      case '/cart':
        return MaterialPageRoute(builder: (_) => CartScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Page not found'),
        ),
      );
    });
  }
}
