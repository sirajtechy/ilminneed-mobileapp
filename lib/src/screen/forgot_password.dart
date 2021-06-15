import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/helper/resources/strings.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/textFieldStyle.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/button.dart';
import 'package:ilminneed/src/widgets/header_text.dart';
import 'package:ilminneed/src/widgets/hint_text.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:loading_overlay/loading_overlay.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  bool _loading = false;
  final TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _formKey  = GlobalKey<FormState>();

  _sendlink() async {
    if(!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() { _loading = true;});
    var res = await ctrl.requestwithoutheader({'email': _email.text}, 'forgot/password');
    setState(() { _loading = false; });
    if (res != null && res['error'] == null) {
      await ctrl.toastmsg(res['message'], 'long');
    } else {
      setState(() { _loading = false; });
      await ctrl.toastmsg(res['message'], 'long');
    }
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: konLightColor2,
      ),
      backgroundColor: konLightColor2,
      body: LoadingOverlay(
        isLoading: _loading,
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
                    SvgPicture.asset(forgot_password),
                    HeaderTextWidget(label: FORGOT_PASSWORD),
                    HintWidget(label: FORGOT_PASSWORD_HINT),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: TextFormField(
                        controller: _email,
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
                        decoration: textFormFieldInputDecoration('email'),
                      ),
                    ),
                    InkWell(
                      onTap: _sendlink,
                      child: ButtonWidget(
                        value: SEND_LINK,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Back to ',
                            style: smallTextStyle().copyWith(color: konDarkColorB1),
                          ),
                          InkWell(
                            onTap: (){
                              Get.offNamed('/signIn');
                            },
                            child: Text(
                              SIGN_IN,
                              style: buttonTextStyle().copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: konPrimaryColor1,
                                  color: konPrimaryColor1),
                            ),
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
