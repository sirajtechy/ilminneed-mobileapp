import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilminneed/cart_bloc.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:ilminneed/src/model/course.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'courses/latest_course.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key key}) : super(key: key);

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  bool _loading = true;
  List<Course> _wishlist = new List<Course>();

  _mywishlist() async {
    var res = await ctrl.getrequestwithheader('my_wishlist');
    print(res);
    setState(() {
      _loading = false;
      _wishlist.clear();
    });
    if (res != null) {
      List<dynamic> data = res;
      for (int i = 0; i < data.length; i++) {
        if (!mounted) return;
        setState(() {
          _wishlist.add(Course.fromJson(data[i]));
        });
      }
    }
  }

  _userLoggedIn() async {
    if(await ctrl.LoggedIn() != true){
      Get.offNamed('/signIn', arguments: {
        'name': '/wishlist',
        'arg': ''
      });
    }else{
      await _mywishlist();
    }
  }

  @override
  void initState() {
    _userLoggedIn();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Wishlist',
          style: largeTextStyle().copyWith(fontSize: 18, color: konDarkColorB1),
        ),
      ),
      body: LoadingOverlay(
        color: Colors.white,
        isLoading: _loading,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _wishlist.length != 0 && !_loading?Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _wishlist.length,
                  primary: false,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LatestCourse(
                              isRating: false,
                              course: _wishlist[index]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.delete_outlined),
                              SizedBox(width: 10),
                              InkWell(
                                onTap: () async {
                                  setState(() {
                                    _loading = true;
                                  });
                                  await ctrl.addtowishlist(_wishlist[index].id);
                                  _mywishlist();
                                },
                                child: Text(
                                  'Remove',
                                  style: mediumTextStyle()
                                      .copyWith(color: konPrimaryColor1),
                                ),
                              ),
                              SizedBox(width: 30),
                              Icon(Icons.shopping_cart),
                              SizedBox(width: 10),
                              InkWell(
                                onTap: () async {
                                  if( _wishlist[index].is_carted == 'false'){
                                    setState(() {
                                      _loading = true;
                                    });
                                    await ctrl.addtocart(_wishlist[index].id, context);
                                    _mywishlist();
                                  }
                                },
                                child: Text(
                                  _wishlist[index].is_carted == 'false'?'Move to cart':'Added to cart',
                                  style: mediumTextStyle()
                                      .copyWith(color: konPrimaryColor1),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: konDarkColorB4,
                      thickness: 1,
                    );
                  },
                ),
              ):_wishlist.length == 0 && !_loading?Container(
                height: 200,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: [
                      Image(
                        image:
                        AssetImage(qanda_empty),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Your wishlist is empty',
                        style: mediumTextStyle()
                            .copyWith(
                            fontSize: 15,
                            color:
                            konDarkColorD3),
                      ),
                    ],
                  ),
                ),
              ):SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}