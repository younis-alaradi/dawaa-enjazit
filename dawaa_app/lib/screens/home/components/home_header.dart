import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dawaa_app/all.dart';
import 'package:dawaa_app/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:dawaa_app/screens/cart/cart_screen.dart';

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);
  static int refreshCart_count()
  {
    return Cart.carts.length;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            numOfitem: refreshCart_count(),
            press: () {


              if(Cart.carts.length==0)
              {
                Navigator.pushNamed(context, CartScreen.routeName);
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.INFO,
                  animType: AnimType.BOTTOMSLIDE,
                  title: 'No items available in the list',
                  desc: 'Please add some items and re-visit the page',
                  //autoHide: Duration(seconds: 5),
                  btnOkOnPress: ()
                  {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                    (context as Element).markNeedsBuild();
                  },
                )..show();
              }
              else
                Navigator.pushNamed(context, CartScreen.routeName);
              },
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: 3,
            press: () {},
          ),
        ],
      ),
    );
  }
}
