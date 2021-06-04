import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../helper/resources/images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          splashScreen,
          height: 350,
          width: 350,
        ),
      ),
    );
  }
}
