import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/helper/resources/strings.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/textFieldStyle.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/button.dart';
import 'package:ilminneed/src/widgets/header_text.dart';
import 'package:ilminneed/src/widgets/hint_text.dart';
import 'package:loading_overlay/loading_overlay.dart';


class ResetLink extends StatefulWidget {
  final Map param;

  const ResetLink({Key key, this.param}) : super(key: key);

  @override
  _ResetLinkState createState() => _ResetLinkState();
}

class _ResetLinkState extends State<ResetLink> {

  bool _loading = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _passcode = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  Timer _timer;
  int _start = 60;
  bool _resendbtn = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _changepassword() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _loading = true;
    });
    var res = await ctrl.requestwithoutheader({
      'email': _email.text,
      'password': _password.text,
      'passcode': _passcode.text
    }, 'change/password');
    print(res);
    setState(() {
      _loading = false;
    });
    if (res != null && res['error'] == null) {
      await ctrl.toastmsg(res['message'], 'long');
      Get.offAllNamed('/signIn');
    } else {
      setState(() {
        _loading = false;
      });
      await ctrl.toastmsg('Enter valid passcode', 'long');
    }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            setState(() {
              _resendbtn = true;
            });
          } else {
            setState(() {
              _start = _start - 1;
            });
          }
        },
      ),
    );
  }

  _sendlink() async {
    setState(() {
      _loading = true;
    });
    var res = await ctrl
        .requestwithoutheader({'email': _email.text}, 'forgot/password');
    setState(() {
      _loading = false;
    });
    if (res != null && res['error'] == null) {
      await ctrl.toastmsg(res['message'], 'long');
      startTimer();
      setState(() {
        _start = 30;
        _resendbtn = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
      await ctrl.toastmsg(res['message'], 'long');
    }
  }

  @override
  void initState() {
    setState(() {
      _email.text = widget.param['email'];
    });
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: konLightColor2,
      ),
      backgroundColor: konLightColor2,
      body: LoadingOverlay(
        isLoading: _loading,
        color: Colors.white,
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      reset_link,
                    ),
                    HeaderTextWidget(label: RESET_LINK),
                    HintWidget(label: RESET_LINK_HINT),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: TextFormField(
                        controller: _email,
                        enabled: false,
                        validator: (String value) {
                          if(value.isEmpty){
                            return 'Email is required';
                          }
                          if(!RegExp("^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*").hasMatch(value)){
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                        style: mediumTextStyle().copyWith(color: konDarkColorB1),
                        decoration: textFormFieldInputDecoration('abc@gmail.com'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: TextFormField(
                        controller: _passcode,
                        keyboardType: TextInputType.number,
                        validator: (String value) {
                          if(value.isEmpty){
                            return 'passcode is required';
                          }
                        },
                        style: mediumTextStyle().copyWith(color: konDarkColorB1),
                        decoration: textFormFieldInputDecoration('passcode'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: TextFormField(
                        controller: _password,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _obscureText,
                        validator: (String value) {
                          if(value.isEmpty){
                            return 'Password is required';
                          }
                        },
                        style: mediumTextStyle().copyWith(color: konDarkColorB1),
                        decoration: textFormFieldInputDecoration('password')
                            .copyWith(suffixIcon: InkWell(onTap: (){  setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: Icon(_obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off))),
                      ),
                    ),
                    InkWell(
                      onTap: _changepassword,
                      child: ButtonWidget(
                        value: 'Change Password',
                      ),
                    ),
                    !_resendbtn
                        ? Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Resend in ',
                                  style: smallTextStyle()
                                      .copyWith(color: konDarkColorB1),
                                ),
                                Text(
                                  _start.toString(),
                                  style: buttonTextStyle().copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor: konPrimaryColor1,
                                      color: konPrimaryColor1),
                                ),
                              ],
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              _sendlink();
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Resend passcode',
                                    style: buttonTextStyle().copyWith(
                                        decoration: TextDecoration.underline,
                                        decorationColor: konPrimaryColor1,
                                        color: konPrimaryColor1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Back to ',
                            style: smallTextStyle()
                                .copyWith(color: konDarkColorB1),
                          ),
                          Text(
                            SIGN_IN,
                            style: buttonTextStyle().copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: konPrimaryColor1,
                                color: konPrimaryColor1),
                          ),
                        ],
                      ),
                    )
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
