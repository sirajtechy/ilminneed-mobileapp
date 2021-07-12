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

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _loading = true;
  List<Course> _course = new List<Course>();
  List<Course> _wishlist = new List<Course>();
  String base_price = '';
  String discount_price = '';
  String total_price = '';
  Razorpay _razorpay;
  String order_id = '';
  String paid_amt;

  _fetchcourse() async {
    var res = await ctrl.getrequestwithheader('my_cart');
    setState(() {
      _loading = false;
      _course.clear();
    });
    var bloc = Provider.of<CartBloc>(context, listen: false);
    if (res != null && res != 'null') {
      print(res);
      if(res['courses'].length != 0){
        List<dynamic> data = res['courses'];
        for (int i = 0; i < data.length; i++) {
          if (!mounted) return;
          setState(() {
            _course.add(Course.fromJson(data[i]));
          });
        }
        bloc.totalCount(data.length);
        if(data.length != 0){
          if (!mounted) return;
          setState(() {
            base_price = res['total_course_price'].toString();
            discount_price = res['discount'].toString();
            total_price = res['total_price'].toString();
          });
        }
      }else{
        bloc.totalCount(0);
        _course.clear();
      }
    }else{
      bloc.totalCount(0);
      _course.clear();
    }
  }

  _mywishlist() async {
    var res = await ctrl.getrequestwithheader('my_wishlist');
    setState(() {
      _loading = false;
      _wishlist.clear();
    });
    if (res != null) {
        List<dynamic> data = res;
        for (int i = 0; i < data.length; i++) {
          print(data[i]['is_wishlisted']);
          if (!mounted) return;
          print(data[i]['is_carted']);
          setState(() {
            _wishlist.add(Course.fromJson(data[i]));
          });
        }
        if (!mounted) return;
        setState(() {
          _loading = false;
        });
    }
  }

  _checkout() async {
    var res = await ctrl.getrequestwithheader('razorpay_checkout');
    setState(() {
      _loading = false;
    });
    if (res != null) {
      setState(() {
        order_id = res['order_id'].toString();
        paid_amt = res['amount'].toString();
      });
      print(order_id);
      var options = res;
      try {
        _razorpay.open(options);
      } catch (e) {
        //debugPrint(e);
        setState(() {
          _loading = false;
        });
        await ctrl.toastmsg('Payment Error. Please try again', 'long');
      }
    }
  }

  _userLoggedIn() async {
    if(await ctrl.LoggedIn() != true){
      Get.offAllNamed('/signIn', arguments: {
        'name': '/cart',
        'arg': ''
      });
    }else{
      await _fetchcourse();
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    setState(() {
      _loading = true;
    });
    Map data = {
      'razorpay_payment_id': response.paymentId,
      'razorpay_order_id' : order_id.toString(),
      'razorpay_signature': response.signature,
      'razorpay_amount':paid_amt
    };
    var res = await ctrl.requestwithheader(data,'razorpay_payment');
    setState(() {
      _loading = true;
    });
    if (res != null && res != 'null') {
      if (res['response']['status'] == true) {
        Get.offAllNamed('/thankyou');
        return;
      } else {
        await ctrl.toastmsg('Error. Please try again', 'long');
      }
    } else {
      await ctrl.toastmsg('Error. Please try again', 'long');
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    print('_handlePaymentError');
    print(response.code.toString());
    print(response.message);
    setState(() {
      _loading = false;
    });
    await ctrl.toastmsg('Payment Error. Please try again', 'long');
  }

  void _handleExternalWallet(ExternalWalletResponse response) async {
    print('_handleExternalWallet');
    print(response.walletName);
    print(response.toString());
    setState(() {
      _loading = false;
    });
    await ctrl.toastmsg('Wallet Response', 'long');
  }

  @override
  void initState() {
    // TODO: implement initState
    _userLoggedIn();
    _mywishlist();
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _course?.clear();
    super.dispose();
    _razorpay.clear();
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
          'Cart',
          style: largeTextStyle().copyWith(fontSize: 18, color: konDarkColorB1),
        ),
      ),
      body: LoadingOverlay(
        isLoading: _loading,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _course.length != 0?Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _course.length,
                  primary: false,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LatestCourse(
                              isRating: false,
                              course: _course[index]),
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
                                  var res = await ctrl.addtocart(_course[index].id,this.context);
                                  if(res){
                                    _fetchcourse();
                                  }
                                },
                                child: Text(
                                  'Remove',
                                  style: mediumTextStyle()
                                      .copyWith(color: konPrimaryColor1),
                                ),
                              ),
                              SizedBox(width: 30),
                              Icon(Icons.favorite_border_outlined),
                              SizedBox(width: 10),
                              _course[index].is_wishlisted == 'false'?InkWell(
                                onTap: () async {
                                  setState(() {
                                    _loading = true;
                                  });
                                  await ctrl.addtowishlist(_course[index].id);
                                  _fetchcourse();
                                  _mywishlist();
                                },
                                child: Text(
                                  'Move to wishlist',
                                  style: mediumTextStyle()
                                      .copyWith(color: konPrimaryColor1),
                                ),
                              ):SizedBox()
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
              ):Container(),
              _course.length == 0 && !_loading?Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Image(
                                      image: AssetImage(empty_cart),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Your cart is empty',
                                      style: largeTextStyle().copyWith(
                                          fontSize: 32,
                                          color: konDarkBlackColor),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Add courses to find here',
                                      style: mediumTextStyle().copyWith(
                                          fontSize: 15, color: konDarkColorD3),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              _course.length == 0 && _wishlist.length != 0
                  ? Divider(color: konDarkColorB4, thickness: 1)
                  : SizedBox(),
              _course.length != 0
                  ? GestureDetector(
                      onTap: () {
                        Get.toNamed('/coupon');
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.all(12),
                        color: Color(0xffF6F5FF),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '%',
                        style: largeTextStyle()
                            .copyWith(fontSize: 16, color: konDarkColorB2),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Apply coupon',
                        style: largeTextStyle()
                            .copyWith(fontSize: 16, color: konDarkColorB2),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      )
                    ],
                  ),
                ),
              ):Container(),
              _course.length != 0?Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text('Price details',
                    style: largeTextStyle()
                        .copyWith(fontSize: 16, color: konDarkColorB2)),
              ):Container(),
              _course.length != 0?Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Total Course',
                            style: mediumTextStyle()
                                .copyWith(fontSize: 16, color: konDarkBlackColor),
                          ),
                          Spacer(),
                          Text('₹ '+base_price.toString(),
                              style: mediumTextStyle()
                                  .copyWith(fontSize: 14, color: konDarkColorB1))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Discount',
                            style: mediumTextStyle()
                                .copyWith(fontSize: 16, color: konDarkBlackColor),
                          ),
                          Spacer(),
                          Text('₹ '+discount_price.toString(),
                              style: mediumTextStyle()
                                  .copyWith(fontSize: 14, color: konDarkColorB1))
                        ],
                      ),
                    ),
                  ],
                ),
              ):Container(),
              _course.length != 0?Divider(color: konDarkColorB4, thickness: 1):SizedBox(),
              _course.length != 0?Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Amount to pay',
                      style: mediumTextStyle()
                          .copyWith(fontSize: 16, color: konDarkBlackColor),
                    ),
                    Spacer(),
                    Text('₹ '+total_price,
                        style: mediumTextStyle()
                            .copyWith(fontSize: 14, color: konDarkColorB1))
                  ],
                ),
              ):Container(),
              _course.length != 0?Divider(color: konDarkColorB4, thickness: 1):SizedBox(),
              _wishlist.length != 0?Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text('My wishlist',
                    style: largeTextStyle()
                        .copyWith(fontSize: 16, color: konDarkColorB2)),
              ):SizedBox(),
              _wishlist.length != 0?Container(
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
                                    _fetchcourse();
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
                                    _fetchcourse();
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
              ):SizedBox(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _course.length != 0?Padding(
        padding: EdgeInsets.all(0),
        child: !_loading?GestureDetector(
          onTap: () {},
          child: Container(
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: konLightColor1,
                borderRadius: BorderRadius.only(topRight: Radius.circular(0), topLeft: Radius.circular(0)),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).focusColor.withOpacity(0.15), offset: Offset(0, -2), blurRadius: 5.0)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row (
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text (
                      'Total ₹ '+total_price.toString(),
                        style: buttonTextStyle().copyWith(color: konDarkColorB1),
                    ),
                    SizedBox(width: 10),
                    Text (
                      'View Detail',
                      style: mediumTextStyle().copyWith(color: konPrimaryColor),
                    )
                  ],
                ),
                Stack(
                  fit: StackFit.loose,
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                      child: FlatButton(
                        onPressed: () async {
                                      setState(() {
                                        _loading = true;
                                      });
                                      _checkout();
                                    },
                        shape: StadiumBorder(),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        color: konPrimaryColor,
                        child: Text(
                          'Checkout',
                          textAlign: TextAlign.left,
                          style: ctaTextStyle().copyWith(color: konLightColor1, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ):SizedBox(),
      ):SizedBox(),
    );
  }
}
