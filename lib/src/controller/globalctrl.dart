import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future requestwithoutheader(data,module) async {
  final String endpoint = '${GlobalConfiguration().getValue('api_base_url')}'+module;
  final client = new http.Client();
  try {
    final response = await client.post(
      endpoint,
      headers: await _headerwithouttoken(),
      body: json.encode(data),
    );
    if (response.statusCode == 200) {
      print(response.body);
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

Future requestwithheader(data,module) async {
  final String endpoint = '${GlobalConfiguration().getValue('api_base_url')}'+module;
  final client = new http.Client();
  try {
    final response = await client.post(
      endpoint,
      headers: await _headerwithtoken(),
      body: json.encode(data),
    );
    if (response.statusCode == 200) {
      print(response.body);
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
  return { HttpHeaders.contentTypeHeader: 'application/json', 'Authorization' : 'Bearer $token' };
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
  return _prefs.getInt('user_id').toString();
}

Future getusername() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString('full_name').toString();
}

Future saveuserdata(data) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setInt('user_id', data['id']);
  _prefs.setString('full_name', data['full_name']);
  _prefs.setString('pincode', data['pincode']);
  if(data['token'] != '' && data['token'] != null){
    _prefs.setString('token', data['token']);
  }
  _prefs.setString('email', data['email']);
  _prefs.setString('phone', data['phone']);
  print('saved sharedpreferences');
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
  return Fluttertoast.showToast(
      msg: value,
      toastLength: time == 'short'?Toast.LENGTH_SHORT:Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 15.0
  );
}
