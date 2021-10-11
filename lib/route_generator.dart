import 'package:flutter/material.dart';
import 'package:ilminneed/src/screen/author.dart';
import 'package:ilminneed/src/screen/cart.dart';
import 'package:ilminneed/src/screen/category.dart';
import 'package:ilminneed/src/screen/category_result.dart';
import 'package:ilminneed/src/screen/change_password.dart';
import 'package:ilminneed/src/screen/coupon.dart';
import 'package:ilminneed/src/screen/courses/course_detail.dart';
import 'package:ilminneed/src/screen/courses/latest_course.dart';
import 'package:ilminneed/src/screen/forgot_password.dart';
import 'package:ilminneed/src/screen/lesson.dart';
import 'package:ilminneed/src/screen/metting.dart';
import 'package:ilminneed/src/screen/my_profile.dart';
import 'package:ilminneed/src/screen/myaccount.dart';
import 'package:ilminneed/src/screen/mycourses.dart';
import 'package:ilminneed/src/screen/qandareply.dart';
import 'package:ilminneed/src/screen/reset_link.dart';
import 'package:ilminneed/src/screen/search.dart';
import 'package:ilminneed/src/screen/sign_in.dart';
import 'package:ilminneed/src/screen/sign_up.dart';
import 'package:ilminneed/src/screen/thank_you.dart';
import 'package:ilminneed/src/screen/welcome.dart';
import 'package:ilminneed/src/screen/wishlist.dart';
import 'package:ilminneed/src/widgets/file_reader.dart';
import 'package:ilminneed/src/widgets/lesson_details.dart';
import 'package:ilminneed/src/widgets/view_image.dart';

import 'src/screen/home_screen.dart';
import 'src/screen/splash.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => HomeScreen(
                currentTab: args == null
                    ? {'currentTab': 0, 'data': ''}
                    : args as Map<dynamic, dynamic>?));
      case '/splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/welcome':
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case '/signIn':
        return MaterialPageRoute(
            builder: (_) => SignInScreen(data: args as Map<dynamic, dynamic>?));

      case '/signUp':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/forgotPassword':
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case '/resetLink':
        return MaterialPageRoute(
            builder: (_) => ResetLink(param: args as Map<dynamic, dynamic>?));
      case '/myAccount':
        return MaterialPageRoute(builder: (_) => MyAccountScreen());
      case '/homeScreen':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/category':
        return MaterialPageRoute(builder: (_) => Category());
      case '/search':
        return MaterialPageRoute(
            builder: (_) => SearchScreen(term: args as String?));
      case '/courseDetail':
        return MaterialPageRoute(
            builder: (_) => CourseDetail(id: args as String?));
      case '/latestCourse':
        return MaterialPageRoute(builder: (_) => LatestCourse());
      case '/author':
        return MaterialPageRoute(
            builder: (_) => AuthorScreen(id: args as String?));
      case '/cart':
        return MaterialPageRoute(builder: (_) => CartScreen());
      case '/coupon':
        return MaterialPageRoute(builder: (_) => CouponScreen());
      case '/thankyou':
        return MaterialPageRoute(builder: (_) => ThankYou());
      case '/categoryresult':
        return MaterialPageRoute(
            builder: (_) =>
                CategoryResultScreen(param: args as Map<dynamic, dynamic>?));
      case '/mycourses':
        return MaterialPageRoute(builder: (_) => MyCourses());
      case '/lesson':
        return MaterialPageRoute(
            builder: (_) => LessonScreen(id: args as String?));
      case '/lessondetail':
        return MaterialPageRoute(
            builder: (_) => CourseLesson(data: args as Map<dynamic, dynamic>?));
      case '/qandareply':
        return MaterialPageRoute(
            builder: (_) =>
                QandAReplyScreen(data: args as Map<dynamic, dynamic>?));
      case '/viewimage':
        return MaterialPageRoute(
            builder: (_) => ViewImage(url: args as String?));
      case '/wishlist':
        return MaterialPageRoute(builder: (_) => WishlistScreen());
      case '/myprofile':
        return MaterialPageRoute(builder: (_) => MyProfileScreen());
      case '/changepassword':
        return MaterialPageRoute(builder: (_) => ChangePasswordScreen());
      case '/meetings':
        return MaterialPageRoute(builder: (_) => MeetingScreen());
      case '/file_reader':
        return MaterialPageRoute(
            builder: (_) => FileReaderPage(filePath: args as String?));
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
