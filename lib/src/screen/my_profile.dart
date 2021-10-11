import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ilminneed/cart_bloc.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/textFieldStyle.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/button.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:textfield_tags/textfield_tags.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _phoneno = TextEditingController();
  final TextEditingController _biography = TextEditingController();
  final TextEditingController _profession = TextEditingController();
  final TextEditingController _collage_name = TextEditingController();
  final TextEditingController _degree = TextEditingController();
  final TextEditingController _yearofstudy = TextEditingController();
  final TextEditingController _yearofexperience = TextEditingController();
  final TextEditingController _designation = TextEditingController();
  final TextEditingController _qualification = TextEditingController();
  final TextEditingController _major_in = TextEditingController();
  final TextEditingController _facebook = TextEditingController();
  final TextEditingController _twitter = TextEditingController();
  final TextEditingController _linkedin = TextEditingController();
  List<String> tags = <String>[];
  String? image = '';
  String? p_image_extextion = '';
  String p_image_string = '';

  bool _loading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _getuserdata() async {
    setState(() {
      _loading = true;
      tags.clear();
    });
    var res = await ctrl.getrequestwithheader('userdata');
    print(res);
    setState(() {
      _loading = false;
    });
    if (res != null && res['error'] == null) {
      if (res['skills'] != null && res['skills'] != 'null') {
        res['skills'].forEach((item) {
          setState(() {
            //tags.add(item);
          });
        });
      }
      setState(() {
        _firstname.text = res['first_name'];
        _lastname.text = res['last_name'];
        _email.text = res['email'];
        _phoneno.text = res['phone_no'];
        _facebook.text = res['facebook'];
        _twitter.text = res['twitter'];
        _linkedin.text = res['linkedin'];
        _biography.text = res['biography'];
        _qualification.text = res['qualification'];
        _major_in.text = res['major_in'];
        _collage_name.text = res['college_name'];
        _degree.text = res['degree'];
        _yearofstudy.text = res['year_of_study'];
        _yearofexperience.text = res['work_experience'];
        _designation.text = res['work_designation'];
        _profession.text = res['profession'];
        image = res['image'];
      });
    } else {
      await ctrl.toastmsg('Error. Please try again', 'long');
    }
  }

  _updateprofile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _loading = true;
    });
    Map data = {
      "first_name": _firstname.text,
      "last_name": _lastname.text,
      "email": _email.text,
      "phone_no": _phoneno.text,
      "facebook": _facebook.text,
      "twitter": _twitter.text,
      "linkedin": _linkedin.text,
      "skills": tags,
      "profession": _profession.text,
      "qualification": _qualification.text,
      "major_in": _major_in.text,
      "college_name": _collage_name.text,
      "degree": _degree.text,
      "year_of_study": _yearofstudy.text,
      "work_experience": _yearofexperience.text,
      "work_designation": _designation.text,
      "biography": _biography.text
    };
    var res = await ctrl.requestwithheader(data, 'profile/update');
    print(res);
    setState(() {
      _loading = false;
    });
    if (res != null) {
      ctrl.toastmsg('Profile updated', 'long');
      if (res.containsKey('image')) {
        var bloc = Provider.of<CartBloc>(context, listen: false);
        //await bloc.updateUserImage(res['image'].toString());
      }
    } else {
      await ctrl.toastmsg('Error. Please try again', 'long');
    }
  }

  _updateimage() async {
    setState(() {
      _loading = true;
    });
    Map data = {"profile_image": p_image_string};
    var res = await ctrl.requestwithheader(data, 'profile/image/update');
    print(res);
    setState(() {
      _loading = false;
    });
    if (res != null) {
      _getuserdata();
      ctrl.toastmsg('Profile image updated', 'long');
    } else {
      await ctrl.toastmsg('Error. Please try again', 'long');
    }
  }

  _userLoggedIn() async {
    if (await ctrl.LoggedIn() != true) {
      Get.offNamed('/signIn', arguments: {'name': '/myprofile', 'arg': ''});
    } else {
      await _getuserdata();
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
            'My Profile',
            style:
                largeTextStyle().copyWith(fontSize: 18, color: konDarkColorB1),
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
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child: image != null && image != ''
                                ? Image(
                                    image: NetworkImage(image!),
                                  )
                                : Icon(Icons.person),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 5,
                            child: InkWell(
                              onTap: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: [
                                      'jpg',
                                      'png',
                                      'jpeg'
                                    ]);
                                if (result != null) {
                                  if (result.files.first.extension == 'png' ||
                                      result.files.first.extension == 'jpeg' ||
                                      result.files.first.extension == 'jpg') {
                                    File file = File(result.files.first.path!);
                                    var img_path =
                                        base64Encode(file.readAsBytesSync());
                                    p_image_extextion =
                                        result.files.first.extension;
                                    p_image_string =
                                        'data:image/${result.files.first.extension};base64,' +
                                            img_path;
                                    _updateimage();
                                  } else {
                                    await ctrl.toastmsg(
                                        'Only png,jpg,jpeg allowed', 'long');
                                  }
                                } else {
                                  print('cancelled');
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: konTextInputBorderActiveColor,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.add_a_photo_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: TextFormField(
                        controller: _firstname,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Firstname is required.';
                          }
                        },
                        style:
                            mediumTextStyle().copyWith(color: konDarkColorB1),
                        decoration: textFormFieldInputDecoration('name'),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: TextFormField(
                        controller: _lastname,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Lastname is required.';
                          }
                        },
                        style:
                            mediumTextStyle().copyWith(color: konDarkColorB1),
                        decoration: textFormFieldInputDecoration('First Name'),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: TextFormField(
                        controller: _email,
                        readOnly: true,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Email is required';
                          }
                          if (!RegExp(
                                  "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                              .hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                        style:
                            mediumTextStyle().copyWith(color: konDarkColorB1),
                        decoration: textFormFieldInputDecoration('email'),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: TextFormField(
                        controller: _phoneno,
                        style:
                            mediumTextStyle().copyWith(color: konDarkColorB1),
                        decoration: textFormFieldInputDecoration('Phone No'),
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(maxHeight: 50),
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: TextFormField(
                        controller: _biography,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style:
                            mediumTextStyle().copyWith(color: konDarkColorB1),
                        decoration: textFormFieldInputDecoration('Biography'),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(30.0),
                            ),
                          ),
                        ),
                        focusColor: Colors.white,
                        value: _profession.text.isNotEmpty
                            ? _profession.text
                            : null,
                        //elevation: 5,
                        style: TextStyle(color: Colors.white),
                        iconEnabledColor: Colors.black,
                        items: <String>[
                          'student',
                          'working',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        hint: Text(
                          "Choose a profession",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _profession.text = value!;
                          });
                        },
                      ),
                    ),
                    _profession.text == 'student'
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: TextFormField(
                              controller: _collage_name,
                              style: mediumTextStyle()
                                  .copyWith(color: konDarkColorB1),
                              decoration:
                                  textFormFieldInputDecoration('Collage Name'),
                            ),
                          )
                        : SizedBox(),
                    _profession.text == 'student'
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: TextFormField(
                              controller: _degree,
                              style: mediumTextStyle()
                                  .copyWith(color: konDarkColorB1),
                              decoration:
                                  textFormFieldInputDecoration('Degree'),
                            ),
                          )
                        : SizedBox(),
                    _profession.text == 'student'
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: TextFormField(
                              controller: _yearofstudy,
                              style: mediumTextStyle()
                                  .copyWith(color: konDarkColorB1),
                              decoration:
                                  textFormFieldInputDecoration('Year of Study'),
                            ),
                          )
                        : SizedBox(),
                    _profession.text == 'working'
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: TextFormField(
                              controller: _yearofexperience,
                              style: mediumTextStyle()
                                  .copyWith(color: konDarkColorB1),
                              decoration: textFormFieldInputDecoration(
                                  'Year of Experience'),
                            ),
                          )
                        : SizedBox(),
                    _profession.text == 'working'
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: TextFormField(
                              controller: _designation,
                              style: mediumTextStyle()
                                  .copyWith(color: konDarkColorB1),
                              decoration:
                                  textFormFieldInputDecoration('Designation'),
                            ),
                          )
                        : SizedBox(),
                    _profession.text == 'working'
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 15),
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(30.0),
                                  ),
                                ),
                              ),
                              focusColor: Colors.white,
                              value: _qualification.text.isNotEmpty
                                  ? _qualification.text
                                  : null,
                              //elevation: 5,
                              style: TextStyle(color: Colors.white),
                              iconEnabledColor: Colors.black,
                              items: <String>[
                                'UG',
                                'PG',
                                'Phd'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              hint: Text(
                                "Choose a qualification",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  _qualification.text = value!;
                                });
                              },
                            ),
                          )
                        : SizedBox(),
                    _profession.text == 'working'
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: TextFormField(
                              controller: _major_in,
                              style: mediumTextStyle()
                                  .copyWith(color: konDarkColorB1),
                              decoration:
                                  textFormFieldInputDecoration('Major In'),
                            ),
                          )
                        : SizedBox(),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: TextFieldTags(
                          initialTags: tags,
                          textFieldStyler: TextFieldStyler(
                              helperText: '',
                              hintText: 'Skills',
                              textFieldBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(90.0))),
                              textFieldFocusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(90.0)),
                                  borderSide: BorderSide(
                                      color: konTextInputBorderActiveColor))

                              // bool textFieldFilled = false,
                              // Icon icon,
                              // String helperText = 'Enter tags',
                              // TextStyle helperStyle,
                              // String hintText = 'Got tags?',
                              // TextStyle hintStyle,
                              // EdgeInsets contentPadding,
                              // Color textFieldFilledColor,
                              // bool isDense = true,
                              // bool textFieldEnabled = true,
                              // OutlineInputBorder textFieldBorder = const OutlineInputBorder(),
                              // OutlineInputBorder textFieldFocusedBorder,
                              // OutlineInputBorder textFieldDisabledBorder,
                              // OutlineInputBorder textFieldEnabledBorder
                              ),
                          tagsStyler: TagsStyler(
                              tagTextStyle:
                                  TextStyle(fontWeight: FontWeight.normal),
                              tagDecoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              tagCancelIcon: Icon(Icons.cancel,
                                  size: 18.0, color: Colors.blue[900]),
                              tagPadding: const EdgeInsets.all(6.0)),
                          onTag: (tag) {
                            setState(() {
                              tags.add(tag);
                            });
                          },
                          onDelete: (tag) {
                            setState(() {
                              tags.remove(tag);
                            });
                          },
                          validator: (tag) {
                            if (tag.length > 20) {
                              return "hey that's too long";
                            }
                            return null;
                          }),
                    ),
                    InkWell(
                      onTap: _updateprofile,
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
