import 'package:ilminneed/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("app_settings");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Barlow',
        primaryColor: Colors.white,
        brightness: Brightness.light,
        textTheme: TextTheme(
          button: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}