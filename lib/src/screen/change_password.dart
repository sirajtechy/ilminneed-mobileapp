import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/textFieldStyle.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/button.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final GlobalKey<FormState> _formKey  = GlobalKey<FormState>();
  final TextEditingController _currentpassword = TextEditingController();
  final TextEditingController _newpassword = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();

  bool _loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _updatepassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _loading = true;
    });
    Map data = {
      'current_password': _currentpassword.text,
      'new_password': _newpassword.text,
      'confirm_password': _confirmpassword.text
    };
    var res = await ctrl.requestwithheader(data, 'profile/password/update');
    print(res);
    setState(() {
      _loading = false;
    });
    if (res != null && res['status'] == 'success') {
      ctrl.toastmsg('Password changed', 'long');
    } else {
      await ctrl.toastmsg('Failed to update password', 'long');
    }
  }

  _userLoggedIn() async {
    if(await ctrl.LoggedIn() != true){
      Get.offNamed('/signIn', arguments: {
        'name': '/myprofile',
        'arg': ''
      });
    }else{
    }
  }

  @override
  void initState() {
    super.initState();
    _userLoggedIn();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return LoadingOverlay(
      isLoading: _loading,
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Change Password',
            style: largeTextStyle().copyWith(fontSize: 18, color: konDarkColorB1),
          ),
        ),
        key: _scaffoldKey,
        backgroundColor: konLightColor2,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 20, bottom: 8, left: 8, right: 8),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: TextFormField(
                        controller: _currentpassword,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Current password is required.';
                          }
                        },
                        style:
                            mediumTextStyle().copyWith(color: konDarkColorB1),
                        decoration:
                            textFormFieldInputDecoration('Current Password'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: TextFormField(
                        controller: _newpassword,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'New password is required';
                          }
                        },
                        style:
                            mediumTextStyle().copyWith(color: konDarkColorB1),
                        decoration:
                            textFormFieldInputDecoration('New Password'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: TextFormField(
                        controller: _confirmpassword,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Confirm password is required';
                          }
                        },
                        style:
                            mediumTextStyle().copyWith(color: konDarkColorB1),
                        decoration:
                            textFormFieldInputDecoration('Confirm Password'),
                      ),
                    ),
                    InkWell(
                      onTap: _updatepassword,
                      child: ButtonWidget(
                        value: 'Update',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}