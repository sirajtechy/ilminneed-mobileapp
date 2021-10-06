import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:get/get.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:ilminneed/cart_bloc.dart';
import 'package:ilminneed/route_generator.dart';
import 'package:provider/provider.dart';

import 'helper/GetXNetworkManager.dart';
import 'helper/NetworkBinding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: false);
  await GlobalConfiguration().loadFromAsset("app_settings");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GetXNetworkManager _networkManager =
      Get.put<GetXNetworkManager>(GetXNetworkManager());

  bool isNotConnected = false;

  @override
  void initState() {
    super.initState();
    _networkManager.addListener(() {
      debugPrint("the listener value is ${_networkManager.connectionType}");
      if (_networkManager.connectionType == 0) {
        _showDialog();
      }
    });
  }

  void _showDialog() => {
        debugPrint("dialog called"),
        Future.delayed(Duration.zero, () => Get.defaultDialog(title: "Alert"))
      };

  @override
  Widget build(BuildContext context) {
    return Portal(
      child: ChangeNotifierProvider<CartBloc>(
        create: (context) => CartBloc(),
        child: GetMaterialApp(
          initialBinding: NetworkBinding(),
          builder: BotToastInit(),
          initialRoute: '/splash',
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
        ),
      ),
    );
  }
}
