import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ilminneed/cart_bloc.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;

class ShoppingCartButtonWidget extends StatelessWidget {
  final String c;
  const ShoppingCartButtonWidget({Key key,this.c}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartBloc>(context);

    return InkWell(
      onTap: () async{
        if(await ctrl.LoggedIn() == true){
          Get.offNamed('/cart');
        }else{
          ctrl.toastmsg('Login to continue', 'short');
        }
      },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Icon(
              Icons.shopping_cart,
              color: c == 'white'?Colors.white:Colors.black,
              size: 25,
            ),
          ),
    bloc.getcount() != 0?Container(
            child: Text(
              bloc.getcount().toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption.merge(
                TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: Color(0xFFff5959),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            constraints: BoxConstraints(minWidth: 15, maxWidth: 15, minHeight: 15, maxHeight: 15),
          ):SizedBox(),
        ],
      ),
    );
  }
}
