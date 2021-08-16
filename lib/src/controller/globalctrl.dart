import 'dart:convert';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ilminneed/cart_bloc.dart';
import 'package:provider/provider.dart';

Future getrequest(data,module) async {
  //Fluttertoast.cancel();
  final String endpoint = '${GlobalConfiguration().getValue('api_base_url')}'+module;
  final client = new http.Client();
  try {
    final response = await client.get(
      endpoint,
      headers: await _headerwithouttoken(),
    );
    if (response.statusCode == 200) {
      //print(response.body);
      return json.decode(response.body);
    } else {
      print(Exception(response.body).toString());
      return null;
    }
  } on SocketException {
    print(Exception('Failed to load post'));
    return null;
  }
}

Future requestwithoutheader(data,module) async {
  //Fluttertoast.cancel();
  final String endpoint = '${GlobalConfiguration().getValue('api_base_url')}'+module;
  final client = new http.Client();
  try {
    final response = await client.post(
      endpoint,
      headers: await _headerwithouttoken(),
      body: json.encode(data),
    );
    if (response.statusCode == 200) {
      //print(response.body);
      return json.decode(response.body);
    } else {
      print(Exception(response.body).toString());
      return null;
    }
  } on SocketException {
    print(Exception('Failed to load post'));
    return null;
  }
}

String getTimeString(int value) {
  var hour = value / 3600;
  var  minutes = value / 60%60;
  var  seconds = value % 60;
  return '${hour.toInt().toString().padLeft(2, "0")}:${minutes.toInt().toString().padLeft(2, "0")}:${seconds.toInt().toString().padLeft(2, "0")}';
}


Future requestwithheader(data,module) async {
  //Fluttertoast.cancel();
  final String endpoint = '${GlobalConfiguration().getValue('api_base_url')}'+module;
  final client = new http.Client();
  try {
    final response = await client.post(
      endpoint,
      headers: await _headerwithtoken(),
      body: json.encode(data),
    );
    if (response.statusCode == 200) {
      //print(response.body);
      return json.decode(response.body);
    } else {
      print(Exception(response.body).toString());
      return null;
    }
  } on SocketException {
    print(Exception('Failed to load post'));
    return null;
  }
}

Future getrequestwithheader(module) async {
  //Fluttertoast.cancel();
  final String endpoint = '${GlobalConfiguration().getValue('api_base_url')}'+module;
  final client = new http.Client();
  try {
    final response = await client.get(
      endpoint,
      headers: await _headerwithtoken(),
    );
    if (response.statusCode == 200) {
      //print(response.body);
      return json.decode(response.body);
    } else {
      print(Exception(response.body).toString());
      return null;
    }
  } on SocketException {
    print(Exception('Failed to load post'));
    return null;
  }
}

Future _headerwithtoken() async{
  String token = await gettoken();
  return { HttpHeaders.contentTypeHeader: 'application/json', 'X-Auth-Token' : '$token' };
}

Future _headerwithouttoken() async {
  return { HttpHeaders.contentTypeHeader: 'application/json' };
}

Future gettoken() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString('token');
}

Future getuserid() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString('user_id').toString();
}

Future getuserimage() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString('user_image').toString();
}

Future getusername() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString('full_name').toString();
}

Future getemail() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString('email').toString();
}

Future saveuserdata(data) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString('user_id', data['user_id'].toString());
  _prefs.setString('full_name', data['first_name']);
  _prefs.setString('user_image', data['image'].toString());
  _prefs.setString('role', data['role']);
  if(data['token'] != '' && data['token'] != null){
    _prefs.setString('token', data['token']);
  }
  _prefs.setString('email', data['email']);
  _prefs.setString('role_id', data['role_id']);
  print('saved sharedpreferences');
  return true;
}


Future logout() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.clear();
  return true;
}

Future<bool> LoggedIn() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  if(_prefs.getString('token') != null){
    return true;
  }else{
    return false;
  }
}

Future<bool> validateEmail(String value) async{
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return true;
  else
    return false;
}

Future<bool> validateMobile(String value) async{
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return false;
  }
  else if (!regExp.hasMatch(value)) {
    return false;
  }
  return true;
}

Future toastmsg(String value,String time) async {
  if(time == 'long'){
    BotToast.showSimpleNotification(title: value.toString(),backgroundColor: Colors.black54,crossPage: true, titleStyle: TextStyle(
        color:Colors.white ),borderRadius: 15,duration: Duration(seconds: 5));
  }else{
    BotToast.showSimpleNotification(title: value.toString(),backgroundColor: Colors.black54,crossPage: true, titleStyle: TextStyle(
        color:Colors.white ),borderRadius: 15,duration: Duration(seconds: 3));
  }
}

Future addtocart(course_id,context) async {
  print(course_id);
  var res = await requestwithheader({'courseId': course_id }, 'toggle_cart');
  print(res);
  var bloc = Provider.of<CartBloc>(context, listen: false);
  if(res != null && res != 'null' && res['cart']['status'] == 'added'){
    bloc.totalCount(bloc.getcount() + 1);
  }else if(res != null && res != 'null' && res['cart']['status'] == 'removed'){
    bloc.totalCount(bloc.getcount() - 1);
  }
  return true;
}

Future addtowishlist(course_id) async {
  var res = await requestwithheader({'courseId': course_id }, 'toggle_wishlist');
  return true;
}