import 'package:flutter/material.dart';
import 'package:ilminneed/src/screen/sign_in.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('ilminneed'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: GestureDetector(
          child: Text('Splash Screen'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SignInScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
